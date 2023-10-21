import 'package:isar/isar.dart';

part 'party.g.dart';

@Collection()
class Party {
  final Id xParty;
  final String name;

  Party({required this.name, required this.xParty});
}
