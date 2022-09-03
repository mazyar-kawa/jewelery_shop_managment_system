import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/items.dart';
import 'package:jewelery_shop_managmentsystem/provider/items_provider.dart';
import 'package:jewelery_shop_managmentsystem/widgets/card_items.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

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
          padding: const EdgeInsets.only(left: 25, right: 15, top: 60),
          child: Text(
            'Basket',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoB',
              color: Theme.of(context).primaryColor,
            ),
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
                        'Your Basket is empty',
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
              itemCount: basket.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                final product = Provider.of<ItemProvider>(context)
                    .items
                    .where((element) => element.id == basket[i].idItem)
                    .toList();
                for (var j = 0; j < product.length; j++) {
                  return ChangeNotifierProvider.value(
                    value: product[j],
                    child: CardItems(index: i),
                  );
                }
                return Container();
              }),
    );
  }
}
