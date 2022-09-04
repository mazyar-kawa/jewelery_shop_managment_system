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
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Text(
              'Categories',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CatergoryCard('assets/images/Italy.png', 'italian'),
              CatergoryCard('assets/images/Turkey.png', 'Turkish')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CatergoryCard('assets/images/Iraq.png', 'Iraqi'),
              CatergoryCard('assets/images/Iran.png', 'persian')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CatergoryCard('assets/images/Dubai.png', 'Dubai'),
              CatergoryCard('assets/images/France.png', 'French')
            ],
          )
        ],
      ),
    ));
  }

  Widget CatergoryCard(image, name) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 160,
        child: Card(
            elevation: 20,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Image(
                    image: AssetImage(image),
                    height: 100,
                  ),
                  Divider(
                    height: 30,
                  ),
                  Text('$name',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))
                ],
              ),
            )),
      ),
    );
  }
}
