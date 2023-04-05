import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/user_model.dart';
import 'package:jewelery_shop_managmentsystem/service/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_service.dart';

class RefreshUser with ChangeNotifier {
  AuthUser? _currentUser;

  AuthUser get currentUser => _currentUser!;
  late int _favourite;

  int get favorite => _favourite;

  late int _Order;

  int get Order => _Order;

  Future<int> increasefavorite() async {
    _currentUser!.user!.favoriteNo = _currentUser!.user!.favoriteNo! + 1;
    _favourite=_currentUser!.user!.favoriteNo!;
    notifyListeners();
    return _favourite;
  }

   Future<int> decreasefavorite() async {
    _currentUser!.user!.favoriteNo = _currentUser!.user!.favoriteNo! - 1;
    _favourite=_currentUser!.user!.favoriteNo!;
    notifyListeners();
    return _favourite;
  }

  Future<int> increaseOrder() async {
    _currentUser!.user!.OrderNo = _currentUser!.user!.OrderNo! + 1;
    _Order=_currentUser!.user!.OrderNo!;
    notifyListeners();
    return _Order;
  }

   Future<int> decreaseOrder() async {
    _currentUser!.user!.OrderNo = _currentUser!.user!.OrderNo! - 1;
    _Order=_currentUser!.user!.OrderNo!;
    notifyListeners();
    return _Order;
  }

  Future<void> refreshuser({bool update = false, AuthUser? user}) async {
    
    if (!update) {
      ApiProvider user = await Auth().getUserDetials();
      if(user.data!=null){
      _currentUser = user.data as AuthUser;
      _favourite=_currentUser!.user!.favoriteNo!;
      _Order=_currentUser!.user!.OrderNo!;
      }else{
        
      }
    } else {
      _currentUser = AuthUser(user: user!.user);
    }
    notifyListeners();
  }
}
