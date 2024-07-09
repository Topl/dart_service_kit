import 'package:sembast/sembast.dart';

class VerificationKey {
  VerificationKey(
      {required this.xFellowship, required this.yContract, required this.vks});

  late int xFellowship;
  late int yContract;
  late String vks;

  Map<String, Object?> get toSembast => {
        "xFellowship": xFellowship,
        "yContract": yContract,
        "vks": vks,
      };
}

final verificationKeysStore = intMapStoreFactory.store("verificationKeys");
