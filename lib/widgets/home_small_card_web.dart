import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/items.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:provider/provider.dart';

class HomeSmallCardweb extends StatelessWidget {
  const HomeSmallCardweb({
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
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                offset: Offset(0, 3),
                blurRadius: 2,
              )
            ]),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.width < 1100
                  ? MediaQuery.of(context).size.height * 0.10
                  : MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                  color: Color(0xfff1f5f9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
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
                                  width: 20,
                                  color: Colors.red,
                                )
                              : SvgPicture.asset(
                                  'assets/images/heart-regular.svg',
                                  width: 18,
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
                        width: 120,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              width: double.infinity,
              height: MediaQuery.of(context).size.width < 1100
                  ? MediaQuery.of(context).size.height * 0.10
                  : MediaQuery.of(context).size.height * 0.14,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
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
                            fontSize: 18,
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
                            fontSize: 18,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'RobotoM',
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${product.price}\$',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontFamily: 'RobotoB',
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColorLight,
                        ),
                        child: Center(
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
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
