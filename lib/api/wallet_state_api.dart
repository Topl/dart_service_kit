import 'dart:convert';

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
import 'package:servicekit/models/contract.dart';

import 'package:servicekit/models/fellowship.dart';
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
      int networkId, int ledgerId, quivr_shared
    .VerificationKey vk) async {
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
        _instance, Fellowship(name: 'nofellowship', xFellowship: 0).toSembast);
    await fellowshipsStore.add(
        _instance, Fellowship(name: 'self', xFellowship: 1).toSembast);

    // Create contracts
    await contractsStore.add(
        _instance,
        Contract(
                contract: 'default',
                yContract: 1,
                lock: jsonEncode(defaultTemplate.toJson()))
            .toSembast);
    await contractsStore.add(
        _instance,
        Contract(
                contract: 'genesis',
                yContract: 2,
                lock: jsonEncode(genesisTemplate.toJson()))
            .toSembast);

    // Create verification keys
    await verificationKeysStore.add(
        _instance,
        sk.VerificationKey(
          xFellowship: 1,
          yContract: 1,
          vks: [Encoding().encodeToBase58Check(vk.writeToBuffer())],
        ).toSembast); // TODO(ultimaterex): figure out if encoding to stringbase 58 is better
    await verificationKeysStore.add(
        _instance,
        sk.VerificationKey(
          xFellowship: 0,
          yContract: 2,
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
          yContract: 1,
          zState: 1,
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
          yContract: 2,
          zState: 1,
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
      y: result.first["yContract"] as int?,
      z: result.first["zState"] as int?,
    );
  }

  @override
  Lock_Predicate? getLockByIndex(Indices indices) {
    final result = cartesiansStore.findSync(_instance,
        finder: Finder(
            filter: Filter.and([
          Filter.equals("xFellowship", indices.x),
          Filter.equals("yContract", indices.y),
          Filter.equals("zState", indices.z),
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
          Filter.equals("lockAddress", lockAddress),
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
              yContract: indices.y,
              zState: indices.z,
              lockPredicate: lockPredicate,
              address: lockAddress,
              routine: routine,
              vk: vk)
          .toSembast,
    );
  }

  @override
  Indices? getNextIndicesForFunds(String fellowship, String contract) {
    final fellowshipResult = fellowshipsStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("name", fellowship)));

    final contractResult = contractsStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("contract", contract)));

    if (fellowshipResult != null && contractResult != null) {
      final cartesianResult = cartesiansStore.findFirstSync(_instance,
          finder: Finder(
              filter: Filter.and([
                Filter.equals("xFellowship", fellowshipResult["xFellowship"]),
                Filter.equals("yContract", contractResult.key),
              ]),
              sortOrders: [SortOrder("zState", false)]));

      if (cartesianResult != null) {
        return Indices(
          x: cartesianResult["xFellowship"]! as int,
          y: cartesianResult["yContract"]! as int,
          z: (cartesianResult["zState"]! as int) + 1,
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

  bool validateContract(String contract) {
    final result = contractsStore.findFirstSync(_instance,
        finder: Finder(
            filter: Filter.and([
          Filter.equals("contract", contract),
        ])));
    return result != null;
  }

  @override
  Either<String, Indices> validateCurrentIndicesForFunds(
      String fellowship, String contract, int? someState) {
    // ignore: unused_local_variable
    final p = validateFellowship(fellowship);
    // ignore: unused_local_variable
    final c = validateContract(contract);
    final indices = getCurrentIndicesForFunds(fellowship, contract, someState);

    if (indices == null) return Either.left('Indices not found');
    return Either.right(indices);
  }

  @override
  String? getAddress(String fellowship, String contract, int? someState) {
    final fellowshipResult = fellowshipsStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("name", fellowship)));

    final contractResult = contractsStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("contract", contract)));

    if (fellowshipResult != null && contractResult != null) {
      final cartesianResult = cartesiansStore.findFirstSync(_instance,
          finder: Finder(
            filter: Filter.and([
              Filter.equals("xFellowship", fellowshipResult["xFellowship"]),
              Filter.equals("yContract", contractResult.key),
              Filter.equals("zState", someState ?? 0),
            ]),
          ));

      if (cartesianResult == null) return null;
      return cartesianResult["address"]! as String;
    }
    return null;
  }

  @override
  Indices? getCurrentIndicesForFunds(
      String fellowship, String contract, int? someState) {
    final fellowshipResult = fellowshipsStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("name", fellowship)));

    final contractResult = contractsStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("contract", contract)));

    if (fellowshipResult != null && contractResult != null) {
      final cartesianResult = cartesiansStore.findFirstSync(_instance,
          finder: Finder(
            filter: Filter.and([
              Filter.equals("xFellowship", fellowshipResult["xFellowship"]),
              Filter.equals("yContract", contractResult.key),
              Filter.equals("zState", someState ?? 0),
            ]),
          ));

      if (cartesianResult == null) return null;
      return Indices(
        x: cartesianResult["xFellowship"]! as int,
        y: cartesianResult["yContract"]! as int,
        z: (cartesianResult["zState"]! as int) + 1,
      );
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
          Filter.equals("yContract", 1),
        ]),
        sortOrders: [SortOrder("zState", false)],
      ),
    );

    if (cartesianResult != null) return cartesianResult["address"]! as String;
    throw Exception('No address found');
  }

  // TODO(ultimaterex): We are not yet supporting Digest propositions in brambl-cli
  @override
  quivr_shared
.Preimage? getPreimage(Proposition_Digest digestProposition) {
    // TODO(ultimaterex): implement getPreimage
    throw UnimplementedError();
  }

  @override
  Future<void> addEntityVks(
      String fellowship, String contract, List<String> entities) async {
    final fellowshipResult = fellowshipsStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("name", fellowship)));

    final contractResult = contractsStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("contract", contract)));

    if (fellowshipResult != null && contractResult != null) {
      await verificationKeysStore.add(
        _instance,
        sk.VerificationKey(
          xFellowship: fellowshipResult["xFellowship"]! as int,
          yContract: contractResult.key,
          vks: entities,
        ).toSembast,
      );
    }
  }

  @override
  List<String>? getEntityVks(String fellowship, String contract) {
    final fellowshipResult = fellowshipsStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("name", fellowship)));

    final contractResult = contractsStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("contract", contract)));

    if (fellowshipResult != null && contractResult != null) {
      final verificationKeyResult =
          verificationKeysStore.findFirstSync(_instance,
              finder: Finder(
                filter: Filter.and([
                  Filter.equals("xFellowship", fellowshipResult["xFellowship"]),
                  Filter.equals("yContract", contractResult.key),
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
      String contract, LockTemplate lockTemplate) async {
    final contractResult = cartesiansStore.findFirstSync(_instance,
        finder: Finder(
          sortOrders: [SortOrder("yContract", false)],
        ));

    final yContract =
        contractResult != null ? (contractResult["yContract"]! as int) + 1 : 1;

    await contractsStore.add(
      _instance,
      Contract(
        contract: contract,
        yContract: yContract,
        lock: jsonEncode(lockTemplate),
      ).toSembast,
    );
  }

  @override
  LockTemplate? getLockTemplate(String contract) {
    final contractResult = contractsStore.findFirstSync(_instance,
        finder: Finder(filter: Filter.equals("contract", contract)));

    if (contractResult == null) return null;
    return LockTemplate.fromJson(jsonDecode(contractResult["lock"]! as String));
  }

  @override
  Lock? getLock(String fellowship, String contract, int nextState) {
    final lockTemplate = getLockTemplate(contract);
    final entityVks = getEntityVks(fellowship, contract);

    if (lockTemplate == null || entityVks == null) return null;

    final childVks = entityVks.map((vk) {
      final fullKey = quivr_shared
    .VerificationKey.fromBuffer(
          Encoding().decodeFromBase58Check(vk).get());
      return api.deriveChildVerificationKey(fullKey, nextState);
    });
    final res = lockTemplate.build(childVks.toList());

    return res.isRight ? res.right! : null;
  }
}
