import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/filter_model.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';

class Basket {
  Basket({
    required this.currentPage,
    required this.data,
    this.nextPageUrl,
    required this.total,
  });

  int? currentPage;
  List<ItemBasket>? data;
  dynamic? nextPageUrl;
  int? total;

  factory Basket.fromJson(Map<String, dynamic> json) => Basket(
        currentPage: json["current_page"],
        data: List<ItemBasket>.from(
            json["data"].map((x) => ItemBasket.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        total: json["total"],
      );
}

class ItemBasket with ChangeNotifier {
  ItemBasket({
     this.basketId,
     this.userId,
     this.id,
     this.name,
     this.quantity,
     this.img,
     this.countryName,
     this.caratMs,
     this.caratType,
     this.price,
     this.weight,
     this.inBasket,
     
  });
  int? basketId;
  int? userId;
  int? id;
  String? name;
  int? quantity;
  String? img;
  String? caratType;
  String? caratMs;
  String? countryName;
  double? price;
  int? weight;
  bool? inBasket;
  
  factory ItemBasket.fromJson(Map<String, dynamic> json) => ItemBasket(
        basketId: json["id"],
        userId: json["user_id"],
        id: json["item_id"],
        quantity: json["quantity"],
        img: SingleItem.fromJson(json["item"]).img,
        caratMs: SingleItem.fromJson(json["item"]).caratMs,
        caratType: SingleItem.fromJson(json["item"]).caratType,
        countryName: SingleItem.fromJson(json["item"]).countryName,
        name: SingleItem.fromJson(json["item"]).name,
        price: SingleItem.fromJson(json["item"]).price,
        weight: SingleItem.fromJson(json["item"]).weight,
        inBasket: SingleItem.fromJson(json["item"]).inBasket,
      );
}
