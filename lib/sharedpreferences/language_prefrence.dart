import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePrefrences {
  static const String LANGUAGE_KEY = "language_key";

  Future<String> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(LANGUAGE_KEY) ?? 'en';
  }

  setLanguage(String locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(LANGUAGE_KEY, locale);
  }
}
