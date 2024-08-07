import 'package:brambldart/brambldart.dart' as brambl;
import 'package:sembast/sembast.dart';

class WalletContract extends brambl.WalletContract {
  WalletContract(super.yIdx, super.name, super.lockTemplate) : super();

  Map<String, Object?> get toSembast => {
        "yIdx": yIdx,
        "name": name,
        "lockTemplate": lockTemplate,
      };
}

final walletContractsStore = intMapStoreFactory.store("walletContracts");
