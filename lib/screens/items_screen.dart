import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/home_items_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/item_provider_org.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:jewelery_shop_managmentsystem/widgets/card_items_mobile.dart';
import 'package:jewelery_shop_managmentsystem/widgets/card_items_web.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ItemsScreen extends StatefulWidget {
  static const routname = "/items";
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen>
    with TickerProviderStateMixin {
  final boredrUser = OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffE9E9E9), width: 2),
    borderRadius: BorderRadius.circular(15),
  );

  RangeValues rangePrice = const RangeValues(100, 6000);
  bool isfilter = false;
  bool istype = true;
  bool isSize = true;
  bool isPrice = true;
  int sizevalue = 4;
  int _selectedTypeIndex = 0;
  bool isloading = true;

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  AnimationController? controller;
  Animation<double>? animation;

  void openFilter() {
    setState(() {
      isfilter = !isfilter;
    });
    if (isfilter) {
      controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: 1000));
      controller!.forward();
      animation = CurvedAnimation(parent: controller!, curve: Curves.easeIn)
        ..addListener(() {
          setState(() {});
        });
    } else {
      controller!.reset();
    }
  }

  int _current = 2;

  PageController _pageController = PageController();
  Future? all;
  @override
  void initState() {
    Provider.of<HomeItemsProvider>(context, listen: false).getAllItemHome();
    Future.delayed(
      Duration.zero,
      () {
        all = AllItems(isloading);
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => all);
    super.initState();
  }

  AllItems(bool first) async {
    final CategoryId = ModalRoute.of(context)!.settings.arguments as int;
    if (first) {
      await Provider.of<ItemProviderORG>(context, listen: false)
          .getItems(CategoryId);
    } else {
      await Provider.of<ItemProviderORG>(context, listen: false).refresh();
    }
  }

  void Loading() async {
    await Future.delayed(
      Duration(seconds: 2),
      () {
        all = AllItems(false);
      },
    );
    refreshController.loadComplete();
  }

  void Refresh() async {
    await Future.delayed(
      Duration(seconds: 2),
      () {
        all = AllItems(true);
      },
    );
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<HomeItemsProvider>(context).categories;
    final provider = Provider.of<ItemProviderORG>(context, listen: false);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                      AppLocalizations.of(context)!.items,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'RobotoB',
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColorLight,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/basket-shopping-solid.svg',
                            width: 25,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        height: 18,
                        width: 18,
                        child: Consumer<BasketItemProvider>(
                            builder: (context, basket, child) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1000),
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            child: Center(
                              child: Text(
                                  basket.countItem() > 9
                                      ? '9+'
                                      : '${basket.countItem()}',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontWeight: FontWeight.bold)),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SmartRefresher(
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
          onRefresh: Refresh,
          onLoading: Loading,
          footer: CustomFooter(builder: (context, mode) {
            Widget body;
            if (provider.next_url == 'No data') {
              body = Lottie.asset('assets/images/no-data.json');
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
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  children: [
                    MediaQuery.of(context).size.width > websize
                        ? Container()
                        : Container(
                            margin: EdgeInsets.only(top: 95),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 25),
                              height: isfilter
                                  ? MediaQuery.of(context).size.height *
                                      animation!.value *
                                      0.45
                                  : MediaQuery.of(context).size.height * 0.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xffECF1F4),
                              ),
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Text(
                                            'Categories',
                                            style: TextStyle(
                                              fontFamily: 'RobotoB',
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: istype
                                              ? IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      istype = false;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    size: 28,
                                                  ))
                                              : IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      istype = true;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    size: 18,
                                                  )),
                                        )
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    child: Container(
                                        height: istype
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.085
                                            : 0,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 15),
                                        child: Row(
                                          children: [
                                            categoryHorizontal(
                                                context, 'All', 0),
                                            Container(
                                              height: 35,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: category.length,
                                                itemBuilder: (context, index) {
                                                  return categoryHorizontal(
                                                      context,
                                                      '${category[index].name![0].toUpperCase()}' +
                                                          category[index]
                                                              .name
                                                              .toString()
                                                              .substring(1),
                                                      category[index].id);
                                                },
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Text(
                                            'Size: ${sizevalue}',
                                            style: TextStyle(
                                              fontFamily: 'RobotoB',
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: isSize
                                              ? IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      isSize = false;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    size: 28,
                                                  ))
                                              : IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      isSize = true;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    size: 18,
                                                  )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: isSize
                                        ? MediaQuery.of(context).size.height *
                                            0.075
                                        : 0,
                                    child: isSize
                                        ? Slider(
                                            min: 4.0,
                                            max: 30.0,
                                            label: sizevalue.round().toString(),
                                            divisions: 26,
                                            activeColor: Theme.of(context)
                                                .primaryColorLight,
                                            inactiveColor: Theme.of(context)
                                                .primaryColorLight
                                                .withOpacity(0.3),
                                            value: sizevalue.toDouble(),
                                            onChanged: (double value) {
                                              setState(() {
                                                sizevalue = value.round();
                                              });
                                            })
                                        : null,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Text(
                                            'Price: ${rangePrice.start.toStringAsFixed(1)} to ${rangePrice.end.toStringAsFixed(1)}',
                                            style: TextStyle(
                                              fontFamily: 'RobotoB',
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: isPrice
                                              ? IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      isPrice = false;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    size: 28,
                                                  ))
                                              : IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      isPrice = true;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    size: 18,
                                                  )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: isPrice
                                        ? MediaQuery.of(context).size.height *
                                            0.075
                                        : 0,
                                    child: isPrice
                                        ? RangeSlider(
                                            values: rangePrice,
                                            min: 100,
                                            max: 6000,
                                            activeColor: Theme.of(context)
                                                .primaryColorLight,
                                            inactiveColor: Theme.of(context)
                                                .primaryColorLight
                                                .withOpacity(0.3),
                                            labels: RangeLabels(
                                              rangePrice.start
                                                  .toStringAsFixed(2),
                                              rangePrice.end.toStringAsFixed(2),
                                            ),
                                            onChanged: (RangeValues values) {
                                              setState(() {
                                                rangePrice = values;
                                              });
                                            },
                                          )
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: MediaQuery.of(context).size.width > websize
                            ? MediaQuery.of(context).size.width / 3
                            : double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            border: boredrUser,
                            enabledBorder: boredrUser,
                            disabledBorder: boredrUser,
                            hintText:
                                '${AppLocalizations.of(context)!.search}...',
                            hintStyle: TextStyle(
                                fontFamily: 'RobotoR', color: Colors.grey),
                            prefixIcon: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: SvgPicture.asset(
                                'assets/images/search.svg',
                                width: 5,
                                height: 5,
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                            suffixIcon: MediaQuery.of(context).size.width >
                                    websize
                                ? Container()
                                : Container(
                                    padding: EdgeInsets.symmetric(vertical: 13),
                                    child: InkWell(
                                      onTap: openFilter,
                                      child: SvgPicture.asset(
                                        'assets/images/sliders-solid.svg',
                                        width: 2,
                                        height: 2,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                MediaQuery.of(context).size.width > websize
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: MediaQuery.of(context).size.width * 0.18,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorLight,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).shadowColor,
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                  )
                                ]),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text('Price:',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        fontSize: 16,
                                        fontFamily: 'RobotoB',
                                      )),
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          children: [
                                            Checkbox(
                                                value: false,
                                                onChanged: (value) {}),
                                            Text('10-100\$',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                ))
                                          ],
                                        ),
                                      );
                                    }),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text('Categories:',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        fontSize: 16,
                                        fontFamily: 'RobotoB',
                                      )),
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          children: [
                                            Checkbox(
                                                value: false,
                                                onChanged: (value) {}),
                                            Text('All',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                ))
                                          ],
                                        ),
                                      );
                                    }),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text('Size:',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        fontSize: 16,
                                        fontFamily: 'RobotoB',
                                      )),
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          children: [
                                            Checkbox(
                                                value: false,
                                                onChanged: (value) {}),
                                            Text('10',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                ))
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.82,
                            height: MediaQuery.of(context).size.height,
                            child: FutureBuilder(
                                future: all,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    final product =
                                        Provider.of<ItemProviderORG>(context)
                                            .items;
                                    return GridView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemCount: product.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 0.9,
                                          crossAxisSpacing: 6,
                                          mainAxisSpacing: 10,
                                        ),
                                        itemBuilder: (context, i) {
                                          return ChangeNotifierProvider.value(
                                            value: product[i],
                                            child: CardItemsWeb(index: i),
                                          );
                                        });
                                  } else {
                                    return Center(
                                      child: Lottie.asset(
                                          'assets/images/loader_daimond.json',
                                          width: 200),
                                    );
                                  }
                                }),
                          ),
                        ],
                      )
                    : FutureBuilder(
                        future: all,
                        builder: (context, snapshot) {
                          final product =
                              Provider.of<ItemProviderORG>(context).items;
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ListView.builder(
                                itemCount: product.length,
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, i) {
                                  return ChangeNotifierProvider.value(
                                    value: product[i],
                                    child: CardItemsMobile(index: i),
                                  );
                                });
                          } else {
                            return Center(
                              child: Lottie.asset(
                                  'assets/images/loader_daimond.json',
                                  width: 200),
                            );
                          }
                        })
              ],
            ),
          ),
        ));
  }

  categoryHorizontal(BuildContext context, String title, index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTypeIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        height: 38,
        width: 81,
        decoration: BoxDecoration(
            color: _selectedTypeIndex == index
                ? Theme.of(context).primaryColorLight
                : null,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).primaryColorLight)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: _selectedTypeIndex == index
                  ? Colors.white
                  : Theme.of(context).primaryColorLight,
              fontFamily: 'RobotoB',
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
