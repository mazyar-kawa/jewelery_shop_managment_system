import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeSmallCardMobile extends StatefulWidget {
  const HomeSmallCardMobile({
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
  State<HomeSmallCardMobile> createState() => _HomeSmallCardMobileState();
}

class _HomeSmallCardMobileState extends State<HomeSmallCardMobile>
    with TickerProviderStateMixin {
  late AnimationController controller;

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

  bool twitter_favorite = false;

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
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        opacity: widget._current == widget.index ? 1 : 0.5,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 2)
            ],
            color: widget.index % 2 == 0
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Flexible(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(10000),
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
                                onTap: () {},
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
                                      )),
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
                                    height: 100,
                                    fit: BoxFit.contain)),
                          ]),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 2,
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
                                color: Theme.of(context).primaryColorLight,
                                fontFamily: 'RobotoB',
                                fontSize: 18,
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
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    'Mount: ${product.mount}',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontFamily: 'RobotoM',
                                      fontSize: 14,
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
                                color: Theme.of(context).primaryColorLight,
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
      ),
    );
  }
}
// child: Stack(
//           children: [
//             InkWell(
//               // onDoubleTap: () {
//               //   product.favorite();
//               //   if (product.isFavorite && twitter_favorite == false) {
//               //     twitter_favorite = true;
//               //     controller.forward();
//               //   }
//               // },
//               child: Container(
//                 margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//                 decoration: BoxDecoration(
//                     color: Theme.of(context).scaffoldBackgroundColor,
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Theme.of(context).shadowColor,
//                         offset: Offset(0, 3),
//                         blurRadius: 2,
//                       )
//                     ]),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: MediaQuery.of(context).size.height * 0.2,
//                       decoration: BoxDecoration(
//                           color: Color(0xfff1f5f9),
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(15),
//                             topRight: Radius.circular(15),
//                           )),
//                       child: Stack(
//                         children: [
//                           Positioned(
//                             top: 10,
//                             right: 10,
//                             child: Container(
//                               alignment: Alignment.topRight,
//                               // child: Consumer<Items>(
//                               //     builder: (context, products, _) {
//                               //   return InkWell(
//                               //     onTap: () {
//                               //       products.favorite();
//                               //       if (products.isFavorite &&
//                               //           twitter_favorite == false) {
//                               //         twitter_favorite = true;
//                               //         controller.forward();
//                               //       } else if (products.isFavorite == false &&
//                               //           twitter_favorite == true) {
//                               //         twitter_favorite = false;
//                               //       }
//                               //     },
//                               //     child: products.isFavorite
//                               //         ? SvgPicture.asset(
//                               //             'assets/images/heart-solid.svg',
//                               //             width: 20,
//                               //             color: Colors.red,
//                               //           )
//                               //         : SvgPicture.asset(
//                               //             'assets/images/heart-regular.svg',
//                               //             width: 18,
//                               //           ),
//                               //   );
//                               // }),
//                             ),
//                           ),
//                           Center(
//                             child: Container(
//                               child: Image(
//                                 image: NetworkImage(product.img!),
//                                 fit: BoxFit.cover,
//                                 width: 120,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                       width: double.infinity,
//                       height: MediaQuery.of(context).size.height * 0.13,
//                       decoration: BoxDecoration(
//                           color: Theme.of(context).scaffoldBackgroundColor,
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(15),
//                             bottomRight: Radius.circular(15),
//                           )),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 child: Text(
//                                   product.name!,
//                                   style: TextStyle(
//                                     color: Theme.of(context).primaryColorLight,
//                                     fontFamily: 'RobotoB',
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                               ),
//                               // Container(
//                               //   child: Text(
//                               //     product.puring,
//                               //     style: TextStyle(
//                               //       color: product.puring == 'Gold'
//                               //           ? Color(0xffFFD700)
//                               //           : Color(0xffC0C0C0),
//                               //       fontFamily: 'RobotoM',
//                               //       fontSize: 18,
//                               //     ),
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Mount:',
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontFamily: 'RobotoM',
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     Text(
//                                       '${product.mount}',
//                                       style: TextStyle(
//                                         color:
//                                             Theme.of(context).primaryColorLight,
//                                         fontFamily: 'RobotoB',
//                                         fontSize: 22,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 height: 35,
//                                 width: 35,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Theme.of(context).primaryColorLight,
//                                 ),
//                                 child: Center(
//                                   child: InkWell(
//                                     onTap: () {
//                                       basket.addToBasket(
//                                           DateTime.now().toString(),
//                                           product.id!,
//                                           1);
//                                     },
//                                     child: Text(
//                                       '+',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 25,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             twitter_favorite
//                 ? Center(
//                     child: Container(
//                       child: LottieBuilder.asset(
//                         controller: controller,
//                         'assets/images/twitter-favorite-heart.json',
//                         width: 550,
//                       ),
//                     ),
//                   )
//                 : Container(),
//           ],
//         ),