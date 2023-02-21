import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/widgets/card_items.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MixItemsScreen extends StatefulWidget {
  final String title;
  final List<SingleItem> items;
  const MixItemsScreen({super.key, required this.title, required this.items});

  @override
  State<MixItemsScreen> createState() => _MixItemsScreenState();
}

class _MixItemsScreenState extends State<MixItemsScreen> {
  bool loading = false;
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 150), () {
      setState(() {
        loading = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoB',
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            height: 20,
            width: 25,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
        ),
      ),
      body: loading
          ? Container(
              child: ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: widget.items[index],
                    builder: (context, child) {
                      return CardItems(
                        index: index,
                        isbasket: false,
                        
                      );
                    },
                  );
                },
              ),
            )
          : Center(
              child:
                  Lottie.asset('assets/images/loader_daimond.json', width: 200),
            ),
    );
  }
}
