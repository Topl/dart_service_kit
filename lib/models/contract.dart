import 'package:sembast/sembast.dart';

class Contract {
  Contract(
      {required this.yContract, required this.contract, required this.lock});

  final int yContract;

  final String contract;
  final String lock;

  Map<String, Object?> get toSembast => {
        "yContract": yContract,
        "contract": contract,
        "lock": lock,
      };
}

final contractsStore = intMapStoreFactory.store("contracts");
