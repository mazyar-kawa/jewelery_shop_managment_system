import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/theme_change_provider.dart';
import 'package:jewelery_shop_managmentsystem/screens/basket_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/category_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/home_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/items_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/notfication_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/profile_screen.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  int _selectedIndex = 0;
  bool ismodule = false;
  bool ismoduleAppBar = false;
  bool islogin = false;
  Widget currentPage = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          currentPage,
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(right: 25, bottom: 50),
              height: ismoduleAppBar ? 160 : 0,
              width: ismoduleAppBar ? 140 : 0,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      offset: Offset(0, 3),
                      blurRadius: 5,
                      spreadRadius: 2,
                    )
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Consumer<ThemeChangeProvider>(
                          builder: (context, providerTheme, child) {
                            return Switch(
                                inactiveThumbImage: NetworkImage(
                                    'https://img.icons8.com/officel/344/sun.png'),
                                activeThumbImage: NetworkImage(
                                    'https://img.icons8.com/offices/344/full-moon.png'),
                                value: providerTheme.currentTheme == 'dark'
                                    ? ismodule = true
                                    : ismodule = false,
                                onChanged: (value) {
                                  setState(() {
                                    if (value) {
                                      providerTheme.setThemeProvider('dark');
                                      ismodule = true;
                                    } else {
                                      providerTheme.setThemeProvider('light');
                                      ismodule = false;
                                    }
                                  });
                                });
                          },
                        ),
                        Text(
                          'Theme',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: 18,
                            fontFamily: 'RobotoM',
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => BasketScreen()));
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Consumer<BasketItemProvider>(
                              builder: (context, basket, child) {
                            return Stack(
                              children: [
                                SvgPicture.asset(
                                    'assets/images/basket-shopping-solid.svg',
                                    width: 30,
                                    color: Theme.of(context).primaryColorLight),
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
                          Text(
                            'Basket',
                            style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontSize: 18,
                              fontFamily: 'RobotoM',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset('assets/images/settings.svg',
                            width: 30,
                            color: Theme.of(context).primaryColorLight),
                        Text(
                          'Settings',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: 18,
                            fontFamily: 'RobotoM',
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      appBar: MediaQuery.of(context).size.width > websize
          ? PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Row(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: appBarItem('Home', 0),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: appBarItem('Categories', 1),
                              ),
                              // Container(
                              //   width: 90,
                              //   height: 30,
                              //   padding: EdgeInsets.symmetric(horizontal: 10),
                              //   decoration: BoxDecoration(
                              //     border: Border.all(
                              //       color: Theme.of(context).primaryColorLight,
                              //       width: 1,
                              //     ),
                              //   ),
                              //   child: Center(
                              //     child: Text(
                              //       'Login',
                              //       style: TextStyle(
                              //         color:
                              //             Theme.of(context).primaryColorLight,
                              //         fontSize: 16,
                              //         fontFamily: 'RobotoB',
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Stack(
                                  children: [
                                    Container(
                                        child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      NotficationScreen()));
                                        },
                                        child: SvgPicture.asset(
                                            'assets/images/bell-solid.svg',
                                            width: 26,
                                            color: Theme.of(context)
                                                .primaryColorLight),
                                      ),
                                    )),
                                    Positioned(
                                        top: 20,
                                        right: 0,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(1000),
                                              color: Color(0xffEF4444)),
                                        ))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          ismoduleAppBar = !ismoduleAppBar;
                                        });
                                      },
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/images/profile.jpg'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
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
                        navBarItem('assets/images/basket-shopping-solid.svg',
                            30, 30, 2),
                        Positioned(
                          right: 0,
                          height: 18,
                          width: 18,
                          child: Container(
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
                  currentPage = HomeScreen();
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
                  currentPage = ProfileScreen();
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
              currentPage = HomeScreen();
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
              currentPage = ProfileScreen();
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
