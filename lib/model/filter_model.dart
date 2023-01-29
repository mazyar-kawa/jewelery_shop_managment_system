import 'package:flutter/cupertino.dart';

class Filter {
    Filter({
         this.carats,
         this.categories,
    });

    List<Carat>? carats;
    List<Category>? categories;

    factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        carats: List<Carat>.from(json["carats"].map((x) => Carat.fromJson(x))),
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

}

class Carat with ChangeNotifier{
    Carat({
         this.id,
         this.carat,
         this.type,
    });

    int? id;
    String? carat;
    String? type;

    factory Carat.fromJson(Map<String, dynamic> json) => Carat(
        id: json["id"],
        carat: json["carat"],
        type: json["type"],
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