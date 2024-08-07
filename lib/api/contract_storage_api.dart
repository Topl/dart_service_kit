import 'package:brambldart/brambldart.dart' as brambl;
import 'package:sembast/sembast.dart';
import 'package:servicekit/api/abstractions/parse_result.dart';
import 'package:servicekit/models/wallet_contract.dart';

class ContractStorageApi
    implements
        brambl.ContractStorageAlgebra,
        ParseResult<brambl.WalletContract, WalletContract> {
  ContractStorageApi(this._instance);

  final Database _instance;

  @override
  Future<int> addContract(brambl.WalletContract walletContract) async {
    try {
      return walletContractsStore.add(_instance, walletContract.asSK.toSembast);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<brambl.WalletContract>> findContracts(
      List<brambl.WalletContract> walletContracts) async {
    try {
      final result = await walletContractsStore
          .records(walletContracts.map((c) => c.yIdx))
          .get(_instance);

      return result
          .map((json) => brambl.WalletContract(json!["yIdx"]! as int,
              json["name"]! as String, json["lockTemplate"]! as String))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<brambl.WalletContract> parse(List<WalletContract?> results) {
    return results.isNotEmpty
        ? (results as List<WalletContract>).map((e) => e.asBrambl).toList()
        : [];
  }
}

extension WalletContractExtension on WalletContract {
  brambl.WalletContract get asBrambl =>
      brambl.WalletContract(yIdx, name, lockTemplate);
}

extension BramblWalletContractExtension on brambl.WalletContract {
  WalletContract get asSK => WalletContract(yIdx, name, lockTemplate);
}
