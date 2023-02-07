import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/countries_model.dart';
import 'package:http/http.dart' as http;
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';

class CountriesProvider with ChangeNotifier {
  List<CountriesModel> _countries = [];

  List<CountriesModel> get countries => [..._countries];

  bool loadingState = false;

  Future<void> getCountries() async {
    
      try {
        final response =
            await http.get(Uri.parse(base + 'countries'), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });

        final data = Contries.fromJson(json.decode(response.body));

        final List<CountriesModel> temporaryList = [];

        for (int i = 0; i < data.countries.length; i++) {
          temporaryList.add(CountriesModel(
            id: data.countries[i].id,
            namecountries: data.countries[i].namecountries,
            picturecountries: data.countries[i].picturecountries,
          ));
        }
        _countries = temporaryList;
      } catch (e) {}
      notifyListeners();
     
  }
}
