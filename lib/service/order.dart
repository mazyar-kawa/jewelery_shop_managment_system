import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/orders_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:http/http.dart' as http;

class Order with ChangeNotifier{
  List<MyOrders> _orders = [];

  List<MyOrders> get orders => [..._orders];

  Future<void> getMyOrders() async {
    String token = await Auth().getToken();
    try {
      final response = await http.get(Uri.parse(base + "myOrders"), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      switch (response.statusCode) {
        case 200:
          List responseList = json.decode(response.body);
          List<MyOrders> data =
              responseList.map((e) => MyOrders.fromJson(e)).toList();
          List<MyOrders> temporaryList = [];

          for (int i = 0; i < data.length; i++) {
            temporaryList.add(MyOrders(
              id: data[i].id,
              status: data[i].status,
              total: data[i].total,
              createdAt: data[i].createdAt,
            ));
          }

          _orders = temporaryList;
          notifyListeners();
         

          break;
        default:
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ApiProvider> UpdateQuantity(int itemId, int quantity) async {
    ApiProvider apiProvider = ApiProvider();
    final body = {'item_id': itemId, "quantity": quantity};
    String token = await Auth().getToken();
    try {
      final response = await http.post(
          Uri.parse(base + "basket/updateQuantity"),
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      switch (response.statusCode) {
        case 200:
          apiProvider.data = json.decode(response.body);
          break;
        default:
          apiProvider.error = jsonDecode(response.body);
      }
    } catch (e) {
      apiProvider.error = {'message': e.toString()};
    }
    return apiProvider;
  }

  Future<ApiProvider> Orders(List<int> BasketsId) async {
    ApiProvider resultResquest = ApiProvider();
    String token = await Auth().getToken();
    final body = {"basket": BasketsId};
    try {
      final response = await http
          .post(Uri.parse(base + "addOrder"), body: jsonEncode(body), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          resultResquest.data = json.decode(response.body);
          break;
        default:
          resultResquest.error = jsonDecode(response.body);
      }
    } catch (e) {
      resultResquest.error = {'message': e.toString()};
      print(e.toString());
    }
    return resultResquest;
  }
}
