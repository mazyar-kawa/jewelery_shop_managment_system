import 'package:flutter/material.dart';

class TextFieldUserManagment extends StatelessWidget {
  final String lable;
  final String initialValue;

  const TextFieldUserManagment(
      {Key? key, required this.lable, required this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE9E9E9), width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE9E9E9), width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE9E9E9), width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE9E9E9), width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: lable,
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
