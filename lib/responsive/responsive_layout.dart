import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';

class LayoutScreen extends StatefulWidget {
  final Widget webscreen;
  final Widget mobilescreen;

  const LayoutScreen(
      {Key? key, required this.webscreen, required this.mobilescreen})
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
          return widget.webscreen;
        }
        return widget.mobilescreen;
      },
    );
  }
}
