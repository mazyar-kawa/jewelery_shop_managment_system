import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/notification.dart';
import 'package:http/http.dart' as http;
import 'package:jewelery_shop_managmentsystem/service/auth_service.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';

class NotificationsService with ChangeNotifier{

  List<Notifications> _notify=[];

  List<Notifications> get notify=>[..._notify];

  Future<void> getNotification() async{
   
     String token = await Auth().getToken();
      try {
        final response =
            await http.get(Uri.parse(base + 'notifications'), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
        final data1= notificationsFromJson(response.body);

        final List<Notifications> temporaryList = [];

      

        for (Notifications notify in data1){
          temporaryList.add(notify);
        }
        _notify = temporaryList;
      } catch (e) {
          print(e.toString());
      }
      notifyListeners();
     
  }

}