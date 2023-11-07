import 'package:brambldart/brambldart.dart';
import 'package:servicekit/toolkit/features/simple_transaction/simple_transaction_algebra.dart';
import 'package:topl_common/proto/brambl/models/address.pb.dart';
import 'package:topl_common/proto/brambl/models/identifier.pb.dart';

export 'simple_transaction_algebra.dart';
export 'simple_transaction_algebra_error.dart';

class SimpleTransaction {
  SimpleTransaction({
    required this.walletStateAlgebra,
    required this.simpleTransactionAlgebra,
  });

  final WalletStateAlgebra walletStateAlgebra;
  final SimpleTransactionAlgebra simpleTransactionAlgebra;

  Future<Either<String, String>> createSimpleTransactionFromParams({
    required String keyfile,
    required String password,
    required (String, String, int?) fromCoordinates,
    required (String?, String?, int?) changeCoordinates,
    LockAddress? someToAddress,
    String? someToFellowship,
    String? someToContract,
    required int amount,
    required int fee,
    required ValueTypeIdentifier tokenType,
    Option<GroupId>? groupId,
    Option<SeriesId>? seriesId,
  }) async {
    try {
      final fromFellowship = fromCoordinates.$1;
      final fromContract = fromCoordinates.$2;
      final someFromState = fromCoordinates.$3;
      final someChangeFellowship = changeCoordinates.$1;
      final someChangeContract = changeCoordinates.$2;
      final someChangeState = changeCoordinates.$3;

      final validationResult =
          walletStateAlgebra.validateCurrentIndicesForFunds(
              fromFellowship, fromContract, someFromState);

      if (validationResult.isLeft) {
        return Either.left('Invalid params\n ${validationResult.left}');
      }

      final res =
          await simpleTransactionAlgebra.createSimpleTransactionFromParams(
        keyfile: keyfile,
        password: password,
        fromFellowship: fromFellowship,
        fromContract: fromContract,
        someFromState: someFromState,
        someChangeFellowship: someChangeFellowship,
        someChangeContract: someChangeContract,
        someChangeState: someChangeState,
        someToAddress: someToAddress,
        someToFellowship: someToFellowship,
        someToContract: someToContract,
        amount: amount,
        fee: fee,
        tokenType: tokenType,
      );

      return res.fold((p0) => Either.left(p0.description),
          (_) => Either.right("Transaction successfully created"));
    } catch (e) {
      return Either.left('Unexpected error: $e');
    }
  }
}
