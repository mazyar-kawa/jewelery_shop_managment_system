import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:jewelery_shop_managmentsystem/model/basket_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:http/http.dart' as http;

class BasketItemProvider with ChangeNotifier {
  List<ItemBasket> _basket = [];

  List<ItemBasket> get baskets => [..._basket];

  List<ItemBasket> _ready = [];

  List<ItemBasket> get ready => [..._ready];

  TotalPrice() {
    double total = 0;
    for (var i = 0; i < ready.length; i++) {
      total += _ready[i].price!.round() * _ready[i].quantity!;
    }
    return total;
  }

  Future<void> getReadyItem() async {
    await _ready;
    notifyListeners();
  }

  clearItemChecked() {
    _ready.clear();
  }

  countItemReady() {
    return _ready.length;
  }

  addItemReady(ItemBasket items) {
    _ready.add(ItemBasket(
        basketId: items.basketId,
        userId: items.userId,
        id: items.id,
        quantity: items.quantity,
        name: items.name,
        countryName: items.countryName,
        caratMs: items.caratMs,
        caratType: items.caratType,
        img: items.img,
        price: items.price,
        weight: items.weight));
    countItemReady();
    notifyListeners();
  }

  removeItemReady(ItemBasket items) {
    _ready.removeWhere(
      (element) {
        return element.id == items.id;
      },
    );
    countItemReady();
    notifyListeners();
  }

  String next_url = '';

  countItem() {
    return _basket.length;
  }

  Future<void> getItemBasket() async {
    String token = await Auth().getToken();
    try {
      final response = await http.get(Uri.parse(base + 'basket/'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      switch (response.statusCode) {
        case 200:
          final data = await Basket.fromJson(json.decode(response.body));
          List<ItemBasket> temporaryList = [];
          next_url = data.nextPageUrl == null ? "No data" : data.nextPageUrl;
          for (var i = 0; i < data.data!.length; i++) {
            final dataOrganize = data.data![i];
            if (dataOrganize.quantity != 0) {
              temporaryList.add(ItemBasket(
                basketId: dataOrganize.basketId,
                userId: dataOrganize.userId,
                id: dataOrganize.id,
                quantity: dataOrganize.quantity,
                name: dataOrganize.name,
                countryName: dataOrganize.countryName,
                caratMs: dataOrganize.caratMs,
                caratType: dataOrganize.caratType,
                img: dataOrganize.img,
                price: dataOrganize.price,
                weight: dataOrganize.weight,
                inBasket: dataOrganize.inBasket,
              ));
            } else {
              removeToBasket(dataOrganize.id!);
            }
          }

          _basket = temporaryList;

          countItem();
          notifyListeners();

          break;

        case 401:
          _basket.clear();
          break;
        default:
          print("Some thing are worng");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> pagination() async {
    String token = await Auth().getToken();
    try {
      String token = await Auth().getToken();
      final response = await http.get(Uri.parse(next_url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      final data = await Basket.fromJson(json.decode(response.body));
      this.next_url = data.nextPageUrl == null ? "No data" : data.nextPageUrl;

      for (var i = 0; i < data.data!.length; i++) {
        final dataOrganize = data.data![i];
        _basket.add(ItemBasket(
          basketId: dataOrganize.basketId,
          userId: dataOrganize.userId,
          id: dataOrganize.id,
          quantity: dataOrganize.quantity,
          name: dataOrganize.name,
          countryName: dataOrganize.countryName,
          caratMs: dataOrganize.caratMs,
          caratType: dataOrganize.caratType,
          img: dataOrganize.img,
          price: dataOrganize.price,
          weight: dataOrganize.weight,
          inBasket: dataOrganize.inBasket,
        ));
      }

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ApiProvider> addToBasket(int itemId) async {
    await getItemBasket();
    final body = {'item_id': itemId};
    ApiProvider apiProvider = ApiProvider();
    try {
      String token = await Auth().getToken();
      final response = await http.post(Uri.parse(base + 'basket/addItem'),
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

  Future<ApiProvider> removeToBasket(int itemId) async {
    final body = {'item_id': itemId};
    ApiProvider apiProvider = ApiProvider();
    try {
      String token = await Auth().getToken();
      final response = await http.post(Uri.parse(base + 'basket/removeItem'),
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
}
