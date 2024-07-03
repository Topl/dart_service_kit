import 'package:brambldart/brambldart.dart'
    show
        AddressCodecs,
        Either,
        Encoding,
        EncodingError,
        GenusQueryAlgebra,
        InvalidInputString,
        LongAsInt128,
        TransactionBuilderApi,
        ValueTypeIdentifier,
        WalletApi,
        WalletStateAlgebra,
        WithResultExtension;
import 'package:servicekit/toolkit/features/simple_transaction/simple_transaction_algebra_error.dart';
import 'package:servicekit/toolkit/features/wallet/wallet_management_utils.dart';
import 'package:topl_common/proto/brambl/models/address.pb.dart';
import 'package:topl_common/proto/brambl/models/box/lock.pb.dart';
import 'package:topl_common/proto/brambl/models/indices.pb.dart';
import 'package:topl_common/proto/brambl/models/transaction/io_transaction.pb.dart';
import 'package:topl_common/proto/genus/genus_models.pb.dart';
import 'package:topl_common/proto/quivr/models/shared.pb.dart';

abstract class SimpleTransactionAlgebraDefinition {
  Future<Either<SimpleTransactionAlgebraError, IoTransaction>>
      createSimpleTransactionFromParams({
    required String keyfile,
    required String password,
    required String fromFellowship,
    required String fromContract,
    int? someFromState,
    String? someChangeFellowship,
    String? someChangeContract,
    int? someChangeState,
    LockAddress? someToAddress,
    String? someToFellowship,
    String? someToContract,
    required int amount,
    required int fee,
    required ValueTypeIdentifier tokenType,
  });
}

class SimpleTransactionAlgebra extends SimpleTransactionAlgebraDefinition {
  SimpleTransactionAlgebra({
    required this.walletApi,
    required this.walletStateApi,
    required this.utxoAlgebra,
    required this.transactionBuilderApi,
    required this.walletManagementUtils,
  });

  final WalletApi walletApi;
  final WalletStateAlgebra walletStateApi;
  final GenusQueryAlgebra utxoAlgebra;
  final TransactionBuilderApi transactionBuilderApi;
  final WalletManagementUtils walletManagementUtils;

  /// Builds a transaction.
  ///
  /// Throws a [CannotSerializeProtobufFile] if there is a problem serializing the transaction.
  Future<IoTransaction> buildTransaction(
    List<Txo> txos,
    String? someChangeFellowship,
    String? someChangeContract,
    int? someChangeState,
    Lock_Predicate predicateFundsToUnlock,
    Lock lockForChange,
    LockAddress recipientLockAddress,
    int amount,
    int fee,
    Indices? someNextIndices,
    KeyPair keyPair,
    ValueTypeIdentifier typeIdentifier,
  ) async {
    try {
      final lockChange = await transactionBuilderApi.lockAddress(lockForChange);
      final eitherIoTransaction =
          await transactionBuilderApi.buildTransferAmountTransaction(
        typeIdentifier,
        txos,
        predicateFundsToUnlock,
        amount,
        recipientLockAddress,
        lockChange,
        fee,
      );

      final ioTransaction = eitherIoTransaction.fold((l) => throw l, (r) => r);

      bool nextIndicesExist = false;
      if (someChangeFellowship != null &&
          someChangeContract != null &&
          someChangeState != null) {
        nextIndicesExist = !(walletStateApi.getCurrentIndicesForFunds(
              someChangeFellowship,
              someChangeContract,
              someChangeState,
            ) ==
            null);
      }

      if (ioTransaction.outputs.length >= 2 && !nextIndicesExist) {
        final lockAddress =
            await transactionBuilderApi.lockAddress(lockForChange);
        final vk = someNextIndices != null
            ? walletApi.deriveChildKeys(keyPair, someNextIndices)
            : null;

        walletStateApi.updateWalletState(
          Encoding()
              .encodeToBase58Check(lockForChange.predicate.writeToBuffer()),
          AddressCodecs.encode(lockAddress),
          vk != null ? "ExtendedEd25519" : null,
          vk != null ? Encoding().encodeToBase58(vk.writeToBuffer()) : null,
          someNextIndices!, // TODO(ultimaterex): Figure out why nullable is allowed but we don't have a null path
        );
      }
      return ioTransaction;
    } catch (e) {
      throw CannotSerializeProtobufFile('Cannot write to file');
    }
  }

  @override
  Future<Either<SimpleTransactionAlgebraError, IoTransaction>>
      createSimpleTransactionFromParams({
    required String keyfile,
    required String password,
    required String fromFellowship,
    required String fromContract,
    int? someFromState,
    String? someChangeFellowship,
    String? someChangeContract,
    int? someChangeState,
    LockAddress? someToAddress,
    String? someToFellowship,
    String? someToContract,
    required int amount,
    required int fee,
    required ValueTypeIdentifier tokenType,
  }) async {
    try {
      final keyPair = await walletManagementUtils.loadKeys(keyfile, password);
      final someCurrentIndices = walletStateApi.getCurrentIndicesForFunds(
          fromFellowship, fromContract, someFromState);
      final predicateFundsToUnlock = someCurrentIndices != null
          ? walletStateApi.getLockByIndex(someCurrentIndices)
          : null;

      Indices? someNextIndices;
      if (someChangeFellowship != null &&
          someChangeContract != null &&
          someChangeState != null) {
        someNextIndices = walletStateApi.getCurrentIndicesForFunds(
            someChangeFellowship, someChangeContract, someChangeState);
      } else {
        someNextIndices =
            walletStateApi.getNextIndicesForFunds(fromFellowship, fromContract);
      }

      Lock? changeLock;
      if (someNextIndices != null) {
        changeLock = walletStateApi.getLock(
            fromFellowship, fromContract, someNextIndices.z);
      }

      final fromAddress = predicateFundsToUnlock != null
          ? await transactionBuilderApi
              .lockAddress(Lock(predicate: predicateFundsToUnlock))
          : null;

      List<Txo>? txos;
      try {
        txos = await utxoAlgebra.queryUtxo(fromAddress: fromAddress!);
      } catch (_) {
        throw CreateTxError('Problem contacting network');
      }

      txos = txos
          .where((x) =>
              !x.transactionOutput.value.hasTopl() &&
              !x.transactionOutput.value.hasUpdateProposal())
          .toList();

      Either<EncodingError, LockAddress> toAddressOpt;
      if (someToAddress != null) {
        toAddressOpt = Either.right(someToAddress);
      } else if (someToFellowship != null && someToContract != null) {
        final addrStr =
            walletStateApi.getAddress(someToFellowship, someToContract, null);
        toAddressOpt = AddressCodecs.decode(addrStr!);
      } else {
        toAddressOpt = Either.left(InvalidInputString());
      }

      if (txos.isEmpty) {
        throw CreateTxError('No LVL txos found');
      } else if (changeLock != null && toAddressOpt.isRight) {
        return (await buildTransaction(
          txos,
          someChangeFellowship,
          someChangeContract,
          someChangeState,
          predicateFundsToUnlock!,
          changeLock,
          toAddressOpt.get(),
          amount,
          fee,
          someNextIndices,
          keyPair.get(),
          tokenType,
        ))
            .withResult((p0) => Either.right(p0));
      } else if (changeLock == null) {
        throw CreateTxError('Unable to generate change lock');
      } else {
        throw CreateTxError('Unable to derive recipient address');
      }
    } catch (e) {
      if (e is SimpleTransactionAlgebraError) {
        return Either.left(e);
      } else {
        return Either.left(UnexpectedError(e.toString()));
      }
    }
  }
}
