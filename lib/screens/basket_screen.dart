import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/item_provider_org.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:jewelery_shop_managmentsystem/widgets/card_items_mobile.dart';
import 'package:jewelery_shop_managmentsystem/widgets/card_items_web.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final basket = Provider.of<BasketItemProvider>(context).baskets;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: Container(
          padding: EdgeInsets.only(
              left: 15,
              right: 15,
              top: MediaQuery.of(context).size.width > websize ? 10 : 35),
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
                AppLocalizations.of(context)!.basket,
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
      body: basket.length == 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Center(
                          child: Text(
                        AppLocalizations.of(context)!.yourBasketisempty,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'RobotoB',
                          color: Theme.of(context).primaryColorLight,
                        ),
                      )),
                    ),
                    Container(
                      child: Center(
                        child: LottieBuilder.asset(
                          'assets/images/empty-box.json',
                          width: MediaQuery.of(context).size.width > websize
                              ? 650
                              : 350,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
          : MediaQuery.of(context).size.width > websize
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.82,
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: basket.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.9,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, i) {
                        final product = Provider.of<ItemProviderORG>(context)
                            .items
                            .where((element) => element.id == basket[i].idItem)
                            .toList();
                        for (var j = 0; j < product.length; j++) {
                          return ChangeNotifierProvider.value(
                            value: product[j],
                            child: CardItemsWeb(index: i),
                          );
                        }
                        return Container();
                      }),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: basket.length,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    final product = Provider.of<ItemProviderORG>(context)
                        .items
                        .where((element) => element.id == basket[i].idItem)
                        .toList();
                    for (var j = 0; j < product.length; j++) {
                      return ChangeNotifierProvider.value(
                        value: product[j],
                        child: CardItemsMobile(index: i),
                      );
                    }
                    return Container();
                  }),
    );
  }
}
