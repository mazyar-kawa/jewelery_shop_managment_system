import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/orders_model.dart';
import 'package:jewelery_shop_managmentsystem/service/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_service.dart';
import 'package:jewelery_shop_managmentsystem/service/refresh_user.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OrderService with ChangeNotifier {
  List<MyOrder> _Orders = [];

  List<MyOrder> get Orders => [..._Orders];

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
          List<MyOrder> data =
              responseList.map((e) => MyOrder.fromJson(e)).toList();
          List<MyOrder> temporaryList = [];

          for (int i = 0; i < data.length; i++) {
            temporaryList.add(MyOrder(
              id: data[i].id,
              status: data[i].status,
              total: data[i].total,
              createdAt: data[i].createdAt,
            ));
          }
          _Orders = temporaryList;
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
      print(response.statusCode);
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


  Future<ApiProvider> DeleteOrder(int itemId,BuildContext context) async {
    ApiProvider apiProvider = ApiProvider();
    String token = await Auth().getToken();
    try {
      final response = await http.delete(
          Uri.parse(base + "order/${itemId}"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      switch (response.statusCode) {
        case 200:
          apiProvider.data = json.decode(response.body);
          deleteOrderById(itemId,context);
          break;
        default:
          apiProvider.error = jsonDecode(response.body);
      }
    } catch (e) {
      apiProvider.error = {'message': e.toString()};
    }
    return apiProvider;
  }

  Future<ApiProvider> OrderById(List<int> BasketsId,BuildContext context) async {
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
    await Provider.of<RefreshUser>(context, listen: false).increaseOrder();
    return resultResquest;
  }


   Future deleteOrderById(int item_id,BuildContext context)async{
    _Orders.removeWhere((element) => element.id == item_id);
    await Provider.of<RefreshUser>(context, listen: false).decreaseOrder();
    notifyListeners();

  }
}
