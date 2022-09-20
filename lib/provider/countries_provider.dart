import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/countries_model.dart';
import 'package:http/http.dart' as http;
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';

class CountriesProvider with ChangeNotifier {
  List<CountriesModel> _countries = [];

  List<CountriesModel> get countries => [..._countries];

  Future<void> getCountries() async {
    try {
      final response = await http.get(Uri.parse(base + 'countries'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      final data = await json.decode(response.body) as Map<String, dynamic>;

      final List<dynamic> extradata = data['countries'];

      final List<CountriesModel> temporaryList = [];

      extradata.forEach((element) {
        temporaryList.add(CountriesModel(
            id: element['id'],
            namecountries: element['name'],
            picturecountries: element['img']));
      });
      _countries = temporaryList;
      notifyListeners();
    } catch (e) {}
  }
}
