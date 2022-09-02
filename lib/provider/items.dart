import 'package:flutter/cupertino.dart';

class Items with ChangeNotifier {
  String name;
  String image;
  double price;
  int size;
  String nameCategory;
  int id;
  int idCategory;
  String puring;
  bool isFavorite;

  Items({
    required this.name,
    required this.image,
    required this.price,
    required this.size,
    required this.nameCategory,
    required this.id,
    required this.idCategory,
    required this.puring,
    this.isFavorite = false,
  });

  void favorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

// List<Items> items = [];
