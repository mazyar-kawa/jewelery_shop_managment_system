import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:jewelery_shop_managmentsystem/model/basket_model.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/screens/item_details.dart';
import 'package:jewelery_shop_managmentsystem/screens/signin_screen.dart';
import 'package:jewelery_shop_managmentsystem/service/Basket_item_service.dart';
import 'package:jewelery_shop_managmentsystem/service/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_service.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CardItems extends StatefulWidget {
  ValueChanged<int>? onChanged;
  CardItems({
    Key? key,
    required this.index,
    required this.isbasket,
  }) : super(key: key);

  final int index;
  final bool isbasket;

  @override
  State<CardItems> createState() => _CardItemsState();
}

class _CardItemsState extends State<CardItems>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  bool islike = false;

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
    final provider = Provider.of<BasketItemService>(context, listen: false);
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
      product = Provider.of<ItemBasket>(context, listen: false);
    } else {
      product = Provider.of<SingleItem>(context, listen: false);
    }

  
    return Consumer<SingleItem>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetails(
                    item_id: product.id,
                  ),
                ));
          },
          onDoubleTap: () async {
            if (islogin != false && widget.isbasket == false) {
              ApiProvider response =
                  await value.FavouriteAndUnfavouriteItem(product.id, context);
              if (response.data != null) {
                setState(() {
                  islike = true;
                  startAnimation(product);
                });
                showSnackBar(context, response.data['message'],
                    response.data['message'].contains("added") ? false : true);
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
                                child: islogin
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                           borderRadius: BorderRadius.circular(10000),
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
                                              onTap: () async {
                                                ApiProvider response = await value
                                                    .FavouriteAndUnfavouriteItem(
                                                        product.id, context);
                                                if (response.data != null) {
                                                  showSnackBar(
                                                      context,
                                                      response.data['message'],
                                                      response.data['message']
                                                              .contains("added")
                                                          ? false
                                                          : true);
                                                }
                                              },
                                              child: value.isFavourited!
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
                                          borderRadius: BorderRadius.circular(10000),
                                        ),
                                      ),
                              ),
                              Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    AspectRatio(
                                        aspectRatio: 1.8,
                                        child: Image.network(
                                        "http://192.168.1.32:8000" + product.img!,
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
                                            : Color(0xffC0C0C0)
                                                .withOpacity(0.1),
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
                              Container(
                                child: Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: 15,
                                              left: 10,
                                              top: 5,
                                              bottom: 5),
                                          padding: EdgeInsets.only(right: 13.0),
                                          child: Text(
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
                                        margin: EdgeInsets.only(
                                            right: 15,
                                            left: 10,
                                            top: 5,
                                            bottom: 5),
                                        child: Text(
                                          product.countryName!,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            fontFamily: 'RobotoM',
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              right: 15,
                                              left: 10,
                                              top: 5,
                                              bottom: 5),
                                          child: Row(children: [
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
                                          ])),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: 15, left: 10, top: 5, bottom: 5),
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        '\$ ${product.price!.round()}',
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
                                         borderRadius: BorderRadius.circular(10),
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                      child: Center(
                                        child: InkWell(
                                          onTap: () async {
                                            if (islogin == false) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          SignIn()));
                                            } else {
                                              ApiProvider response = await value
                                                  .basketAndUnbasketItems(
                                                      product.id, context);
                                              if (response.data != null) {
                                                showSnackBar(
                                                    context,
                                                    response.data['message'],
                                                    response.data['message']
                                                            .contains("Added")
                                                        ? false
                                                        : true);
                                              }
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
                                                  color: Theme.of(context)
                                                      .secondaryHeaderColor,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
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
      },
    );
  }
}
