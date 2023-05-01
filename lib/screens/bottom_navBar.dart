import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/model/user_model.dart';
import 'package:jewelery_shop_managmentsystem/screens/basket_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/category_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/home_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/notfication_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/profile_screen.dart';
import 'package:jewelery_shop_managmentsystem/service/Basket_item_service.dart';
import 'package:jewelery_shop_managmentsystem/service/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_service.dart';
import 'package:jewelery_shop_managmentsystem/service/refresh_user.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoadingPage extends StatefulWidget {
  // late bool islogin;
  LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool ismodule = false;
  bool splash = false;
  Widget currentPage = HomeScreen();
  bool islogin = false;

  RefreshUser refreshUser = RefreshUser();
  AuthUser user = AuthUser();
  PageController? pageController;

  Future adduser() async {
    final checkuser =
        await Provider.of<Checkuser>(context, listen: false).checkUser();
    if (checkuser) {
      refreshUser = await Provider.of<RefreshUser>(context, listen: false);
      await refreshUser.refreshuser();
      ApiProvider response = await Auth().getUserDetials() as ApiProvider;
      if (response.data != null) {
        user = refreshUser.currentUser;
        // OneSignal.shared.setEmail(email: user.user!.email!);
        OneSignal.shared.sendTag("email",user.user!.email!);
        islogin = true;
      } else {
        islogin = await Provider.of<Checkuser>(context, listen: false)
            .checkUser(iserror: true);
      }
    }
  }

  @override
  void initState() {
    pageController = PageController();
    adduser().then((value) {
      Provider.of<BasketItemService>(context, listen: false)
          .getItemBasket()
          .then((value) {
        setState(() {
          splash = true;
        });
      });
    });
    super.initState();
  }

  int _selectedIndex = 0;

  final List<Widget> screens = [
    HomeScreen(),
    CategoryPage(),
    BasketScreen(),
    NotficationScreen(),
    ProfileScreen(),
  ];

  onTapped(index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController!.jumpToPage(index);
  }

  _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return splash
        ? Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: MediaQuery.of(context).size.width > websize
                ? Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                islogin
                                    ? Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage: user.user!
                                                              .profilePicture !=
                                                          null
                                                      ? NetworkImage(
                                                          "http://192.168.1.32:8000" +
                                                              user.user!
                                                                  .profilePicture,
                                                        )
                                                      : NetworkImage(
                                                          'https://t3.ftcdn.net/jpg/03/39/45/96/360_F_339459697_XAFacNQmwnvJRqe1Fe9VOptPWMUxlZP8.jpg')),
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(user.user!.username!,
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorLight,
                                                          fontFamily: 'RobotoB',
                                                          fontSize: 20)),
                                                  Text(user.user!.email!,
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorLight
                                                              .withOpacity(0.5),
                                                          fontFamily: 'RobotoM',
                                                          fontSize: 18)),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : Container(),
                                Container(
                                  child: Column(
                                    children: [
                                      ItemBarSide(
                                          icon: 'assets/images/home.svg',
                                          title: 'Home',
                                          width: 33,
                                          height: 33,
                                          selected: _selectedIndex == 0,
                                          onPressed: () {
                                            onTapped(0);
                                          }),
                                      ItemBarSide(
                                          icon: 'assets/images/category.svg',
                                          title: 'Countries',
                                          width: 30,
                                          height: 30,
                                          selected: _selectedIndex == 1,
                                          onPressed: () {
                                            onTapped(1);
                                          }),
                                      ItemBarSide(
                                          icon:
                                              'assets/images/basket-shopping-solid.svg',
                                          title: 'My cart',
                                          width: 30,
                                          height: 30,
                                          selected: _selectedIndex == 2,
                                          onPressed: () {
                                            onTapped(2);
                                          }),
                                      ItemBarSide(
                                          icon: 'assets/images/bell-solid.svg',
                                          title: 'Notfications',
                                          width: 30,
                                          height: 30,
                                          selected: _selectedIndex == 3,
                                          onPressed: () {
                                            onTapped(3);
                                          }),
                                      ItemBarSide(
                                          icon: 'assets/images/user-solid.svg',
                                          title: 'My profile',
                                          width: 30,
                                          height: 30,
                                          selected: _selectedIndex == 4,
                                          onPressed: () {
                                            onTapped(4);
                                          }),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/logout.svg',
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          width: 30,
                                          height: 30,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text("Logout",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                  fontFamily: 'RobotoB',
                                                  fontSize: 20)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                        flex: 2,
                        child: PageView(
                          controller: pageController,
                          onPageChanged: _onPageChanged,
                          children: screens,
                        ),
                      )
                    ],
                  )
                : PageView(
                    controller: pageController,
                    onPageChanged: _onPageChanged,
                    children: screens,
                  ),
            bottomNavigationBar: MediaQuery.of(context).size.width < websize
                ? Container(
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: BottomAppBar(
                      elevation: 0,
                      color: Colors.transparent,
                      child: SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconBottomAppBar(
                                icon: 'assets/images/home.svg',
                                width: 33,
                                height: 33,
                                selected: _selectedIndex == 0,
                                onPressed: () {
                                  onTapped(0);
                                }),
                            IconBottomAppBar(
                                icon: 'assets/images/category.svg',
                                width: 30,
                                height: 30,
                                selected: _selectedIndex == 1,
                                onPressed: () {
                                  onTapped(1);
                                }),
                            Consumer<BasketItemService>(
                                builder: (context, basket, child) {
                              return Stack(
                                children: [
                                  IconBottomAppBar(
                                      icon:
                                          'assets/images/basket-shopping-solid.svg',
                                      width: 30,
                                      height: 30,
                                      selected: _selectedIndex == 2,
                                      onPressed: () {
                                        onTapped(2);
                                      }),
                                  Positioned(
                                    right: 0,
                                    height: 18,
                                    width: 18,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(1000),
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor),
                                      child: Center(
                                        child: Text(
                                            basket.countItem() > 9
                                                ? '9+'
                                                : '${basket.countItem()}',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                            Stack(
                              children: [
                                Container(
                                  child: IconBottomAppBar(
                                      icon: 'assets/images/bell-solid.svg',
                                      width: 30,
                                      height: 30,
                                      selected: _selectedIndex == 3,
                                      onPressed: () {
                                        onTapped(3);
                                      }),
                                ),
                                Positioned(
                                    right: 0,
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(1000),
                                          color: Color(0xffEF4444)),
                                    ))
                              ],
                            ),
                            IconBottomAppBar(
                                icon: 'assets/images/user-solid.svg',
                                width: 30,
                                height: 30,
                                selected: _selectedIndex == 4,
                                onPressed: () {
                                  onTapped(4);
                                }),
                          ],
                        ),
                      ),
                    ),
                  )
                : null,
          )
        : Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 10,
                  child: Container(
                    child: Center(
                      child: Lottie.asset('assets/images/loader_daimond.json',
                          width: 200),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Center(
                        child: Text(
                      AppLocalizations.of(context)!.loading,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 18,
                      ),
                    )),
                  ),
                ),
              ],
            ),
          );
  }
}

class ItemBarSide extends StatelessWidget {
  final String icon;
  final String title;
  final double width;
  final double height;
  final bool selected;
  final Function() onPressed;
  const ItemBarSide({
    super.key,
    required this.icon,
    required this.title,
    required this.width,
    required this.height,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).secondaryHeaderColor
              : Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: Theme.of(context).primaryColorLight,
              width: width,
              height: height,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(title,
                  style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontFamily: 'RobotoB',
                      fontSize: 20)),
            )
          ],
        ),
      ),
    );
  }
}

class IconBottomAppBar extends StatelessWidget {
  final String icon;
  final double width;
  final double height;
  final bool selected;
  final Function() onPressed;
  const IconBottomAppBar(
      {super.key,
      required this.icon,
      required this.width,
      required this.height,
      required this.selected,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: SvgPicture.asset(
            icon,
            color: selected
                ? Theme.of(context).primaryColorLight
                : Theme.of(context).primaryColorLight.withOpacity(0.7),
            width: width,
            height: height,
          ),
        ),
        selected
            ? Container(
                margin: EdgeInsets.only(top: 4),
                width: 25,
                height: 3,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(15)),
              )
            : Container(
                margin: EdgeInsets.only(top: 4),
                width: 25,
                height: 3,
              ),
      ],
    );
  }
}
