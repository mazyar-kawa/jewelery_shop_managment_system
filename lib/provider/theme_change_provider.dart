import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/sharedpreferences/theme_change.dart';

class ThemeChangeProvider with ChangeNotifier {
  String currentTheme = 'system';
  ThemeChangePreferences themechange = ThemeChangePreferences();
  ThemeMode get themeMode {
    if (currentTheme == 'system') {
      return ThemeMode.system;
    } else if (currentTheme == 'light') {
      return ThemeMode.light;
    } else if (currentTheme == 'dark') {
      return ThemeMode.dark;
    }
    return ThemeMode.system;
  }

  setThemeProvider(String value) {
    currentTheme = value;
    themechange.setTheme(value);
    notifyListeners();
  }
}
