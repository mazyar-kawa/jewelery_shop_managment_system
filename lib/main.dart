import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/items_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/theme_change_provider.dart';
import 'package:jewelery_shop_managmentsystem/responsive/mobile_screen_layout.dart';
import 'package:jewelery_shop_managmentsystem/responsive/responsive_layout.dart';
import 'package:jewelery_shop_managmentsystem/responsive/web_screen_layout.dart';
import 'package:jewelery_shop_managmentsystem/screens/bottom_navBar.dart';
import 'package:jewelery_shop_managmentsystem/screens/category_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeChangeProvider _themeChangeProvider = ThemeChangeProvider();

  @override
  void initState() {
    changeTheme();
    super.initState();
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
        ChangeNotifierProvider.value(value: ItemProvider()),
        ChangeNotifierProvider.value(value: BasketItemProvider()),
      ],
      child: Consumer<ThemeChangeProvider>(
          builder: (context, themeChangeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Color(0xffFFFFFF),
            primaryColor: Color(0xff455A64),
          ),
          darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Color(0xFF1F1F1F),
            primaryColor: Color(0xff3DB8EF),
          ),
          themeMode: themeChangeProvider.themeMode,
          home: LayoutScreen(
            mobilescreen: MobileScreenLayout(),
            webscreen: WebScreenLayout(),
          ),
        );
      }),
    );
  }
}
