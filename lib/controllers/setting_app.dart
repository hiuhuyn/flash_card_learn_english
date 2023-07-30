import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/language.dart';

class SettingApp extends ChangeNotifier {
  Locale _locale = const Locale("en");
  Locale get locale => _locale;
  String _languageKey = "en";
  String get languageKey => _languageKey;

  Future loadLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? res = prefs.getString("language");
    if (res != null) {
      _locale = Locale(res);
      _languageKey = res;
    } else {
      await prefs.setString("language", "en");
      _locale = const Locale("en");
      _languageKey = "en";
    }
    notifyListeners();
  }

  setLocale(Language language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language.key).then((value) {
      _locale = Locale(language.key);
      _languageKey = language.key;
    });
    notifyListeners();
  }
}
