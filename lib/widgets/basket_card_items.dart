import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:jewelery_shop_managmentsystem/model/basket_model.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/service/Basket_item_service.dart';
import 'package:jewelery_shop_managmentsystem/service/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/order.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:provider/provider.dart';

class BasketCardItem extends StatefulWidget {
  const BasketCardItem({super.key});

  @override
  State<BasketCardItem> createState() => _BasketCardItemState();
}

class _BasketCardItemState extends State<BasketCardItem> {
  UpdateQuantities(int item_id, int quantity, bool decrease) async {
    ApiProvider response =
        await Provider.of<OrderService>(context, listen: false)
            .UpdateQuantity(item_id, quantity);
    if (response.data != null) {
      showSnackBar(context, response.data['message'], decrease);
    } else {
      showSnackBar(context, response.error!['errors']['quantity'], true);
    }
  }

  addItemToReady(ItemBasket item, bool ischecked) async {
    if (ischecked) {
      await Provider.of<BasketItemService>(context, listen: false)
          .addItemReady(item);
    } else {
      await Provider.of<BasketItemService>(context, listen: false)
          .removeItemReady(item);
    }
  }

  bool ischecked = false;
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<ItemBasket>(context, listen: false);
    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 25),
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.black,
              )
            ),
            child: Stack(
              children: [
                Positioned(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Checkbox(
                      checkColor:Colors.white,
                      fillColor: MaterialStateProperty.all(Colors.black),
                      value: ischecked,
                      onChanged: (bool? value) {
                        setState(() {
                          ischecked = value!;
                          addItemToReady(item, ischecked);
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: AspectRatio(
                        aspectRatio: 2,
                        child: Image.network(item.img!, fit: BoxFit.contain)),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width * 0.6,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight.withOpacity(0.4),
              borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(right: 13.0),
                                child: Text(
                                  item.name!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontFamily: 'RobotoB',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                      child: Text(
                                        '\$ ${item.price!.round()}',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontFamily: 'RobotoB',
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                          ],
                          
                        ),
                        Container(
                          child: Text(
                            item.countryName!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontFamily: 'RobotoB',
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                            child: Row(children: [
                              Icon(FontAwesome5.balance_scale,
                                  color: Theme.of(context).primaryColorLight,
                                  size: 15),
                              Text(
                                '  ${item.weight!}g',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontFamily: 'RobotoM',
                                  fontSize: 16,
                                ),
                              ),
                            ])),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (item.quantity! == 1) {
                                  showSnackBar(context,
                                      "Quantity must be greater than 0", true);
                                } else {
                                  addItemToReady(item, false);
                                  ischecked = false;
                                  item.quantity = item.quantity! - 1;
                                  EasyDebounce.debounce("decreaseQuantity",
                                      Duration(milliseconds: 250), () {
                                    return UpdateQuantities(
                                        item.id!, item.quantity!, true);
                                  });
                                }
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorLight,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                  child: Icon(Icons.minimize,
                                      color:
                                          Theme.of(context).scaffoldBackgroundColor,
                                      size: 16)),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            child: Center(
                              child: Text(
                                '${item.quantity}',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontFamily: 'RobotoM',
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (item.quantity! >= item.instack!) {
                                  showSnackBar(context,
                                      "This quantity is not available!", true);
                                } else {
                                  addItemToReady(item, false);
                                  ischecked = false;
                                  item.quantity = item.quantity! + 1;
                                  EasyDebounce.debounce("increaseQuantity",
                                      Duration(milliseconds: 250), () {
                                    return UpdateQuantities(
                                        item.id!, item.quantity!, false);
                                  });
                                }
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorLight,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                  child: Icon(Icons.add,
                                      color:
                                          Theme.of(context).scaffoldBackgroundColor,
                                      size: 16)),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                            onTap: () {
                              setState(() {
                                Provider.of<SingleItem>(context,listen: false).UnbasketItems(item.id!, context);
                                ischecked=false;
                                addItemToReady(item, ischecked);
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              child: Center(
                                  child: Icon(FontAwesome5.trash,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      size: 16)),
                            ),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
