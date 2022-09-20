import 'package:flutter/cupertino.dart';

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
}
