import 'package:brambldart/brambldart.dart' as brambl;
import 'package:sembast/sembast.dart';
import 'package:servicekit/api/abstractions/parse_result.dart';
import 'package:servicekit/models/wallet_entity.dart';

class FellowshipStorageApi
    implements
        brambl.FellowshipStorageAlgebra,
        ParseResult<brambl.WalletFellowship, WalletFellowship> {
  FellowshipStorageApi(this._instance);

  final Database _instance;

  @override
  Future<int> addFellowship(brambl.WalletFellowship walletEntity) {
    try {
      return walletFellowshipsStore.add(_instance, walletEntity.asSK.toSembast);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<brambl.WalletFellowship>> findFellowships(
      List<brambl.WalletFellowship> walletEntities) async {
    try {
      final walletFellowships = await walletFellowshipsStore
          .records(walletEntities.map((c) => c.xIdx))
          .get(_instance);

      return walletFellowships
          .map((json) => brambl.WalletFellowship(
              json!["xIdx"]! as int, json["name"]! as String))
          .toList();
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
