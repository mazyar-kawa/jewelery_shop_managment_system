import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:jewelery_shop_managmentsystem/model/basket_model.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/order.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:provider/provider.dart';

class BasketCardItem extends StatefulWidget {
  const BasketCardItem({super.key});

  @override
  State<BasketCardItem> createState() => _BasketCardItemState();
}

class _BasketCardItemState extends State<BasketCardItem> {

   UpdateQuantities(int item_id, int quantity,bool decrease) async {
    ApiProvider response = await Provider.of<Order>(context, listen: false)
        .UpdateQuantity(item_id, quantity);
    if(response.data!=null){
      showSnackBar(context, response.data['message'], decrease);
    }else{
      showSnackBar(context, response.error!['errors']['quantity'], true);
    }
  }
  
  addItemToReady(ItemBasket item, bool ischecked) async {
    if (ischecked) {
      await Provider.of<BasketItemProvider>(context, listen: false)
          .addItemReady(item);
    } else {
      await Provider.of<BasketItemProvider>(context, listen: false)
          .removeItemReady(item);
    }
  }

  bool ischecked = false;
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<ItemBasket>(context,listen: false);
    return Slidable(
      endActionPane:
          ActionPane(extentRatio: 1 / 5, motion: ScrollMotion(), children: [
        Consumer<SingleItem>(
          builder: (context, value, child) {
          return InkWell(
            onTap: (){
             value.UnbasketItems(item.id!, context);
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xffFED4D5),
              ),
              child: Center(
                child: Icon(FontAwesome5.trash, color: Color(0xffFA515C)),
              ),
            ),
          );
          },
        ),
      ]),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 2,
              spreadRadius: 2
            )
          ]
        ),
        child: Row(
          children: [
            Checkbox(
              checkColor: Theme.of(context).scaffoldBackgroundColor,
              fillColor: MaterialStateProperty.all(
                  Theme.of(context).primaryColorLight),
              value: ischecked,
              onChanged: (bool? value) {
                setState(() {
                  ischecked = value!;
                  addItemToReady(item, ischecked);
                });
              },
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: AspectRatio(
                aspectRatio: 0.2,
                child: Image.network(item.img!),
              ),
            ),
            Container(
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(
                                right: 25, left: 5, top: 5, bottom: 5),
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
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Icon(Icons.close,
                                  size: 16,
                                  color: Theme.of(context).primaryColorLight),
                              Text(
                                '${item.quantity}',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontFamily: 'RobotoB',
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          right: 25, left: 5, top: 2, bottom: 2),
                      child: Text(
                        item.countryName!,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontFamily: 'RobotoM',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          right: 25, left: 5, top: 2, bottom: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(FontAwesome5.balance_scale,
                                    color: Theme.of(context).primaryColorLight,
                                    size: 14),
                                Text(
                                  ' ${item.weight}g',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontFamily: 'RobotoM',
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      if(item.quantity! == 1){
                                          showSnackBar(context, "Quantity must be greater than 0", true);
                                      }else{
                                      item.quantity=item.quantity!-1;
                                      EasyDebounce.debounce("decreaseQuantity", Duration(milliseconds: 250), () {
                                       return UpdateQuantities(item.id!,item.quantity!,true);
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
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
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
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontFamily: 'RobotoM',
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      item.quantity=item.quantity!+1;
                                      EasyDebounce.debounce("increaseQuantity", Duration(milliseconds: 250), () {
                                        return UpdateQuantities(item.id!,item.quantity!,false);
                                       });
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
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            size: 16)),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
