import 'package:flutter/foundation.dart';
import 'package:jewelery_shop_managmentsystem/model/card_items.dart';

class BasketItemProvider with ChangeNotifier {
  List<BasketItem> _basket = [];

  List<BasketItem> get baskets => [..._basket];

  countItem() {
    return _basket.length;
  }

  addToBasket(String id, int idItem, int quantity) {
    _basket.add(BasketItem(id: id, idItem: idItem, quantity: quantity));
    countItem();
    notifyListeners();
  }
}
