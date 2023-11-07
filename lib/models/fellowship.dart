import 'package:isar/isar.dart';

part 'fellowship.g.dart';

@Collection()
class Fellowship {
  Fellowship({required this.name, required this.xFellowship});

  final Id xFellowship;
  final String name;
}
