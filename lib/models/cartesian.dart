import 'package:sembast/sembast.dart';

class Cartesian {
  Cartesian(
      {required this.xFellowship,
      required this.yTemplate,
      required this.zInteraction,
      required this.lockPredicate,
      required this.address,
      this.routine,
      this.vk});

  final int xFellowship;

  final int yTemplate;
  final int zInteraction;
  final String lockPredicate;
  final String address;
  String? routine;
  String? vk;

  Map<String, Object?> get toSembast => {
        "xFellowship": xFellowship,
        "yTemplate": yTemplate,
        "zInteraction": zInteraction,
        "lockPredicate": lockPredicate,
        "address": address,
        "routine": routine,
        "vk": vk,
      };
}

final cartesiansStore = intMapStoreFactory.store("cartesians");
