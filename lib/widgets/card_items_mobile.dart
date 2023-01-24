import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/screens/signin_screen.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardItemsMobile extends StatefulWidget {
  const CardItemsMobile({Key? key, required this.index, required this.islogin})
      : super(key: key);

  final int index;
  final bool islogin;

  @override
  State<CardItemsMobile> createState() => _CardItemsMobileState();
}

class _CardItemsMobileState extends State<CardItemsMobile>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  bool islike = false;

  favouriteAndUnFavourite(SingleItem product) async {
    if (product.isFavourited == true) {
      ApiProvider unFavourite = await Auth().UnFavouriteItem(product.id!);
      if (unFavourite.data != null) {
        setState(() {
          product.isFavourited = false;
          showSnackBar(context, unFavourite.data['message'], true);
        });
      }
    } else {
      ApiProvider favourite = await Auth().FavouriteItem(product.id!);
      if (favourite.data != null) {
        setState(() {
          islike = true;
          startAnimation(product);
          product.isFavourited = true;
          showSnackBar(context, favourite.data['message'], false);
        });
      }
    }
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    super.initState();
  }

  startAnimation(SingleItem product) async {
    if (product.isFavourited == true || islike == true) {
      await animationController.forward();
      await Future.delayed(
        Duration(milliseconds: 150),
        () {
          if (animationController.isCompleted) {
            setState(() {
              islike = false;
              animationController.reverse();
            });
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<SingleItem>(context);
    return GestureDetector(
      onDoubleTap: () async {
        if (widget.islogin != false) {
          ApiProvider favourite = await Auth().FavouriteItem(product.id!);
          if (favourite.data != null) {
            setState(() {
              islike = true;
              startAnimation(product);
              product.isFavourited = true;
              showSnackBar(context, favourite.data['message'], false);
            });
          }
        } else {
          return;
        }
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              width: MediaQuery.of(context).size.width,
              height: 180,
              decoration: BoxDecoration(
                color: widget.index % 2 == 0
                    ? Theme.of(context).accentColor
                    : Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: widget.islogin
                                ? Container(
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
                                          color: Colors.white,
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
                                          child: product.isFavourited!
                                              ? SvgPicture.asset(
                                                  'assets/images/heart-solid.svg',
                                                  width: 15,
                                                  color: Colors.red,
                                                )
                                              : SvgPicture.asset(
                                                  'assets/images/heart-regular.svg',
                                                  width: 15,
                                                  color: Colors.red,
                                                )),
                                    ),
                                  )
                                : Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10000),
                                    ),
                                  ),
                          ),
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
                  Expanded(
                    flex: 3,
                    child: Container(
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
                        children: [
                          Flexible(
                            child: Container(
                              margin:
                                  EdgeInsets.only(right: 15, left: 10, top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: new Container(
                                      padding: new EdgeInsets.only(right: 13.0),
                                      child: new Text(
                                        product.name!,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontFamily: 'RobotoB',
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      product.caratType!,
                                      style: TextStyle(
                                        color: product.caratType == 'GOLD'
                                            ? Color(0xffFFD700)
                                            : Color(0xffC0C0C0),
                                        fontFamily: 'RobotoM',
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      product.countryName!,
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontFamily: 'RobotoM',
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Weight: ${product.weight!}',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            fontFamily: 'RobotoM',
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          'Size: ${product.size!}',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            fontFamily: 'RobotoM',
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          'Carat: ${product.caratMs!}',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            fontFamily: 'RobotoM',
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Text(
                                                'Price: ${product.price!.round()}\$',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                  fontFamily: 'RobotoB',
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                              ),
                                              child: Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    // basket.addToBasket(
                                                    //     DateTime.now().toString(),
                                                    //     product.id!,
                                                    //     1);
                                                    if (widget.islogin ==
                                                        false) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  SignIn()));
                                                    }
                                                  },
                                                  child: product.inBasket!
                                                      ? SvgPicture.asset(
                                                          "assets/images/check.svg",
                                                          color: Colors.white,
                                                        )
                                                      : SvgPicture.asset(
                                                          "assets/images/shop.svg",
                                                          color: Colors.white,
                                                        ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
            islike
                ? Center(
                    child: Container(
                      child: Lottie.asset(
                        controller: animationController,
                        'assets/images/twitter-favorite-heart.json',
                        width: 550,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
