import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:jewelery_shop_managmentsystem/model/basket_model.dart';
import 'package:jewelery_shop_managmentsystem/screens/item_details.dart';
import 'package:jewelery_shop_managmentsystem/service/Basket_item_service.dart';
import 'package:provider/provider.dart';

class SureItemsCard extends StatefulWidget {
  const SureItemsCard({super.key});

  @override
  State<SureItemsCard> createState() => _SureItemsCardState();
}

class _SureItemsCardState extends State<SureItemsCard> {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<ItemBasket>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemDetails(item_id: item.id!,ishiddin: true),
              ));
        },
        child: Slidable(
          endActionPane:
              ActionPane(extentRatio: 1 / 5, motion: ScrollMotion(), children: [
            Consumer<BasketItemService>(
              builder: (context, basket, child) {
                return InkWell(
                  onTap: () {
                    basket.removeItemReady(item);
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
            )
          ]),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            height: MediaQuery.of(context).size.height * 0.12,
            decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                 borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 3,
                  ),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      AspectRatio(
                          aspectRatio: 1.2,
                          child: Image.network(item.img!, fit: BoxFit.contain)),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  item.name!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontFamily: 'RobotoB',
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
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
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                '\$${item.price!.round()}',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontFamily: 'RobotoB',
                                  fontSize: 14,
                                ),
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
        ),
      ),
    );
  }
}
