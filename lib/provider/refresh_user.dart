import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/user_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';

class RefreshUser with ChangeNotifier {
  AuthUser? _currentUser;

  AuthUser get currentUser => _currentUser!;

  Future<void> refreshuser() async {
    ApiProvider user = await Auth().getUserDetials();
    _currentUser = user.data as AuthUser;
    notifyListeners();
  }
}
