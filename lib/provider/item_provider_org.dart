import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:http/http.dart' as http;
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';

class ItemProviderORG with ChangeNotifier {
  List<SingleItem> _items = [];

  List<SingleItem> get items => [..._items];

  Future<void> getItems(int country_id) async {
    print(country_id);
    try {
      print(base + 'country_items/$country_id?page=1');
      final response =
          await http.get(Uri.parse(base + 'country_items/$country_id?page=1'));
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = await Items.fromJson(json.decode(response.body));
          List<SingleItem> temporaryList = [];
          for (int i = 0; i < data.items!.data!.length; i++) {
            temporaryList.add(SingleItem(
              id: data.items!.data![i].id,
              name: data.items!.data![i].name,
              img: data.items!.data![i].img,
              price: data.items!.data![i].price,
              size: data.items!.data![i].size,
              profit: data.items!.data![i].profit,
              categoryId: data.items!.data![i].categoryId,
              companyId: data.items!.data![i].companyId,
              countryId: data.items!.data![i].countryId,
              description: data.items!.data![i].description,
              quantity: data.items!.data![i].quantity,
            ));
          }
          _items = temporaryList;
          print(json.decode(response.body));

          notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
