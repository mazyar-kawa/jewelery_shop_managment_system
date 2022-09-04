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
  Widget currentPage = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      appBar: MediaQuery.of(context).size.width > websize
          ? PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * 0.075),
              child: Container(
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: appBarItem('Home', 0),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: appBarItem('Categories', 1),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              child: navBarItem(
                                  'assets/images/bell-solid.svg', 20, 20, 3),
                            ),
                            Positioned(
                                right: 0,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1000),
                                      color: Color(0xffEF4444)),
                                ))
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        navBarItem('assets/images/user-solid.svg', 20, 20, 4),
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
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          : null,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: MediaQuery.of(context).size.width < websize
          ? Container(
              padding: EdgeInsets.symmetric(vertical: 7),
              height: 60,
              color: Theme.of(context).primaryColor,
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
                                      color: Theme.of(context).primaryColor,
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
              currentPage = ItemsScreen();
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

  appBarItem(String title, int index) {
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
          Text(
            title,
            style: TextStyle(
              color: index == _selectedIndex
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          index == _selectedIndex
              ? Container(
                  width: 25,
                  height: 4,
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
