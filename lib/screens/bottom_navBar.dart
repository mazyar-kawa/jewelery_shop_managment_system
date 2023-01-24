import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/model/user_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/refresh_user.dart';
import 'package:jewelery_shop_managmentsystem/provider/theme_change_provider.dart';
import 'package:jewelery_shop_managmentsystem/screens/basket_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/category_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/home_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/notfication_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/profile_screen.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  // late bool islogin;
  LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  int _selectedIndex = 0;
  bool ismodule = false;
  // bool ismoduleAppBar = false;
  bool splash = false;
  Widget currentPage = HomeScreen();
  bool islogin = false;
  RefreshUser refreshUser = RefreshUser();
  AuthUser user = AuthUser();
  adduser() async {
    String token = await Auth().getToken();
    if (token == '') {
      islogin = false;
    } else {
      refreshUser = Provider.of<RefreshUser>(context, listen: false);
      await refreshUser.refreshuser();
      ApiProvider response = await Auth().getUserDetials() as ApiProvider;
      if (response.data != null) {
        islogin = true;
        currentPage = HomeScreen();
        user = refreshUser.currentUser;
      }
    }
  }

  @override
  void initState() {
    // Provider.of<ItemProviderORG>(context, listen: false).getItems(1);
    adduser();
    Future.delayed(
      Duration(seconds: 3),
      () {
        setState(() {
          splash = true;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return splash
        ? Scaffold(
            body: currentPage,
            appBar: MediaQuery.of(context).size.width > websize
                ? PreferredSize(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Text(
                                "Logo",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 35),
                                child: Container(
                                  margin: EdgeInsets.only(right: 70),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      appBarItem("Home", 0),
                                      appBarItem("Categorys", 1),
                                      appBarItem("Basket", 2),
                                      appBarItem("Notfications", 3),
                                    ],
                                  ),
                                ),
                              )),
                          Container(
                            padding: EdgeInsets.only(right: 50, left: 20),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: islogin
                                  ? NetworkImage(user.user!.profilePicture)
                                  : NetworkImage(
                                      'https://t3.ftcdn.net/jpg/03/39/45/96/360_F_339459697_XAFacNQmwnvJRqe1Fe9VOptPWMUxlZP8.jpg'),
                            ),
                          )
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(1000),
                          //   child: islogin
                          //       ? Image.network(user.user!.profilePicture)
                          //       : Image.network(
                          //           'https://t3.ftcdn.net/jpg/03/39/45/96/360_F_339459697_XAFacNQmwnvJRqe1Fe9VOptPWMUxlZP8.jpg'),
                          // ),
                        ],
                      ),
                    ),
                    preferredSize: Size.fromHeight(
                        MediaQuery.of(context).size.height * 0.09))
                : null,
            bottomNavigationBar: MediaQuery.of(context).size.width < websize
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 7),
                    height: 60,
                    color: Theme.of(context).primaryColorLight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        navBarItem('assets/images/home.svg', 33, 33, 0),
                        navBarItem('assets/images/category.svg', 30, 30, 1),
                        Consumer<BasketItemProvider>(
                            builder: (context, basket, child) {
                          return Stack(
                            children: [
                              navBarItem(
                                  'assets/images/basket-shopping-solid.svg',
                                  30,
                                  30,
                                  2),
                              Positioned(
                                right: 0,
                                height: 18,
                                width: 18,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1000),
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
                              child: navBarItem(
                                  'assets/images/bell-solid.svg', 30, 30, 3),
                            ),
                            Positioned(
                                right: 0,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1000),
                                      color: Color(0xffEF4444)),
                                ))
                          ],
                        ),
                        navBarItem('assets/images/user-solid.svg', 30, 30, 4),
                      ],
                    ),
                  )
                : null,
          )
        : Container(
            color: Colors.white,
            child: Center(
              child:
                  Lottie.asset('assets/images/loader_daimond.json', width: 200),
            ),
          );
  }

  appBarItem(String title, int index) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = index;
              switch (_selectedIndex) {
                case 0:
                  currentPage = HomeScreen(
                      // islogin:islogin,
                      );
                  break;
                case 1:
                  currentPage = CategoryPage();
                  break;
                case 2:
                  currentPage = BasketScreen();
                  break;
                case 3:
                  currentPage = NotficationScreen();
                  break;
                case 4:
                  currentPage = ProfileScreen(
                    islogin: islogin,
                  );
                  break;
              }
            });
          },
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'RobotoB',
              color: index == _selectedIndex
                  ? Theme.of(context).primaryColorLight
                  : Theme.of(context).primaryColorLight.withOpacity(0.7),
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        index == _selectedIndex
            ? Container(
                width: 35,
                height: 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: Theme.of(context).primaryColorLight),
              )
            : Container(),
      ],
    );
  }

  navBarItem(String icon, double width, double height, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          switch (_selectedIndex) {
            case 0:
              currentPage = HomeScreen(
                  // islogin: islogin,
                  );
              break;
            case 1:
              currentPage = CategoryPage();
              break;
            case 2:
              currentPage = BasketScreen();
              break;
            case 3:
              currentPage = NotficationScreen();
              break;
            case 4:
              currentPage = ProfileScreen(
                islogin: islogin,
              );
              break;
          }
        });
      },
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            color: index == _selectedIndex
                ? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
            width: width,
            height: height,
          ),
          SizedBox(
            height: 3,
          ),
          index == _selectedIndex && MediaQuery.of(context).size.width < websize
              ? Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      color: Theme.of(context).scaffoldBackgroundColor),
                )
              : Container(),
        ],
      ),
    );
  }
}
