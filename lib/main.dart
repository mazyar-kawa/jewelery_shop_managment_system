import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/provider/theme_change_provider.dart';
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
      ],
      child: Consumer<ThemeChangeProvider>(
          builder: (context, themeChangeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.light().copyWith(primaryColor: Color(0xff94B49F)),
          darkTheme: ThemeData.dark().copyWith(
            primaryColor: Color(0xff94B49F),
          ),
          themeMode: themeChangeProvider.themeMode,
          home: CategoryPage(),
        );
      }),
    );
  }
}
