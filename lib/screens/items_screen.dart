import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/provider/Basket_item_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/items_provider.dart';
import 'package:jewelery_shop_managmentsystem/widgets/card_items.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemsScreen extends StatefulWidget {
  static const routname = "/items";
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen>
    with TickerProviderStateMixin {
  final boredrUser = OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffE9E9E9), width: 2),
    borderRadius: BorderRadius.circular(15),
  );

  RangeValues rangePrice = const RangeValues(100, 6000);
  bool isfilter = false;
  bool istype = true;
  bool isSize = true;
  bool isPrice = true;
  int sizevalue = 4;
  int _selectedTypeIndex = 0;

  AnimationController? controller;
  Animation<double>? animation;

  void openFilter() {
    setState(() {
      isfilter = !isfilter;
    });
    if (isfilter) {
      controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: 1000));
      controller!.forward();
      animation = CurvedAnimation(parent: controller!, curve: Curves.easeIn)
        ..addListener(() {
          setState(() {});
        });
    } else {
      controller!.reset();
    }
  }

  int _current = 2;

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final CategoryId = ModalRoute.of(context)!.settings.arguments as int;
    final products = Provider.of<ItemProvider>(context)
        .item
        .where((element) => element.idCategory == CategoryId)
        .toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Theme.of(context).primaryColor,
                      )),
                  Text(
                    AppLocalizations.of(context)!.items,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoB',
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).primaryColor,
                ),
                child: Stack(
                  children: [
                    Container(
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/basket-shopping-solid.svg',
                          width: 25,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      height: 18,
                      width: 18,
                      child: Consumer<BasketItemProvider>(
                          builder: (context, basket, child) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              color: Theme.of(context).scaffoldBackgroundColor),
                          child: Center(
                            child: Text(
                                basket.countItem() > 9
                                    ? '9+'
                                    : '${basket.countItem()}',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: products.length == 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Center(
                          child: Text(
                        AppLocalizations.of(context)!.thisCategoryisempty,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'RobotoB',
                          color: Theme.of(context).primaryColor,
                        ),
                      )),
                    ),
                    Container(
                      child: Center(
                        child: LottieBuilder.asset(
                          'assets/images/empty-box.json',
                          width: 350,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 95),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          height: isfilter
                              ? MediaQuery.of(context).size.height *
                                  animation!.value *
                                  0.45
                              : MediaQuery.of(context).size.height * 0.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffECF1F4),
                          ),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Categories',
                                        style: TextStyle(
                                          fontFamily: 'RobotoB',
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: istype
                                          ? IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  istype = false;
                                                });
                                              },
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                size: 28,
                                              ))
                                          : IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  istype = true;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 18,
                                              )),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: istype
                                    ? MediaQuery.of(context).size.height * 0.085
                                    : 0,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  child: Row(
                                    children: [
                                      categoryHorizontal(context, 'All', 0),
                                      categoryHorizontal(context, 'Rings', 1),
                                      categoryHorizontal(
                                          context, 'Necklaces', 2),
                                      categoryHorizontal(
                                          context, 'Earrings', 3),
                                      categoryHorizontal(context, 'Gold', 4),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Size: ${sizevalue}',
                                        style: TextStyle(
                                          fontFamily: 'RobotoB',
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: isSize
                                          ? IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  isSize = false;
                                                });
                                              },
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                size: 28,
                                              ))
                                          : IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  isSize = true;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 18,
                                              )),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: isSize
                                    ? MediaQuery.of(context).size.height * 0.075
                                    : 0,
                                child: isSize
                                    ? Slider(
                                        min: 4.0,
                                        max: 30.0,
                                        label: sizevalue.round().toString(),
                                        divisions: 26,
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        inactiveColor: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.3),
                                        value: sizevalue.toDouble(),
                                        onChanged: (double value) {
                                          setState(() {
                                            sizevalue = value.round();
                                          });
                                        })
                                    : null,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Price: ${rangePrice.start.toStringAsFixed(1)} to ${rangePrice.end.toStringAsFixed(1)}',
                                        style: TextStyle(
                                          fontFamily: 'RobotoB',
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: isPrice
                                          ? IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  isPrice = false;
                                                });
                                              },
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                size: 28,
                                              ))
                                          : IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  isPrice = true;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 18,
                                              )),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: isPrice
                                    ? MediaQuery.of(context).size.height * 0.075
                                    : 0,
                                child: isPrice
                                    ? RangeSlider(
                                        values: rangePrice,
                                        min: 100,
                                        max: 6000,
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        inactiveColor: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.3),
                                        labels: RangeLabels(
                                          rangePrice.start.toStringAsFixed(2),
                                          rangePrice.end.toStringAsFixed(2),
                                        ),
                                        onChanged: (RangeValues values) {
                                          setState(() {
                                            rangePrice = values;
                                          });
                                        },
                                      )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            border: boredrUser,
                            enabledBorder: boredrUser,
                            disabledBorder: boredrUser,
                            hintText:
                                '${AppLocalizations.of(context)!.search}...',
                            hintStyle: TextStyle(
                                fontFamily: 'RobotoR', color: Colors.grey),
                            prefixIcon: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: SvgPicture.asset(
                                'assets/images/search.svg',
                                width: 5,
                                height: 5,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            suffixIcon: Container(
                              padding: EdgeInsets.symmetric(vertical: 13),
                              child: InkWell(
                                onTap: openFilter,
                                child: SvgPicture.asset(
                                  'assets/images/sliders-solid.svg',
                                  width: 2,
                                  height: 2,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: products.length,
                      shrinkWrap: true,
                      itemBuilder: (context, i) => ChangeNotifierProvider.value(
                            value: products[i],
                            child: CardItems(index: i),
                          )),
                ],
              ),
            ),
    );
  }

  categoryHorizontal(BuildContext context, String title, index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTypeIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        height: 38,
        width: 81,
        decoration: BoxDecoration(
            color: _selectedTypeIndex == index
                ? Theme.of(context).primaryColor
                : null,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).primaryColor)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: _selectedTypeIndex == index
                  ? Colors.white
                  : Theme.of(context).primaryColor,
              fontFamily: 'RobotoB',
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}