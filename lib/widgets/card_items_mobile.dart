import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardItemsMobile extends StatefulWidget {
  const CardItemsMobile({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<CardItemsMobile> createState() => _CardItemsMobileState();
}

class _CardItemsMobileState extends State<CardItemsMobile> {
  @override
  Widget build(BuildContext context) {
    // final product = Provider.of<Items>(context, listen: false);
    final product = Provider.of<SingleItem>(context);
    return Container(
      width: double.infinity,
      height: 180,
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
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
                  Align(
                    alignment: Alignment.topLeft,
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
          Flexible(
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 15, left: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            product.name!,
                            style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
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
                              color: Theme.of(context).primaryColorLight,
                              fontFamily: 'RobotoM',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            '${AppLocalizations.of(context)!.size}: ${product.size}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
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
                        // basket.addToBasket(
                        //     DateTime.now().toString(), product.id!, 1);
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
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
