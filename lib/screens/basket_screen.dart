import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/basket_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:jewelery_shop_managmentsystem/widgets/card_items_mobile.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Future? items;
  @override
  void initState() {
    items = onLoading();
    isLogin();
    super.initState();
  }

  onLoading()  async{
    await Provider.of<BasketItemProvider>(context, listen: false)
        .getItemBasket();
  }

  bool ischeckAll = false;
  bool islogin = false;

  Future isLogin() async {
    String token = await Auth().getToken();
    if (token != "") {
      islogin = true;
    } else {
      islogin = false;
    }
  }

  
  

  @override
  Widget build(BuildContext context) {
    final basket = Provider.of<BasketItemProvider>(context, listen: false);
     final item = Provider.of<BasketItemProvider>(context).baskets;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:item.length != 0
            ? InkWell(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$990",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontFamily: 'RobotoM',
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColorLight,
                        ),
                        child: Center(
                          child: Text(
                            "Next",
                            style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontFamily: 'RobotoM',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : null,
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
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Theme.of(context).primaryColorLight,
                    )),
                Text(
                  AppLocalizations.of(context)!.basket,
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
        body: item.length == 0 ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Center(
                        child: Text(
                      AppLocalizations.of(context)!.yourBasketisempty,
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
              ):
             SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                controller: refreshController,
                header: CustomHeader(
                  builder: (context, mode) {
                    Widget body;
                    if (mode == LoadStatus.loading) {
                      body = Lottie.asset('assets/images/refresh.json');
                    } else {
                      body = Lottie.asset('assets/images/refresh.json');
                    }
                    return Container(
                      height: 75,
                      child: Center(child: body),
                    );
                  },
                ),
                footer: CustomFooter(builder: (context, mode) {
                  Widget body;
                  if (basket.next_url == 'No data') {
                    body = Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Lottie.asset('assets/images/not more.json'),
                        ),
                        Container(
                          child: Text(
                            'There\'s no more Item.',
                            style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    );
                  } else if (mode == LoadStatus.loading) {
                    body = Lottie.asset('assets/images/preloader.json');
                  } else {
                    body = Lottie.asset('assets/images/preloader.json');
                  }

                  return Container(
                    padding: EdgeInsets.only(bottom: 10),
                    height: 75.0,
                    child: Center(child: body),
                  );
                }),
                onLoading: onLoading,
                onRefresh: onLoading,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      item.length != 0
                          ? Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                            checkColor: Colors.white,
                                            fillColor: MaterialStateProperty.all(
                                                Theme.of(context).primaryColorLight),
                                            value: ischeckAll,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                ischeckAll = value!;
                                              });
                                            },
                                          ),
                                          Text(
                                            "All",
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).primaryColorLight,
                                              fontFamily: 'RobotoM',
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                            "${basket.countItemReady()} Selected",
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).primaryColorLight,
                                              fontFamily: 'RobotoM',
                                              fontSize: 16,
                                            ),
                                          ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  indent: 10,
                                  color: Theme.of(context).primaryColorLight,
                                  height: 2,
                                ),
                              ],
                            )
                          : Container(),
                      FutureBuilder(
                        future: items,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return 
                            item.length != 0 ? 
                            ListView.builder(
                                    itemCount: item.length,
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, i) {
                                      return ChangeNotifierProvider.value(
                                        value: item[i],
                                        child: CardItemsMobile(index: i, islogin: islogin, isbasket: true,),
                                      );
                                    },
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Center(
                                            child: Text(
                                          AppLocalizations.of(context)!
                                              .yourBasketisempty,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontFamily: 'RobotoB',
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                          ),
                                        )),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Lottie.asset(
                                            'assets/images/empty-box.json',
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width >
                                                    websize
                                                ? 650
                                                : 350,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                          } else {
                            return Container(
                              child: Lottie.asset(
                                  'assets/images/loader_daimond.json',
                                  width: 200),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              )
           );
  }
}
