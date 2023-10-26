import 'package:isar/isar.dart';

part 'verification_key.g.dart';

@Collection()
class VerificationKey {
  Id id = Isar.autoIncrement;

  late int xParty;
  late int yContract;
  late String vks;

  VerificationKey({required this.xParty, required this.yContract, required this.vks});
}
