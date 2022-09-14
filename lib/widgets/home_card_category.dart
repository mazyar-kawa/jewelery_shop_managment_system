import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/items.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeCardCategory extends StatelessWidget {
  const HomeCardCategory({
    Key? key,
    required PageController pageController,
    required int current,
    required this.index,
  })  : _pageController = pageController,
        _current = current,
        super(key: key);

  final PageController _pageController;
  final int _current;
  final int index;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Items>(context, listen: false);
    final basket = Provider.of<BasketItemProvider>(context);
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        return AnimatedScale(
            curve: Curves.fastOutSlowIn,
            scale: _current == index ? 1 : 0.8,
            duration: Duration(milliseconds: 500),
            child: child!);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: index % 2 == 0
              ? Theme.of(context).accentColor
              : Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10000),
                  ),
                  child: Consumer<Items>(builder: (context, product, _) {
                    return Center(
                      child: InkWell(
                        onTap: () {
                          product.favorite();
                        },
                        child: product.isFavorite
                            ? SvgPicture.asset(
                                'assets/images/heart-solid.svg',
                                width: 20,
                                color: Colors.red,
                              )
                            : SvgPicture.asset(
                                'assets/images/heart-regular.svg',
                                width: 20,
                                color: Colors.black,
                              ),
                      ),
                    );
                  }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
                            color: index % 2 == 0
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
                )
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
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
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
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
