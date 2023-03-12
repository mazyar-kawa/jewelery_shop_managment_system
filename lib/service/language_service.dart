import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/sharedpreferences/language_prefrence.dart';

class LanguageServ with ChangeNotifier {
  LanguagePrefrences languagePrefrences = LanguagePrefrences();

  String currentLanguage = 'en';

  Locale get getCurrentLanguage {
    if (currentLanguage == 'en') {
      return Locale('en');
    } else if (currentLanguage == 'ar') {
      return Locale('ar');
    } else if (currentLanguage == 'ku') {
      return Locale('ku');
    }
    return Locale('en');
  }

  setLanguage(String language) {
    currentLanguage = language;
    languagePrefrences.setLanguage(language);
    notifyListeners();
  }
}
