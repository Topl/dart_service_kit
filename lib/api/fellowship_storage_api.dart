import 'package:brambldart/brambldart.dart' as brambl;
import 'package:isar/isar.dart';
import 'package:servicekit/api/abstractions/parse_result.dart';
import 'package:servicekit/models/wallet_entity.dart';

class FellowshipStorageApi
    implements
        brambl.FellowshipStorageAlgebra,
        ParseResult<brambl.WalletFellowship, WalletFellowship> {
  FellowshipStorageApi(this._instance);

  final Isar _instance;

  @override
  Future<int> addFellowship(brambl.WalletFellowship walletEntity) {
    try {
      return _instance.walletFellowships.put(walletEntity.asSK);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<brambl.WalletFellowship>> findFellowships(
      List<brambl.WalletFellowship> walletEntities) async {
    try {
      return (await _instance.walletFellowships
              .getAll(walletEntities.map((c) => c.xIdx).toList()))
          .withResult((res) => parse(res));
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<brambl.WalletFellowship> parse(List<WalletFellowship?> entities) {
    return entities.isNotEmpty
        ? (entities as List<WalletFellowship>).map((e) => e.asBrambl).toList()
        : [];
  }
}

extension WalletFellowshipExtension on WalletFellowship {
  brambl.WalletFellowship get asBrambl => brambl.WalletFellowship(xIdx, name);
}

extension BramblWalletFellowshipExtension on brambl.WalletFellowship {
  WalletFellowship get asSK => WalletFellowship(xIdx, name);
}
