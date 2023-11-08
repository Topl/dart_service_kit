import 'dart:convert';
import 'dart:typed_data';


import 'package:brambldart/brambldart.dart'
    show
        Either,
        Encoding,
        HeightTemplate,
        IntExtension,
        LockTemplate,
        PredicateTemplate,
        SignatureTemplate,
        SizedEvidence,
        WalletApi,
        WalletStateAlgebra;

import 'package:fixnum/fixnum.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:isar/isar.dart';
import 'package:servicekit/api/wallet_key_api.dart';
import 'package:servicekit/models/cartesian.dart';
import 'package:servicekit/models/contract.dart';

import 'package:servicekit/models/fellowship.dart';
import 'package:servicekit/models/verification_key.dart' as sk;
import 'package:topl_common/proto/brambl/models/address.pb.dart';
import 'package:topl_common/proto/brambl/models/box/lock.pb.dart';
import 'package:topl_common/proto/brambl/models/identifier.pb.dart';
import 'package:topl_common/proto/brambl/models/indices.pb.dart';
import 'package:topl_common/proto/quivr/models/proposition.pb.dart';

import 'package:topl_common/proto/quivr/models/shared.pb.dart'
    show Preimage, VerificationKey;

/// An implementation of the WalletStateAlgebra that uses a database to store state information.

class WalletStateApi implements WalletStateAlgebra {

  WalletStateApi(this._instance, this._secureStorage)
      : api = WalletApi(WalletKeyApi(_secureStorage));
  
  final Isar _instance;
  // ignore: unused_field
  final FlutterSecureStorage _secureStorage;
  final WalletApi api;

  @override
  Future<void> initWalletState(
      int networkId, int ledgerId, VerificationKey vk) async {
    final parties = _instance.fellowships;
    final contracts = _instance.contracts;
    final verificationKeys = _instance.verificationKeys;
    final cartesian = _instance.cartesians;

    await _instance.writeTxn(() async {
      final defaultTemplate = PredicateTemplate(
        [SignatureTemplate("ExtendedEd25519", 0)],
        1,
      );

      final genesisTemplate = PredicateTemplate(
        [HeightTemplate('header', 1.toInt64, Int64.MAX_VALUE)],
        1,
      );

      // Create parties
      await parties.put(Fellowship(name: 'nofellowship', xFellowship: 0));
      await parties.put(Fellowship(name: 'self', xFellowship: 1));

      // Create contracts
      await contracts.put(Contract(
          contract: 'default',
          yContract: 1,
          lock: defaultTemplate.toJson().toString()));
      await contracts.put(Contract(
          contract: 'genesis',
          yContract: 2,
          lock: genesisTemplate.toJson().toString()));

      // Create verification keys
      await verificationKeys.put(sk.VerificationKey(
          xFellowship: 1,
          yContract: 1,
          vks: Encoding().encodeToBase58(vk
              .writeToBuffer()))); // TODO(ultimaterex): figure out if encoding to stringbase 58 is better
      await verificationKeys.put(sk.VerificationKey(
          xFellowship: 0,
          yContract: 2,
          vks: Encoding().encodeToBase58(Uint8List(0))));

      final defaultSignatureLock = getLock("self", "default", 1)!; // unsafe
      final signatureLockAddress = LockAddress(
          network: networkId,
          ledger: ledgerId,
          id: LockId(
              value:
                  defaultSignatureLock.predicate.sizedEvidence.digest.value));

      final childVk = api.deriveChildVerificationKey(vk, 1);
      final genesisHeightLock =
          getLock("nofellowship", "genesis", 1)!; // unsafe
      final heightLockAddress = LockAddress(
          network: networkId,
          ledger: ledgerId,
          id: LockId(
              value: genesisHeightLock.predicate.sizedEvidence.digest.value));

      // Create cartesian coordinates
      await cartesian.put(Cartesian(
        xFellowship: 1,
        yContract: 1,
        zState: 1,
        lockPredicate: Encoding()
            .encodeToBase58(defaultSignatureLock.predicate.writeToBuffer()),
        address:
            Encoding().encodeToBase58(signatureLockAddress.writeToBuffer()),
        routine: 'ExtendedEd25519',
        vk: Encoding().encodeToBase58(childVk.writeToBuffer()),
      ));

      await cartesian.put(Cartesian(
        xFellowship: 0,
        yContract: 2,
        zState: 1,
        lockPredicate: Encoding()
            .encodeToBase58(genesisHeightLock.predicate.writeToBuffer()),
        address: Encoding().encodeToBase58(heightLockAddress.writeToBuffer()),
      ));
    });
  }

  @override
  Indices? getIndicesBySignature(
      Proposition_DigitalSignature signatureProposition) {
    final cartesian = _instance.cartesians;

    final result = cartesian
        .where()
        .filter()
        .routineEqualTo(signatureProposition.routine)
        .and()
        .vkEqualTo(Encoding().encodeToBase58(
            signatureProposition.verificationKey.writeToBuffer()))
        .findAllSync();

    if (result.isEmpty) return null;
    return Indices(
      x: result.first.xFellowship,
      y: result.first.yContract,
      z: result.first.zState,
    );
  }

  @override
  Lock_Predicate? getLockByIndex(Indices indices) {
    final cartesian = _instance.cartesians;

    final result = cartesian
        .where()
        .filter()
        .xFellowshipEqualTo(indices.x)
        .and()
        .yContractEqualTo(indices.y)
        .and()
        .zStateEqualTo(indices.z)
        .findAllSync();

    if (result.isEmpty) return null;
    return Lock_Predicate.fromBuffer(
        Encoding().decodeFromBase58Check(result.first.lockPredicate).get());
  }

  @override
  Lock_Predicate? getLockByAddress(String lockAddress) {
    final cartesian = _instance.cartesians;

    final result =
        cartesian.where().filter().addressEqualTo(lockAddress).findAllSync();

    if (result.isEmpty) return null;
    return Lock_Predicate.fromBuffer(
        Encoding().decodeFromBase58Check(result.first.lockPredicate).get());
  }

  @override
  Future<void> updateWalletState(String lockPredicate, String lockAddress,
      String? routine, String? vk, Indices indices) async {
    final cartesian = _instance.cartesians;

    await cartesian.put(
      Cartesian(
          xFellowship: indices.x,
          yContract: indices.y,
          zState: indices.z,
          lockPredicate: lockPredicate,
          address: lockAddress,
          routine: routine,
          vk: vk),
    );
  }

  @override
  Indices? getNextIndicesForFunds(String fellowship, String contract) {
    final parties = _instance.fellowships;
    final contracts = _instance.contracts;
    final cartesian = _instance.cartesians;

    final fellowshipResult =
        parties.where().filter().nameEqualTo(fellowship).findFirstSync();

    final contractResult =
        contracts.where().filter().contractEqualTo(contract).findFirstSync();

    if (fellowshipResult != null && contractResult != null) {
      final cartesianResult = cartesian
          .where()
          .filter()
          .xFellowshipEqualTo(fellowshipResult.xFellowship)
          .and()
          .yContractEqualTo(contractResult.yContract)
          .sortByZStateDesc()
          .findFirstSync();

      if (cartesianResult != null) {
        return Indices(
          x: cartesianResult.xFellowship,
          y: cartesianResult.yContract,
          z: cartesianResult.zState + 1,
        );
      }
    }

    return null;
  }

  bool validateFellowship(String fellowship) {
    final parties = _instance.fellowships;

    final fellowshipResult =
        parties.where().filter().nameEqualTo(fellowship).findFirstSync();
    return fellowshipResult != null;
  }

  bool validateContract(String contract) {
    final contracts = _instance.contracts;

    final contractResult =
        contracts.where().filter().contractEqualTo(contract).findFirstSync();

    return contractResult != null;
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
    final parties = _instance.fellowships;
    final contracts = _instance.contracts;
    final cartesian = _instance.cartesians;

    final fellowshipResult =
        parties.where().filter().nameEqualTo(fellowship).findFirstSync();
    final contractResult =
        contracts.where().filter().contractEqualTo(contract).findFirstSync();

    if (fellowshipResult != null && contractResult != null) {
      final cartesianResult = cartesian
          .where()
          .filter()
          .xFellowshipEqualTo(fellowshipResult.xFellowship)
          .and()
          .yContractEqualTo(contractResult.yContract)
          .and()
          .zStateEqualTo(someState ?? 0)
          .findFirstSync();

      if (cartesianResult == null) return null;
      return cartesianResult.address;
    }
    return null;
  }

  @override
  Indices? getCurrentIndicesForFunds(
      String fellowship, String contract, int? someState) {
    final parties = _instance.fellowships;
    final contracts = _instance.contracts;
    final cartesian = _instance.cartesians;

    final fellowshipResult =
        parties.where().filter().nameEqualTo(fellowship).findFirstSync();
    final contractResult =
        contracts.where().filter().contractEqualTo(contract).findFirstSync();

    if (fellowshipResult != null && contractResult != null) {
      final cartesianResult = cartesian
          .where()
          .filter()
          .xFellowshipEqualTo(fellowshipResult.xFellowship)
          .and()
          .yContractEqualTo(contractResult.yContract)
          .and()
          .zStateEqualTo(someState ?? 0)
          .findFirstSync();

      if (cartesianResult == null) return null;
      return Indices(
        x: cartesianResult.xFellowship,
        y: cartesianResult.yContract,
        z: cartesianResult.zState,
      );
    }
    return null;
  }

  @override
  String getCurrentAddress() {
    final cartesian = _instance.cartesians;

    final cartesianResult = cartesian
        .where()
        .filter()
        .xFellowshipEqualTo(1)
        .and()
        .yContractEqualTo(1)
        .sortByZStateDesc()
        .findFirstSync();

    if (cartesianResult != null) return cartesianResult.address;
    throw Exception('No address found');
  }

  // TODO(ultimaterex): We are not yet supporting Digest propositions in brambl-cli
  @override
  Preimage? getPreimage(Proposition_Digest digestProposition) {
    // TODO(ultimaterex): implement getPreimage
    throw UnimplementedError();
  }

  @override
  Future<void> addEntityVks(
      String fellowship, String contract, List<String> entities) async {
    final parties = _instance.fellowships;
    final contracts = _instance.contracts;
    final verificationKeys = _instance.verificationKeys;

    final fellowshipResult =
        parties.where().filter().nameEqualTo(fellowship).findFirstSync();
    final contractResult =
        contracts.where().filter().contractEqualTo(contract).findFirstSync();

    if (fellowshipResult != null && contractResult != null) {
      await verificationKeys.put(
        sk.VerificationKey(
          xFellowship: fellowshipResult.xFellowship,
          yContract: contractResult.yContract,
          vks: jsonEncode(entities),
        ),
      );
    }
  }

  @override
  List<String>? getEntityVks(String fellowship, String contract) {
    final parties = _instance.fellowships;
    final contracts = _instance.contracts;
    final verificationKeys = _instance.verificationKeys;

    final fellowshipResult =
        parties.where().filter().nameEqualTo(fellowship).findFirstSync();
    final contractResult =
        contracts.where().filter().contractEqualTo(contract).findFirstSync();

    if (fellowshipResult != null && contractResult != null) {
      final verificationKeyResult = verificationKeys
          .where()
          .filter()
          .xFellowshipEqualTo(fellowshipResult.xFellowship)
          .and()
          .yContractEqualTo(contractResult.yContract)
          .findFirstSync();

      if (verificationKeyResult != null) {
        return jsonDecode(verificationKeyResult.vks);
      }
    }

    return null;
  }

  @override
  Future<void> addNewLockTemplate(
      String contract, LockTemplate lockTemplate) async {
    final contracts = _instance.contracts;

    final contractResult =
        contracts.where().sortByYContractDesc().findFirstSync();


    final yContract = contractResult != null ? contractResult.yContract + 1 : 1;

    await contracts.put(
      Contract(
        contract: contract,
        yContract: yContract,
        lock: jsonEncode(lockTemplate),
      ),
    );
  }

  @override
  LockTemplate? getLockTemplate(String contract) {
    final contracts = _instance.contracts;

    final contractResult =
        contracts.where().filter().contractEqualTo(contract).findFirstSync();


    if (contractResult == null) return null;
    return LockTemplate.fromJson(jsonDecode(contractResult.lock));
  }

  @override
  Lock? getLock(String fellowship, String contract, int nextState) {
    final lockTemplate = getLockTemplate(contract);
    final entityVks = getEntityVks(fellowship, contract);


    if (lockTemplate == null || entityVks == null) return null;

    final childVks = entityVks.map((vk) {

      final fullKey = VerificationKey.fromBuffer(
          Encoding().decodeFromBase58Check(vk).get());
      return api.deriveChildVerificationKey(fullKey, nextState);
    });
    final res = lockTemplate.build(childVks.toList());

    return res.isRight ? res.right! : null;
  }
}
