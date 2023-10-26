abstract class SimpleTransactionAlgebraError implements Exception {
  final String description;

  SimpleTransactionAlgebraError(this.description);
}

class CannotInitializeProtobuf extends SimpleTransactionAlgebraError {
  CannotInitializeProtobuf(String description) : super(description);
}

class InvalidProtobufFile extends SimpleTransactionAlgebraError {
  InvalidProtobufFile(String description) : super(description);
}

class CannotSerializeProtobufFile extends SimpleTransactionAlgebraError {
  CannotSerializeProtobufFile(String description) : super(description);
}

class NetworkProblem extends SimpleTransactionAlgebraError {
  NetworkProblem(String description) : super(description);
}

class UnexpectedError extends SimpleTransactionAlgebraError {
  UnexpectedError(String description) : super(description);
}

class CreateTxError extends SimpleTransactionAlgebraError {
  CreateTxError(String description) : super(description);
}
