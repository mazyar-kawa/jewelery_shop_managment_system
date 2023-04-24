import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:http/http.dart' as http;
import 'package:jewelery_shop_managmentsystem/model/search_for_items.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_service.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';

class SearchFoItems with ChangeNotifier{
List<SingleItem> _items = [];

List<SingleItem> get items => [..._items];

  String next_url='';

  Future<void> search(String item_name) async{

    try {
      _items=[];
      print(item_name);
      String token = await Auth().getToken();
      final response = await http.get(
          Uri.parse(base +'items?search=$item_name'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
          

          final data = SearchItems.fromJson(json.decode(response.body));
        
      next_url =data.nextPageUrl == null ? "No data" : data.nextPageUrl;
      print(next_url);
      
      final List<SingleItem> temporaryList = [];

      for (SingleItem item in data.data!){
          
          temporaryList.add(item);
      }
      _items = temporaryList;
      print("service");
      print(_items.length);
      notifyListeners();
    } catch (e) {
       print(e.toString());
    }


  }

  Future<void> pagination(String item_name) async{
    String token = await Auth().getToken();
     try {
       final response = await http.get(
          Uri.parse(next_url +
              '&search=$item_name'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
    final data = SearchItems.fromJson(json.decode(response.body));
    this.next_url = data.nextPageUrl == null ? "No data" : data.nextPageUrl;
     for (SingleItem item in data.data!){
          _items.add(item);
      }
      notifyListeners();
     } catch (e) {
       print(e.toString());
     }
  }




}