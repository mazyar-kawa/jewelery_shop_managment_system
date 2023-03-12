import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/service/item_service.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:jewelery_shop_managmentsystem/widgets/card_items.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Future? loadData;
  @override
  void initState() {
    loadData = LoagingFavoriteItems();
    super.initState();
  }

  LoagingFavoriteItems() async {
    await Provider.of<ItemService>(context, listen: false).getFavouriteItem();
  }

  @override
  Widget build(BuildContext context) {
    List<SingleItem> product = Provider.of<ItemService>(context).favouriteItems;
    print(product.length);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.favourite,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoB',
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            height: 20,
            width: 25,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: loadData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return product.length != 0
                ? MediaQuery.of(context).size.width > websize
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.82,
                        height: MediaQuery.of(context).size.height,
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: product.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.9,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, i) =>
                                ChangeNotifierProvider.value(
                                  value: product[i],
                                  // child: CardItemsWeb(index: i),
                                )),
                      )
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: product.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i) =>
                            ChangeNotifierProvider.value(
                              value: product[i],
                              child: CardItems(
                                index: i,
                                isbasket: false,
                              ),
                            ))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Center(
                            child: Text(
                          AppLocalizations.of(context)!.yourFavouriteisempty,
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'RobotoB',
                            color: Theme.of(context).primaryColorLight,
                          ),
                        )),
                      ),
                      Container(
                        child: Center(
                          child: Lottie.asset(
                            'assets/images/empty-box.json',
                            width: MediaQuery.of(context).size.width > websize
                                ? 650
                                : 350,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: Lottie.asset('assets/images/loader_daimond.json',
                    width: 200),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}