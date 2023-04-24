import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/screens/signin_screen.dart';
import 'package:jewelery_shop_managmentsystem/service/theme_change_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UnAuthentication extends StatelessWidget {
  String title;
 UnAuthentication({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChangeProvider>(builder: (context, provider, chile) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Theme.of(context).primaryColorLight.value == 4286436348
                ? Lottie.asset(
                    'assets/images/unauthorized_blue.json',
                    width: 450,
                  )
                : Lottie.asset(
                    'assets/images/unauthorized_grey.json',
                    width: 450,
                  ),
          ),
          Container(
              child: Text( title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
              fontSize: 24,
              fontFamily: 'RobotoB',
            ),
          )),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SignIn()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
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
                  AppLocalizations.of(context)!.login,
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
      );
    });
  }
}
