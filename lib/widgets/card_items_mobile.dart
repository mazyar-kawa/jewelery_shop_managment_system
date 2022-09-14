import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/items.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardItemsMobile extends StatefulWidget {
  const CardItemsMobile({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<CardItemsMobile> createState() => _CardItemsMobileState();
}

class _CardItemsMobileState extends State<CardItemsMobile> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Items>(context, listen: false);
    return Container(
      width: double.infinity,
      height: 180,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: widget.index % 2 == 0
            ? Theme.of(context).accentColor
            : Theme.of(context).primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10000),
                ),
                child: Consumer<Items>(builder: (context, products, _) {
                  return Center(
                    child: InkWell(
                      onTap: () {
                        products.favorite();
                      },
                      child: products.isFavorite
                          ? SvgPicture.asset(
                              'assets/images/heart-solid.svg',
                              width: 20,
                              color: Colors.red,
                            )
                          : SvgPicture.asset(
                              'assets/images/heart-regular.svg',
                              width: 18,
                            ),
                    ),
                  );
                }),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Stack(
                  children: [
                    Transform.rotate(
                      angle: -5,
                      child: Container(
                        margin: EdgeInsets.only(right: 0, top: 15),
                        width: 110,
                        height: 80,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 2,
                                offset: Offset(2, -5))
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: widget.index % 2 == 0
                              ? Theme.of(context).secondaryHeaderColor
                              : Theme.of(context).backgroundColor,
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Image(
                          image: AssetImage(product.image),
                          width: 110,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontFamily: 'RobotoB',
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${AppLocalizations.of(context)!.size}: ${product.size}',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontFamily: 'RobotoM',
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    product.nameCategory,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontFamily: 'RobotoB',
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    product.puring,
                    style: TextStyle(
                      color: product.puring == 'Gold'
                          ? Color(0xffFFD700)
                          : Color(0xffC0C0C0),
                      fontFamily: 'RobotoM',
                      fontSize: 20,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      '${product.price}\$',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontFamily: 'RobotoB',
                        fontSize: 22,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Consumer<BasketItemProvider>(builder: (context, basket, _) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      height: 31,
                      width: 95,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        onTap: () {
                          basket.addToBasket(
                              DateTime.now().toString(), product.id, 1);
                        },
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.addtobag,
                            style: TextStyle(
                              fontFamily: 'RobotoM',
                              fontSize: 13,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
