import 'dart:convert';

import 'package:flutter/cupertino.dart';

Items itemsFromJson(String str) => Items.fromJson(json.decode(str));

class Items {
  Items({
    this.items,
  });

  ItemsClass? items;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        items: ItemsClass.fromJson(json["items"]),
      );
}

class ItemsClass {
  ItemsClass({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
  });

  int? currentPage;
  List<SingleItem>? data;
  String? firstPageUrl;
  int? from;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic? prevPageUrl;
  int? to;

  factory ItemsClass.fromJson(Map<String, dynamic> json) => ItemsClass(
        currentPage: json["current_page"],
        data: List<SingleItem>.from(
            json["data"].map((x) => SingleItem.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
      );
}

class SingleItem with ChangeNotifier {
  SingleItem({
    this.id,
    this.name,
    this.size,
    this.price,
    this.profit,
    this.img,
    this.description,
    this.quantity,
    this.companyId,
    this.categoryId,
    this.countryId,
  });

  int? id;
  String? name;
  int? size;
  int? price;
  String? profit;
  String? img;
  String? description;
  int? quantity;
  int? companyId;
  int? categoryId;
  int? countryId;

  factory SingleItem.fromJson(Map<String, dynamic> json) => SingleItem(
        id: json["id"],
        name: json["name"],
        size: json["size"],
        price: json["price"],
        profit: json["profit"],
        img: json["img"],
        description: json["description"],
        quantity: json["quantity"],
        companyId: json["company_id"],
        categoryId: json["category_id"],
        countryId: json["country_id"],
      );
}
