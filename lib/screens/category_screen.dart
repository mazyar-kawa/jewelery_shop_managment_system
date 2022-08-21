import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/provider/theme_change_provider.dart';

import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
        centerTitle: true,
        actions: [
          Consumer<ThemeChangeProvider>(
              builder: (context, providerTheme, child) {
            return DropdownButton(
                value: providerTheme.currentTheme,
                underline: Container(),
                icon: Icon(Icons.more_vert),
                items: [
                  DropdownMenuItem(
                    child: Text('Light'),
                    value: 'light',
                  ),
                  DropdownMenuItem(
                    child: Text('Dark'),
                    value: 'dark',
                  ),
                  DropdownMenuItem(
                    child: Text('System'),
                    value: 'system',
                  ),
                ],
                onChanged: (String? value) {
                  providerTheme.setThemeProvider(value!);
                });
          }),
        ],
      ),
      body: Center(
        child: Text(
          'Category Page',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
