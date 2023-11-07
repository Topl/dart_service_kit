import 'package:isar/isar.dart';

part 'verification_key.g.dart';

@Collection()
class VerificationKey {
  VerificationKey(
      {required this.xFellowship, required this.yContract, required this.vks});

  Id id = Isar.autoIncrement;

  late int xFellowship;
  late int yContract;
  late String vks;
}
