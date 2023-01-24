import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';

class TextFormUser extends StatefulWidget {
  final TextEditingController controller;
  bool isobscure;
  final dynamic hintText;
  final bool isIcon;
  TextFormUser(
      {super.key,
      required this.controller,
      this.isobscure = false,
      this.isIcon = false,
      required this.hintText});

  @override
  State<TextFormUser> createState() => _TextFormUserState();
}

class _TextFormUserState extends State<TextFormUser> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isobscure,
      decoration: InputDecoration(
          hintText: widget.hintText,
          border: boredruser,
          enabledBorder: boredruser,
          focusedBorder: boredruser,
          suffixIcon: widget.isIcon
              ? Padding(
                  padding: const EdgeInsets.all(15),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        widget.isobscure = !widget.isobscure;
                      });
                    },
                    child: widget.isobscure
                        ? SvgPicture.asset(
                            'assets/images/eye-solid.svg',
                            width: 5,
                          )
                        : SvgPicture.asset(
                            'assets/images/eye-slash-solid.svg',
                            width: 5,
                          ),
                  ),
                )
              : null),
    );
  }
}
