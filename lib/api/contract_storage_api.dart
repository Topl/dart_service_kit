import 'package:brambldart/brambldart.dart' as brambl;
import 'package:isar/isar.dart';
import 'package:servicekit/api/abstractions/parse_result.dart';
import 'package:servicekit/models/wallet_contract.dart';

class ContractStorageApi implements brambl.ContractStorageAlgebra, ParseResult<brambl.WalletContract, WalletContract> {
  final Isar _instance;

  ContractStorageApi(this._instance);

  @override
  Future<int> addContract(brambl.WalletContract walletContract) async {
    try {
      return _instance.walletContracts.put(walletContract.asSK);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<brambl.WalletContract>> findContracts(List<brambl.WalletContract> walletContracts) async {
    try {
      return (await _instance.walletContracts.getAll(walletContracts.map((c) => c.yIdx).toList()))
          .withResult((res) => parse(res));
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<brambl.WalletContract> parse(List<WalletContract?> results) {
    return results.isNotEmpty ? (results as List<WalletContract>).map((e) => e.asBrambl).toList() : [];
  }
}

extension WalletContractExtension on WalletContract {
  brambl.WalletContract get asBrambl => brambl.WalletContract(yIdx, name, lockTemplate);
}

extension BramblWalletContractExtension on brambl.WalletContract {
  WalletContract get asSK => WalletContract(yIdx, name, lockTemplate);
}
