import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:servicekit/models/cartesian.dart';
import 'package:servicekit/models/contract.dart';
import 'package:servicekit/models/party.dart';
import 'package:servicekit/models/verification_key.dart';
import 'package:servicekit/models/wallet_contract.dart';
import 'package:servicekit/models/wallet_entity.dart';

/// Provides an API for managing storage using Isar and FlutterSecureStorage.
class StorageApi {
  /// Creates a new instance of StorageApi.
  ///
  /// If [isar] and [secureStorage] are not provided, they will be initialized
  /// with default settings.
  StorageApi({Isar? isar, FlutterSecureStorage? secureStorage}) {
    _secureStorage = secureStorage ?? _initSecureStorage();
    _initIsar(isar);
  }

  /// List of all schemas used in the library.
  static const schemas = [
    CartesianSchema,
    ContractSchema,
    PartySchema,
    VerificationKeySchema,
    WalletContractSchema,
    WalletEntitySchema,
  ];

  late Isar _isar;
  late FlutterSecureStorage _secureStorage;

  Isar get isar => _isar;
  FlutterSecureStorage get secureStorage => _secureStorage;

  /// Initializes Isar with the schemas defined in this class.
  ///
  /// If [set] is `true`, the created Isar instance will be assigned to [_isar].
  Future _initIsar(Isar? instance) async {
    if (instance != null) {
      _isar = instance;
      return _isar;
    }
    
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(schemas, directory: dir.path);
  }

  /// Initializes FlutterSecureStorage with default settings.
  FlutterSecureStorage _initSecureStorage() => const FlutterSecureStorage();
}
