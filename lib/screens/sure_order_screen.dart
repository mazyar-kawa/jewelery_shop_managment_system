import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/basket_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/home_items_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/order.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:jewelery_shop_managmentsystem/widgets/sure_items_card.dart';
import 'package:jewelery_shop_managmentsystem/widgets/dashed_separator.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SureOrderScreen extends StatefulWidget {
  const SureOrderScreen({super.key});

  @override
  State<SureOrderScreen> createState() => _SureOrderScreenState();
}

class _SureOrderScreenState extends State<SureOrderScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  bool orederd = false;

  void showBill(BuildContext context, List<ItemBasket> items) => showDialog(
        context: context,
        builder: (context) {
          List<int> basketId = [];
          for (int i = 0; i < items.length; i++) {
            basketId.add(items[i].basketId!);
          }
          return Dialog(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          alignment: Alignment.topRight,
                          child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Check Out",
                            style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontFamily: 'RobotoB',
                              fontSize: 18,
                            ),
                          ),
                        ),
                        ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${index + 1}. ${items[index].name}',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontFamily: 'RobotoM',
                                          fontSize: 14,
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.close,
                                              size: 14,
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                            ),
                                            Text(
                                              '${items[index].quantity}',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontFamily: 'RobotoM',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "\$${items[index].price!.round()}",
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontFamily: 'RobotoM',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Consumer<BasketItemProvider>(
                      builder: (context, basket, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "Total: \$${basket.TotalPrice()}",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontFamily: 'RobotoB',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                ApiProvider response = await Provider.of<Order>(
                                        context,
                                        listen: false)
                                    .Orders(basketId);
                                if (response.error == null) {
                                  if (response.data!['message'] != 'New Order Added') {
                                    for (int i = 0;i < response.data!['errors'].length; i++) {
                                      showSnackBar( context, response.data!['errors']['basket.${i}'], true);
                                    }
                                  } else {
                                    await Provider.of<HomeItemsProvider>(
                                            context,
                                            listen: false)
                                        .getAllItemHome();
                                    await Provider.of<BasketItemProvider>(
                                            context,
                                            listen: false)
                                        .getItemBasket();
                                    Navigator.pop(context);
                                    showdialog(context);
                                    setState(() {
                                      basket.clearItemChecked();
                                      orederd = true;
                                    });
                                  }
                                }
                              },
                              child: Container(
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                    child: Text(
                                  "Buy Now",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    fontFamily: "RobotoB",
                                    fontSize: 18,
                                  ),
                                )),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );

  void showdialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: LottieBuilder.asset(
              'assets/images/Complete Order.json',
              controller: animationController,
              onLoaded: (complet) {
                animationController.forward();
              },
              width: MediaQuery.of(context).size.width > websize ? 200 : 800,
              fit: BoxFit.cover,
            ),
          );
        },
      );

  Future? loadItem;

  @override
  void initState() {
    loadItem = Provider.of<BasketItemProvider>(context, listen: false).getReadyItem();

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pop(context);
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<BasketItemProvider>(context, listen: false).ready;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            "Check out",
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
          future: loadItem,
          builder: (context, snapshot) {
            final items = Provider.of<BasketItemProvider>(context).ready;
            if (snapshot.connectionState == ConnectionState.done) {
              return items.length != 0
                  ? Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Your Order",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'RobotoB',
                              color: Theme.of(context).primaryColorLight,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Container(
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: items.length,
                                  itemBuilder: (context, index) {
                                    return ChangeNotifierProvider.value(
                                      value: items[index],
                                      child: SureItemsCard(),
                                    );
                                  },
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Consumer<BasketItemProvider>(
                              builder: (context, basket, child) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    children: [
                                      MySeparator(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Text(
                                                'Total: ',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColorLight
                                                      .withOpacity(0.3),
                                                  fontFamily: 'RobotoB',
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                '\$${basket.TotalPrice()}',
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
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showBill(context, items);
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          margin:
                                              EdgeInsets.symmetric(vertical: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Checkout",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                fontFamily: 'RobotoB',
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            )),
                      ],
                    )
                  : !orederd
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Center(
                                  child: Text(
                                "Ops! it is empty",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'RobotoB',
                                  color: Theme.of(context).primaryColorLight,
                                ),
                              )),
                            ),
                            Container(
                              child: Center(
                                child: Lottie.asset(
                                  'assets/images/empty-box.json',
                                  width: MediaQuery.of(context).size.width >
                                          websize
                                      ? 650
                                      : 350,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Center(
                                  child: Text(
                                "Thank\'s for your order, Please check your orders",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'RobotoB',
                                  color: Theme.of(context).primaryColorLight,
                                ),
                              )),
                            ),
                            Container(
                              child: Center(
                                child: Lottie.asset(
                                  'assets/images/order_complete.json',
                                  width: MediaQuery.of(context).size.width >
                                          websize
                                      ? 650
                                      : 350,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
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
        ));
  }
}
