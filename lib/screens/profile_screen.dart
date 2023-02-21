import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/model/user_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/refresh_user.dart';
import 'package:jewelery_shop_managmentsystem/provider/theme_change_provider.dart';
import 'package:jewelery_shop_managmentsystem/screens/bottom_navBar.dart';
import 'package:jewelery_shop_managmentsystem/screens/favorite_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/myOrders_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/settings_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/signin_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/user_managment.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/widgets/settings_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // super.build(context);
    final islogin = Provider.of<Checkuser>(context).islogin;
    late User user;
    if (islogin) {
      user = Provider.of<RefreshUser>(context).currentUser.user!;
    }
    return Scaffold(
        body: islogin
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              child: Lottie.asset(
                                  "assets/images/circle_avatar.json",
                                  width:
                                      MediaQuery.of(context).size.width * 0.45),
                            ),
                            Container(
                              child: CircleAvatar(
                                  radius:
                                      MediaQuery.of(context).size.width * 0.12,
                                  backgroundImage: user.profilePicture != null
                                      ? NetworkImage(
                                          user.profilePicture,
                                        )
                                      : NetworkImage(
                                          'https://t3.ftcdn.net/jpg/03/39/45/96/360_F_339459697_XAFacNQmwnvJRqe1Fe9VOptPWMUxlZP8.jpg')),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                user.username!,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontFamily: "RobotoB",
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                user.email!,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryColorLight
                                      .withOpacity(0.5),
                                  fontFamily: "RobotoM",
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer<RefreshUser>(
                        builder: (context, value, child) {
                          return Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                width: MediaQuery.of(context).size.width * 0.30,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context).shadowColor,
                                          blurRadius: 4,
                                          offset: Offset(0, 3))
                                    ]),
                                child: Column(
                                  children: [
                                    // Text(
                                    //   '${value.favorite<9?'0${value.favorite}': value.favorite}',
                                    //   style: TextStyle(
                                    //     color:
                                    //         Theme.of(context).primaryColorLight,
                                    //     fontFamily: "RobotoB",
                                    //     fontSize: 18,
                                    //   ),
                                    // ),
                                    Text(
                                      'Favorites',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontFamily: "RobotoB",
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                width: MediaQuery.of(context).size.width * 0.30,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context).shadowColor,
                                          blurRadius: 4,
                                          offset: Offset(0, 3))
                                    ]),
                                child: Column(
                                  children: [
                                    // Text(
                                    //   '${value.order<9?'0${value.order}': value.order}',
                                    //   style: TextStyle(
                                    //     color:
                                    //         Theme.of(context).primaryColorLight,
                                    //     fontFamily: "RobotoB",
                                    //     fontSize: 18,
                                    //   ),
                                    // ),
                                    Text(
                                      'Orders',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontFamily: "RobotoB",
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                        },
                       
                      ),
                      Container(
                        child: Column(
                          children: [
                            ProfileCards(
                                title: "Settings",
                                image: "settings.svg",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SettingScreen()));
                                }),
                            ProfileCards(
                                title: "Account information",
                                image: "user.svg",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserManagmentScreen()));
                                }),
                            ProfileCards(
                                title: "My Orders",
                                image: "orders.svg",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MyOrdersScreen()));
                                }),
                            ProfileCards(
                                title: "My Favorites",
                                image: "heart-solid.svg",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FavoriteScreen()));
                                }),
                            user.roleId! == 1
                                ? ProfileCards(
                                    title: "Admin",
                                    image: "user-group-solid.svg",
                                    onPressed: () {})
                                : Container(),
                            ProfileCards(
                                title: "LogOut",
                                image: "logout.svg",
                                onPressed: () {
                                  Auth().logOut();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoadingPage(),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Consumer<ThemeChangeProvider>(
                builder: (context, provider, chile) {
                return SafeArea(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SettingScreen()));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 25,horizontal: 15),
                          alignment: Alignment.topRight,
                          child: SvgPicture.asset('assets/images/settings.svg',color: Theme.of(context).primaryColorLight,),
                        ),
                      ),
                      Container(
                        child: Theme.of(context).primaryColorLight.value ==
                                4286436348
                            ? LottieBuilder.asset(
                                'assets/images/unauthorized_blue.json',
                                width: 450,
                              )
                            : LottieBuilder.asset(
                                'assets/images/unauthorized_grey.json',
                                width: 450,
                              ),
                      ),
                      Container(
                          child: Text(
                        'Oops!...Unauthorized',
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 24,
                          fontFamily: 'RobotoB',
                        ),
                      )),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SignIn()));
                        },
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).shadowColor,
                                  blurRadius: 3,
                                  offset: Offset(2, 3),
                                )
                              ]),
                          child: Center(
                            child: Text(
                              'LogIn',
                              style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                                fontFamily: 'RobotoB',
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }));
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
