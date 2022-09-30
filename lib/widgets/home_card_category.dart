import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeCardCategory extends StatefulWidget {
  const HomeCardCategory({
    Key? key,
    required PageController pageController,
    required int current,
    required this.index,
    required this.login,
  })  : _pageController = pageController,
        _current = current,
        super(key: key);

  final PageController _pageController;
  final int _current;
  final int index;
  final bool login;

  @override
  State<HomeCardCategory> createState() => _HomeCardCategoryState();
}

class _HomeCardCategoryState extends State<HomeCardCategory>
    with TickerProviderStateMixin {
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..addStatusListener((status) {
            setState(() {
              if (status == AnimationStatus.completed) {
                twitter_favorite = false;
              } else {
                twitter_favorite = true;
              }
            });
          });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late AnimationController controller;

  bool twitter_favorite = false;

  favouriteAndUnFavourite(SingleItem product) async {
    if (product.isFavourited == true) {
      ApiProvider response =
          await Auth().UnFavouriteItem(product.id!) as ApiProvider;
      if (response.data != null) {
        setState(() {
          product.isFavourited = false;
          twitter_favorite = false;
          showSnackBar(context, response.data['message'], true);
        });
      }
    } else {
      ApiProvider response = await Auth().FavouriteItem(product.id!);
      if (response.data != null) {
        setState(() {
          product.isFavourited = true;
          twitter_favorite = true;
          controller.forward();
          showSnackBar(context, response.data['message'], false);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<SingleItem>(context);
    final basket = Provider.of<BasketItemProvider>(context);
    return AnimatedBuilder(
      animation: widget._pageController,
      builder: (context, child) {
        return AnimatedScale(
            curve: Curves.fastOutSlowIn,
            scale: widget._current == widget.index ? 1 : 0.8,
            duration: Duration(milliseconds: 500),
            child: child!);
      },
      child: Stack(
        children: [
          InkWell(
            onDoubleTap: () async {
              if (widget.login) {
                ApiProvider response = await Auth().FavouriteItem(product.id!);
                if (response.data != null) {
                  product.isFavourited = true;
                  twitter_favorite = true;
                  controller.forward();
                  showSnackBar(context, response.data['message'], false);
                }
              } else {}
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 2)
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        color: Theme.of(context).buttonColor,
                      ),
                      child: Column(
                        children: [
                          widget.login == true
                              ? Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius:
                                          BorderRadius.circular(10000),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context).shadowColor,
                                          blurRadius: 5,
                                          spreadRadius: 2,
                                          offset: Offset(1, 2),
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          favouriteAndUnFavourite(product);
                                        },
                                        child: product.isFavourited == true
                                            ? SvgPicture.asset(
                                                'assets/images/heart-solid.svg',
                                                width: 15,
                                                color: Colors.red,
                                              )
                                            : SvgPicture.asset(
                                                'assets/images/heart-regular.svg',
                                                width: 15,
                                                color: Colors.red,
                                              ),
                                      ),
                                    ),
                                  ),
                                )
                              : Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    height: 30,
                                    width: 30,
                                  )),
                          Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.stretch, // add this
                              children: <Widget>[
                                ClipRRect(
                                    child: Image.network(product.img!,
                                        // width: 300,
                                        height: 90,
                                        fit: BoxFit.contain)),
                              ]),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        color: widget.index % 2 == 0
                            ? Theme.of(context).accentColor
                            : Theme.of(context).primaryColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(right: 15, left: 10, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    product.name!,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontFamily: 'RobotoB',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    product.type!,
                                    style: TextStyle(
                                      color: product.type == 'GOLD'
                                          ? Color(0xffFFD700)
                                          : Color(0xffC0C0C0),
                                      fontFamily: 'RobotoM',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    'Mount: ${product.mount}',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontFamily: 'RobotoM',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '${AppLocalizations.of(context)!.size}: ${product.size}',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontFamily: 'RobotoM',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 10),
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
                                    DateTime.now().toString(), product.id!, 1);
                              },
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.addtobag,
                                  style: TextStyle(
                                    fontFamily: 'RobotoM',
                                    fontSize: 13,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          twitter_favorite
              ? Center(
                  child: Container(
                    child: LottieBuilder.asset(
                      controller: controller,
                      'assets/images/twitter-favorite-heart.json',
                      width: 550,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
