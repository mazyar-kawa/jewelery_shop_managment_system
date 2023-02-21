import 'package:flutter/material.dart';


const websize = 600;
// 7dd3fc    sky
Color scaffoldbackgroundLight = Color(0xffFFFFFF);
Color primaryColorLight = Color(0xff455A64);

Color secondColorLight = Color(0xffFFFFFF);

Color primaryFadeCardLight = Color(0xffECF1F4);
Color seconderFadeCardLight = Color(0xffFFEDED);

Color primaryCardLight = Color(0xffDBE5E7);
Color seconderCardLight = Color(0xffFFDAD9);

Color shadowCardLight = Colors.grey.withOpacity(0.3);




Color scaffoldbackgroundDark = Color(0xFF000000);
Color primaryColorDark = Color(0xffFFFFFF);

Color secondColorDark = Color(0xff262626);

Color primaryFadeCardDark = Color(0xfffb7185);
Color seconderFadeCardDark = Color(0xff38bdf8);

// Color primaryFadeCardDark = Color(0xfff43f5e);
// Color seconderFadeCardDark = Color(0xffF5F5DC);

//3B3B3B

Color shadowCardDark = Color.fromARGB(255, 19, 19, 19);

String base = 'http://192.168.1.32:8000/api/';

void showSnackBar(BuildContext context, message, undon) {
  final snackBar = SnackBar(
    dismissDirection: DismissDirection.startToEnd,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    content: Text('${message}'),
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

 