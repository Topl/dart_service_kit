import 'package:sembast/sembast.dart';

class Template {
  Template({required this.template, required this.lock});

  final String template;
  final String lock;

  Map<String, Object?> get toSembast => {
        "template": template,
        "lock": lock,
      };
}

final templatesStore = intMapStoreFactory.store("templates");
