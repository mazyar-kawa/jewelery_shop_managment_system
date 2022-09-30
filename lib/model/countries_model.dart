import 'dart:convert';

class Contries {
  Contries({
    required this.countries,
  });

  List<CountriesModel> countries;

  factory Contries.fromJson(Map<String, dynamic> json) => Contries(
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
