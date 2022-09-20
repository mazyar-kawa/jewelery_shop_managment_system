import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/user_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/refresh_user.dart';
import 'package:jewelery_shop_managmentsystem/provider/theme_change_provider.dart';
import 'package:jewelery_shop_managmentsystem/screens/bottom_navBar.dart';
import 'package:jewelery_shop_managmentsystem/screens/favorite_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/history_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/settings_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/signin_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/user_managment.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/widgets/settings_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final bool islogin;

  ProfileScreen({required this.islogin});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    late AuthUser user;
    if (widget.islogin) {
      user = Provider.of<RefreshUser>(context).currentUser;
    }
    return Scaffold(
        body: widget.islogin
            ? ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    child: Row(
                      children: [
                        Container(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: user.user!.profilePicture != null
                                ? NetworkImage(user.user!.profilePicture)
                                : NetworkImage(
                                    'https://t3.ftcdn.net/jpg/03/39/45/96/360_F_339459697_XAFacNQmwnvJRqe1Fe9VOptPWMUxlZP8.jpg'),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user.user!.name}',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontFamily: 'RobotoB',
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                '@ ${user.user!.username}',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'RobotoM',
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    indent: 30,
                    endIndent: 30,
                    color: Theme.of(context).primaryColorLight.withOpacity(0.3),
                    thickness: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      children: [
                        ProfileCards(
                          title: AppLocalizations.of(context)!.settings,
                          image: 'assets/images/settings.svg',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => SettingScreen()));
                          },
                        ),
                        ProfileCards(
                          title: AppLocalizations.of(context)!.userManagement,
                          image: 'assets/images/user-solid.svg',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => UserManagmentScreen()));
                          },
                        ),
                        ProfileCards(
                          title: AppLocalizations.of(context)!.favourite,
                          image: 'assets/images/heart-solid.svg',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => FavoriteScreen()));
                          },
                        ),
                        ProfileCards(
                          title: AppLocalizations.of(context)!.history,
                          image: 'assets/images/history.svg',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => HistoryScreen()));
                          },
                        ),
                        user.user!.roleId == 1
                            ? ProfileCards(
                                title: AppLocalizations.of(context)!.admin,
                                image: 'assets/images/user-group-solid.svg',
                                onPressed: () {},
                              )
                            : Container(),
                        ProfileCards(
                          title: AppLocalizations.of(context)!.logOut,
                          image: 'assets/images/logout.svg',
                          onPressed: () {
                            Auth().logOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoadingPage(
                                          islogin: false,
                                        )));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Consumer<ThemeChangeProvider>(
                builder: (context, provider, chile) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                        setState(() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SignIn()));
                        });
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
                              color: Colors.white,
                              fontFamily: 'RobotoB',
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }));
  }
}
