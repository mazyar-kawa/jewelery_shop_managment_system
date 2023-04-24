import 'dart:convert';

import 'package:jewelery_shop_managmentsystem/model/item_model.dart';


class SearchItems {
    SearchItems({
        required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
  });

  int? currentPage;
  List<SingleItem>? data;
  String? firstPageUrl;
  int? from;
  dynamic? nextPageUrl;
  String path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;

    factory SearchItems.fromJson(Map<String, dynamic> json) => SearchItems(
        currentPage: json["current_page"],
        data: List<SingleItem>.from(json["data"].map((x) => SingleItem.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
         from: json["to"],
    );
}