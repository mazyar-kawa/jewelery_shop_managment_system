import 'package:flutter/material.dart';

class Notifications with ChangeNotifier{
  String? title;
  String? body;
  bool? status;
  String? date;


  Notifications({
    this.title,
    this.body,
    this.status,
    this.date,
  });

}
