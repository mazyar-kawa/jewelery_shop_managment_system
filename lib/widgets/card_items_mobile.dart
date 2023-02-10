import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:jewelery_shop_managmentsystem/model/basket_model.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/home_items_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/item_provider_org.dart';
import 'package:jewelery_shop_managmentsystem/screens/item_details.dart';
import 'package:jewelery_shop_managmentsystem/screens/signin_screen.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CardItemsMobile extends StatefulWidget {
  ValueChanged<int>? onChanged;
  CardItemsMobile({
    Key? key,
    required this.index,
    required this.isbasket,
    required this.issure,
  }) : super(key: key);

  final int index;
  final bool isbasket;
  final bool issure;

  @override
  State<CardItemsMobile> createState() => _CardItemsMobileState();
}

class _CardItemsMobileState extends State<CardItemsMobile>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  bool islike = false;
  bool ischecked = false;

  favouriteAndUnFavourite(SingleItem product) async {
    if (product.isFavourited == true) {
      ApiProvider unFavourite = await Auth().UnFavouriteItem(product.id!);
      if (unFavourite.data != null) {
        setState(() {
          product.isFavourited = false;
          showSnackBar(context, unFavourite.data['message'], true);
          Provider.of<ItemProviderORG>(context, listen: false)
              .getFavouriteItem();
          Provider.of<HomeItemsProvider>(context, listen: false)
              .getAllItemHome();
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

  addAndRemoveItemToBasket(item) async {
    widget.isbasket == true ? item as ItemBasket : item as SingleItem;
    if (item.inBasket == true) {
      ApiProvider removeItem =
          await BasketItemProvider().removeToBasket(item.id!);
      if (removeItem.data != null) {
        setState(() {
          item.inBasket = false;
          showSnackBar(context, removeItem.data['message'], true);
        });
      }
    } else {
      ApiProvider addItem = await BasketItemProvider().addToBasket(item.id!);
      if (addItem.data != null) {
        setState(() {
          item.inBasket = true;
          showSnackBar(context, addItem.data['message'], false);
        });
      }
    }
    await Provider.of<BasketItemProvider>(context, listen: false)
        .getItemBasket();
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

  additemReady(ItemBasket itemBasket, bool checked) {
    final provider = Provider.of<BasketItemProvider>(context, listen: false);
    if (checked == true) {
      provider.addItemReady(itemBasket);
    } else {
      provider.removeItemReady(itemBasket);
    }
  }

  @override
  Widget build(BuildContext context) {
    final islogin = Provider.of<Checkuser>(context).islogin;
    final product;
    if (widget.isbasket == true) {
      product = Provider.of<ItemBasket>(context);
    } else {
      product = Provider.of<SingleItem>(context);
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetails(item_id: product.id!),
            ));
      },
      onDoubleTap: () async {
        if (islogin != false && widget.isbasket == false) {
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
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          width: MediaQuery.of(context).size.width,
          height: 170,
          decoration: BoxDecoration(
            // color: widget.index % 2 == 0
            //     ? Theme.of(context).accentColor
            //     : Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: widget.isbasket
                                ? Checkbox(
                                    checkColor: Theme.of(context).scaffoldBackgroundColor,
                                    fillColor: MaterialStateProperty.all(
                                        Theme.of(context).primaryColorLight),
                                    value: ischecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        ischecked = value!;
                                        additemReady(product, ischecked);
                                      });
                                    },
                                  )
                                : islogin
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
                                              color:
                                                  Theme.of(context).shadowColor,
                                              blurRadius: 5,
                                              spreadRadius: 2,
                                              offset: Offset(1, 2),
                                            )
                                          ],
                                        ),
                                        child: Center(
                                          child: InkWell(
                                              onTap: () {
                                                favouriteAndUnFavourite(
                                                    product);
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
                                          color: Theme.of(context)
                                              .secondaryHeaderColor,
                                          borderRadius:
                                              BorderRadius.circular(10000),
                                        ),
                                      ),
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                AspectRatio(
                                    aspectRatio: 1.8,
                                    child: Image.network(product.img!,
                                        fit: BoxFit.contain)),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: product.caratType == 'gold'
                                        ? Color(0xffFFD700).withOpacity(0.1)
                                        : Color(0xffC0C0C0).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${product.caratType!} ${product.caratMs!}',
                                      style: TextStyle(
                                        color: product.caratType == 'gold'
                                            ? Color(0xffFFD700)
                                            : Color(0xFFA3A3A3),
                                        fontFamily: 'RobotoM',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
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
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).shadowColor,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              margin:
                                  EdgeInsets.only(right: 15, left: 10, top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
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
                                      widget.isbasket
                                          ? Container(
                                              child: Row(
                                                children: [
                                                  Text('${product.quantity}'),
                                                  Icon(Icons.close, size: 16),
                                                ],
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
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
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      children: [
                                        Icon(FontAwesome5.balance_scale,
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            size: 15),
                                        Text(
                                          '  ${product.weight!}g',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            fontFamily: 'RobotoM',
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right: 15, left: 10, top: 5, bottom: 5),
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    '\$ ${product.price!.round()}',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontFamily: 'RobotoB',
                                      fontSize: 18,
                                    ),
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
                                    child: widget.isbasket
                                        ? InkWell(
                                            onTap: () {
                                                addAndRemoveItemToBasket(
                                                    product);
                                                Provider.of<HomeItemsProvider>(
                                                        context,
                                                        listen: false)
                                                    .getAllItemHome();
                                              
                                            },
                                            child: Icon(
                                              FontAwesome5.trash,
                                              size: 20,
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                            ))
                                        : InkWell(
                                            onTap: () {
                                              if (islogin == false) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            SignIn()));
                                              } else {
                                                addAndRemoveItemToBasket(
                                                    product);
                                              }
                                            },
                                            child: product.inBasket!
                                                ? SvgPicture.asset(
                                                    "assets/images/check.svg",
                                                    color: Colors.green,
                                                  )
                                                : SvgPicture.asset(
                                                    "assets/images/basket-shopping-solid.svg",
                                                    width: 20,
                                                    color: Theme.of(context).secondaryHeaderColor,
                                                  ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              islike
                  ? Container(
                      child: Lottie.asset(
                        controller: animationController,
                        'assets/images/twitter-favorite-heart.json',
                        width: 450,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
