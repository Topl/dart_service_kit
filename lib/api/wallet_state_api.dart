import 'dart:typed_data';

import 'package:brambl_dart/brambl_dart.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:isar/isar.dart';
import 'package:servicekit/api/wallet_key_api.dart';
import 'package:servicekit/models/cartesian.dart';
import 'package:servicekit/models/contract.dart';
import 'package:servicekit/models/party.dart';
import 'package:servicekit/models/verification_key.dart' as sk;
import 'package:topl_common/proto/brambl/models/address.pb.dart';
import 'package:topl_common/proto/brambl/models/box/lock.pb.dart';
import 'package:topl_common/proto/brambl/models/identifier.pb.dart';
import 'package:topl_common/proto/brambl/models/indices.pb.dart';
import 'package:topl_common/proto/quivr/models/proposition.pb.dart';
import 'package:topl_common/proto/quivr/models/shared.pb.dart' show Preimage, VerificationKey;

/// An implementation of the WalletStateAlgebra that uses a database to store state information.

class WalletStateApi implements WalletStateAlgebra {
  final Isar _instance;
  final FlutterSecureStorage _secureStorage;
  final WalletApi api;

  WalletStateApi(this._instance, this._secureStorage) : api = WalletApi(WalletKeyApi(_secureStorage));

  @override
  Future<void> initWalletState(int networkId, int ledgerId, VerificationKey vk) async {
    final parties = _instance.partys;
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
      await parties.put(Party(name: 'noparty', xParty: 0));
      await parties.put(Party(name: 'self', xParty: 1));

      // Create contracts
      await contracts.put(Contract(contract: 'default', yContract: 1, lock: defaultTemplate.toJson().toString()));
      await contracts.put(Contract(contract: 'genesis', yContract: 2, lock: genesisTemplate.toJson().toString()));

      // Create verification keys
      await verificationKeys.put(sk.VerificationKey(
          xParty: 1,
          yContract: 1,
          vks: Encoding()
              .encodeToBase58(vk.writeToBuffer()))); // TODO: figure out if encoding to stringbase 58 is better
      await verificationKeys
          .put(sk.VerificationKey(xParty: 0, yContract: 2, vks: Encoding().encodeToBase58(Uint8List(0))));

      final defaultSignatureLock = getLock("self", "default", 1)!; // unsafe
      final signatureLockAddress = LockAddress(
          network: networkId,
          ledger: ledgerId,
          id: LockId(value: defaultSignatureLock.predicate.sizedEvidence.digest.value));

      final childVk = api.deriveChildVerificationKey(vk, 1);
      final genesisHeightLock = getLock("noparty", "genesis", 1)!; // unsafe
      final heightLockAddress = LockAddress(
          network: networkId,
          ledger: ledgerId,
          id: LockId(value: genesisHeightLock.predicate.sizedEvidence.digest.value));

      // Create cartesian coordinates
      await cartesian.put(Cartesian(
        xParty: 1,
        yContract: 1,
        zState: 1,
        lockPredicate: Encoding().encodeToBase58(defaultSignatureLock.predicate.writeToBuffer()),
        address: Encoding().encodeToBase58(signatureLockAddress.writeToBuffer()),
        routine: 'ExtendedEd25519',
        vk: Encoding().encodeToBase58(childVk.writeToBuffer()),
      ));

      await cartesian.put(Cartesian(
        xParty: 0,
        yContract: 2,
        zState: 1,
        lockPredicate: Encoding().encodeToBase58(genesisHeightLock.predicate.writeToBuffer()),
        address: Encoding().encodeToBase58(heightLockAddress.writeToBuffer()),
      ));
    });
  }

  @override
  Indices? getIndicesBySignature(Proposition_DigitalSignature signatureProposition) {
    final cartesian = _instance.cartesians;

    final result = cartesian
        .where()
        .filter()
        .routineEqualTo(signatureProposition.routine)
        .and()
        .vkEqualTo(Encoding().encodeToBase58(signatureProposition.verificationKey.writeToBuffer()))
        .findAllSync();

    if (result.isEmpty) return null;
    return Indices(
      x: result.first.xParty,
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
        .xPartyEqualTo(indices.x)
        .and()
        .yContractEqualTo(indices.y)
        .and()
        .zStateEqualTo(indices.z)
        .findAllSync();

    if (result.isEmpty) return null;
    return Lock_Predicate.fromBuffer(Encoding().decodeFromBase58Check(result.first.lockPredicate).get());
  }

  @override
  Lock_Predicate? getLockByAddress(String lockAddress) {
    final cartesian = _instance.cartesians;

    final result = cartesian.where().filter().addressEqualTo(lockAddress).findAllSync();

    if (result.isEmpty) return null;
    return Lock_Predicate.fromBuffer(Encoding().decodeFromBase58Check(result.first.lockPredicate).get());
  }

  @override
  Future<void> updateWalletState(
      String lockPredicate, String lockAddress, String? routine, String? vk, Indices indices) async {
    final cartesian = _instance.cartesians;

    await cartesian.put(
      Cartesian(
          xParty: indices.x,
          yContract: indices.y,
          zState: indices.z,
          lockPredicate: lockPredicate,
          address: lockAddress,
          routine: routine ?? '',
          vk: vk),
    );
  }

  @override
  Indices? getNextIndicesForFunds(String party, String contract) {
    // TODO: implement getNextIndicesForFunds
    throw UnimplementedError();
  }

  @override
  void addEntityVks(String party, String contract, List<String> entities) {
    // TODO: implement addEntityVks
  }

  @override
  void addNewLockTemplate(String contract, LockTemplate lockTemplate) {
    // TODO: implement addNewLockTemplate
  }

  @override
  String? getAddress(String party, String contract, int? someState) {
    // TODO: implement getAddress
    throw UnimplementedError();
  }

  @override
  String getCurrentAddress() {
    // TODO: implement getCurrentAddress
    throw UnimplementedError();
  }

  @override
  Indices? getCurrentIndicesForFunds(String party, String contract, int? someState) {
    // TODO: implement getCurrentIndicesForFunds
    throw UnimplementedError();
  }

  @override
  List<String>? getEntityVks(String party, String contract) {
    // TODO: implement getEntityVks
    throw UnimplementedError();
  }

  @override
  Lock? getLock(String party, String contract, int nextState) {
    // TODO: implement getLock
    throw UnimplementedError();
  }

  @override
  LockTemplate? getLockTemplate(String contract) {
    // TODO: implement getLockTemplate
    throw UnimplementedError();
  }

  @override
  Preimage? getPreimage(Proposition_Digest digestProposition) {
    // TODO: implement getPreimage
    throw UnimplementedError();
  }

  @override
  (String, Indices)? validateCurrentIndicesForFunds(String party, String contract, int? someState) {
    // TODO: implement validateCurrentIndicesForFunds
    throw UnimplementedError();
  }
}
