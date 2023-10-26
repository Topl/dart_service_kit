import 'package:isar/isar.dart';

part 'cartesian.g.dart';

@Collection()
class Cartesian {
  Id id = Isar.autoIncrement;

  final int xParty;
  final int yContract;
  final int zState;
  final String lockPredicate;
  final String address;
  String? routine;
  String? vk;

  Cartesian(
      {
      required this.xParty,
      required this.yContract,
      required this.zState,
      required this.lockPredicate,
      required this.address,
      this.routine,
      this.vk});
}
