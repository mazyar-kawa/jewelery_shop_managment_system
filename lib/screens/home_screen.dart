import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jewelery_shop_managmentsystem/model/filter_model.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/model/user_model.dart';
import 'package:jewelery_shop_managmentsystem/screens/search_screen.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_service.dart';
import 'package:jewelery_shop_managmentsystem/service/home_items_service.dart';
import 'package:jewelery_shop_managmentsystem/service/refresh_user.dart';
import 'package:jewelery_shop_managmentsystem/service/search_for_items.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:jewelery_shop_managmentsystem/widgets/card_items.dart';
import 'package:jewelery_shop_managmentsystem/widgets/horizantl_list_view_home_screen.dart';
import 'package:jewelery_shop_managmentsystem/widgets/rounded_search_input.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int _current = 2;
  int _selectedIndex = 0;
  bool isLoading = false;

  TextEditingController searchEditText = TextEditingController();

  PageController _pageControllerMobile = PageController();
  PageController _pageControllerIpad = PageController();

  DateTime now = DateTime.now();
  String? time;
  getTiem() {
    if (now.hour >= 1 && now.hour <= 12) {
      time = AppLocalizations.of(context)!.goodMorning;
    } else if (now.hour >= 12 && now.hour <= 16) {
      time = AppLocalizations.of(context)!.goodAfternoon;
    } else if (now.hour >= 16 && now.hour <= 21) {
      time = AppLocalizations.of(context)!.goodEvening;
    } else if (now.hour >= 21 && now.hour <= 24) {
      time = AppLocalizations.of(context)!.goodNight;
    }
    return time;
  }

  Future? random;
  Future? all;

  @override
  void initState() {
    _pageControllerMobile = PageController(
        initialPage: _current, viewportFraction: 0.95, keepPage: true);
    _pageControllerIpad = PageController(
        initialPage: _current, viewportFraction: 0.7, keepPage: true);
    all = AllItems();
    super.initState();
  }

  AllItems() async {
    await Provider.of<HomeItemsService>(context, listen: false)
        .getAllItemHome();
  }

  randomItem({int id = 0}) async {
    await Provider.of<HomeItemsService>(context, listen: false)
        .getRandomItems(id: _selectedIndex);
  }

  @override
  void dispose() {
    _pageControllerMobile.dispose();
    _pageControllerIpad.dispose();
    searchEditText.dispose();
    super.dispose();
  }

  Refresh() {
    all = AllItems();
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final islogin = Provider.of<Checkuser>(context).islogin;
    late User user;
    if (islogin) {
      user = Provider.of<RefreshUser>(context).currentUser.user!;
    }

    final provider = Provider.of<HomeItemsService>(context);
    final category = provider.categories;
    List<Category> _categories = [
      Category(id: 0, name: 'all'),
    ];

    for (int i = 0; i < category.length; i++) {
      _categories.add(Category(id: category[i].id, name: category[i].name));
    }
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SmartRefresher(
        enablePullDown: true,
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
        child: FutureBuilder(
            future: all,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      child: MediaQuery.of(context).size.width > websize
                          ? null
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTiem(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'RobotoR',
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .primaryColorLight
                                              .withOpacity(0.5)),
                                    ),
                                    islogin
                                        ? Text(
                                            '${user.username}',
                                            style: TextStyle(
                                              fontSize: 26,
                                              fontFamily: 'RobotoB',
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                                islogin
                                    ? Container(
                                        child: CircleAvatar(
                                            radius: 25,
                                            backgroundImage: user
                                                        .profilePicture !=
                                                    null
                                                ? NetworkImage(
                                                    "http://192.168.1.32:8000" +
                                                        user.profilePicture,
                                                  )
                                                : NetworkImage(
                                                    'https://t3.ftcdn.net/jpg/03/39/45/96/360_F_339459697_XAFacNQmwnvJRqe1Fe9VOptPWMUxlZP8.jpg')),
                                      )
                                    : Container()
                              ],
                            ),
                    ),

                    InkWell(
                      onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchScreen()));
                      },
                      child: Container(
                          height: 55,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          decoration: BoxDecoration(
                              color: Theme.of(context).secondaryHeaderColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Theme.of(context).shadowColor,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(12, 26),
                                    blurRadius: 50,
                                    spreadRadius: 0,
                                    color: Colors.grey.withOpacity(.1)),
                              ]),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 15),
                                child: Icon(Icons.search,
                                    color: Theme.of(context).primaryColorLight),
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    '${AppLocalizations.of(context)!.search}...',
                                    style: TextStyle(color: Colors.grey),
                                  )),
                            ],
                          )),
                    ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MediaQuery.of(context).size.width > websize
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.start,
                            children: [
                              
                              Container(
                                height: 35,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _categories.length,
                                  itemBuilder: (context, index) {
                                    return categoryHorizontal(
                                        context,
                                        '${_categories[index].name![0].toUpperCase()}' +
                                            _categories[index]
                                                .name
                                                .toString()
                                                .substring(1),
                                        _categories[index].id);
                                  },
                                ),
                              ),
                            ],
                          )),
                    ),
                    FutureBuilder(
                        future: isLoading == true ? random : all,
                        builder: (context, snapshot) {
                          final products =
                              Provider.of<HomeItemsService>(context)
                                  .randomItems;
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              height: 260,
                              child: PageView.builder(
                                itemCount: products.length,
                                onPageChanged: ((value) {
                                  setState(() {
                                    _current = value;
                                  });
                                }),
                                physics: BouncingScrollPhysics(),
                                controller:
                                    MediaQuery.of(context).size.width > websize
                                        ? _pageControllerIpad
                                        : _pageControllerMobile,
                                itemBuilder: (context, index) =>
                                    ChangeNotifierProvider.value(
                                  value: products[index],
                                  child: AnimatedBuilder(
                                    animation: _pageControllerMobile,
                                    builder: (context, child) {
                                      return AnimatedScale(
                                        curve: Curves.fastOutSlowIn,
                                        scale: _current == index ? 1 : 0.8,
                                        duration: Duration(milliseconds: 500),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: CardItems(
                                            index: index,
                                            isbasket: false,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Lottie.asset(
                                  'assets/images/loader_daimond.json',
                                  width: 200),
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }),

                    HorizantleListView(
                      title: AppLocalizations.of(context)!.neww,
                      provder: provider.latestItems,
                    ),
                    // most sale
                    HorizantleListView(
                      title: AppLocalizations.of(context)!.mostSales,
                      provder: provider.mostSalesItem,
                    ),
                    // most favorite
                    HorizantleListView(
                      title: AppLocalizations.of(context)!.mostFavourite,
                      provder: provider.mostFavourite,
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Lottie.asset('assets/images/loader_daimond.json',
                      width: 200),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }

  categoryHorizontal(BuildContext context, String title, index) {
    return InkWell(
      onTap: () {
        setState(() {
          isLoading = true;
          _selectedIndex = index;
          random = randomItem(id: _selectedIndex);
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        height: 38,
        width: 81,
        decoration: BoxDecoration(
            color: _selectedIndex == index
                ? Theme.of(context).primaryColorLight
                : null,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).primaryColorLight)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: _selectedIndex == index
                  ? Theme.of(context).secondaryHeaderColor
                  : Theme.of(context).primaryColorLight,
              fontFamily: 'RobotoB',
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}


