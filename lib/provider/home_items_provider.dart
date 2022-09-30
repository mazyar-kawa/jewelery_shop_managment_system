import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:http/http.dart' as http;
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';

class HomeItemsProvider with ChangeNotifier {
  List<SingleItem> _latestItems = [];

  List<SingleItem> get latestItems => [..._latestItems];

  List<Categories> _categories = [];

  List<Categories> get categories => [..._categories];

  List<SingleItem> _mostFavourite = [];

  List<SingleItem> get mostFavourite => [..._mostFavourite];

  List<SingleItem> _randomItems = [];

  List<SingleItem> get randomItems => [..._randomItems];

  Future<void> getRandomItems({int id = 0}) async {
    try {
      final List<SingleItem> temporaryList = [];
      if (id == 0) {
        final response = await http.get(Uri.parse(base + 'random_items'));
        final data = HomeRandomItems.fromJson(json.decode(response.body));

        for (var i = 0; i < data.items!.length; i++) {
          temporaryList.add(SingleItem(
              id: data.items![i].id,
              name: data.items![i].name,
              img: data.items![i].img,
              description: data.items![i].description,
              mount: data.items![i].mount,
              type: data.items![i].type,
              profit: data.items![i].profit,
              quantity: data.items![i].quantity,
              size: data.items![i].size,
              categoryId: data.items![i].categoryId,
              companyId: data.items![i].companyId,
              countryId: data.items![i].countryId));
        }
      } else {
        final response =
            await http.get(Uri.parse(base + 'random_items?category=$id'));
        final data = HomeRandomItems.fromJson(json.decode(response.body));

        for (var i = 0; i < data.items!.length; i++) {
          temporaryList.add(SingleItem(
              id: data.items![i].id,
              name: data.items![i].name,
              img: data.items![i].img,
              description: data.items![i].description,
              mount: data.items![i].mount,
              type: data.items![i].type,
              profit: data.items![i].profit,
              quantity: data.items![i].quantity,
              size: data.items![i].size,
              categoryId: data.items![i].categoryId,
              companyId: data.items![i].companyId,
              countryId: data.items![i].countryId));
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
      final response = await http.get(Uri.parse(base + 'home'));
      final data = HomeItems.fromJson(json.decode(response.body));
      final List<Categories> categories = [];
      final List<SingleItem> temporaryList = [];
      final List<SingleItem> temporaryList1 = [];
      final List<SingleItem> temporaryList2 = [];
      for (var i = 0; i < data.categories!.length; i++) {
        categories.add(Categories(
          id: data.categories![i].id,
          name: data.categories![i].name,
        ));
      }
      _categories = categories;

      for (var i = 0; i < data.randomItems!.length; i++) {
        temporaryList.add(SingleItem(
            id: data.randomItems![i].id,
            name: data.randomItems![i].name,
            img: data.randomItems![i].img,
            description: data.randomItems![i].description,
            mount: data.randomItems![i].mount,
            type: data.randomItems![i].type,
            profit: data.randomItems![i].profit,
            quantity: data.randomItems![i].quantity,
            size: data.randomItems![i].size,
            categoryId: data.randomItems![i].categoryId,
            companyId: data.randomItems![i].companyId,
            countryId: data.randomItems![i].countryId));
      }
      _randomItems = temporaryList;
      for (var i = 0; i < data.latestItems!.length; i++) {
        temporaryList1.add(SingleItem(
            id: data.latestItems![i].id,
            name: data.latestItems![i].name,
            img: data.latestItems![i].img,
            description: data.latestItems![i].description,
            mount: data.latestItems![i].mount,
            type: data.latestItems![i].type,
            profit: data.latestItems![i].profit,
            quantity: data.latestItems![i].quantity,
            size: data.latestItems![i].size,
            categoryId: data.latestItems![i].categoryId,
            companyId: data.latestItems![i].companyId,
            countryId: data.latestItems![i].countryId));
      }
      _latestItems = temporaryList1;
      for (var i = 0; i < data.mostFavouriteItems!.length; i++) {
        temporaryList2.add(SingleItem(
            id: data.mostFavouriteItems![i].id,
            name: data.mostFavouriteItems![i].name,
            img: data.mostFavouriteItems![i].img,
            description: data.mostFavouriteItems![i].description,
            mount: data.mostFavouriteItems![i].mount,
            type: data.mostFavouriteItems![i].type,
            profit: data.mostFavouriteItems![i].profit,
            quantity: data.mostFavouriteItems![i].quantity,
            size: data.mostFavouriteItems![i].size,
            categoryId: data.mostFavouriteItems![i].categoryId,
            companyId: data.mostFavouriteItems![i].companyId,
            countryId: data.mostFavouriteItems![i].countryId));
      }
      _mostFavourite = temporaryList2;

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
