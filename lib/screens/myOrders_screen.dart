import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jewelery_shop_managmentsystem/service/order.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  Future? Orders;

  @override
  void initState() {
    Orders = LoadingOrders();
    super.initState();
  }

  LoadingOrders() async {
    await Provider.of<Order>(context, listen: false).getMyOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "My Orders",
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
      body: FutureBuilder(
        future: Orders,
        builder: (context, snapshot) {
          final orders = Provider.of<Order>(context).orders;
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        spreadRadius: 1,
                        blurRadius: 3,
                      )
                    ],
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColorLight
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Lottie.asset('assets/images/orders.json',
                                  width: 60),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'No. ${orders[index].id}',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontFamily: 'RobotoM',
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Total: \$${orders[index].total!.round()}',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontFamily: 'RobotoM',
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "Date Order: " +
                                        DateFormat.yMd()
                                            .format(orders[index].createdAt!),
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontFamily: 'RobotoM',
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: orders[index].status == "Requested"
                            ? SvgPicture.asset(
                                'assets/images/requested.svg',
                                color: Theme.of(context).primaryColorLight,
                                width: 25,
                              )
                            : SvgPicture.asset(
                                'assets/images/check.svg',
                                color: orders[index].status == "Accepted"
                                    ? Theme.of(context).primaryColorLight
                                    : Colors.green,
                                width: 25,
                              ),
                      )
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child:
                  Lottie.asset('assets/images/loader_daimond.json', width: 200),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
