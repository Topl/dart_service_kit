import 'package:brambldart/brambldart.dart';
import 'package:servicekit/api/fellowship_storage_api.dart';
import 'package:test/test.dart';

import 'base.dart';

main() {
  final base = BaseSpec();
  late final fellowshipApi = FellowshipStorageApi(base.storageApi.isar);

  test('addFellowship then findFellowships', () async {
    final fellowship = WalletFellowship(2, 'testFellowship');

    await base.walletStateApi.initWalletState(
      NetworkConstants.privateNetworkId,
      NetworkConstants.mainNetworkId,
      // ignore: avoid_dynamic_calls
      base.mockMainKeyPair().verificationKey,
    );

    final fellowships = await fellowshipApi.findFellowships([]);
    expect(fellowships.length == 3 && fellowships.last == fellowship, isTrue);
  });
}
