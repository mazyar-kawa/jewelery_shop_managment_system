import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:jewelery_shop_managmentsystem/model/basket_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:provider/provider.dart';

class BasketCardItem extends StatefulWidget {
  bool islogin;
  BasketCardItem({super.key, required this.islogin});

  @override
  State<BasketCardItem> createState() => _BasketCardItemState();
}

class _BasketCardItemState extends State<BasketCardItem> {
  bool ischecked = false;
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ItemBasket>(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      height: 100,
      decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).primaryColorLight, width: 1),
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).shadowColor,
                blurRadius: 5,
                offset: Offset(0, 3)),
          ]),
      child: Dismissible(
        movementDuration: Duration(milliseconds: 1500),
        direction: DismissDirection.endToStart,
        background: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 100,
          decoration: BoxDecoration(
          border:
              Border.all(color: Colors.red, width: 1),
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).shadowColor,
                blurRadius: 5,
                offset: Offset(0, 3)),
          ]),
          child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                FontAwesome5.trash,
                color: Theme.of(context).scaffoldBackgroundColor,
              )),
        ),
        onDismissed: (direction) async {
          ApiProvider removeItem =
              await BasketItemProvider().removeToBasket(product.id!);
          showSnackBar(context, removeItem.data['message'], true);
          Provider.of<BasketItemProvider>(context, listen: false)
              .getItemBasket();
        },
        key: Key("${product}"),
        child: Row(
          children: [
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.all(
                  Theme.of(context).primaryColorLight),
              value: ischecked,
              onChanged: (bool? value) {
                setState(() {
                  ischecked = value!;
                });
              },
            ),
            Container(
              width: 50,
              height: 50,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Image.network(
                product.img!,
                height: 50,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: new Container(
                    padding: new EdgeInsets.only(right: 13.0),
                    child: new Text(
                      product.name!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontFamily: 'RobotoB',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    product.countryName!,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontFamily: 'RobotoM',
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    product.caratType!,
                    style: TextStyle(
                      color: product.caratType == 'gold'
                          ? Color(0xffFFD700)
                          : Color(0xffC0C0C0),
                      fontFamily: 'RobotoM',
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
