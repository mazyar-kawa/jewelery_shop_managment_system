import 'package:flutter/material.dart';

const websize = 600;

Color scaffoldbackgroundLight = Color(0xffFFFFFF);
Color primaryColorLight = Color(0xff455A64);

Color primaryFadeCardLight = Color(0xffECF1F4);
Color seconderFadeCardLight = Color(0xffFFEDED);

Color primaryCardLight = Color(0xffDBE5E7);
Color seconderCardLight = Color(0xffFFDAD9);

Color shadowCardLight = Colors.grey.withOpacity(0.3);

Color primaryColorDark = Color(0xff7dd3fc);

Color primaryFadeCardDark = Color(0xffe0f2fe);
Color seconderFadeCardDark = Color(0xffe9d5ff);

Color primaryCardDark = Color(0xffbae6fd);
Color seconderCardDark = Color(0xFFfecdd3);
Color scaffoldbackgroundDark = Color(0xFF3B3B3B);
Color shadowCardDark = Color(0xff7dd3fc).withOpacity(0.3);

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
