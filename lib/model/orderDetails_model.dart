import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';

class OrderDetailsModel with ChangeNotifier{
    OrderDetailsModel({
         this.id,
         this.total,
         this.status,
         this.orderItems,
    });

    int? id;
    double? total;
    String? status;
    List<OrderItem>? orderItems;

    factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
        id: json["id"],
        total: json["total"]?.toDouble(),
        status: json["status"],
        orderItems: List<OrderItem>.from(json["order_items"].map((x) => OrderItem.fromJson(x))),
    );
}

class OrderItem {
    OrderItem({
        required this.id,
        required this.quantity,
        required this.priceSingle,
        required this.priceTotal,
        required this.item,
    });

    int id;
    int quantity;
    double priceSingle;
    double priceTotal;
    SingleItem item;

    factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        quantity: json["quantity"],
        priceSingle: json["price_single"]?.toDouble(),
        priceTotal: json["price_total"]?.toDouble(),
        item: SingleItem.fromJson(json["item"]),
    );
}


