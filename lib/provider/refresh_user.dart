import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/user_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';

class RefreshUser with ChangeNotifier {
  AuthUser? _currentUser;

  AuthUser get currentUser => _currentUser!;
 late  int _favourite;

  int get favorite => _favourite;


  late  int _order ;

  int get order  => _order ;

  // Future<int> increasefavorite() async {
  //   _currentUser!.user!.favoriteNo = _currentUser!.user!.favoriteNo! + 1;
  //   _favourite=_currentUser!.user!.favoriteNo!;
  //   notifyListeners();
  //   return _favourite;
  // }


  //  Future<int> decreasefavorite() async {
  //   _currentUser!.user!.favoriteNo = _currentUser!.user!.favoriteNo! - 1;
  //   _favourite=_currentUser!.user!.favoriteNo!;
  //   notifyListeners();
  //   return _favourite;
  // }


  // Future<int> increaseOrder() async {
  //   _currentUser!.user!.orderNo = _currentUser!.user!.orderNo! + 1;
  //   _order=_currentUser!.user!.orderNo!;
  //   notifyListeners();
  //   return _order;
  // }


  //  Future<int> decreaseOrder() async {
  //   _currentUser!.user!.orderNo = _currentUser!.user!.orderNo! - 1;
  //   _order=_currentUser!.user!.orderNo!;
  //   notifyListeners();
  //   return _order;
  // }

  Future<void> refreshuser({bool update = false, AuthUser? user}) async {
    if (!update) {
      ApiProvider user = await Auth().getUserDetials();
      _currentUser = user.data as AuthUser;
      // _favourite=_currentUser!.user!.favoriteNo!;
      // _order=_currentUser!.user!.orderNo!;
    } else {
      _currentUser = AuthUser(user: user!.user);
    }
    notifyListeners();
  }
}
