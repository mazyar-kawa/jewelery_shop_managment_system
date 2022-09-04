import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/screens/favorite_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/history_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/settings_screen.dart';
import 'package:jewelery_shop_managmentsystem/screens/user_managment.dart';
import 'package:jewelery_shop_managmentsystem/widgets/settings_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Row(
              children: [
                Container(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mazyar',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'RobotoB',
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        '@ MR.Mazyar',
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
            color: Theme.of(context).primaryColor.withOpacity(0.3),
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => SettingScreen()));
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => FavoriteScreen()));
                  },
                ),
                ProfileCards(
                  title: AppLocalizations.of(context)!.history,
                  image: 'assets/images/history.svg',
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => HistoryScreen()));
                  },
                ),
                ProfileCards(
                  title: AppLocalizations.of(context)!.admin,
                  image: 'assets/images/user-group-solid.svg',
                  onPressed: () {},
                ),
                ProfileCards(
                  title: AppLocalizations.of(context)!.logOut,
                  image: 'assets/images/logout.svg',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
