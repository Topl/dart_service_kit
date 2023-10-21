import 'package:brambl_dart/brambl_dart.dart';

class WalletKeyApi implements WalletKeyApiAlgebra {
  /// Updates the main key vault store.
  ///
  /// [mainKeyVaultStore] is the new VaultStore to update to.
  /// [name] is the filepath of the VaultStore to update.
  ///
  /// Returns nothing if successful. Throws an exception if the VaultStore does not exist.
  @override
  Future<Either<WalletKeyException, Unit>> updateMainKeyVaultStore(VaultStore mainKeyVaultStore, String name) {
    // TODO: implement updateMainKeyVaultStore
    throw UnimplementedError();
  }

  /// Deletes the main key vault store.
  ///
  /// [name] is the filepath of the VaultStore to delete.
  ///
  /// Returns nothing if successful. Throws an exception if the VaultStore does not exist.
  @override
  Either<WalletKeyException, Unit> deleteMainKeyVaultStore(String name) {
    // TODO: implement deleteMainKeyVaultStore
    throw UnimplementedError();
  }

  /// Persists the main key vault store to disk.
  ///
  /// [mainKeyVaultStore] is the VaultStore to persist.
  /// [name] is the filepath to persist the VaultStore to.
  ///
  /// Returns nothing if successful. If persisting fails due to an underlying cause, returns a WalletKeyException.
  @override
  Future<Either<WalletKeyException, Unit>> saveMainKeyVaultStore(VaultStore mainKeyVaultStore, String name) {
    // TODO: implement saveMainKeyVaultStore
    throw UnimplementedError();
  }

  /// Retrieves the main key vault store from disk.
  ///
  /// [name] is the filepath of the VaultStore to retrieve.
  ///
  /// Returns the VaultStore for the Topl Main Secret Key if it exists.
  /// If retrieving fails due to an underlying cause, returns a WalletKeyException.
  @override
  Either<WalletKeyException, VaultStore> getMainKeyVaultStore(String name) {
    // TODO: implement getMainKeyVaultStore
    throw UnimplementedError();
  }

  /// Persists the mnemonic to disk.
  ///
  /// [mnemonic] is the mnemonic to persist.
  /// [mnemonicName] is the filepath to persist the mnemonic to.
  ///
  /// Returns nothing if successful. If persisting fails due to an underlying cause, returns a WalletKeyException.
  @override
  Future<Either<WalletKeyException, Unit>> saveMnemonic(List<String> mnemonic, String mnemonicName) {
    // TODO: implement saveMnemonic
    throw UnimplementedError();
  }
}
