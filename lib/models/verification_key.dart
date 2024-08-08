import 'package:sembast/sembast.dart';

class VerificationKey {
  VerificationKey(
      {required this.xFellowship, required this.yTemplate, required this.vks});

  late int xFellowship;
  late int yTemplate;
  late List<String> vks;

  Map<String, Object?> get toSembast => {
        "xFellowship": xFellowship,
        "yTemplate": yTemplate,
        "vks": vks,
      };
}

final verificationKeysStore = intMapStoreFactory.store("verificationKeys");
