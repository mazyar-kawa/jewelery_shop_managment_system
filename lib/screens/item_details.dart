import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:jewelery_shop_managmentsystem/provider/item_provider_org.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ItemDetails extends StatefulWidget {
  final int item_id;
  const ItemDetails({super.key, required this.item_id});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  bool isloading = false;
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        loadItem().then((value) {
          isloading = true;
        });
      },
    );

    super.initState();
  }

  Future loadItem() async {
    return await Provider.of<ItemProviderORG>(context, listen: false)
        .getItemById(widget.item_id);
  }

  int current = 0;
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<ItemProviderORG>(context).ItemDetails;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: Container(
            padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: MediaQuery.of(context).size.width > websize ? 10 : 35),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Theme.of(context).primaryColorLight,
                    )),
                Text(
                  "Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoB',
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: isloading
            ? Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                height: 40,
                                width: 40,
                                child: Center(
                                  child: InkWell(
                                      onTap: () {
                                        // favouriteAndUnFavourite(
                                        //     product);
                                      },
                                      child: item.isFavourited!
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
                                )),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AspectRatio(
                                aspectRatio: 2.5,
                                child: PageView.builder(
                                  onPageChanged: (value) {
                                    setState(() {
                                      current = value;
                                    });
                                  },
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    return Image.network(item.img!,
                                        fit: BoxFit.contain);
                                  },
                                ),
                              ),
                              Flex(
                                children: List.generate(3, (_) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 25),
                                    width: current == _
                                        ? MediaQuery.of(context).size.width *
                                            0.05
                                        : 6,
                                    height: 6,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                        color: current == _
                                            ? Theme.of(context)
                                                .primaryColorLight
                                            : Theme.of(context)
                                                .primaryColorLight
                                                .withOpacity(0.3),
                                      ),
                                    ),
                                  );
                                }),
                                mainAxisAlignment: MainAxisAlignment.center,
                                direction: Axis.horizontal,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: DraggableScrollableSheet(
                      initialChildSize: 0.85,
                      minChildSize: 0.25,
                      builder: (context, scrollController) {
                        return Container(
                          
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius:
                                  BorderRadius.vertical(top: Radius.circular(32.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).shadowColor,
                                  blurRadius: 5,
                                  offset: Offset(0, -4),
                                )
                              ]),
                          child: SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                
                                children: [
                                   Center(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(15)),
                                    height: 4,
                                    width: 48,
                                  ),
                                ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name!,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                fontFamily: 'RobotoB',
                                                fontSize: 18),
                                          ),
                                          Text(
                                            item.countryName!,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                fontFamily: 'RobotoB',
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        padding: const EdgeInsets.all(5),
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: item.caratType == 'gold'
                                              ? Color(0xffFFD700)
                                                  .withOpacity(0.1)
                                              : Color(0xffC0C0C0)
                                                  .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${item.caratType!} ${item.caratMs!}',
                                            style: TextStyle(
                                              color: item.caratType == 'gold'
                                                  ? Color(0xffFFD700)
                                                  : Color(0xFFA3A3A3),
                                              fontFamily: 'RobotoM',
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "\$${item.price!.round()}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              fontFamily: 'RobotoB',
                                              fontSize: 20),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Row(
                                            children: [
                                              Icon(FontAwesome5.balance_scale,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                  size: 15),
                                              Text(
                                                '  ${item.weight}g',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
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
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "Description",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                fontFamily: 'RobotoM',
                                                fontSize: 20),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: new Text(
                                            item.description!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              fontFamily: 'RobotoB',
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          item.inBasket!
                                              ? "Added"
                                              : "Add to basket",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            fontFamily: 'RobotoB',
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            : Center(
                child: Lottie.asset('assets/images/loader_daimond.json',
                    width: 200),
              ));
  }
}
