import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/screens/basket_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/category_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/home_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/notfication_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/profile_screen.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  int _selectedIndex = 0;

  Widget currentPage = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 9),
        height: MediaQuery.of(context).size.height * 0.075,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 3,
                offset: Offset(0, -5),
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navBarItem('assets/images/home.svg', 33, 33, 0),
            navBarItem('assets/images/category.svg', 30, 30, 1),
            Stack(
              children: [
                navBarItem(
                    'assets/images/basket-shopping-solid.svg', 30, 30, 2),
                Positioned(
                  right: 0,
                  height: 18,
                  width: 18,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        color: Theme.of(context).scaffoldBackgroundColor),
                    child: Center(
                      child: Text('3',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  child: navBarItem('assets/images/bell-solid.svg', 30, 30, 3),
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
      ),
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
          index == _selectedIndex
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
