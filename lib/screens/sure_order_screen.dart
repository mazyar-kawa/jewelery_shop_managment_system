import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/basket_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:jewelery_shop_managmentsystem/widgets/card_items_mobile.dart';
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
      loadItem=Provider.of<BasketItemProvider>(context,listen: false).getReadyItem();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController
      ..addStatusListener((status) {
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
    final item = Provider.of<BasketItemProvider>(context,listen: false);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: Container(
            padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: MediaQuery.of(context).size.width > websize ? 10 : 35),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      item.clearItemChecked();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Theme.of(context).primaryColorLight,
                    )),
                Text(
                  "Sure Order",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoB',
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: FutureBuilder(
          future: loadItem,
          builder: (context, snapshot) {
             final items =
                          Provider.of<BasketItemProvider>(context).ready;
            if(snapshot.connectionState==ConnectionState.done){
              return items.length!=0? Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: ListView.builder(
                      itemCount: items.length,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return ChangeNotifierProvider.value(
                          value: items[i],
                          child: CardItemsMobile(
                            index: i,
                            islogin: true,
                            isbasket: true,
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Column(
                        children: [
                          Divider(
                            color: Theme.of(context).primaryColorLight,
                          ),
                          // CountEveryThing(
                          //   item: item,
                          //   title: "Profit:",
                          //   fuction: item.countProfite(),
                          // ),
                          // Divider(
                          //   color: Theme.of(context).primaryColorLight,
                          // ),
                          // CountEveryThing(
                          //   item: item,
                          //   title: "Total:",
                          //   fuction: item.totalBeforOrder(),
                          // ),
                          InkWell(
                            onTap: () {
                              showdialog(context);
                              setState(() {
                                items.clear();
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              height:
                                  MediaQuery.of(context).size.height * 0.050,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorLight,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                  child: Text(
                                "Order",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'RobotoB',
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Center(
                        child: Text(
                      "Ops! it is Empty",
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
                        width: MediaQuery.of(context).size.width > websize
                            ? 650
                            : 350,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              );
            }else{
              return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Lottie.asset(
                                  'assets/images/loader_daimond.json',
                                  width: 200),
                            ),
                          ],
                        );
            }
          },
        ),
            );
  }
}

class CountEveryThing extends StatelessWidget {
  const CountEveryThing(
      {Key? key,
      required this.item,
      required this.title,
      required this.fuction})
      : super(key: key);

  final BasketItemProvider item;
  final String title;
  final dynamic fuction;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: 18,
                  fontFamily: 'RobotoB')),
          Text('${fuction}',
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: 16,
                  fontFamily: 'RobotoB'))
        ],
      ),
    );
  }
}
/*



*/