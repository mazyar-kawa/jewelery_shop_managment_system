import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';

class Filter {
    Filter({
        required this.carats,
        required this.caratTypes,
        required this.categories,
    });

    List<String> carats;
    List<String> caratTypes;
    List<Category> categories;

    factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        carats: List<String>.from(json["carats"].map((x) => x)),
        caratTypes: List<String>.from(json["caratTypes"].map((x) => x)),
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

}

class Carats with ChangeNotifier{
    Carats({
         this.id,
         this.carat,
         
    });

    int? id;
    String? carat;

    factory Carats.fromJson(Map<String, dynamic> json) => Carats(
        id: json["id"],
        carat: json["carat"],
    );
}

class CaratType with ChangeNotifier{
    CaratType({
         this.id,
         this.caratType,
         
    });

    int? id;
    String? caratType;

    factory CaratType.fromJson(Map<String, dynamic> json) => CaratType(
        id: json["id"],
        caratType: json["caratType"],
    );
}

class Category with ChangeNotifier{
    Category({
         this.id,
         this.name,
    });

    int? id;
    String? name;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
    );
}