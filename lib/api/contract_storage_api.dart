import 'package:brambl_dart/brambl_dart.dart' as brambl;
import 'package:isar/isar.dart';
import 'package:servicekit/models/wallet_contract.dart';

class ContractStorageApi extends brambl.ContractStorageAlgebra {
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
  Future<List<WalletContract>> findContracts(List<brambl.WalletContract> walletContracts) async {
    try {
      final contracts = await _instance.walletContracts.getAll(walletContracts.map((c) => c.yIdx).toList());
      return contracts.isNotEmpty ? contracts as List<WalletContract> : [];
    } catch (e) {
      rethrow;
    }
  }
}

extension WalletContractExtension on WalletContract {
  brambl.WalletContract get asBrambl => brambl.WalletContract(yIdx, name, lockTemplate);
}

extension BramblWalletContractExtension on brambl.WalletContract {
  WalletContract get asSK => WalletContract(yIdx, name, lockTemplate);
}
