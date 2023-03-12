import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/basket_model.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_service.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:http/http.dart' as http;

class BasketItemService with ChangeNotifier {
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
        // caratMs: items.caratMs,
        // caratType: items.caratType,
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
          for (ItemBasket item in data.data!){
            temporaryList.add(item);
          }
          // for (var i = 0; i < data.data!.length; i++) {
          //   final dataOrganize = data.data![i];
          //   if (dataOrganize.quantity != 0) {
          //     temporaryList.add(ItemBasket(
          //       basketId: dataOrganize.basketId,
          //       userId: dataOrganize.userId,
          //       id: dataOrganize.id,
          //       quantity: dataOrganize.quantity,
          //       name: dataOrganize.name,
                
          //       countryName: dataOrganize.countryName,
          //       caratMs: dataOrganize.caratMs,
          //       caratType: dataOrganize.caratType,
          //       img: dataOrganize.img,
          //       price: dataOrganize.price,
          //       weight: dataOrganize.weight,
          //       inBasket: dataOrganize.inBasket,
          //     ));
          //   } 
          // }

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
      for (ItemBasket item in data.data!){
            _basket.add(item);
          }
      // for (var i = 0; i < data.data!.length; i++) {
      //   final dataOrganize = data.data![i];
      //   _basket.add(ItemBasket(
      //     basketId: dataOrganize.basketId,
      //     userId: dataOrganize.userId,
      //     id: dataOrganize.id,
      //     quantity: dataOrganize.quantity,
      //     name: dataOrganize.name,
      //     countryName: dataOrganize.countryName,
      //     caratMs: dataOrganize.caratMs,
      //     caratType: dataOrganize.caratType,
      //     img: dataOrganize.img,
      //     price: dataOrganize.price,
      //     weight: dataOrganize.weight,
      //     inBasket: dataOrganize.inBasket,
      //   ));
      // }
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteItemBasket(int item_id,BuildContext context) async{
    _basket.removeWhere((element) => element.id==item_id);
    notifyListeners();
  }
}
