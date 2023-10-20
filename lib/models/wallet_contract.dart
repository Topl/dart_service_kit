import 'package:brambl_dart/brambl_dart.dart' as brambl;
import 'package:isar/isar.dart';

part 'wallet_contract.g.dart';

@Collection()
class WalletContract extends brambl.WalletContract {
  WalletContract(super.yIdx, super.name, super.lockTemplate) : super();
}



