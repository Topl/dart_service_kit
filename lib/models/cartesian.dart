import 'package:sembast/sembast.dart';

class Cartesian {
  Cartesian(
      {required this.xFellowship,
      required this.yContract,
      required this.zState,
      required this.lockPredicate,
      required this.address,
      this.routine,
      this.vk});

  final int xFellowship;

  final int yContract;
  final int zState;
  final String lockPredicate;
  final String address;
  String? routine;
  String? vk;

  Map<String, Object?> get toSembast => {
        "xFellowship": xFellowship,
        "yContract": yContract,
        "zState": zState,
        "lockPredicate": lockPredicate,
        "address": address,
        "routine": routine,
        "vk": vk,
      };
}

final cartesiansStore = intMapStoreFactory.store("cartesians");
