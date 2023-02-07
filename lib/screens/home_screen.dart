import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/model/filter_model.dart';
import 'package:jewelery_shop_managmentsystem/model/user_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/home_items_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/refresh_user.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:jewelery_shop_managmentsystem/widgets/card_items_mobile.dart';
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

  final RefreshController refreshController = RefreshController(initialRefresh: false);
  int _current = 2;
  int _selectedIndex = 0;
  bool laoding = false;
  final TextEditingController _searchEditText = TextEditingController();

  PageController _pageControllerMobile = PageController();
  PageController _pageControllerWeb = PageController();

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

  bool islogin = false;
  late AuthUser user;
  Future isLogin() async {
    String token = await Auth().getToken();
    if (token != '') {
      islogin = true;
      user = Provider.of<RefreshUser>(context, listen: false).currentUser;
    } else {
      islogin = false;
    }
  }

  Future? random;
  Future? all;

  @override
  void initState() {
    _pageControllerMobile = PageController(
        initialPage: _current, viewportFraction: 0.95, keepPage: true);
    _pageControllerWeb = PageController(
        initialPage: _current, viewportFraction: 0.5, keepPage: true);
    isLogin();
    all = AllItems();
    super.initState();
  }

  AllItems() async {
    await Provider.of<HomeItemsProvider>(context, listen: false)
        .getAllItemHome();
  }

  randomItem({int id = 0}) async {
    if (id != 0) {
      await Provider.of<HomeItemsProvider>(context, listen: false)
          .getRandomItems(id: _selectedIndex);
    } else {
      await Provider.of<HomeItemsProvider>(context, listen: false)
          .getRandomItems();
    }
    _current = 2;
  }

  @override
  void dispose() {
    _pageControllerMobile.dispose();
    _pageControllerWeb.dispose();
    _searchEditText.dispose();
    super.dispose();
  }

  Refresh(){
  all=  AllItems();
  refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final provider = Provider.of<HomeItemsProvider>(context);
    final category = provider.categories;
    List<Category> _categories = [
      Category(id: 0, name: 'all'),
    ];

    for (int i = 0; i < category.length; i++) {
      _categories.add(Category(id: category[i].id, name: category[i].name));
    }
    return Scaffold(
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
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
                                          color: Colors.grey),
                                    ),
                                    islogin
                                        ? Text(
                                            '${user.user!.username}',
                                            style: TextStyle(
                                              fontSize: 26,
                                              fontFamily: 'RobotoB',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                                islogin
                                    ? Container(
                                        child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: user
                                                        .user!.profilePicture !=
                                                    null
                                                ? NetworkImage(
                                                    user.user!.profilePicture,
                                                  )
                                                : NetworkImage(
                                                    'https://t3.ftcdn.net/jpg/03/39/45/96/360_F_339459697_XAFacNQmwnvJRqe1Fe9VOptPWMUxlZP8.jpg')),
                                      )
                                    : Container()
                              ],
                            ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width > websize
                              ? 150
                              : 25,
                          vertical: 20),
                      child: SearchInput(
                        hintText: '${AppLocalizations.of(context)!.search}...',
                        textController: _searchEditText,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal:
                                  MediaQuery.of(context).size.width > websize
                                      ? 200
                                      : 0),
                          child: Row(
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
                        future: laoding == true ? random : all,
                        builder: (context, snapshot) {
                          final products = Provider.of<HomeItemsProvider>(context).randomItems;
                          if (snapshot.connectionState == ConnectionState.done) {
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
                                        ? _pageControllerWeb
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
                                          padding:
                                              EdgeInsets.symmetric(vertical: 15),
                                          child: CardItemsMobile(
                                            index: index,
                                            islogin: islogin,
                                            isbasket: false,
                                            issure: false,
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
                        islogin: islogin),
                    // most sale
                    HorizantleListView(
                        title: AppLocalizations.of(context)!.mostSales,
                        provder: provider.randomItems,
                        islogin: islogin),
                    // most favorite
                    HorizantleListView(
                        title: AppLocalizations.of(context)!.mostFavourite,
                        provder: provider.mostFavourite,
                        islogin: islogin),
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
          _selectedIndex = index;
          random = randomItem(id: _selectedIndex);
          laoding = true;
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
