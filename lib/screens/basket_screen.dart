import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:jewelery_shop_managmentsystem/model/basket_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/theme_change_provider.dart';
import 'package:jewelery_shop_managmentsystem/screens/signin_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/sure_order_screen.dart';
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
  bool onload = true;
  @override
  void initState() {
    items = LoadingAllItem(onload);
    super.initState();
  }

  Future LoadingAllItem(bool isfirst) async {
    if (isfirst) {
      await Provider.of<BasketItemProvider>(context, listen: false)
          .getItemBasket();
    } else {
      await Provider.of<BasketItemProvider>(context, listen: false)
          .pagination();
    }
  }

  void onLoading() async {
    onload = false;
    await Future.delayed(
      Duration(seconds: 2),
      () {
        items = LoadingAllItem(false);
      },
    );
    refreshController.loadComplete();
  }

  void Refresh() async {
    await Future.delayed(
      Duration(seconds: 2),
      () {
        items = LoadingAllItem(true);
      },
    );
    refreshController.refreshCompleted();
  }

  bool ischeckAll = false;

  bool change = false;

  @override
  Widget build(BuildContext context) {
    final basket = Provider.of<BasketItemProvider>(context, listen: false);
    final islogin = Provider.of<Checkuser>(context).islogin;
    return Scaffold(
        floatingActionButton: Consumer<BasketItemProvider>(
          builder: (context, baskets, child) {
            return  baskets.ready.length != 0
                ? Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (contextx) => SureOrderScreen(),
                            ));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        height: 40,
                        width: 80,
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
                      ),
                    ),
                  )
                : Container();
          },
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.basket,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoB',
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          leading: InkWell(
            onTap: (){
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
        body: !islogin
            ? Consumer<ThemeChangeProvider>(
                builder: (context, provider, chile) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Theme.of(context).primaryColorLight.value ==
                              4286436348
                          ? LottieBuilder.asset(
                              'assets/images/unauthorized_blue.json',
                              width: 450,
                            )
                          : LottieBuilder.asset(
                              'assets/images/unauthorized_grey.json',
                              width: 450,
                            ),
                    ),
                    Container(
                        child: Text(
                      'If you want to see your cart please login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 24,
                        fontFamily: 'RobotoB',
                      ),
                    )),
                    InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SignIn()));
                        });
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).shadowColor,
                                blurRadius: 3,
                                offset: Offset(2, 3),
                              )
                            ]),
                        child: Center(
                          child: Text(
                            'LogIn',
                            style: TextStyle(
                              color: Theme.of(context).secondaryHeaderColor,
                              fontFamily: 'RobotoB',
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              })
            : basket.baskets.length != 0
                ?  SmartRefresher(
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
                              child:
                                  Lottie.asset('assets/images/not more.json'),
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
                    onRefresh: Refresh,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              FutureBuilder(
                                future: items,
                                builder: (context, snapshot) {
                                  final item =
                                      Provider.of<BasketItemProvider>(context)
                                          .baskets;
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return item.length != 0
                                        ? Column(children: [
                                            Container(
                                              alignment: Alignment.centerRight,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                              child: Text(
                                                "${basket.countItemReady()} Selected",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                  fontFamily: 'RobotoM',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              indent: 10,
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                              height: 2,
                                            ),
                                            ListView.builder(
                                              itemCount: item.length,
                                              physics: BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, i) {
                                                return ChangeNotifierProvider
                                                    .value(
                                                  value: item[i],
                                                  child: CardItemsMobile(
                                                    index: i,
                                                    isbasket: true,
                                                    issure: false,
                                                  ),
                                                );
                                              },
                                            ),
                                          ])
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                    width:
                                                        MediaQuery.of(context)
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
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      child: Center(
                                        child: Lottie.asset(
                                            'assets/images/loader_daimond.json',
                                            width: 200),
                                      ),
                                    );
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ):
                  Column(
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
                  )
                  
                  );
  }
}
