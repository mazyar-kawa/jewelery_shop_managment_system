import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jewelery_shop_managmentsystem/screens/items_screen.dart';
import 'package:jewelery_shop_managmentsystem/service/countries_service.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Future? category;
  @override
  void initState() {
    category = fetchCategory();
    WidgetsBinding.instance.addPostFrameCallback((_) => category);
    super.initState();
  }

  fetchCategory() async {
    await Provider.of<CountriesService>(context, listen: false).getCountries();
  }

  void Refresh() async {
    await Future.delayed(
      Duration(seconds: 2),
      () {
        category = fetchCategory();
      },
    );
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
              MediaQuery.of(context).size.width > websize
                  ? MediaQuery.of(context).size.height * 0.3
                  : MediaQuery.of(context).size.height * 0.2),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 15),
            child: Text(
              AppLocalizations.of(context)!.countries,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
          ),
        ),
        body: SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          header: CustomHeader(
            builder: (context, mode) {
              Widget body;
              if (mode == LoadStatus.loading) {
                body = Lottie.asset('assets/images/refresh.json');
              } else {
                body = Lottie.asset('assets/images/refresh.json');
              }
              return Container(
                height: 75,
                child: Center(child: body),
              );
            },
          ),
          onRefresh: Refresh,
          child: FutureBuilder(
              future: Provider.of<CountriesService>(context, listen: false)
                  .getCountries(),
              builder: (context, snapshot) {
                final category =
                    Provider.of<CountriesService>(context).countries;
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: category.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  MediaQuery.of(context).size.width > websize
                                      ? 3
                                      : 2,
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
                                  // Navigator.pushNamed(
                                  //   context,
                                  //   '/items',
                                  //   arguments: category[index].id,
                                  // );

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ItemsScreen(
                                                country_id: category[index].id!,
                                                country_name: category[index]
                                                    .namecountries!,
                                              )));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  width: 120,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: Card(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(25.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Image(
                                                image: NetworkImage(
                                                    category[index]
                                                        .picturecountries!),
                                              ),
                                            ),
                                            Divider(
                                              height: 30,
                                            ),
                                            Expanded(
                                              child: Container(
                                                constraints: BoxConstraints(
                                                    maxWidth: 100),
                                                child: Text(
                                                    category[index]
                                                        .namecountries!,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColorLight,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              );
                            }),
                      )
                    ],
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Container(
                    child: Center(
                      child: Lottie.asset('assets/images/loader_daimond.json',
                          width: 200),
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
