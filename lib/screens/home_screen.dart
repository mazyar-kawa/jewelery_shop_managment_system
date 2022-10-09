import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/model/user_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/home_items_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/refresh_user.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:jewelery_shop_managmentsystem/widgets/horizantl_list_view_home_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/home_card_category.dart';

class HomeScreen extends StatefulWidget {
  final bool islogin;
  const HomeScreen({Key? key, required this.islogin}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 2;
  int _selectedIndex = 0;
  bool laoding = false;

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

  Future? random;
  Future? all;

  @override
  void initState() {
    _pageControllerMobile = PageController(
        initialPage: _current, viewportFraction: 0.81, keepPage: true);
    _pageControllerWeb = PageController(
        initialPage: _current, viewportFraction: 0.5, keepPage: true);

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<HomeItemsProvider>(context).categories;
    late AuthUser user;
    if (widget.islogin) {
      user = Provider.of<RefreshUser>(context).currentUser;
    }

    final boredrUser = OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffE9E9E9), width: 2),
      borderRadius: BorderRadius.circular(15),
    );
    return Scaffold(
      body: FutureBuilder(
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
                                  widget.islogin
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
                              widget.islogin
                                  ? Container(
                                      child: CircleAvatar(
                                          radius: 25,
                                          backgroundImage: user
                                                      .user!.profilePicture !=
                                                  null
                                              ? NetworkImage(
                                                  user.user!.profilePicture)
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
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                          )),
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
                                    ? 150
                                    : 0),
                        child: Row(
                          children: [
                            categoryHorizontal(context, 'All', 0),
                            Container(
                              height: 35,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
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
                  FutureBuilder(
                      future: laoding == true ? random : all,
                      builder: (context, snapshot) {
                        final products =
                            Provider.of<HomeItemsProvider>(context).randomItems;
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            height: 260,
                            child: MediaQuery.of(context).size.width > websize
                                ? PageView.builder(
                                    itemCount: products.length,
                                    onPageChanged: ((value) {
                                      setState(() {
                                        _current = value;
                                      });
                                    }),
                                    physics: BouncingScrollPhysics(),
                                    controller: _pageControllerWeb,
                                    itemBuilder: (context, index) =>
                                        ChangeNotifierProvider.value(
                                      value: products[index],
                                      child: HomeCardCategory(
                                        pageController: _pageControllerWeb,
                                        current: _current,
                                        index: index,
                                        login: widget.islogin,
                                      ),
                                    ),
                                  )
                                : PageView.builder(
                                    itemCount: products.length,
                                    onPageChanged: ((value) {
                                      setState(() {
                                        _current = value;
                                      });
                                    }),
                                    physics: BouncingScrollPhysics(),
                                    controller: _pageControllerMobile,
                                    itemBuilder: (context, index) =>
                                        ChangeNotifierProvider.value(
                                      value: products[index],
                                      child: HomeCardCategory(
                                        pageController: _pageControllerMobile,
                                        current: _current,
                                        index: index,
                                        login: widget.islogin,
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
                      provder:
                          Provider.of<HomeItemsProvider>(context).latestItems,
                      islogin: widget.islogin),
                  // most sale
                  HorizantleListView(
                      title: AppLocalizations.of(context)!.mostSales,
                      provder:
                          Provider.of<HomeItemsProvider>(context).randomItems,
                      islogin: widget.islogin),
                  // most favorite
                  HorizantleListView(
                      title: AppLocalizations.of(context)!.mostFavourite,
                      provder:
                          Provider.of<HomeItemsProvider>(context).mostFavourite,
                      islogin: widget.islogin),
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
}
