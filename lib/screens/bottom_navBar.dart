import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/model/user_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/refresh_user.dart';
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
  
  bool ismodule = false;
  bool splash = false;
  Widget currentPage = HomeScreen();
  bool islogin = false;

  RefreshUser refreshUser = RefreshUser();
  AuthUser user = AuthUser();
  PageController? pageController;

  Future adduser() async {

   final  checkuser=  await Provider.of<Checkuser>(context,listen: false).checkUser();
    
    if(checkuser){
      refreshUser = await Provider.of<RefreshUser>(context, listen: false);
      await refreshUser.refreshuser();
      ApiProvider response = await Auth().getUserDetials() as ApiProvider;
      if (response.data != null) {
        
        currentPage = HomeScreen();
        user = refreshUser.currentUser;
      }
    }
  }

  @override
  void initState() {
    pageController=PageController();
    adduser().then((value) {
      Provider.of<BasketItemProvider>(context, listen: false)
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

  onTapped(index){
    setState(() {
      _selectedIndex=index;
    });
    pageController!.jumpToPage(index);
  }

  _onPageChanged(int index){
    setState(() {
      _selectedIndex=index;
    });
  }



  @override
  Widget build(BuildContext context) {
    final islogin=Provider.of<Checkuser>(context).islogin;
    return splash
        ? Scaffold(
            body: PageView(
              controller: pageController,
              onPageChanged: _onPageChanged,
              children: screens,
            ),
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
                            Consumer<BasketItemProvider>(
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
                      "Loading...",
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
