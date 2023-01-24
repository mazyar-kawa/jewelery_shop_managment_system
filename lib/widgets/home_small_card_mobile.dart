import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/screens/signin_screen.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeSmallCardMobile extends StatefulWidget {
  HomeSmallCardMobile({
    Key? key,
    this.current,
    required this.islogin,
    required this.index,
  }) : super(key: key);

  int? current;
  final bool islogin;
  final int index;

  @override
  State<HomeSmallCardMobile> createState() => _HomeSmallCardMobileState();
}

class _HomeSmallCardMobileState extends State<HomeSmallCardMobile>
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
        AnimationController(vsync: this, duration: Duration(seconds: 1));
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
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<SingleItem>(context);
    final basket = Provider.of<BasketItemProvider>(context);
    return GestureDetector(
      onDoubleTap: () async {
        ApiProvider favourite = await Auth().FavouriteItem(product.id!);
        if (favourite.data != null) {
          setState(() {
            islike = true;
            startAnimation(product);
            product.isFavourited = true;
            showSnackBar(context, favourite.data['message'], false);
          });
        }
      },
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        opacity:
            widget.current == widget.index || widget.current == null ? 1 : 0.5,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).shadowColor,
                      blurRadius: 2,
                      offset: Offset(0, 2)),
                ],
                color: widget.index % 2 == 0
                    ? Theme.of(context).accentColor
                    : Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          widget.islogin == true
                              ? Align(
                                  alignment: Alignment.topRight,
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
                                  ),
                                )
                              : Container(
                                  height: 30,
                                  width: 30,
                                ),
                          Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.stretch, // add this
                              children: <Widget>[
                                ClipRRect(
                                    child: Image.network(product.img!,
                                        // width: 300,
                                        height: 100,
                                        fit: BoxFit.contain)),
                              ]),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                child: Text(
                                  product.name!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontFamily: 'RobotoB',
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  product.countryName!,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontFamily: 'RobotoM',
                                    fontSize: 16,
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
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              
                              Divider(),

                              Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Weight: ${product.weight!}',
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
                                          'Size: ${product.size!}',
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
                                          'Carat: ${product.caratMs!}',
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          '${product.price!.round()}\$',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColorLight,
                                            fontFamily: 'RobotoB',
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          if (widget.islogin ==
                                                        false) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  SignIn()));
                                                    }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(top: 10,left: 5,right: 5),
                                          alignment: Alignment.bottomCenter,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Theme.of(context).shadowColor,
                                                blurRadius: 2,
                                                spreadRadius: 1,
                                              )
                                            ]
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                              product.inBasket!?SvgPicture.asset("assets/images/check.svg",color: Theme.of(context).primaryColorLight,)  :SvgPicture.asset("assets/images/shop.svg",color: Theme.of(context).primaryColorLight,),
                                              product.inBasket!?Text('ADDED!',style: TextStyle(
                                                  color:
                                                      Theme.of(context).primaryColorLight,
                                                  fontFamily: 'RobotoB',
                                                  fontSize: 12,
                                                ),)  :Text('Add to basket',style: TextStyle(
                                                  color:
                                                      Theme.of(context).primaryColorLight,
                                                  fontFamily: 'RobotoB',
                                                  fontSize: 12,
                                                ),)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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


/*
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                child: Text(
                                  product.name!,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).primaryColorLight,
                                    fontFamily: 'RobotoB',
                                    fontSize: 18,
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
                              Divider(),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Mount: ${product.caratMs}',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontFamily: 'RobotoM',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        '${AppLocalizations.of(context)!.size}: ${product.size}',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontFamily: 'RobotoM',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        Theme.of(context).primaryColorLight,
                                  ),
                                  child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        basket.addToBasket(
                                            DateTime.now().toString(),
                                            product.id!,
                                            1);
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
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

*/
