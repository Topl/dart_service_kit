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
    final genesisXFellowship = await fellowshipsStore.add(
        _instance, Fellowship(name: 'nofellowship').toSembast);
    final selfXFellowship = await fellowshipsStore.add(
        _instance, Fellowship(name: 'self').toSembast);

    // Create templates
    final selfYTemplate = await templatesStore.add(
        _instance,
        Template(
                template: 'default', lock: jsonEncode(defaultTemplate.toJson()))
            .toSembast);
    final genesisYTemplate = await templatesStore.add(
        _instance,
        Template(
                template: 'genesis', lock: jsonEncode(genesisTemplate.toJson()))
            .toSembast);

    // Create verification keys
    await verificationKeysStore.add(
        _instance,
        sk.VerificationKey(
          xFellowship: selfXFellowship,
          yTemplate: selfYTemplate,
          vks: [Encoding().encodeToBase58Check(vk.writeToBuffer())],
        ).toSembast); // TODO(ultimaterex): figure out if encoding to stringbase 58 is better
    await verificationKeysStore.add(
        _instance,
        sk.VerificationKey(
          xFellowship: genesisXFellowship,
          yTemplate: genesisYTemplate,
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
          xFellowship: 1,
          yTemplate: 1,
          zInteraction: 1,
          lockPredicate: Encoding().encodeToBase58Check(
              defaultSignatureLock.predicate.writeToBuffer()),
          address: AddressCodecs.encode(signatureLockAddress),
          routine: 'ExtendedEd25519',
          vk: Encoding().encodeToBase58Check(childVk.writeToBuffer()),
        ).toSembast);

    await cartesiansStore.add(
        _instance,
        Cartesian(
          xFellowship: 0,
          yTemplate: 2,
          zInteraction: 1,
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
      x: result.first["xFellowship"] as int?,
      y: result.first["yTemplate"] as int?,
      z: result.first["zInteraction"] as int?,
    );
  }

  @override
  Lock_Predicate? getLockByIndex(Indices indices) {
    final result = cartesiansStore.findSync(_instance,
        finder: Finder(
            filter: Filter.and([
          Filter.equals("xFellowship", indices.x),
          Filter.equals("yTemplate", indices.y),
          Filter.equals("zInteraction", indices.z),
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
              xFellowship: indices.x,
              yTemplate: indices.y,
              zInteraction: indices.z,
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
        finder: Finder(filter: Filter.equals("template", template)));

    if (fellowshipResult != null && templateResult != null) {
      final cartesianResult = cartesiansStore.findFirstSync(_instance,
          finder: Finder(
              filter: Filter.and([
                Filter.equals("xFellowship", fellowshipResult.key),
                Filter.equals("yTemplate", templateResult.key),
              ]),
              sortOrders: [SortOrder("zInteraction", false)]));

      if (cartesianResult != null) {
        return Indices(
          x: cartesianResult["xFellowship"]! as int,
          y: cartesianResult["yTemplate"]! as int,
          z: (cartesianResult["zInteraction"]! as int) + 1,
        );
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
          Filter.equals("template", template),
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
        finder: Finder(filter: Filter.equals("template", template)));

    if (fellowshipResult != null && templateResult != null) {
      final cartesianResult = cartesiansStore.findFirstSync(_instance,
          finder: Finder(
            filter: Filter.and([
              Filter.equals("xFellowship", fellowshipResult.key),
              Filter.equals("yTemplate", templateResult.key),
              Filter.equals("zInteraction", someInteraction ?? 0),
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
        finder: Finder(filter: Filter.equals("template", template)));

    if (fellowshipResult != null && templateResult != null) {
      final cartesianResult = cartesiansStore.findFirstSync(_instance,
          finder: Finder(
            filter: Filter.and([
              Filter.equals("xFellowship", fellowshipResult.key),
              Filter.equals("yTemplate", templateResult.key),
              Filter.equals("zInteraction", someState ?? 0),
            ]),
          ));

      if (cartesianResult == null) return null;
      return Indices(
        x: cartesianResult["xFellowship"]! as int,
        y: cartesianResult["yTemplate"]! as int,
        z: (cartesianResult["zInteraction"]! as int) + 1,
      );
    }
    return null;
  }

  @override
  Indices? setCurrentIndices(
      String fellowship, String template, int interaction) {
    final fellowshipResult = fellowshipsStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("name", fellowship)));

    final templateResult = templatesStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("template", template)));

    // TODO: Incorrect implementation
    if (fellowshipResult != null && templateResult != null) {
      cartesiansStore.add(
          _instance,
          Cartesian(
            xFellowship: fellowshipResult.key,
            yTemplate: templateResult.key,
            zInteraction: interaction,
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
          Filter.equals("xFellowship", 1),
          Filter.equals("yTemplate", 1),
        ]),
        sortOrders: [SortOrder("zInteraction", false)],
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
        finder: Finder(filter: Filter.equals("template", template)));

    if (fellowshipResult != null && templateResult != null) {
      await verificationKeysStore.add(
        _instance,
        sk.VerificationKey(
          xFellowship: fellowshipResult.key,
          yTemplate: templateResult.key,
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
        finder: Finder(filter: Filter.equals("template", template)));

    if (fellowshipResult != null && templateResult != null) {
      final verificationKeyResult =
          verificationKeysStore.findFirstSync(_instance,
              finder: Finder(
                filter: Filter.and([
                  Filter.equals("xFellowship", fellowshipResult.key),
                  Filter.equals("yTemplate", templateResult.key),
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
    await templatesStore.add(
      _instance,
      Template(
        template: template,
        lock: jsonEncode(lockTemplate.toJson()),
      ).toSembast,
    );
  }

  @override
  LockTemplate? getLockTemplate(String template) {
    final templateResult = templatesStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("template", template)));

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
