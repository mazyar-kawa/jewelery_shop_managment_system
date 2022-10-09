import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:http/http.dart' as http;
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';

class ItemProviderORG with ChangeNotifier {
  List<SingleItem> _items = [];

  List<SingleItem> get items => [..._items];

  List<SingleItem> _favouriteItems = [];
  List<SingleItem> get favouriteItems => [..._favouriteItems];

  String next_url = '';

  Future<void> getItems(int country_id, {String search = ''}) async {
    try {
      String token = await Auth().getToken();
      final response = await http.get(
          Uri.parse(base + 'country_items/$country_id?search=$search'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });

      final data = Items.fromJson(json.decode(response.body));
      next_url = data.items.nextPageUrl!;
      final List<SingleItem> temporaryList = [];
      for (var i = 0; i < data.items.data.length; i++) {
        temporaryList.add(SingleItem(
          id: data.items.data[i].id,
          name: data.items.data[i].name,
          img: data.items.data[i].img,
          description: data.items.data[i].description,
          mount: data.items.data[i].mount,
          type: data.items.data[i].type,
          profit: data.items.data[i].profit,
          quantity: data.items.data[i].quantity,
          size: data.items.data[i].size,
          categoryId: data.items.data[i].categoryId,
          companyId: data.items.data[i].companyId,
          countryId: data.items.data[i].countryId,
          isFavourited: data.items.data[i].isFavourited,
        ));
      }
      _items = temporaryList;

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> refresh() async {
    try {
      String token = await Auth().getToken();
      final response = await http.get(Uri.parse(next_url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      final data = Items.fromJson(json.decode(response.body));
      this.next_url = data.items.nextPageUrl!;
      for (var i = 0; i < data.items.data.length; i++) {
        _items.add(SingleItem(
          id: data.items.data[i].id,
          name: data.items.data[i].name,
          img: data.items.data[i].img,
          description: data.items.data[i].description,
          mount: data.items.data[i].mount,
          type: data.items.data[i].type,
          profit: data.items.data[i].profit,
          quantity: data.items.data[i].quantity,
          size: data.items.data[i].size,
          categoryId: data.items.data[i].categoryId,
          companyId: data.items.data[i].companyId,
          countryId: data.items.data[i].countryId,
          isFavourited: data.items.data[i].isFavourited,
        ));
      }

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getFavouriteItem() async {
    try {
      String token = await Auth().getToken();
      final response =
          await http.get(Uri.parse(base + 'my_favorite'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      final data = FavouriteItems.fromJson(json.decode(response.body));
      final List<SingleItem> temporaryList = [];
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
          countryId: data.items![i].countryId,
          isFavourited: data.items![i].isFavourited,
        ));
      }
      _favouriteItems = temporaryList;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
