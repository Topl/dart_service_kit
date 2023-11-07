import 'package:isar/isar.dart';

part 'contract.g.dart';

@Collection()
class Contract {
  Contract(
      {required this.yContract, required this.contract, required this.lock});

  final Id id = Isar.autoIncrement;

  final int yContract;

  final String contract;
  final String lock;
}
