import 'package:brambldart/brambldart.dart' as brambl;
import 'package:isar/isar.dart';
import 'package:servicekit/api/abstractions/parse_result.dart';
import 'package:servicekit/models/wallet_entity.dart';

class PartyStorageApi implements brambl.PartyStorageAlgebra, ParseResult<brambl.WalletEntity, WalletEntity> {
  final Isar _instance;

  PartyStorageApi(this._instance);

  @override
  Future<int> addParty(brambl.WalletEntity walletEntity) {
    try {
      return _instance.walletEntitys.put(walletEntity.asSK);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<brambl.WalletEntity>> findParties(List<brambl.WalletEntity> walletEntities) async {
    try {
      return (await _instance.walletEntitys.getAll(walletEntities.map((c) => c.xIdx).toList()))
          .withResult((res) => parse(res));
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<brambl.WalletEntity> parse(List<WalletEntity?> entities) {
    return entities.isNotEmpty ? (entities as List<WalletEntity>).map((e) => e.asBrambl).toList() : [];
  }
}

extension WalletContractExtension on WalletEntity {
  brambl.WalletEntity get asBrambl => brambl.WalletEntity(xIdx, name);
}

extension BramblWalletContractExtension on brambl.WalletEntity {
  WalletEntity get asSK => WalletEntity(xIdx, name);
}
