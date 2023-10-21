

import 'package:isar/isar.dart';

part 'contract.g.dart';


@Collection()
class Contract {
  final Id yContract;

  final String contract;
  final String lock;

  Contract({required this.yContract, required this.contract, required this.lock});
}
