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
  final String routine;
  final List<int> vk;

  Cartesian(
      {
      required this.xParty,
      required this.yContract,
      required this.zState,
      required this.lockPredicate,
      required this.address,
      required this.routine,
      required this.vk});
}
