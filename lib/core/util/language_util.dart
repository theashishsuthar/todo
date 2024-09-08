import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/core/util/app_constant.dart';


class LanguageUtil {
  static Future<String> getInitialLanguage() async {
    final box = Hive.box(AppConstants.languageBox);
    return box.get(AppConstants.languageKey, defaultValue: 'en');
  }

  static Future<void> saveLanguage(String languageCode) async {
    final box = Hive.box(AppConstants.languageBox);
    await box.put(AppConstants.languageKey, languageCode);
  }
}