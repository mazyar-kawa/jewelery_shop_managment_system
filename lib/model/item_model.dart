import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/filter_model.dart';

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
  List<Category>? categories;

  factory HomeItems.fromJson(Map<String, dynamic> json) => HomeItems(
        randomItems: List<SingleItem>.from(
            json["randomItems"].map((x) => SingleItem.fromJson(x))),
        latestItems: List<SingleItem>.from(
            json["latestItems"].map((x) => SingleItem.fromJson(x))),
        mostFavouriteItems: List<SingleItem>.from(
            json["mostFavouriteItems"].map((x) => SingleItem.fromJson(x))),
        categories: List<Category>.from(
            json['categories'].map((x) => Category.fromJson(x))),
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

//dastkari nakain labar awai hich nagorawa lei
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
    this.weight,
    this.img,
    this.quantity,
    this.companyId,
    this.categoryId,
    this.countryId,
    this.caratId,
    this.isFavourited,
    this.price,
    this.inBasket,
    this.caratType,
    this.caratMs,
    this.countryName,
  });

  int? id;
  String? name;
  int? size;
  int? weight;

  String? img;

  int? quantity;
  int? companyId;
  int? categoryId;
  int? countryId;
  int? caratId;
  bool? isFavourited;
  double? price;
  bool? inBasket;
  String? caratType;
  String? caratMs;
  String? countryName;

  factory SingleItem.fromJson(Map<String, dynamic> json) => SingleItem(
        id: json["id"],
        name: json["name"],
        size: json["size"],
        weight: json["weight"],
        img: json["img"],
        quantity: json["quantity"],
        companyId: json["company_id"],
        categoryId: json["category_id"],
        countryId: json["country_id"],
        countryName: Country.fromJson(json["country"]).name,
        caratId: json["carat_id"],
        isFavourited: json["is_favourited"],
        price: json["price"]?.toDouble(),
        inBasket: json["in_basket"],
        caratType: Carat.fromJson(json["carat"]).type,
        caratMs: Carat.fromJson(json["carat"]).carat,
      );
}

enum Type { GOLD, SILVER }

final typeValues =
    EnumValues({"gold": Type.GOLD.name, "silver": Type.SILVER.name});

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

class Country {
  Country({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: nameValues.map![json["name"]].toString(),
      );
}

enum Name { ITALIAN, IRAQI, FRENCH, PERSIAN, TURKISH, DUBAI }

final nameValues = EnumValues({
  "Italian": Name.ITALIAN.name,
  "Iraqi": Name.IRAQI.name,
  "French": Name.FRENCH.name,
  "Persian": Name.PERSIAN.name,
  "Turkish": Name.TURKISH.name,
  "Dubai": Name.DUBAI.name
});

class EnumValuesCountryName<T> {
  Map<String, T>? map;
  late Map<T, String>? reverseMap;

  EnumValuesCountryName(this.map);

  Map<T, String> get reverse {
    reverseMap = map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
