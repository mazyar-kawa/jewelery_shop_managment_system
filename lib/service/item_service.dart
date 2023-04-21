import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:http/http.dart' as http;
import 'package:jewelery_shop_managmentsystem/service/auth_service.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';

class ItemService with ChangeNotifier {
  List<SingleItem> _items = [];

List<SingleItem> get items => [..._items];
  SingleItem _ItemDetails=SingleItem();

SingleItem get ItemDetails => _ItemDetails;

  

  List<SingleItem> _favouriteItems = [];
  List<SingleItem> get favouriteItems => [..._favouriteItems];

  String next_url = '';

  Future<void> getItems(int country_id,
      {String search = '',
      String type='',
      double size_start = 0,
      double size_end = 0,
      double weight_start = 0,
      double weight_end = 0,
      int category_id = 0,
      String carat='',
      }) async {
    try {
      String token = await Auth().getToken();
      final response = await http.get(
          Uri.parse(base +
              'country_items/$country_id?search=$search&category_id=${category_id == 0 ? '' : category_id}&size_start=${size_start == 0 ? '' : size_start}&size_end=${size_end == 0 ? '' : size_end}&weight_start=${weight_start == 0 ? '' : weight_start}&weight_end=${weight_end == 0 ? '' : weight_end}&type=${type}&carat=${carat}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      final data = Items.fromJson(json.decode(response.body));
      next_url = data.items.nextPageUrl!;
      final List<SingleItem> temporaryList = [];

      for (SingleItem item in data.items.data){
          temporaryList.add(item);
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
      String type='',
      String carat='',}) async {
    try {
      String token = await Auth().getToken();
      final response = await http.get(
          Uri.parse(next_url +
              '&search=$search&category_id=${category_id == 0 ? '' : category_id}&size_start=${size_start == 0 ? '' : size_start}&size_end=${size_end == 0 ? '' : size_end}&weight_start=${weight_start == 0 ? '' : weight_start}&weight_end=${weight_end == 0 ? '' : weight_end}&type=${type}&carat=${carat}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      final data = Items.fromJson(json.decode(response.body));
      this.next_url = data.items.nextPageUrl!;
      for (SingleItem item in data.items.data){
          _items.add(item);
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
      for (SingleItem item in data.items!){
          temporaryList.add(item);
      }
      _favouriteItems = temporaryList;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteFavouriteItem(int item_id) async {
    _favouriteItems.removeWhere((element) => element.id == item_id);
    notifyListeners();
  }


  Future<SingleItem> getItemById(int item_id) async{

  try {
      String token = await Auth().getToken();
      final response =
          await http.get(Uri.parse(base + 'item/'+'${item_id}'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      final data = SingleItem.fromJson(json.decode(response.body));
      _ItemDetails=data;
  } catch (e) {
    print(e.toString());
  }

  return ItemDetails;

  }

  Future getItemByIdCountries(int item_id,
      {bool basket = false, bool favorite = false})async{
        for (SingleItem item in _items) {
      if (item.id == item_id) {
          int index= _items.indexWhere((element) => element.id==item_id);
        _items[index].isFavourited = favorite;
        _items[index].inBasket = basket;
      }
    }
    notifyListeners();

  }



 
}
