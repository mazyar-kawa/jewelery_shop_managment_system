import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/category_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<CategoryModel> category = [
    CategoryModel(image: 'assets/images/Italy.png', name: 'Italian', id: 1),
    CategoryModel(image: 'assets/images/Turkey.png', name: 'Turkish', id: 2),
    CategoryModel(image: 'assets/images/Iraq.png', name: 'Iraqi', id: 3),
    CategoryModel(image: 'assets/images/Iran.png', name: 'Persian', id: 4),
    CategoryModel(image: 'assets/images/Dubai.png', name: 'Dubai', id: 5),
    CategoryModel(image: 'assets/images/France.png', name: 'French', id: 6),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 15),
          child: Text(
            AppLocalizations.of(context)!.categories,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Theme.of(context).primaryColor),
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: category.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/items',
                        arguments: category[index].id,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: 120,
                      child: Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage(category[index].image),
                                  height: 100,
                                ),
                                Divider(
                                  height: 30,
                                ),
                                Text(category[index].name,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          )),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
