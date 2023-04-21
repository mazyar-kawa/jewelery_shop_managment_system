import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/screens/item_details.dart';
import 'package:jewelery_shop_managmentsystem/screens/signin_screen.dart';
import 'package:jewelery_shop_managmentsystem/service/Basket_item_service.dart';
import 'package:jewelery_shop_managmentsystem/service/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_service.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeSmallCard extends StatefulWidget {
  HomeSmallCard({
    Key? key,
    this.current,
    required this.index,
  }) : super(key: key);

  int? current;
  final int index;

  @override
  State<HomeSmallCard> createState() => _HomeSmallCardState();
}

class _HomeSmallCardState extends State<HomeSmallCard>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  bool islike = false;

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
    final islogin = Provider.of<Checkuser>(context).islogin;
    final product = Provider.of<SingleItem>(context);
    final basket = Provider.of<BasketItemService>(context);
    return Consumer<SingleItem>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetails(item_id: product.id!),
                ));
          },
          onDoubleTap: () async {
            if (islogin != false) {
              ApiProvider response =
                  await value.FavouriteAndUnfavouriteItem(product.id!, context);
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
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: widget.current == widget.index || widget.current == null
                ? 1
                : 0.5,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        blurRadius: 2,
                        spreadRadius: 1.5,
                      ),
                    ],
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            padding: const EdgeInsets.all(5),
                            height: 25,
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
                          islogin
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
                                        color: Theme.of(context).shadowColor,
                                        blurRadius: 3,
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
                                                  product.id!, context);
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
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    borderRadius: BorderRadius.circular(10000),
                                  ),
                                ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          child: Image.network(
                           "http://192.168.1.32:8000" + product.img!,
                            height: 100,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: new Container(
                                padding: new EdgeInsets.only(right: 13.0),
                                child: new Text(
                                  product.name!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontFamily: 'RobotoB',
                                    fontSize: 18,
                                  ),
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
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
                                  Container(
                                    child: Text(
                                      '\$${product.price!.round()}',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontFamily: 'RobotoB',
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                      InkWell(
                        onTap: () async {
                          if (islogin == false) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => SignIn()));
                          } else {
                            ApiProvider response = await value
                                .basketAndUnbasketItems(product.id!, context);
                            if (response.data != null) {
                              showSnackBar(
                                  context,
                                  response.data['message'],
                                  response.data['message'].contains("Added")
                                      ? false
                                      : true);
                            }
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: Container(
                            height: 40,
                            width: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  child: product.inBasket!
                                      ? SvgPicture.asset(
                                          "assets/images/check.svg",
                                          color: Colors.green,
                                        )
                                      : SvgPicture.asset(
                                          "assets/images/basket-shopping-solid.svg",
                                          width: 20,
                                          color: Theme.of(context)
                                              .secondaryHeaderColor),
                                ),
                                Container(
                                  child: Text(
                                    product.inBasket! ? AppLocalizations.of(context)!.added :  AppLocalizations.of(context)!.addtocart,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontFamily: 'RobotoM',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
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
      },
    );
  }
}
