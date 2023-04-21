import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/filter_model.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:http/http.dart' as http;
import 'package:jewelery_shop_managmentsystem/service/auth_service.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';

class HomeItemsService with ChangeNotifier {
  List<SingleItem> _latestItems = [];

  List<SingleItem> get latestItems => [..._latestItems];

  List<Category> _categories = [];

  List<Category> get categories => [..._categories];

  List<SingleItem> _mostFavourite = [];

  List<SingleItem> get mostFavourite => [..._mostFavourite];

  List<SingleItem> _mostSalesItem = [];

  List<SingleItem> get mostSalesItem => [..._mostSalesItem];

  List<SingleItem> _randomItems = [];

  List<SingleItem> get randomItems => [..._randomItems];

  List<String> _carates = [];

  List<String> get carates => [..._carates];

  List<String> _type = [];

  List<String> get type => [..._type];

  bool loadingState = false;

  Future<void> getRandomItems({int id = 0}) async {
    try {
      final List<SingleItem> temporaryList = [];
      String token = await Auth().getToken();
      final response = await http
          .get(Uri.parse(base + 'random_items?category=$id'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      final data = HomeRandomItems.fromJson(json.decode(response.body));
      for (SingleItem item in data.items!) {
        temporaryList.add(item);
      }
      _randomItems = temporaryList;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getAllItemHome() async {
    try {
      String token = await Auth().getToken();
      final response = await http.get(Uri.parse(base + 'home'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      final data = HomeItems.fromJson(json.decode(response.body));
      final List<Category> categories = [];
      final List<SingleItem> temporaryList = [];
      final List<SingleItem> temporaryList1 = [];
      final List<SingleItem> temporaryList2 = [];
      final List<SingleItem> temporaryList3 = [];

      for (var i = 0; i < data.categories!.length; i++) {
        categories.add(Category(
          id: data.categories![i].id,
          name: data.categories![i].name,
        ));
      }
      _categories = categories;

      for (SingleItem item in data.randomItems!) {
        temporaryList.add(item);
      }

      for (SingleItem item in data.latestItems!) {
        temporaryList1.add(item);
      }

      for (SingleItem item in data.mostFavouriteItems!) {
        temporaryList2.add(item);
      }
      for (SingleItem item in data.mostSalesItem!) {
        temporaryList3.add(item);
      }
      _randomItems = temporaryList;
      _latestItems = temporaryList1;
      _mostFavourite = temporaryList2;
      _mostSalesItem=temporaryList3;

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getCarates() async {
    try {
      final response =
          await http.get(Uri.parse(base + 'itemsFilter'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      final data = Filter.fromJson(json.decode(response.body));
      final List<Category> category = [];
      final List<String> carat = [];
      final List<String> caratType = [];

      for (String singleCarat in data.carats) {
        carat.add(singleCarat);
      }

      for (String singleCaratType in data.caratTypes) {
        caratType.add(singleCaratType);
      }

      _type=caratType;

      _carates = carat;

      for (Category singleCategory in data.categories) {
        category.add(singleCategory);
      }
      _categories = category;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future findItemById(int item_id,
      {bool basket = false, bool favorite = false}) async {
    for (SingleItem item in _randomItems) {
      if (item.id == item_id) {
        int index = _randomItems.indexWhere((element) => element.id == item_id);
        _randomItems[index].isFavourited = favorite;
        _randomItems[index].inBasket = basket;
      }
    }
    for (SingleItem item in _latestItems) {
      if (item.id == item_id) {
        int index = _latestItems.indexWhere((element) => element.id == item_id);
        _latestItems[index].isFavourited = favorite;
        _latestItems[index].inBasket = basket;
      }
    }

    for (SingleItem item in _mostSalesItem) {
      if (item.id == item_id) {
        int index = _mostSalesItem.indexWhere((element) => element.id == item_id);
        _mostSalesItem[index].isFavourited = favorite;
        _mostSalesItem[index].inBasket = basket;
      }
    }
    for (SingleItem item in _mostFavourite) {
      if (item.id == item_id) {
        int index =
            _mostFavourite.indexWhere((element) => element.id == item_id);
        _mostFavourite[index].isFavourited = favorite;
        _mostFavourite[index].inBasket = basket;
      }
    }

    notifyListeners();
  }
}
