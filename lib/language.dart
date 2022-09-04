import 'package:flutter/cupertino.dart';

class Language {
  final int id;
  final String name;
  final String code;
  Language({required this.id, required this.name, required this.code});

  static List<Language> languageList() {
    return <Language>[
      Language(id: 1, name: 'English', code: 'en'),
      Language(id: 2, name: 'Arabic', code: 'ar'),
      Language(id: 3, name: 'Kurdish', code: 'ku')
    ];
  }
}
