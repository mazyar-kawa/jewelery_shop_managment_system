import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/items.dart';
import 'package:provider/provider.dart';

class HomeSmallCard extends StatelessWidget {
  const HomeSmallCard({
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
    final product = Provider.of<Items>(context);
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
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 0.5)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Size: ${product.size}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'RobotoB',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: InkWell(
                      onTap: () {
                        product.favorite();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: product.isFavorite
                            ? SvgPicture.asset(
                                'assets/images/heart-solid.svg',
                                color: Colors.red,
                              )
                            : SvgPicture.asset(
                                'assets/images/heart-regular.svg',
                                color: Theme.of(context).primaryColor,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 90,
              width: 90,
              child: Image.network(product.image),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'RobotoB',
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      '${product.price}\$',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'RobotoB',
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            Consumer<BasketItemProvider>(builder: (context, basket, _) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 31,
                width: 85,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () {
                    basket.addToBasket(
                        DateTime.now().toString(), product.id, 1);
                  },
                  child: Center(
                    child: Text(
                      'Add to Bag',
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
      ),
    );
  }
}
