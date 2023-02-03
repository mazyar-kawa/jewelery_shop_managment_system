import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/filter_model.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:http/http.dart' as http;
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/screens/item_details.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';

class ItemProviderORG with ChangeNotifier {

  SingleItem ItemDetails=SingleItem();


  List<SingleItem> _items = [];

  List<SingleItem> get items => [..._items];

  List<SingleItem> _favouriteItems = [];
  List<SingleItem> get favouriteItems => [..._favouriteItems];

  String next_url = '';

  Future<void> getItems(int country_id,
      {String search = '',
      double size_start = 0,
      double size_end = 0,
      double weight_start = 0,
      double weight_end = 0,
      int category_id = 0,
      int carat_id = 0}) async {
    try {
      String token = await Auth().getToken();
      final response = await http.get(
          Uri.parse(base +
              'country_items/$country_id?search=$search&category_id=${category_id == 0 ? '' : category_id}&carat_id=${carat_id == 0 ? '' : carat_id}&size_start=${size_start == 0 ? '' : size_start}&size_end=${size_end == 0 ? '' : size_end}&weight_start=${weight_start == 0 ? '' : weight_start}&weight_end=${weight_end == 0 ? '' : weight_end}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      print(response.body);
      final data = Items.fromJson(json.decode(response.body));
      next_url = data.items.nextPageUrl!;

      final List<SingleItem> temporaryList = [];
      for (var i = 0; i < data.items.data.length; i++) {
        temporaryList.add(SingleItem(
            id: data.items.data[i].id,
            name: data.items.data[i].name,
            size: data.items.data[i].size,
            weight: data.items.data[i].weight,
            img: data.items.data[i].img,
            quantity: data.items.data[i].quantity,
            categoryId: data.items.data[i].categoryId,
            companyId: data.items.data[i].companyId,
            countryId: data.items.data[i].countryId,
            caratId: data.items.data[i].caratId,
            isFavourited: data.items.data[i].isFavourited,
            price: data.items.data[i].price,
            inBasket: data.items.data[i].inBasket,
            caratMs: data.items.data[i].caratMs,
            caratType: data.items.data[i].caratType,
            countryName: data.items.data[i].countryName));
      }
      _items = temporaryList;

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> refresh(
      {String search = '',
      double size_start = 0,
      double size_end = 0,
      double weight_start = 0,
      double weight_end = 0,
      int category_id = 0,
      int carat_id = 0}) async {
    try {
      String token = await Auth().getToken();
      final response = await http.get(
          Uri.parse(next_url +
              '&search=$search&category_id=${category_id == 0 ? '' : category_id}&carat_id=${carat_id == 0 ? '' : carat_id}&size_start=${size_start == 0 ? '' : size_start}&size_end=${size_end == 0 ? '' : size_end}&weight_start=${weight_start == 0 ? '' : weight_start}&weight_end=${weight_end == 0 ? '' : weight_end}'),
          headers: {
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
            size: data.items.data[i].size,
            weight: data.items.data[i].weight,
            img: data.items.data[i].img,
            quantity: data.items.data[i].quantity,
            categoryId: data.items.data[i].categoryId,
            companyId: data.items.data[i].companyId,
            countryId: data.items.data[i].countryId,
            caratId: data.items.data[i].caratId,
            isFavourited: data.items.data[i].isFavourited,
            price: data.items.data[i].price,
            inBasket: data.items.data[i].inBasket,
            caratMs: data.items.data[i].caratMs,
            caratType: data.items.data[i].caratType,
            countryName: data.items.data[i].countryName));
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
            size: data.items![i].size,
            weight: data.items![i].weight,
            img: data.items![i].img,
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
      _favouriteItems = temporaryList;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getItemById(int item_id) async{
    String result='';
  try {
      String token = await Auth().getToken();
      final response =
          await http.get(Uri.parse(base + 'item/'+'${item_id}'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      final data = SingleItem.fromJson(json.decode(response.body));
      ItemDetails=SingleItem(
        id: data.id,
        img: data.img,
        name: data.name,
        countryName: data.countryName,
        caratType: data.caratType,
        caratMs: data.caratMs,
        weight: data.weight,
        price: data.price,
        description: data.description,
        inBasket: data.inBasket,
        isFavourited: data.isFavourited,
        size: data.size
      );
      notifyListeners();
      result="success";
    
  } catch (e) {
    result=e.toString();
  }
  print(result);
  return result;

  }
}
