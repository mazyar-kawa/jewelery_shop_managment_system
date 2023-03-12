import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/countries_model.dart';
import 'package:http/http.dart' as http;
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';

class CountriesService with ChangeNotifier {
  List<CountriesModel> _countries = [];

  List<CountriesModel> get countries => [..._countries];

  Future<void> getCountries() async {
    
      try {
        final response =
            await http.get(Uri.parse(base + 'countries'), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });

        final data = Contries.fromJson(json.decode(response.body));

        final List<CountriesModel> temporaryList = [];

        for (CountriesModel country in data.countries){
          temporaryList.add(country);
        }
        _countries = temporaryList;
      } catch (e) {}
      notifyListeners();
     
  }
}
