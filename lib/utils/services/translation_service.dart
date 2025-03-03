import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppTranslation extends Translations {
  static Map<String, Map<String, String>> translations = {};

  @override
  Map<String, Map<String, String>> get keys => translations;

  /// Call this function to load all json files
  static Future<void> loadTranslations() async {
    translations['en_US'] = await _loadAllJson('assets/lang/en_US/');
    translations['id_ID'] = await _loadAllJson('assets/lang/id_ID/');
  }

  /// Merge all json files into one map
  static Future<Map<String, String>> _loadAllJson(String folderPath) async {
    Map<String, String> mergedTranslations = {};

    // List all files that need to loaded
    List<String> files = ['general.json', 'profile.json', 'order.json'];

    for (String file in files) {
      String jsonString = await rootBundle.loadString('$folderPath$file');
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      // merge all file into one map
      mergedTranslations
          .addAll(jsonMap.map((key, value) => MapEntry(key, value.toString())));
    }

    return mergedTranslations;
  }
}
