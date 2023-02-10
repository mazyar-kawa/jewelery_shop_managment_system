
import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  const SearchInput({required this.textController, required this.hintText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: const Offset(12, 26),
              blurRadius: 50,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(.1)),
        ]),
        child: TextField(
         controller: textController,
          onChanged: (value) {
            //Do something wi
          },
          decoration: InputDecoration(
            prefixIcon:  Icon(Icons.search, color: Theme.of(context).primaryColorLight),
            filled: true,
            fillColor: Theme.of(context).secondaryHeaderColor,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            enabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).scaffoldBackgroundColor, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            focusedBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).scaffoldBackgroundColor, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
          ),
        ),
    );
  }
}
