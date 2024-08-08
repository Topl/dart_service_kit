import 'package:brambldart/brambldart.dart' as brambl;
import 'package:sembast/sembast.dart';
import 'package:servicekit/models/template.dart';

class TemplateStorageApi implements brambl.TemplateStorageAlgebra {
  TemplateStorageApi(this._instance);

  final Database _instance;

  @override
  Future<int> addTemplate(brambl.WalletTemplate walletTemplate) async {
    final template = Template(
        lock: walletTemplate.lockTemplate, template: walletTemplate.name);
    try {
      return templatesStore.add(_instance, template.toSembast);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<brambl.WalletTemplate>> findTemplates() async {
    try {
      final result = await templatesStore.find(_instance);

      return result
          .map((json) => brambl.WalletTemplate(
              json.key, json["template"]! as String, json["lock"]! as String))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
