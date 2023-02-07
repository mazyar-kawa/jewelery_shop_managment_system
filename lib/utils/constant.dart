import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/user_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/refresh_user.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:provider/provider.dart';


const websize = 600;

Color scaffoldbackgroundLight = Color(0xffFFFFFF);
Color primaryColorLight = Color(0xff455A64);

Color primaryFadeCardLight = Color(0xffECF1F4);
Color seconderFadeCardLight = Color(0xffFFEDED);

Color primaryCardLight = Color(0xffDBE5E7);
Color seconderCardLight = Color(0xffFFDAD9);

Color shadowCardLight = Colors.grey.withOpacity(0.3);





Color primaryColorDark = Color(0xff7dd3fc);

Color primaryFadeCardDark = Color(0xffbae6fd);
Color seconderFadeCardDark = Color(0xffC6FCE5);

Color primaryCardDark = Color(0xffbae6fd);
Color seconderCardDark = Color(0xFFfecdd3);
//3B3B3B
Color scaffoldbackgroundDark = Color(0xFF121212);
Color shadowCardDark = Color(0xffFFFFFF).withOpacity(0.3);

String base = 'http://192.168.1.32:8000/api/';

void showSnackBar(BuildContext context, message, undon) {
  final snackBar = SnackBar(
    dismissDirection: DismissDirection.startToEnd,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    content: Text(message),
    backgroundColor: undon ? Colors.red : Colors.green,
    behavior: SnackBarBehavior.floating,
    duration: Duration(milliseconds: 1000),
    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
    elevation: 10,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

final boredruser = OutlineInputBorder(
  borderSide: BorderSide(
    color: Color(0xffE9E9E9),
    width: 2,
  ),
  borderRadius: BorderRadius.circular(15),
);

 