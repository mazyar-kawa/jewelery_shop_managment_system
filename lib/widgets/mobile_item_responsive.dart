import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/provider/item_provider_org.dart';
import 'package:jewelery_shop_managmentsystem/widgets/card_items.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ItemMobileResponsive extends StatelessWidget {
  
  const ItemMobileResponsive({
    Key? key,
    required this.all,
    required this.searchController,

  }) : super(key: key);

  final Future? all;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: all,
        builder: (context, snapshot) {
          final product = Provider.of<ItemProviderORG>(context).items;
          if (snapshot.connectionState == ConnectionState.done) {
            return product.length != 0
                ? ListView.builder(
                    itemCount: product.length,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return ChangeNotifierProvider.value(
                        value: product[i],
                        child: CardItems(index: i,isbasket: false,issure: false,),
                      );
                    })
                : Container(
                    width: 300,
                    height: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Center(
                              child: searchController.text != ''
                                  ? Text(
                                      'Not data found with "${searchController.text}"',
                                      style: TextStyle(
                                        color: Color(0xff7dd3fc),
                                        fontSize: 20,
                                        fontFamily: 'RobotoB',
                                      ),
                                    )
                                  : Text(
                                      'Not data found',
                                      style: TextStyle(
                                        color: Color(0xff7dd3fc),
                                        fontSize: 20,
                                        fontFamily: 'RobotoB',
                                      ),
                                    )),
                        ),
                        Container(
                          child: Lottie.asset('assets/images/not_found.json',
                              width: 250),
                        ),
                      ],
                    ),
                  );
          } else {
            return Center(
              child:
                  Lottie.asset('assets/images/loader_daimond.json', width: 200),
            );
          }
        });
  }
}
