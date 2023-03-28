import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:jewelery_shop_managmentsystem/screens/item_details.dart';
import 'package:jewelery_shop_managmentsystem/service/order.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderDetails extends StatefulWidget {
  final int idOrder;
  const OrderDetails({super.key, required this.idOrder});
  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Future? loadData;

  @override
  void initState() {
    loadData = fetchData();
    super.initState();
  }

  fetchData() async {
    await Provider.of<OrderService>(context, listen: false)
        .orderDetails(widget.idOrder);
  }

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderService>(context).orderdetails;
    final items = Provider.of<OrderService>(context).items;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'Order Details',
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
            child: RotatedBox(
              quarterTurns: 90,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: loadData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "#${order.id}",
                            style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontFamily: 'RobotoB',
                              fontSize: 22,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.status}: ",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontFamily: 'RobotoB',
                                  fontSize: 22,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: order.status == 'requested'
                                      ? Color(0xffFEF3C7)
                                      : order.status == 'accepted'
                                          ? Color(0xffDBEAFE)
                                          : order.status == 'completed'
                                              ? Color(0xffDCFCE7)
                                              : order.status == 'rejected'
                                                  ? Color(0xffFEE2E2)
                                                  : Color(0xffFAE8FF),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "${order.status![0].toUpperCase()+order.status.toString().substring(1)}",
                                  // "${order.status}",
                                  style: TextStyle(
                                    color: order.status == 'requested'
                                        ? Color(0xffFE9E0B)
                                        : order.status == 'accepted'
                                            ? Color(0xff0078F6)
                                            : order.status == 'completed'
                                                ? Color(0xff22C55E)
                                                : order.status == 'rejected'
                                                    ? Color(0xffEF4444)
                                                    : Color(0xffD946EF),
                                    fontFamily: 'RobotoB',
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${AppLocalizations.of(context)!.total}:  \$${order.total!.round()}",
                            style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontFamily: 'RobotoB',
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Directionality(
                            textDirection: TextDirection.ltr,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ItemDetails(
                                        item_id: items[index].id!,
                                      ),
                                    ));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                height: 150,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColorLight
                                      .withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).primaryColorDark,
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 2,
                                              offset: Offset(2, 0),
                                            )
                                          ],
                                          border: Border.all(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                          )),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            AspectRatio(
                                                aspectRatio: 1.8,
                                                child: Image.network(
                                                    items[index].img!,
                                                    fit: BoxFit.contain)),
                                            Container(
                                              margin: const EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              padding: const EdgeInsets.all(5),
                                              height: 28,
                                              decoration: BoxDecoration(
                                                color: items[index].caratType ==
                                                        'gold'
                                                    ? Color(0xffFFD700)
                                                        .withOpacity(0.1)
                                                    : Color(0xffC0C0C0)
                                                        .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '${items[index].caratType!} ${items[index].caratMs!}',
                                                  style: TextStyle(
                                                    color:
                                                        items[index].caratType ==
                                                                'gold'
                                                            ? Color(0xffFFD700)
                                                            : Color(0xFFA3A3A3),
                                                    fontFamily: 'RobotoM',
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.55,
                                      margin: EdgeInsets.only(
                                          top: 10, bottom: 10, left: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        right: 13.0),
                                                    child: Text(
                                                      items[index].name!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColorLight,
                                                        fontFamily: 'RobotoB',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      '${order.orderItems![index].quantity}X',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColorLight,
                                                        fontFamily: 'RobotoM',
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: Text(
                                                  items[index].countryName!,
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColorLight,
                                                    fontFamily: 'RobotoB',
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: Row(children: [
                                                    Icon(
                                                        FontAwesome5
                                                            .balance_scale,
                                                        color: Theme.of(context)
                                                            .primaryColorLight,
                                                        size: 15),
                                                    Text(
                                                      '  ${items[index].weight!}g',
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColorLight,
                                                        fontFamily: 'RobotoM',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ])),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  '${AppLocalizations.of(context)!.singlePrice}: \$${order.orderItems![index].priceSingle.round()}',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColorLight,
                                                    fontFamily: 'RobotoB',
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  '${AppLocalizations.of(context)!.totalPrice}: \$${order.orderItems![index].priceTotal.round()}',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColorLight,
                                                    fontFamily: 'RobotoB',
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: Lottie.asset('assets/images/loader_daimond.json',
                    width: 200),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}


/*

ListView.builder(
                  itemCount: 20,
                    itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 150,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                              
                          ],
                        ),
                      );
                    },

                ),


FutureBuilder(
                    builder: (context, snapshot) {
                      if(snapshot.connectionState==ConnectionState.done){
                        return Container(
                          height: 80,
                          color: Colors.red,
                          width: 200,
                        );
                      }else if(snapshot.connectionState==ConnectionState.waiting){
                        return Container(
              child: Center(
                child: Lottie.asset('assets/images/loader_daimond.json',
                    width: 200),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
                    },
                  )

*/