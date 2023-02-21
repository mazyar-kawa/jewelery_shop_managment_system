import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/screens/signin_screen.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:provider/provider.dart';

class ItemDetialsWidget extends StatefulWidget {
  const ItemDetialsWidget({super.key});

  @override
  State<ItemDetialsWidget> createState() => _ItemDetialsWidgetState();
}

class _ItemDetialsWidgetState extends State<ItemDetialsWidget> {
  int current = 0;
  @override
  Widget build(BuildContext context) {
    final islogin = Provider.of<Checkuser>(context).islogin;
    final item = Provider.of<SingleItem>(context);
    return Consumer<SingleItem>(
      builder: (context, value, child) {
        return Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    islogin
                        ? Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                height: 40,
                                width: 40,
                                child: Center(
                                  child: InkWell(
                                      onTap: () async {
                                        ApiProvider response = await value
                                            .FavouriteAndUnfavouriteItem(
                                                item.id!, context);
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
                                      child: item.isFavourited!
                                          ? SvgPicture.asset(
                                              'assets/images/heart-solid.svg',
                                              width: 25,
                                              color: Colors.red,
                                            )
                                          : SvgPicture.asset(
                                              'assets/images/heart-regular.svg',
                                              width: 25,
                                              color: Colors.red,
                                            )),
                                )),
                          )
                        : Container(
                            height: 40,
                            width: 40,
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
                                  ? MediaQuery.of(context).size.width * 0.05
                                  : 6,
                              height: 6,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000),
                                  color: current == _
                                      ? Theme.of(context)
                                          .scaffoldBackgroundColor
                                      : Theme.of(context)
                                          .scaffoldBackgroundColor
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
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15.0)),
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColorLight,
                                    borderRadius: BorderRadius.circular(15)),
                                height: 4,
                                width: 48,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name!,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontFamily: 'RobotoB',
                                          fontSize: 18),
                                    ),
                                    Text(
                                      item.countryName!,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight,
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
                                        ? Color(0xffFFD700).withOpacity(0.1)
                                        : Color(0xffC0C0C0).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(5),
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
                                        color:
                                            Theme.of(context).primaryColorLight,
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
                                                .primaryColorLight,
                                            size: 15),
                                        Text(
                                          '  ${item.weight}g',
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
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      "Description",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontFamily: 'RobotoM',
                                          fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      item.description!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
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
                            InkWell(
                              onTap: () async {
                                if (islogin) {
                                  ApiProvider response =
                                      await value.basketAndUnbasketItems(
                                          item.id!, context);
                                  if (response.data != null) {
                                    showSnackBar(
                                        context,
                                        response.data['message'],
                                        response.data['message']
                                                .contains("Added")
                                            ? false
                                            : true);
                                  }
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SignIn()));
                                }
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).primaryColorLight,
                                ),
                                child: Center(
                                  child: Text(
                                    item.inBasket! ? "Added" : "Add to basket",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
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
        );
      },
    );
  }
}
