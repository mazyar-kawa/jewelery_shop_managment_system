import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/filter_model.dart';
import 'package:jewelery_shop_managmentsystem/service/Basket_item_service.dart';
import 'package:jewelery_shop_managmentsystem/service/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:jewelery_shop_managmentsystem/service/home_items_service.dart';
import 'package:jewelery_shop_managmentsystem/service/item_service.dart';
import 'package:jewelery_shop_managmentsystem/service/refresh_user.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:provider/provider.dart';

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
    this.mostSalesItem,
  });

  List<SingleItem>? randomItems;
  List<SingleItem>? latestItems;
  List<SingleItem>? mostFavouriteItems;
  List<SingleItem>? mostSalesItem;
  List<Category>? categories;

  factory HomeItems.fromJson(Map<String, dynamic> json) => HomeItems(
        randomItems: List<SingleItem>.from(
            json["randomItems"].map((x) => SingleItem.fromJson(x))),
        latestItems: List<SingleItem>.from(
            json["latestItems"].map((x) => SingleItem.fromJson(x))),
        mostFavouriteItems: List<SingleItem>.from(
            json["mostFavouriteItems"].map((x) => SingleItem.fromJson(x))),
        mostSalesItem: List<SingleItem>.from(
            json["mostSaleItems"].map((x) => SingleItem.fromJson(x))),
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
  SingleItem( {
    this.id,
    this.name,
    this.size,
    this.weight,
    this.img,
    this.quantity,
    this.categoryId,
    this.countryId,
    this.caratId,
    this.isFavourited,
    this.price,
    this.inBasket,
    this.caratType,
    this.caratMs,
    this.countryName,
    this.description,
    // this.itemPictures
  });

  int? id;
  String? name;
  int? size;
  int? weight;
  String? img;
  String? description;
  int? quantity;
  int? categoryId;
  int? countryId;
  int? caratId;
  bool? isFavourited;
  double? price;
  bool? inBasket;
  String? caratType;
  String? caratMs;
  String? countryName;

  // List<Country>? itemPictures;

  factory SingleItem.fromJson(Map<String, dynamic> json) => SingleItem(
        id: json["id"],
        name: json["name"],
        size: json["size"],
        weight: json["weight"],
        img: json["img"],
        quantity: json["quantity"],
        categoryId: json["category_id"],
        countryId: json["country_id"],
        countryName: Country.fromJson(json["country"]).name,
        caratId: json["carat_id"],
        isFavourited: json["is_favourited"],
        price: json["price"]?.toDouble(),
        inBasket: json["in_basket"],
        description: json["description"],
        caratType: Carat.fromJson(json["carat"]).type,
        caratMs: Carat.fromJson(json["carat"]).carat,
        // itemPictures: List<Country>.from(json["item_pictures"].map((x) => Country.fromJson(x))),
      );

  Future<ApiProvider> FavouriteAndUnfavouriteItem(
      int itemId, BuildContext context) async {
    final body = {'item_id': itemId};
    ApiProvider apiProvider = ApiProvider();
    try {
      String token = await Auth().getToken();
      if (!isFavourited!) {
        final response = await http.post(Uri.parse(base + 'favorite_item'),
            body: jsonEncode(body),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            });
        switch (response.statusCode) {
          case 200:
            apiProvider.data = json.decode(response.body);
            await Provider.of<RefreshUser>(context, listen: false)
                .increasefavorite();
            break;
          default:
            apiProvider.error = jsonDecode(response.body);
        }
      } else {
        try {
          final response = await http.post(Uri.parse(base + 'unfavorite_item'),
              body: jsonEncode(body),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              });
          switch (response.statusCode) {
            case 200:
              apiProvider.data = json.decode(response.body);
              await Provider.of<RefreshUser>(context, listen: false)
                  .decreasefavorite();
              await Provider.of<ItemService>(context, listen: false)
                  .deleteFavouriteItem(itemId);
              break;
            default:
              apiProvider.error = jsonDecode(response.body);
          }
        } catch (e) {
          apiProvider.error = {'message': e.toString()};
        }
      }
    } catch (e) {
      apiProvider.error = {'message': e.toString()};
    }
    isFavourited = !isFavourited!;
    await Provider.of<HomeItemsService>(context, listen: false)
        .findItemById(itemId, favorite: isFavourited!);
    await Provider.of<ItemService>(context, listen: false)
        .getItemByIdCountries(itemId, favorite: isFavourited!);
    notifyListeners();
    return apiProvider;
  }

  Future<ApiProvider> basketAndUnbasketItems(
      int itemId, BuildContext context) async {
    ApiProvider apiProvider = ApiProvider();
    final body = {'item_id': itemId};
    String token = await Auth().getToken();
    if (!inBasket!) {
      try {
        final response = await http.post(Uri.parse(base + 'basket/addItem'),
            body: jsonEncode(body),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            });
        switch (response.statusCode) {
          case 200:
            apiProvider.data = json.decode(response.body);

            break;
          default:
            apiProvider.error = jsonDecode(response.body);
        }
      } catch (e) {
        apiProvider.error = {'message': e.toString()};
      }
    } else {
      try {
        final response = await http.post(Uri.parse(base + 'basket/removeItem'),
            body: jsonEncode(body),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            });
        switch (response.statusCode) {
          case 200:
            apiProvider.data = json.decode(response.body);
            break;
          default:
            apiProvider.error = jsonDecode(response.body);
        }
      } catch (e) {
        apiProvider.error = {'message': e.toString()};
      }
    }
    inBasket = !inBasket!;
    notifyListeners();
    await Provider.of<HomeItemsService>(context, listen: false)
        .findItemById(itemId, basket: inBasket!);
    await Provider.of<BasketItemService>(context, listen: false)
        .getItemBasket();
    await Provider.of<ItemService>(context, listen: false)
        .getItemByIdCountries(itemId, basket: inBasket!);
    return apiProvider;
  }

  Future<ApiProvider> UnbasketItems(int itemId, BuildContext context) async {
    ApiProvider apiProvider = ApiProvider();
    final body = {'item_id': itemId};
    String token = await Auth().getToken();
    try {
      final response = await http.post(Uri.parse(base + 'basket/removeItem'),
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      switch (response.statusCode) {
        case 200:
          apiProvider.data = json.decode(response.body);
          await Provider.of<BasketItemService>(context, listen: false)
              .deleteItemBasket(itemId, context);
          await Provider.of<HomeItemsService>(context, listen: false)
              .findItemById(itemId, basket: false);
          break;
        default:
          apiProvider.error = jsonDecode(response.body);
      }
    } catch (e) {
      apiProvider.error = {'message': e.toString()};
    }
    notifyListeners();
    return apiProvider;
  }
}

enum Type { GOLD, SILVER , LIRA }

final typeValues =
    EnumValues({"gold": Type.GOLD.name, "silver": Type.SILVER.name,"lira":Type.LIRA.name});

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
  Country({this.id, this.name, this.itemId});

  int? id;
  String? name;
  int? itemId;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: nameValues.map![json["name"]].toString(),
        itemId: json["item_id"],
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