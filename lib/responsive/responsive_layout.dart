import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';

class LayoutScreen extends StatefulWidget {
  final Widget ipadScreen;
  final Widget mobileScreen;

  const LayoutScreen(
      {Key? key, required this.ipadScreen, required this.mobileScreen})
      : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > websize) {
          return widget.ipadScreen;
        }
        return widget.mobileScreen;
      },
    );
  }
}
