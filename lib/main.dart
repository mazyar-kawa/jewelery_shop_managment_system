import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jewelery_shop_managmentsystem/model/basket_model.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/countries_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/home_items_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/item_provider_org.dart';
import 'package:jewelery_shop_managmentsystem/provider/refresh_user.dart';
import 'package:jewelery_shop_managmentsystem/provider/language_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/theme_change_provider.dart';
import 'package:jewelery_shop_managmentsystem/responsive/mobile_screen_layout.dart';
import 'package:jewelery_shop_managmentsystem/responsive/responsive_layout.dart';
import 'package:jewelery_shop_managmentsystem/responsive/ipad_screen_layout.dart';
import 'package:jewelery_shop_managmentsystem/screens/item_details.dart';
import 'package:jewelery_shop_managmentsystem/screens/items_screen.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/order.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_kurdish_localization/flutter_kurdish_localization.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeChangeProvider _themeChangeProvider = ThemeChangeProvider();
  LanguageProvider languageProvider = LanguageProvider();

  @override
  void initState() {
    getlanguage();
    changeTheme();
    super.initState();
    
  }

  getlanguage() async {
    languageProvider
        .setLanguage(await languageProvider.languagePrefrences.getLanguage());
  }

  changeTheme() async {
    _themeChangeProvider
        .setThemeProvider(await _themeChangeProvider.themechange.getTheme());
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _themeChangeProvider),
        ChangeNotifierProvider(create: (_) => languageProvider),
        ChangeNotifierProvider.value(value: BasketItemProvider()),
        ChangeNotifierProvider.value(value: RefreshUser()),
        ChangeNotifierProvider.value(value: CountriesProvider()),
        ChangeNotifierProvider.value(value: ItemProviderORG()),
        ChangeNotifierProvider.value(value: SingleItem()),
        ChangeNotifierProvider.value(value: HomeItemsProvider()),
        ChangeNotifierProvider.value(value: Checkuser()),
        ChangeNotifierProvider.value(value: ItemBasket()),
        ChangeNotifierProvider.value(value: Order()),
      ],
      child: Consumer<ThemeChangeProvider>(
          builder: (context, themeChangeProvider, child) {
        return Consumer<LanguageProvider>(builder: (child, provider, value) {
          return MaterialApp(
            localizationsDelegates: const [
              KurdishMaterialLocalizations.delegate,
              KurdishWidgetLocalizations.delegate,
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: provider.getCurrentLanguage,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: scaffoldbackgroundLight,
              buttonColor: scaffoldbackgroundLight,
              primaryColorLight: primaryColorLight,
              primaryColor: primaryFadeCardLight,
              accentColor: seconderFadeCardLight,
              secondaryHeaderColor: secondColorLight,
              shadowColor: shadowCardLight,
            ),
            darkTheme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: scaffoldbackgroundDark,
              buttonColor: scaffoldbackgroundDark,
              primaryColorLight: primaryColorDark,
              primaryColor: primaryFadeCardDark,
              accentColor: seconderFadeCardDark,
              shadowColor: shadowCardDark,
              secondaryHeaderColor: secondColorDark,
            ),
            themeMode: themeChangeProvider.themeMode,
            home: LayoutScreen(
              mobilescreen: MobileScreenLayout(),
              webscreen: IpadScreenLayout(),
            ),
            
            routes: {
              ItemsScreen.routname: (context) => ItemsScreen(),
            },
          );
        });
      }),
    );
  }
}
