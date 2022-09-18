import 'dart:convert';

class Countries {
  List<CountriesModel> countries;
  Countries({
    required this.countries,
  });
  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        countries: List<CountriesModel>.from(
            json["countries"].map((x) => CountriesModel.fromJson(x))),
      );
}

class CountriesModel {
  int? id;
  String? namecountries;
  String? picturecountries;

  CountriesModel({this.id, this.namecountries, this.picturecountries});

  factory CountriesModel.fromJson(Map<String, dynamic> json) => CountriesModel(
        id: json["id"],
        namecountries: json["name"],
        picturecountries: json["img"],
      );
}
