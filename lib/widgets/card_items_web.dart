import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/items.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardItemsWeb extends StatefulWidget {
  const CardItemsWeb({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<CardItemsWeb> createState() => _CardItemsWebState();
}

class _CardItemsWebState extends State<CardItemsWeb> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Items>(context, listen: false);
    final basket = Provider.of<BasketItemProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width < 800
                ? MediaQuery.of(context).size.height * 0.1
                : MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              color: Color(0xfff1f5f9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Consumer<Items>(builder: (context, products, _) {
                      return InkWell(
                        onTap: () {
                          products.favorite();
                        },
                        child: products.isFavorite
                            ? SvgPicture.asset(
                                'assets/images/heart-solid.svg',
                                width: 25,
                                color: Colors.red,
                              )
                            : SvgPicture.asset(
                                'assets/images/heart-regular.svg',
                                width: 25,
                              ),
                      );
                    }),
                  ),
                ),
                Center(
                  child: Container(
                    child: Image(
                      image: AssetImage(product.image),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width < 800 ? 80 : 180,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            height: MediaQuery.of(context).size.width < 800
                ? MediaQuery.of(context).size.height * 0.05
                : MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        product.name,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontFamily: 'RobotoB',
                          fontSize:
                              MediaQuery.of(context).size.width < 800 ? 15 : 20,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        product.puring,
                        style: TextStyle(
                          color: product.puring == 'Gold'
                              ? Color(0xffFFD700)
                              : Color(0xffC0C0C0),
                          fontFamily: 'RobotoM',
                          fontSize:
                              MediaQuery.of(context).size.width < 800 ? 15 : 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'Price:',
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'RobotoM',
                              fontSize: MediaQuery.of(context).size.width < 800
                                  ? 10
                                  : 16,
                            ),
                          ),
                          Text(
                            '${product.price}\$',
                            style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontFamily: 'RobotoB',
                              fontSize: MediaQuery.of(context).size.width < 800
                                  ? 14
                                  : 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width < 800 ? 25 : 45,
                      width: MediaQuery.of(context).size.width < 800 ? 25 : 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width < 800 ? 2 : 10),
                        color: Theme.of(context).primaryColorLight,
                      ),
                      child: InkWell(
                        onTap: () {
                          basket.addToBasket(
                              DateTime.now().toString(), product.id, 1);
                        },
                        child: Text(
                          '+',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width < 800
                                ? 15
                                : 30,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
