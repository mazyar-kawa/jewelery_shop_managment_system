import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/screens/bottom_navBar.dart';
import 'package:jewelery_shop_managmentsystem/screens/signin_screen.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  @override
  Widget build(BuildContext context) {
    return LoadingPage(
      // islogin: false,
    );
  }
}
