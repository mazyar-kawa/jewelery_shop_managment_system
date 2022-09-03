import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/card_items.dart';
import 'package:jewelery_shop_managmentsystem/provider/items.dart';

class ItemProvider with ChangeNotifier {
  List<Items> items = [
    Items(
        name: 'item1',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 1,
        idCategory: 1,
        puring: 'Gold'),
    Items(
        name: 'item2',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 2,
        idCategory: 1,
        puring: 'Gold'),
    Items(
        name: 'item3',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 3,
        idCategory: 1,
        puring: 'Gold'),
    Items(
        name: 'item4',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 4,
        idCategory: 1,
        puring: 'Gold'),
    Items(
        name: 'item5',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 5,
        idCategory: 1,
        puring: 'Gold'),
    Items(
        name: 'item6',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 6,
        idCategory: 2,
        puring: 'Silver'),
    Items(
        name: 'item7',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 7,
        idCategory: 2,
        puring: 'Silver'),
    Items(
        name: 'item8',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 8,
        idCategory: 2,
        puring: 'Silver'),
    Items(
        name: 'item9',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 9,
        idCategory: 2,
        puring: 'Silver'),
    Items(
        name: 'item10',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 10,
        idCategory: 2,
        puring: 'Silver'),
    Items(
        name: 'item11',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 11,
        idCategory: 3,
        puring: 'Gold'),
    Items(
        name: 'item12',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 12,
        idCategory: 3,
        puring: 'Gold'),
    Items(
        name: 'item13',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 13,
        idCategory: 3,
        puring: 'Gold'),
    Items(
        name: 'item14',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 14,
        idCategory: 3,
        puring: 'Gold'),
    Items(
        name: 'item15',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 15,
        idCategory: 3,
        puring: 'Gold'),
    Items(
        name: 'item16',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 16,
        idCategory: 4,
        puring: 'Silver'),
    Items(
        name: 'item17',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 17,
        idCategory: 4,
        puring: 'Silver'),
    Items(
        name: 'item18',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 18,
        idCategory: 4,
        puring: 'Silver'),
    Items(
        name: 'item19',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 19,
        idCategory: 4,
        puring: 'Silver'),
    Items(
        name: 'item20',
        image:
            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
        price: 190,
        size: 18,
        nameCategory: 'Ring',
        id: 20,
        idCategory: 4,
        puring: 'Silver'),
  ];

  List<Items> get item => [...items];

  List<Items> get favorite =>
      items.where((element) => element.isFavorite).toList();

  getById(id) {
    return items.where((element) => element.isFavorite).toList();
  }
}
