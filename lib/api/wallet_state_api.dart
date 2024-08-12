import 'dart:convert';
import 'dart:typed_data';

import 'package:brambldart/brambldart.dart'
    show
        AddressCodecs,
        Either,
        Encoding,
        ExtendedEd25519,
        HeightTemplate,
        IntExtension,
        LockTemplate,
        PredicateTemplate,
        SCrypt,
        SignatureTemplate,
        SizedEvidence,
        WalletApi,
        WalletStateAlgebra;
import 'package:fixnum/fixnum.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sembast/sembast.dart';
import 'package:servicekit/api/wallet_key_api.dart';
import 'package:servicekit/models/cartesian.dart';
import 'package:servicekit/models/digest.dart';
import 'package:servicekit/models/fellowship.dart';
import 'package:servicekit/models/template.dart';
import 'package:servicekit/models/verification_key.dart' as sk;
import 'package:servicekit/models/verification_key.dart';
import 'package:topl_common/proto/brambl/models/address.pb.dart';
import 'package:topl_common/proto/brambl/models/box/lock.pb.dart';
import 'package:topl_common/proto/brambl/models/identifier.pb.dart';
import 'package:topl_common/proto/brambl/models/indices.pb.dart';
import 'package:topl_common/proto/quivr/models/proposition.pb.dart';
import 'package:topl_common/proto/quivr/models/shared.pb.dart' as quivr_shared;

/// An implementation of the WalletStateAlgebra that uses a database to store state information.

class WalletStateApi implements WalletStateAlgebra {
  WalletStateApi(
    this._instance,
    this._secureStorage, {
    ExtendedEd25519? extendedEd25519,
    SCrypt? kdf,
  }) : api = WalletApi(
          WalletKeyApi(_secureStorage),
          extendedEd25519Instance: extendedEd25519,
          kdfInstance: kdf,
        );

  final Database _instance;
  // ignore: unused_field
  final FlutterSecureStorage _secureStorage;
  final WalletApi api;

  @override
  Future<void> initWalletState(
      int networkId, int ledgerId, quivr_shared.VerificationKey vk) async {
    final defaultTemplate = PredicateTemplate(
      [SignatureTemplate("ExtendedEd25519", 0)],
      1,
    );

    final genesisTemplate = PredicateTemplate(
      [HeightTemplate('header', 1.toInt64, Int64.MAX_VALUE)],
      1,
    );

    // Create parties
    await fellowshipsStore.add(
        _instance, Fellowship(x: 0, name: 'nofellowship').toSembast);
    await fellowshipsStore.add(
        _instance, Fellowship(x: 1, name: 'self').toSembast);

    // Create templates
    await templatesStore.add(
        _instance,
        Template(
                y: 1,
                name: 'default',
                lock: jsonEncode(defaultTemplate.toJson()))
            .toSembast);
    await templatesStore.add(
        _instance,
        Template(
                y: 2,
                name: 'genesis',
                lock: jsonEncode(genesisTemplate.toJson()))
            .toSembast);

    // Create verification keys
    await verificationKeysStore.add(
        _instance,
        sk.VerificationKey(
          x: 1,
          y: 1,
          vks: [Encoding().encodeToBase58Check(vk.writeToBuffer())],
        ).toSembast); // TODO(ultimaterex): figure out if encoding to stringbase 58 is better
    await verificationKeysStore.add(
        _instance,
        sk.VerificationKey(
          x: 0,
          y: 2,
          vks: [],
        ).toSembast);

    final defaultSignatureLock = getLock("self", "default", 1)!; // unsafe
    final signatureLockAddress = LockAddress(
        network: networkId,
        ledger: ledgerId,
        id: LockId(
            value: defaultSignatureLock.predicate.sizedEvidence.digest.value));

    final childVk = api.deriveChildVerificationKey(vk, 1);
    final genesisHeightLock = getLock("nofellowship", "genesis", 1)!; // unsafe
    final heightLockAddress = LockAddress(
        network: networkId,
        ledger: ledgerId,
        id: LockId(
            value: genesisHeightLock.predicate.sizedEvidence.digest.value));

    // Create cartesian coordinates
    await cartesiansStore.add(
        _instance,
        Cartesian(
          x: 1,
          y: 1,
          z: 1,
          lockPredicate: Encoding().encodeToBase58Check(
              defaultSignatureLock.predicate.writeToBuffer()),
          address: AddressCodecs.encode(signatureLockAddress),
          routine: 'ExtendedEd25519',
          vk: Encoding().encodeToBase58Check(childVk.writeToBuffer()),
        ).toSembast);

    await cartesiansStore.add(
        _instance,
        Cartesian(
          x: 0,
          y: 2,
          z: 1,
          lockPredicate: Encoding()
              .encodeToBase58Check(genesisHeightLock.predicate.writeToBuffer()),
          address: AddressCodecs.encode(heightLockAddress),
        ).toSembast);
  }

  @override
  Indices? getIndicesBySignature(
      Proposition_DigitalSignature signatureProposition) {
    final result = cartesiansStore.findSync(_instance,
        finder: Finder(
            filter: Filter.and([
          Filter.equals("routine", signatureProposition.routine),
          Filter.equals(
              "vk",
              Encoding().encodeToBase58Check(
                  signatureProposition.verificationKey.writeToBuffer())),
        ])));

    if (result.isEmpty) return null;
    return Indices(
      x: result.first["x"] as int?,
      y: result.first["y"] as int?,
      z: result.first["z"] as int?,
    );
  }

  @override
  Lock_Predicate? getLockByIndex(Indices indices) {
    final result = cartesiansStore.findSync(_instance,
        finder: Finder(
            filter: Filter.and([
          Filter.equals("x", indices.x),
          Filter.equals("y", indices.y),
          Filter.equals("z", indices.z),
        ])));

    if (result.isEmpty) return null;
    return Lock_Predicate.fromBuffer(Encoding()
        .decodeFromBase58Check(result.first["lockPredicate"]! as String)
        .get());
  }

  @override
  Lock_Predicate? getLockByAddress(String lockAddress) {
    final result = cartesiansStore.findSync(_instance,
        finder: Finder(
            filter: Filter.and([
          Filter.equals("address", lockAddress),
        ])));

    if (result.isEmpty) return null;
    return Lock_Predicate.fromBuffer(Encoding()
        .decodeFromBase58Check(result.first["lockPredicate"]! as String)
        .get());
  }

  @override
  Future<void> updateWalletState(String lockPredicate, String lockAddress,
      String? routine, String? vk, Indices indices) async {
    await cartesiansStore.add(
      _instance,
      Cartesian(
              x: indices.x,
              y: indices.y,
              z: indices.z,
              lockPredicate: lockPredicate,
              address: lockAddress,
              routine: routine,
              vk: vk)
          .toSembast,
    );
  }

  @override
  Indices? getNextIndicesForFunds(String fellowship, String template) {
    final fellowshipResult = fellowshipsStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("name", fellowship)));

    final templateResult = templatesStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("name", template)));

    if (fellowshipResult != null && templateResult != null) {
      final x = fellowshipResult["x"]! as int;
      final y = templateResult["y"]! as int;
      final cartesianResult = cartesiansStore.findFirstSync(_instance,
          finder: Finder(
              filter: Filter.and([
                Filter.equals("x", x),
                Filter.equals("y", y),
              ]),
              sortOrders: [SortOrder("z", false)]));

      if (cartesianResult != null) {
        final z = (cartesianResult["z"]! as int) + 1;
        return Indices(x: x, y: y, z: z);
      } else {
        return Indices(x: x, y: y, z: 1);
      }
    }

    return null;
  }

  bool validateFellowship(String fellowship) {
    final result = fellowshipsStore.findFirstSync(_instance,
        finder: Finder(
            filter: Filter.and([
          Filter.equals("name", fellowship),
        ])));
    return result != null;
  }

  bool validateTemplate(String template) {
    final result = templatesStore.findFirstSync(_instance,
        finder: Finder(
            filter: Filter.and([
          Filter.equals("name", template),
        ])));
    return result != null;
  }

  @override
  Either<String, Indices> validateCurrentIndicesForFunds(
      String fellowship, String template, int? someState) {
    // ignore: unused_local_variable
    final p = validateFellowship(fellowship);
    // ignore: unused_local_variable
    final c = validateTemplate(template);
    final indices = getCurrentIndicesForFunds(fellowship, template, someState);

    if (indices == null) return Either.left('Indices not found');
    return Either.right(indices);
  }

  @override
  String? getAddress(String fellowship, String template, int? someInteraction) {
    final fellowshipResult = fellowshipsStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("name", fellowship)));

    final templateResult = templatesStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("name", template)));

    if (fellowshipResult != null && templateResult != null) {
      final cartesianResult = cartesiansStore.findFirstSync(_instance,
          finder: Finder(
            filter: Filter.and([
              Filter.equals("x", fellowshipResult.key),
              Filter.equals("y", templateResult.key),
              Filter.equals("z", someInteraction ?? 0),
            ]),
          ));

      if (cartesianResult == null) return null;
      return cartesianResult["address"]! as String;
    }
    return null;
  }

  @override
  Indices? getCurrentIndicesForFunds(
      String fellowship, String template, int? someState) {
    final fellowshipResult = fellowshipsStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("name", fellowship)));

    final templateResult = templatesStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("name", template)));

    if (fellowshipResult != null && templateResult != null) {
      final x = fellowshipResult["x"]! as int;
      final y = templateResult["y"]! as int;
      final cartesianResult = cartesiansStore.findFirstSync(_instance,
          finder: Finder(
            filter: Filter.and([
              Filter.equals("x", x),
              Filter.equals("y", y),
              Filter.equals("z", someState ?? 0),
            ]),
          ));

      if (cartesianResult != null) {
        final z = (cartesianResult["z"]! as int) + 1;
        return Indices(x: x, y: y, z: z);
      } else {
        return Indices(x: x, y: y, z: 0);
      }
    }
    return null;
  }

  @override
  Indices? setCurrentIndices(
      String fellowship, String template, int interaction) {
    final fellowshipResult = fellowshipsStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("name", fellowship)));

    final templateResult = templatesStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("name", template)));

    // TODO: Incorrect implementation
    if (fellowshipResult != null && templateResult != null) {
      cartesiansStore.add(
          _instance,
          Cartesian(
            x: fellowshipResult["x"]! as int,
            y: templateResult["y"]! as int,
            z: interaction,
            lockPredicate: "", // TODO
            address: "", // TODO
          ).toSembast);
    }
    return null;
  }

  @override
  String getCurrentAddress() {
    final cartesianResult = cartesiansStore.findFirstSync(
      _instance,
      finder: Finder(
        filter: Filter.and([
          Filter.equals("x", 1),
          Filter.equals("y", 1),
        ]),
        sortOrders: [SortOrder("z", false)],
      ),
    );

    if (cartesianResult != null) return cartesianResult["address"]! as String;
    throw Exception('No address found');
  }

  @override
  quivr_shared.Preimage? getPreimage(Proposition_Digest digestProposition) {
    final result = digestsStore.findFirstSync(_instance,
        finder: Finder(
          filter: Filter.equals(
              "digestEvidence",
              Encoding().encodeToBase58Check(
                  Uint8List.fromList(digestProposition.digest.value))),
        ));

    if (result != null) {
      return quivr_shared.Preimage(
          input: Encoding().decodeFromBase58Check("preimageInput").getOrThrow(),
          salt: Encoding().decodeFromBase58Check("preimageSalt").getOrThrow());
    }
    return null;
  }

  @override
  void addPreimage(
      quivr_shared.Preimage preimage, Proposition_Digest digestProposition) {
    digestsStore.add(
      _instance,
      Digest(
        digestEvidence: Encoding().encodeToBase58Check(
            Uint8List.fromList(digestProposition.sizedEvidence.digest.value)),
        preimageInput:
            Encoding().encodeToBase58Check(Uint8List.fromList(preimage.input)),
        preimageSalt:
            Encoding().encodeToBase58Check(Uint8List.fromList(preimage.salt)),
      ).toSembast,
    );
  }

  @override
  Future<void> addEntityVks(
      String fellowship, String template, List<String> entities) async {
    final fellowshipResult = fellowshipsStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("name", fellowship)));

    final templateResult = templatesStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("name", template)));

    if (fellowshipResult != null && templateResult != null) {
      await verificationKeysStore.add(
        _instance,
        sk.VerificationKey(
          x: fellowshipResult["x"]! as int,
          y: templateResult["y"]! as int,
          vks: entities,
        ).toSembast,
      );
    }
  }

  @override
  List<String>? getEntityVks(String fellowship, String template) {
    final fellowshipResult = fellowshipsStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("name", fellowship)));

    final templateResult = templatesStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("name", template)));

    if (fellowshipResult != null && templateResult != null) {
      final verificationKeyResult =
          verificationKeysStore.findFirstSync(_instance,
              finder: Finder(
                filter: Filter.and([
                  Filter.equals("x", fellowshipResult["x"]! as int),
                  Filter.equals("y", templateResult["y"]! as int),
                ]),
              ));

      if (verificationKeyResult != null) {
        return (verificationKeyResult["vks"]! as List).cast<String>();
      }
    }

    return null;
  }

  @override
  Future<void> addNewLockTemplate(
      String template, LockTemplate lockTemplate) async {
    final latest = await templatesStore.findFirst(_instance,
        finder: Finder(sortOrders: [SortOrder("y", false)]));
    final y = latest != null ? ((latest["y"]! as int) + 1) : 0;
    await templatesStore.add(
      _instance,
      Template(
        y: y,
        name: template,
        lock: jsonEncode(lockTemplate.toJson()),
      ).toSembast,
    );
  }

  @override
  LockTemplate? getLockTemplate(String template) {
    final templateResult = templatesStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("name", template)));

    if (templateResult == null) return null;
    return LockTemplate.fromJson(jsonDecode(templateResult["lock"]! as String));
  }

  @override
  Lock? getLock(String fellowship, String template, int nextState) {
    final lockTemplate = getLockTemplate(template);
    final entityVks = getEntityVks(fellowship, template);

    if (lockTemplate == null || entityVks == null) return null;

    final childVks = entityVks.map((vk) {
      final fullKey = quivr_shared.VerificationKey.fromBuffer(
          Encoding().decodeFromBase58Check(vk).get());
      return api.deriveChildVerificationKey(fullKey, nextState);
    });
    final res = lockTemplate.build(childVks.toList());

    return res.isRight ? res.right! : null;
  }
}
