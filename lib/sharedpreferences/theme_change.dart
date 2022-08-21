import 'package:shared_preferences/shared_preferences.dart';

class ThemeChangePreferences {
  static const String THEME_KEY = 'theme';

  Future<String> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(THEME_KEY) ?? 'system';
  }

  setTheme(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(THEME_KEY, value);
  }
}
