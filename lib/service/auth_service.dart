import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/user_model.dart';

import 'package:http/http.dart' as http;
import 'package:jewelery_shop_managmentsystem/service/api_provider.dart';

import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  Future<ApiProvider> login({
    required String email,
    required String password,
  }) async {
    ApiProvider apiProvider = ApiProvider();
    final body = {
      'email': email,
      'password': password,
    };
    try {
      final response = await http
          .post(Uri.parse(base + 'login'), body: jsonEncode(body), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      switch (response.statusCode) {
        case 200:
          apiProvider.data = User.fromJson(json.decode(response.body));
          break;
        default:
          apiProvider.error = jsonDecode(response.body);
          break;
      }
    } catch (e) {
      apiProvider.error = {'message': e.toString()};
      print(e.toString());
    }
    print(apiProvider.error);
    return apiProvider;
  }

  Future<ApiProvider> SignUp({
    required String name,
    required String username,
    required String email,
    required String password,
    required String passwordconfirm,
  }) async {
    ApiProvider apiProvider = ApiProvider();
    final body = {
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'password_confirmation': passwordconfirm,
    };
    try {
      final response = await http
          .post(Uri.parse(base + 'register'), body: jsonEncode(body), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      switch (response.statusCode) {
        case 200:
          apiProvider.data = User.fromJson(json.decode(response.body));
          break;
        default:
          apiProvider.error = jsonDecode(response.body);
          print(apiProvider.error);
          break;
      }
    } catch (e) {
      apiProvider.error = {'message': e.toString()};
    }
    return apiProvider;
  }

  Future<ApiProvider> getUserDetials() async {
    ApiProvider apiProvider = ApiProvider();
    try {
      String token = await getToken();
      final response =
          await http.get(Uri.parse(base + 'currentUser'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      switch (response.statusCode) {
        case 200:
          apiProvider.data = AuthUser.fromJson(json.decode(response.body));
          break;
        default:
          apiProvider.error = jsonDecode(response.body);
      }
    } catch (e) {
      apiProvider.error = {'message': e.toString()};
    }
    return apiProvider;
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId') ?? 0;
  }

  Future<bool> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove('token');
  }

  Future<ApiProvider> FavouriteItem(int itemId) async {
    final body = {'item_id': itemId};
    ApiProvider apiProvider = ApiProvider();
    try {
      String token = await getToken();

      final response = await http.post(Uri.parse(base + 'favorite_item'),
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      switch (response.statusCode) {
        case 200:
          apiProvider.data = json.decode(response.body);
          break;
        default:
          apiProvider.error = jsonDecode(response.body);
      }
    } catch (e) {
      apiProvider.error = {'message': e.toString()};
    }

    return apiProvider;
  }

  Future<ApiProvider> UnFavouriteItem(int itemId) async {
    final body = {'item_id': itemId};
    ApiProvider apiProvider = ApiProvider();
    try {
      String token = await getToken();

      final response = await http.post(Uri.parse(base + 'unfavorite_item'),
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      switch (response.statusCode) {
        case 200:
          apiProvider.data = json.decode(response.body);
          break;
        default:
          apiProvider.error = jsonDecode(response.body);
      }
    } catch (e) {
      apiProvider.error = {'message': e.toString()};
    }

    return apiProvider;
  }

  Future<ApiProvider> UpdateUserData(File image, String name, String username,
      String email, String phone_no, String address) async {
    ApiProvider apiProvider = ApiProvider();
    try {
      String token = await getToken();
      final url = Uri.parse(base + "updateProfile");
      final request;
      if(image.path==''){
         request = http.MultipartRequest('POST', url)
        ..fields['name'] = name
        ..fields['username'] = username
        ..fields['email'] = email
        ..fields['phone_no'] = phone_no
        ..fields['address'] = address
        ..headers['Accept'] = 'application/json'..headers['Authorization']='Bearer $token';
      }else{
         request = http.MultipartRequest('POST', url)
        ..fields['name'] = name
        ..fields['username'] = username
        ..fields['email'] = email
        ..fields['phone_no'] = phone_no
        ..fields['address'] = address
        ..files.add(
            await http.MultipartFile.fromPath('profile_picture', image.path))
        ..headers['Accept'] = 'application/json'..headers['Authorization']='Bearer $token';
      }
      final response = await request.send();
      

      final responseData = await response.stream.bytesToString();
      switch (response.statusCode) {
        case 200:
          apiProvider.data = AuthUser.fromJson(json.decode(responseData));
          break;
        default:
          apiProvider.error = jsonDecode(responseData);
          break;
      }
    } catch (e) {
      apiProvider.error = {'message': e.toString()};
    }
    
    return apiProvider;
  }

  Future<ApiProvider> UpdatePassword(
      String currentPassword, String newPassword, String retypePassword) async {
    ApiProvider apiProvider = ApiProvider();
    final body = {
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': retypePassword
    };
    try {
      String token = await getToken();
      final response = await http.post(Uri.parse(base + "updatePassword"),
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          apiProvider.data = json.decode(response.body);
          break;
        default:
          apiProvider.error = jsonDecode(response.body);
          break;
      }
    } catch (e) {
      apiProvider.error = {'message': e.toString()};
    }
    print(apiProvider.data);
    print(apiProvider.error);
    return apiProvider;
  }
}

class Checkuser with ChangeNotifier {
  bool _islogon = false;

  bool get islogin => _islogon;

  Future<bool> checkUser({bool iserror = false}) async {
    String token = await Auth().getToken();

    if(iserror){
      _islogon=false;
    }else{
      if (token == '') {
      _islogon = false;
    } else {
      _islogon = true;
    }
    }

    return _islogon;
  }
}
