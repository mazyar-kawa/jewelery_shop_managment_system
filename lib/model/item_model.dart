import 'package:flutter/cupertino.dart';

class FavouriteItems {
  FavouriteItems({
    this.items,
  });

  List<SingleItem>? items;

  factory FavouriteItems.fromJson(Map<String, dynamic> json) => FavouriteItems(
        items: List<SingleItem>.from(
            json["myFavorite"].map((x) => SingleItem.fromJson(x))),
      );
}

class HomeItems {
  HomeItems({
    this.randomItems,
    this.latestItems,
    this.mostFavouriteItems,
    this.categories,
  });

  List<SingleItem>? randomItems;
  List<SingleItem>? latestItems;
  List<SingleItem>? mostFavouriteItems;
  List<Categories>? categories;

  factory HomeItems.fromJson(Map<String, dynamic> json) => HomeItems(
        randomItems: List<SingleItem>.from(
            json["randomItems"].map((x) => SingleItem.fromJson(x))),
        latestItems: List<SingleItem>.from(
            json["latestItems"].map((x) => SingleItem.fromJson(x))),
        mostFavouriteItems: List<SingleItem>.from(
            json["mostFavouriteItems"].map((x) => SingleItem.fromJson(x))),
        categories: List<Categories>.from(
            json['categories'].map((x) => Categories.fromJson(x))),
      );
}

class HomeRandomItems {
  HomeRandomItems({
    this.items,
  });

  List<SingleItem>? items;

  factory HomeRandomItems.fromJson(Map<String, dynamic> json) =>
      HomeRandomItems(
        items: List<SingleItem>.from(
            json["items"].map((x) => SingleItem.fromJson(x))),
      );
}

class Items {
  Items({
    required this.items,
  });

  ItemsClass items;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        items: ItemsClass.fromJson(json["items"]),
      );
}

class ItemsClass {
  ItemsClass({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
  });

  int? currentPage;
  List<SingleItem> data;
  String? firstPageUrl;
  int? from;
  String? nextPageUrl;
  String path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;

  factory ItemsClass.fromJson(Map<String, dynamic> json) => ItemsClass(
        currentPage: json["current_page"],
        data: List<SingleItem>.from(
            json["data"].map((x) => SingleItem.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        nextPageUrl: json["next_page_url"] ?? 'No data',
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
      );
}

class SingleItem with ChangeNotifier {
  SingleItem({
    this.id,
    this.name,
    this.size,
    this.mount,
    this.type,
    this.profit,
    this.img,
    this.description,
    this.quantity,
    this.companyId,
    this.categoryId,
    this.countryId,
    this.isFavourited,
  });

  int? id;
  String? name;
  int? size;
  int? mount;
  String? type;
  String? profit;
  String? img;
  String? description;
  int? quantity;
  int? companyId;
  int? categoryId;
  int? countryId;
  bool? isFavourited;

  factory SingleItem.fromJson(Map<String, dynamic> json) => SingleItem(
        id: json["id"],
        name: json["name"],
        size: json["size"],
        mount: json["mount"],
        type: typeValues.map?[json["type"]],
        profit: json["profit"],
        img: json["img"],
        description: json["description"],
        quantity: json["quantity"],
        companyId: json["company_id"],
        categoryId: json["category_id"],
        countryId: json["country_id"],
        isFavourited: json["is_favourited"],
      );
}

enum Type { LIRA, GOLD, SILVER }

final typeValues = EnumValues({
  "gold": Type.GOLD.name,
  "lira": Type.LIRA.name,
  "silver": Type.SILVER.name
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}

class Categories with ChangeNotifier {
  int? id;
  String? name;
  Categories({
    this.id,
    this.name,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json['id'],
        name: json['name'],
      );
}
