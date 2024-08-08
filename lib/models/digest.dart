import 'package:sembast/sembast.dart';

class Digest {
  Digest(
      {required this.id,
      required this.digestEvidence,
      required this.preimageInput,
      required this.preimageSalt});

  final int id;
  final String digestEvidence;
  final String preimageInput;
  final String preimageSalt;

  Map<String, Object?> get toSembast => {
        "id": id,
        "digestEvidence": digestEvidence,
        "preimageInput": preimageInput,
        "preimageSalt": preimageSalt,
      };
}

final digestsStore = intMapStoreFactory.store("digests");
