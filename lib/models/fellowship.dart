import 'package:sembast/sembast.dart';

class Fellowship {
  Fellowship({required this.name, required this.xFellowship});

  final int xFellowship;
  final String name;

  Map<String, Object?> get toSembast => {
        "xFellowship": xFellowship,
        "name": name,
      };
}

final fellowshipsStore = intMapStoreFactory.store("fellowships");
