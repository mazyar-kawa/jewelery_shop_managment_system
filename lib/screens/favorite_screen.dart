import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jewelery_shop_managmentsystem/provider/item_provider_org.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:jewelery_shop_managmentsystem/widgets/card_items_mobile.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ItemProviderORG>(context).getFavouriteItem();
    final product = Provider.of<ItemProviderORG>(context).favouriteItems;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Theme.of(context).primaryColorLight,
                  )),
              Text(
                AppLocalizations.of(context)!.favourite,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoB',
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
            ],
          ),
        ),
      ),
      body: product.length == 0
          ? Column(
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
            )
          : MediaQuery.of(context).size.width > websize
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.82,
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: product.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.9,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, i) => ChangeNotifierProvider.value(
                            value: product[i],
                            // child: CardItemsWeb(index: i),
                          )),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: product.length,
                  shrinkWrap: true,
                  itemBuilder: (context, i) => ChangeNotifierProvider.value(
                        value: product[i],
                        child: CardItemsMobile(index: i,islogin: true,isbasket: false,issure: false,),
                      )),
    );
  }
}
