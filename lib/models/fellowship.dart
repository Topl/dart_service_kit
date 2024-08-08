import 'package:sembast/sembast.dart';

class Fellowship {
  Fellowship({required this.name});

  final String name;

  Map<String, Object?> get toSembast => {
        "name": name,
      };
}

final fellowshipsStore = intMapStoreFactory.store("fellowships");
