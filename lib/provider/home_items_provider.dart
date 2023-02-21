import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/filter_model.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:http/http.dart' as http;
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';

class HomeItemsProvider with ChangeNotifier {
  List<SingleItem> _latestItems = [];

  List<SingleItem> get latestItems => [..._latestItems];

  List<Category> _categories = [];

  List<Category> get categories => [..._categories];

  List<SingleItem> _mostFavourite = [];

  List<SingleItem> get mostFavourite => [..._mostFavourite];

  List<SingleItem> _randomItems = [];

  List<SingleItem> get randomItems => [..._randomItems];

  List<Carat> _carates = [];

  List<Carat> get carates => [..._carates];

  bool loadingState = false;

  Future<void> getRandomItems({int id = 0}) async {
    try {
      final List<SingleItem> temporaryList = [];
      String token = await Auth().getToken();
      if (id == 0) {
        final response =
            await http.get(Uri.parse(base + 'random_items'), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
        final data = HomeRandomItems.fromJson(json.decode(response.body));

        for (var i = 0; i < data.items!.length; i++) {
          temporaryList.add(SingleItem(
              id: data.items![i].id,
              name: data.items![i].name,
              size: data.items![i].size,
              weight: data.items![i].weight,
              img: data.items![i].img,
              description: data.items![i].description,
              quantity: data.items![i].quantity,
              categoryId: data.items![i].categoryId,
              companyId: data.items![i].companyId,
              countryId: data.items![i].countryId,
              caratId: data.items![i].caratId,
              isFavourited: data.items![i].isFavourited,
              price: data.items![i].price,
              inBasket: data.items![i].inBasket,
              caratMs: data.items![i].caratMs,
              caratType: data.items![i].caratType,
              countryName: data.items![i].countryName));
        }
      } else {
        final response = await http
            .get(Uri.parse(base + 'random_items?category=$id'), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
        final data = HomeRandomItems.fromJson(json.decode(response.body));

        for (var i = 0; i < data.items!.length; i++) {
          temporaryList.add(SingleItem(
              id: data.items![i].id,
              name: data.items![i].name,
              size: data.items![i].size,
              weight: data.items![i].weight,
              img: data.items![i].img,
              description: data.items![i].description,
              quantity: data.items![i].quantity,
              categoryId: data.items![i].categoryId,
              companyId: data.items![i].companyId,
              countryId: data.items![i].countryId,
              caratId: data.items![i].caratId,
              isFavourited: data.items![i].isFavourited,
              price: data.items![i].price,
              inBasket: data.items![i].inBasket,
              caratMs: data.items![i].caratMs,
              caratType: data.items![i].caratType,
              countryName: data.items![i].countryName));
        }
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

      for (var i = 0; i < data.categories!.length; i++) {
        categories.add(Category(
          id: data.categories![i].id,
          name: data.categories![i].name,
        ));
      }
      _categories = categories;

      for (var i = 0; i < data.randomItems!.length; i++) {
        temporaryList.add(SingleItem(
            id: data.randomItems![i].id,
            name: data.randomItems![i].name,
            size: data.randomItems![i].size,
            weight: data.randomItems![i].weight,
            img: data.randomItems![i].img,
            description: data.randomItems![i].description,
            quantity: data.randomItems![i].quantity,
            categoryId: data.randomItems![i].categoryId,
            companyId: data.randomItems![i].companyId,
            countryId: data.randomItems![i].countryId,
            caratId: data.randomItems![i].caratId,
            isFavourited: data.randomItems![i].isFavourited,
            price: data.randomItems![i].price,
            inBasket: data.randomItems![i].inBasket,
            caratMs: data.randomItems![i].caratMs,
            caratType: data.randomItems![i].caratType,
            countryName: data.randomItems![i].countryName));
      }
      _randomItems = temporaryList;
      for (var i = 0; i < data.latestItems!.length; i++) {
        temporaryList1.add(SingleItem(
            id: data.latestItems![i].id,
            name: data.latestItems![i].name,
            size: data.latestItems![i].size,
            weight: data.latestItems![i].weight,
            img: data.latestItems![i].img,
            description: data.latestItems![i].description,
            quantity: data.latestItems![i].quantity,
            categoryId: data.latestItems![i].categoryId,
            companyId: data.latestItems![i].companyId,
            countryId: data.latestItems![i].countryId,
            caratId: data.latestItems![i].caratId,
            isFavourited: data.latestItems![i].isFavourited,
            price: data.latestItems![i].price,
            inBasket: data.latestItems![i].inBasket,
            caratMs: data.latestItems![i].caratMs,
            caratType: data.latestItems![i].caratType,
            countryName: data.latestItems![i].countryName));
      }
      _latestItems = temporaryList1;
      for (var i = 0; i < data.mostFavouriteItems!.length; i++) {
        temporaryList2.add(SingleItem(
            id: data.mostFavouriteItems![i].id,
            name: data.mostFavouriteItems![i].name,
            size: data.mostFavouriteItems![i].size,
            weight: data.mostFavouriteItems![i].weight,
            img: data.mostFavouriteItems![i].img,
            description: data.mostFavouriteItems![i].description,
            quantity: data.mostFavouriteItems![i].quantity,
            categoryId: data.mostFavouriteItems![i].categoryId,
            companyId: data.mostFavouriteItems![i].companyId,
            countryId: data.mostFavouriteItems![i].countryId,
            caratId: data.mostFavouriteItems![i].caratId,
            isFavourited: data.mostFavouriteItems![i].isFavourited,
            price: data.mostFavouriteItems![i].price,
            inBasket: data.mostFavouriteItems![i].inBasket,
            caratMs: data.mostFavouriteItems![i].caratMs,
            caratType: data.mostFavouriteItems![i].caratType,
            countryName: data.mostFavouriteItems![i].countryName));
      }
      _mostFavourite = temporaryList2;

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
      final List<Carat> carat = [];

      for (var i = 0; i < data.carats!.length; i++) {
        carat.add(Carat(
          id: data.carats![i].id,
          carat: data.carats![i].carat,
          type: data.carats![i].type,
        ));
      }
      _carates = carat;
      for (var i = 0; i < data.categories!.length; i++) {
        category.add(Category(
          id: data.categories![i].id,
          name: data.categories![i].name,
        ));
      }
      _categories = category;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

//  List<SingleItem> _latestItems = [];

//   List<SingleItem> get latestItems => [..._latestItems];

//   List<Category> _categories = [];

//   List<Category> get categories => [..._categories];

//   List<SingleItem> _mostFavourite = [];

//   List<SingleItem> get mostFavourite => [..._mostFavourite];

//   List<SingleItem> _randomItems = [];

//   List<SingleItem> get randomItems => [..._randomItems];
  Future findItemById(int item_id,
      {bool basket = false, bool favorite = false}) async {
    for (SingleItem item in _randomItems) {
      if (item.id == item_id) {
          int index= _randomItems.indexWhere((element) => element.id==item_id);
        _randomItems[index].isFavourited = favorite;
        _randomItems[index].inBasket = basket;
      }
    }
    for (SingleItem item in _latestItems) {
      if (item.id == item_id) {
          int index= _latestItems.indexWhere((element) => element.id==item_id);
        _latestItems[index].isFavourited = favorite;
        _latestItems[index].inBasket = basket;
      }
    }
    for (SingleItem item in _mostFavourite) {
      if (item.id == item_id) {
          int index= _mostFavourite.indexWhere((element) => element.id==item_id);
        _mostFavourite[index].isFavourited = favorite;
        _mostFavourite[index].inBasket = basket;
      }
    }

    notifyListeners();
  }
}
