import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/screens/bottom_navBar.dart';
import 'package:jewelery_shop_managmentsystem/screens/signin_screen.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}
