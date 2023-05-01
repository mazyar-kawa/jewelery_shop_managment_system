import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jewelery_shop_managmentsystem/model/basket_model.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/model/notification.dart';
import 'package:jewelery_shop_managmentsystem/model/orderDetails_model.dart';
import 'package:jewelery_shop_managmentsystem/responsive/mobile_screen_layout.dart';
import 'package:jewelery_shop_managmentsystem/responsive/responsive_layout.dart';
import 'package:jewelery_shop_managmentsystem/responsive/ipad_screen_layout.dart';
import 'package:jewelery_shop_managmentsystem/screens/notfication_screen.dart';
import 'package:jewelery_shop_managmentsystem/service/Basket_item_service.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_service.dart';
import 'package:jewelery_shop_managmentsystem/service/countries_service.dart';
import 'package:jewelery_shop_managmentsystem/service/home_items_service.dart';
import 'package:jewelery_shop_managmentsystem/service/item_service.dart';
import 'package:jewelery_shop_managmentsystem/service/language_service.dart';
import 'package:jewelery_shop_managmentsystem/service/notifications_service.dart';
import 'package:jewelery_shop_managmentsystem/service/order.dart';
import 'package:jewelery_shop_managmentsystem/service/refresh_user.dart';
import 'package:jewelery_shop_managmentsystem/service/search_for_items.dart';
import 'package:jewelery_shop_managmentsystem/service/theme_change_provider.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_kurdish_localization/flutter_kurdish_localization.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
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
  LanguageServ LanguageService = LanguageServ();

  @override
  void initState() {
    getlanguage();
    changeTheme();
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId("27238722-d531-4cb0-b104-48ca384936e9");

    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      event.complete(event.notification);
    });
    OneSignal.shared.setNotificationOpenedHandler((result) {
 
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => NotficationScreen()));
    });

    OneSignal.shared
        .setPermissionObserver((OSPermissionStateChanges changes) {});

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {});

   
    super.initState();

  }

  getlanguage() async {
    LanguageService.setLanguage(
        await LanguageService.languagePrefrences.getLanguage());
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
        ChangeNotifierProvider(create: (_) => LanguageService),
        ChangeNotifierProvider.value(value: BasketItemService()),
        ChangeNotifierProvider.value(value: RefreshUser()),
        ChangeNotifierProvider.value(value: CountriesService()),
        ChangeNotifierProvider.value(value: ItemService()),
        ChangeNotifierProvider.value(value: SingleItem()),
        ChangeNotifierProvider.value(value: HomeItemsService()),
        ChangeNotifierProvider.value(value: Checkuser()),
        ChangeNotifierProvider.value(value: ItemBasket()),
        ChangeNotifierProvider.value(value: OrderService()),
        ChangeNotifierProvider.value(value: OrderDetailsModel()),
        ChangeNotifierProvider.value(value: SearchFoItems()),
        ChangeNotifierProvider.value(value: NotificationsService()),
      ],
      child: Consumer<ThemeChangeProvider>(
          builder: (context, themeChangeProvider, child) {
        return Consumer<LanguageServ>(builder: (child, provider, value) {
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
              buttonColor: primaryColorLight,
              primaryColorLight: primaryColorLight,
              primaryColor: primaryFadeCardLight,
              accentColor: seconderFadeCardLight,
              secondaryHeaderColor: secondColorLight,
              shadowColor: shadowCardLight,
              canvasColor: primaryColorLight,
              primaryColorDark: scaffoldbackgroundLight,
            ),
            darkTheme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: scaffoldbackgroundDark,
                buttonColor: scaffoldbackgroundDark,
                primaryColorLight: primaryColorDark,
                primaryColor: primaryFadeCardDark,
                accentColor: seconderFadeCardDark,
                shadowColor: shadowCardDark,
                secondaryHeaderColor: secondColorDark,
                canvasColor: scaffoldbackgroundDark,
                primaryColorDark: primaryColorDark),
            themeMode: themeChangeProvider.themeMode,
            home: LayoutScreen(
              mobileScreen: MobileScreenLayout(),
              ipadScreen: IpadScreenLayout(),
            ),
          );
        });
      }),
    );
  }
}
