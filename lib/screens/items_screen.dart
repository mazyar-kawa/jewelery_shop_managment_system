import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/home_items_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/item_provider_org.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:jewelery_shop_managmentsystem/widgets/items_filter.dart';
import 'package:jewelery_shop_managmentsystem/widgets/mobile_item_responsive.dart';
import 'package:jewelery_shop_managmentsystem/widgets/web_item_responsive.dart';
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
  double start_size = 0.0;
  double end_size = 0.0;

  double start_carat = 0.0;
  double end_carat = 0.0;
  RangeValues rangeCarat = RangeValues(12, 24);
  RangeValues rangeSize = RangeValues(7, 32);
  bool active_filter = false;
  int _selectedTypeIndex = 0;
  bool isloading = true;
  bool issearch = false;
  int _current = 2;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  TextEditingController searchController = TextEditingController();

  bool islogin = false;

  Future isLogin() async {
    String token = await Auth().getToken();
    if (token != "") {
      islogin = true;
    } else {
      islogin = false;
    }
  }

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
    isLogin();
    WidgetsBinding.instance.addPostFrameCallback((_) => all);
    super.initState();
  }

  AllItems(bool first,
      {String search = '',
      double size_start = 0,
      double size_end = 0,
      double mount_start = 0,
      double mount_end = 0}) async {
    final CategoryId = ModalRoute.of(context)!.settings.arguments as int;

    if (first) {
      await Provider.of<ItemProviderORG>(context, listen: false).getItems(
        CategoryId,
        search: search,
        size_start: size_start,
        size_end: size_end,
        mount_start: mount_start,
        mount_end: mount_end,
      );
    } else {
      await Provider.of<ItemProviderORG>(context, listen: false).refresh(
        search: search,
        size_start: size_start,
        size_end: size_end,
        mount_start: mount_start,
        mount_end: mount_end,
      );
    }
  }

  void Loading() async {
    await Future.delayed(
      Duration(seconds: 2),
      () {
        all = AllItems(
          false,
          search: searchController.text,
          size_start: 0,
          size_end: 0,
          mount_start: 0,
          mount_end: 0,
        );
      },
    );
    refreshController.loadComplete();
  }

  void Refresh() async {
    await Future.delayed(
      Duration(seconds: 2),
      () {
        all = AllItems(true);
        searchController.text = '';
      },
    );
    refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
                              color: Theme.of(context).scaffoldBackgroundColor),
                          child: Center(
                            child: Text(
                                basket.countItem() > 9
                                    ? '9+'
                                    : '${basket.countItem()}',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  MediaQuery.of(context).size.width > websize
                      ? Container()
                      : Container(),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width > websize
                          ? MediaQuery.of(context).size.width / 3
                          : double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          value = searchController.text;

                          setState(() {
                            issearch = true;
                          });
                          EasyDebounce.debounce(
                              "Search", Duration(milliseconds: 500), () async {
                            await AllItems(true,
                                search: value,
                                size_start: rangeSize.start,
                                size_end: rangeSize.end,
                                mount_start: rangeCarat.start,
                                mount_end: rangeCarat.end);
                            setState(() {
                              issearch = false;
                            });
                          });
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            border: boredruser,
                            enabledBorder: boredruser,
                            disabledBorder: boredruser,
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
                            suffixIcon:
                                MediaQuery.of(context).size.width > websize
                                    ? Container()
                                    : MyWidget(
                                        categories: category,
                                        active_filter: active_filter,
                                        searchController: searchController,
                                        AllItems: AllItems,
                                        start_size: start_size,
                                        end_size: end_size,
                                        start_carat: start_carat,
                                        end_carat: end_carat,
                                        rangeSize: rangeSize,
                                        rangeCarat: rangeCarat,
                                        onChanged: (value) {
                                          setState(() {
                                            active_filter=value;
                                          });
                                        },
                                      )),
                      ),
                    ),
                  ),
                ],
              ),
              issearch == false && active_filter == false
                  ? MediaQuery.of(context).size.width > websize
                      ? ItemWebResponsive(
                          all: all,
                          islogin: islogin,
                        )
                      : ItemMobileResponsive(
                          all: all,
                          searchController: searchController,
                          islogin: islogin,
                        )
                  : Container(
                      width: 300,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(),
                          Container(
                            child: Lottie.asset(
                                'assets/images/loader_daimond.json',
                                width: 200),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}