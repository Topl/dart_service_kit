import 'package:brambldart/brambldart.dart' as brambl;
import 'package:sembast/sembast.dart';

class WalletFellowship extends brambl.WalletFellowship {
  WalletFellowship(this.xIdx, String name) : super(xIdx, name);

  @override
  // ignore: overridden_fields
  final int xIdx;

  Map<String, Object?> get toSembast => {
        "xIdx": xIdx,
        "name": name,
      };
}

final walletFellowshipsStore = intMapStoreFactory.store("walletFellowships");
