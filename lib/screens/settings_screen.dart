import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jewelery_shop_managmentsystem/service/language_service.dart';
import 'package:jewelery_shop_managmentsystem/service/theme_change_provider.dart';
import 'package:provider/provider.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>{
  
  bool check=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoB',
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            height: 20,
            width: 25,
            child: RotatedBox(
              quarterTurns: 90,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/images/language-solid.svg',
                                  width: 35,
                                  color: Theme.of(context).primaryColorLight,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.7,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.language,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'RobotoB',
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    ),
                                  ),
                                  Container(
                                    child: Consumer<LanguageServ>(builder:
                                        (context, providerLanguage, child) {
                                      return DropdownButton(
                                        underline: SizedBox(),
                                        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                                        value: providerLanguage.currentLanguage,
                                        items: [
                                          DropdownMenuItem(
                                            child: Text('English'),
                                            value: 'en',
                                          ),
                                          DropdownMenuItem(
                                            child: Text('العربية'),
                                            value: 'ar',
                                          ),
                                          DropdownMenuItem(
                                            child: Text('کوردی'),
                                            value: 'ku',
                                          ),
                                        ],
                                        onChanged: (String? value) {
                                          providerLanguage.setLanguage(value!);
                                        },
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Consumer<ThemeChangeProvider>(
                              builder: (context, providerTheme, child) {
                                return Container(
                                  child: Center(
                                    child: providerTheme.currentTheme == 'dark'
                                        ? SvgPicture.asset(
                                            'assets/images/moon-solid.svg',
                                            width: 35,
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                          )
                                        : SvgPicture.asset(
                                            'assets/images/sun-solid.svg',
                                            width: 35,
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                          ),
                                  ),
                                );
                              },
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.7,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.mode,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'RobotoB',
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    ),
                                  ),
                                  Container(
                                    child: Consumer<ThemeChangeProvider>(
                                        builder:
                                            (context, providerTheme, child) {
                                      return DropdownButton(
                                        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                                          value: providerTheme.currentTheme,
                                          underline: Container(),
                                          items: [
                                            DropdownMenuItem(
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .light),
                                              value: 'light',
                                            ),
                                            DropdownMenuItem(
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .dark),
                                              value: 'dark',
                                            ),
                                            DropdownMenuItem(
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .system),
                                              value: 'system',
                                            ),
                                          ],
                                          onChanged: (String? value) {
                                            providerTheme
                                                .setThemeProvider(value!);
                                          });
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                AppLocalizations.of(context)!.more,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoB',
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context)!.rememberMe,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'RobotoB',
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
                subtitle: Text(AppLocalizations.of(context)!
                    .ifYouCheckThisBoxYouWillBeLogoutOnceYouClosedTheApp),
                trailing: Checkbox(
                  onChanged: (value) {
                    setState(() {
                      check=!check;
                     
                    });
                  },
                  value: check,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
