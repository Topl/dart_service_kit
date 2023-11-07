import 'package:isar/isar.dart';

part 'cartesian.g.dart';

@Collection()
class Cartesian {
  Cartesian(
      {required this.xFellowship,
      required this.yContract,
      required this.zState,
      required this.lockPredicate,
      required this.address,
      this.routine,
      this.vk});

  Id id = Isar.autoIncrement;

  final int xFellowship;
  final int yContract;
  final int zState;
  final String lockPredicate;
  final String address;
  String? routine;
  String? vk;
}
