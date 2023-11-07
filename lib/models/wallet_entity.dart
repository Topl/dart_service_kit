import 'package:brambldart/brambldart.dart' as brambl;
import 'package:isar/isar.dart';

part 'wallet_entity.g.dart';

@Collection()
class WalletFellowship extends brambl.WalletFellowship {
  WalletFellowship(this.xIdx, String name) : super(xIdx, name);

  @override
  // ignore: overridden_fields
  final Id xIdx;
}
