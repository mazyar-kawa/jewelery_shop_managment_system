import 'package:flutter/material.dart';

const websize = 600;

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

Color primaryFadeCardDark = Color(0xff262626);
Color seconderFadeCardDark = Color(0xff262626);

Color shadowCardDark = Color.fromARGB(255, 19, 19, 19);

String base = 'http://192.168.1.32:8000/api/';

void showSnackBar(BuildContext context, message, undon) {
  final snackBar = SnackBar(
    dismissDirection: DismissDirection.startToEnd,
    content: Stack(
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: undon ? Colors.red : Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Text(
              message,
              style: TextStyle(fontFamily: 'RobotoB', fontSize: 14),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: EdgeInsets.only(left: 10),
            child: Image.asset(
              'assets/images/gold_bars.png',
              width: 45,
            ),
          ),
        )
      ],
    ),
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
    duration: Duration(milliseconds: 1000),
    elevation: 0,
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
