import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:http/http.dart' as http;
import 'package:jewelery_shop_managmentsystem/model/search_for_items.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';

class SearchFoItems with ChangeNotifier{
List<SingleItem> _items = [];

List<SingleItem> get items => [..._items];


 List<SingleItem> _recentitems = [];

List<SingleItem> get recentitems => [..._recentitems];


  String next_url="";

  Future<void> search(String item_name) async{

    try {
      final response = await http.get(
          Uri.parse(base +'items?search=$item_name'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          });
          final data = SearchItems.fromJson(json.decode(response.body));
  print(response.statusCode);
      next_url = data.nextPageUrl!;
      final List<SingleItem> temporaryList = [];

      for (SingleItem item in data.data){
          temporaryList.add(item);
      }
      _items = temporaryList;
      print(_items.length);
      notifyListeners();
    } catch (e) {
      
    }


  }

  Future<void> pagination(String item_name) async{
    if(next_url!="null"){
      final response = await http.get(
          Uri.parse(next_url +
              '&search=$item_name'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          });
    final data = SearchItems.fromJson(json.decode(response.body));
    this.next_url = data.nextPageUrl!;
     for (SingleItem item in data.data){
          _items.add(item);
      }
      notifyListeners();
    }else{

    }
  }
  Future<void> addRecentItem(SingleItem item) async{

    _recentitems.add(item);

  }

  Future<void> getRecentItem() async{
    
  }




}