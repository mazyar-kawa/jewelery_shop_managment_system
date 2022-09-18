import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jewelery_shop_managmentsystem/provider/countries_provider.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void didChangeDependencies() async {
    await Provider.of<CountriesProvider>(context).getCountries();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final category =
        Provider.of<CountriesProvider>(context, listen: true).countries;
    return category.length == 0
        ? Container(
            color: Colors.white,
            child: Center(
              child:
                  Lottie.asset('assets/images/loader_daimond.json', width: 200),
            ),
          )
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  MediaQuery.of(context).size.width > websize
                      ? MediaQuery.of(context).size.height * 0.3
                      : MediaQuery.of(context).size.height * 0.2),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 15),
                child: Text(
                  AppLocalizations.of(context)!.categories,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Theme.of(context).primaryColorLight,
                  ),
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
                        crossAxisCount:
                            MediaQuery.of(context).size.width > websize ? 3 : 2,
                        childAspectRatio: 0.9,
                        crossAxisSpacing: 5,
                        mainAxisSpacing:
                            MediaQuery.of(context).size.width > websize
                                ? 20
                                : 10,
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
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Image(
                                        image: NetworkImage(
                                            category[index].picturecountries!),
                                        height: 100,
                                      ),
                                      Divider(
                                        height: 30,
                                      ),
                                      Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 100),
                                        child: Text(
                                            category[index].namecountries!,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      )
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
