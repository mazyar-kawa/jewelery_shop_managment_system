import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:http/http.dart' as http;
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';

class ItemProviderORG with ChangeNotifier {
  List<SingleItem> _items = [];

  List<SingleItem> get items => [..._items];

  Future<void> getItems(int country_id) async {
    final url = 'http://192.168.1.32:8000/api/country_items/$country_id?page=1';
    try {
      final response = await http.get(Uri.parse(url));
      switch (response.statusCode) {
        case 200:
          final data = await json.decode(response.body) as Map<String, dynamic>;
          final List<dynamic> extradata = data['items']['data'];
          print(extradata);
          final List<SingleItem> temporaryList = [];

          extradata.forEach((element) {
            temporaryList.add(SingleItem(
              id: element['id'],
              name: element['name'],
              img: element['img'],
              price: element['price'],
              size: element['size'],
              profit: element['profit'],
              categoryId: element['category_id'],
              companyId: element['company_id'],
              countryId: element['country_id'],
              description: element['description'],
              quantity: element['quantity'],
            ));
          });
          _items = temporaryList;
          break;
        default:
          print(response.body);
          notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
