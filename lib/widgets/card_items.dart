import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/provider/items.dart';
import 'package:provider/provider.dart';

class CardItems extends StatefulWidget {
  const CardItems({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<CardItems> createState() => _CardItemsState();
}

class _CardItemsState extends State<CardItems> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Items>(context, listen: false);
    return Container(
      width: double.infinity,
      height: 180,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: widget.index % 2 == 0 ? Color(0xffFFDAD9) : Color(0xffDBE5E7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10000),
                ),
                child: Consumer<Items>(builder: (context, products, _) {
                  return Center(
                    child: InkWell(
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
                              width: 20,
                            ),
                    ),
                  );
                }),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Stack(
                  children: [
                    Transform.rotate(
                      angle: -5,
                      child: Container(
                        margin: EdgeInsets.only(right: 0, top: 15),
                        width: 110,
                        height: 80,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 2,
                                  offset: Offset(2, -5))
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: widget.index % 2 == 0
                                ? Color(0xffFFDAD9)
                                : Color(0xffDBE5E7)),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Image(
                          image: NetworkImage(product.image),
                          width: 110,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'RobotoB',
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Size: ${product.size}',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontFamily: 'RobotoM',
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    product.nameCategory,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'RobotoB',
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    product.puring,
                    style: TextStyle(
                      color: product.puring == 'Gold'
                          ? Color(0xffFFD700)
                          : Color(0xffC0C0C0),
                      fontFamily: 'RobotoM',
                      fontSize: 20,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      '${product.price}\$',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'RobotoB',
                        fontSize: 22,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    height: 31,
                    width: 85,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
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
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
