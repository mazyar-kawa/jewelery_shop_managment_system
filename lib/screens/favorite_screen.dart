import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/provider/items_provider.dart';
import 'package:jewelery_shop_managmentsystem/widgets/card_items.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ItemProvider>(context).favorite;
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
                    color: Theme.of(context).primaryColor,
                  )),
              Text(
                AppLocalizations.of(context)!.favourite,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoB',
                  color: Theme.of(context).primaryColor,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Center(
                          child: Text(
                        AppLocalizations.of(context)!.yourFavouriteisempty,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'RobotoB',
                          color: Theme.of(context).primaryColor,
                        ),
                      )),
                    ),
                    Container(
                      child: Center(
                        child: LottieBuilder.asset(
                          'assets/images/empty-box.json',
                          width: 350,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: product.length,
              shrinkWrap: true,
              itemBuilder: (context, i) => ChangeNotifierProvider.value(
                    value: product[i],
                    child: CardItems(index: i),
                  )),
    );
  }
}
