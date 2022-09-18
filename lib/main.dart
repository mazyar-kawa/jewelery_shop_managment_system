import 'package:flutter/material.dart';
import 'package:flutter_kurdish_localization/flutter_kurdish_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/countries_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/item_provider_org.dart';
import 'package:jewelery_shop_managmentsystem/provider/refresh_user.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/items_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/language_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/theme_change_provider.dart';
import 'package:jewelery_shop_managmentsystem/responsive/mobile_screen_layout.dart';
import 'package:jewelery_shop_managmentsystem/responsive/responsive_layout.dart';
import 'package:jewelery_shop_managmentsystem/responsive/web_screen_layout.dart';
import 'package:jewelery_shop_managmentsystem/screens/items_screen.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        ChangeNotifierProvider.value(value: ItemProvider()),
        ChangeNotifierProvider.value(value: BasketItemProvider()),
        ChangeNotifierProvider.value(value: RefreshUser()),
        ChangeNotifierProvider.value(value: CountriesProvider()),
        ChangeNotifierProvider.value(value: ItemProviderORG()),
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
              buttonColor: scaffoldbackgroundLight,
              primaryColorLight: primaryColorLight,
              primaryColor: primaryFadeCardLight,
              accentColor: seconderFadeCardLight,
              backgroundColor: primaryCardLight,
              secondaryHeaderColor: seconderCardLight,
              shadowColor: shadowCardLight,
            ),
            darkTheme: ThemeData.dark().copyWith(
              buttonColor: scaffoldbackgroundDark,
              primaryColorLight: primaryColorDark,
              primaryColor: primaryFadeCardDark,
              accentColor: seconderFadeCardDark,
              backgroundColor: primaryCardDark,
              secondaryHeaderColor: seconderCardDark,
              shadowColor: shadowCardDark,
            ),
            themeMode: themeChangeProvider.themeMode,
            home: LayoutScreen(
              mobilescreen: MobileScreenLayout(),
              webscreen: WebScreenLayout(),
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
