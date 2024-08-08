import 'package:brambldart/brambldart.dart' as brambl;
import 'package:sembast/sembast.dart';
import 'package:servicekit/models/fellowship.dart';

class FellowshipStorageApi implements brambl.FellowshipStorageAlgebra {
  FellowshipStorageApi(this._instance);

  final Database _instance;

  @override
  Future<int> addFellowship(brambl.WalletFellowship walletEntity) {
    try {
      return fellowshipsStore.add(
          _instance, Fellowship(name: walletEntity.name).toSembast);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<brambl.WalletFellowship>> findFellowships(
      List<brambl.WalletFellowship> walletEntities) async {
    try {
      final walletFellowships = await fellowshipsStore
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
}
