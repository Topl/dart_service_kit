import 'package:brambldart/brambldart.dart' as brambl;
import 'package:isar/isar.dart';

part 'wallet_entity.g.dart';

@Collection()
class WalletEntity extends brambl.WalletEntity {
  @override
  // ignore: overridden_fields
  final Id xIdx;

  WalletEntity(this.xIdx, String name) : super(xIdx, name);
}
