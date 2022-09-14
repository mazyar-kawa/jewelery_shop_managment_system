import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/user_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/auth_provider.dart';

class UserRefresh with ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser!;

  Future<void> refreshUser() async {
    ApiProvider user = await getUserDetails();

    _currentUser = user.data as User;

    notifyListeners();
  }
}
