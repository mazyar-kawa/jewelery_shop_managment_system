import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/service/item_service.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:jewelery_shop_managmentsystem/widgets/card_items.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          final product = Provider.of<ItemService>(context).items;
          if (snapshot.connectionState == ConnectionState.done) {
            return product.length != 0
                ? ListView.builder(
                    itemCount: product.length,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return ChangeNotifierProvider.value(
                        value: product[i],
                        child: CardItems(index: i, isbasket: false),
                      );
                    })
                : searchController.text != "" ? Container(
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
                  ):Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Center(
                            child: Text(
                          AppLocalizations.of(context)!.thisCountryHasNoItems,
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'RobotoB',
                            color: Theme.of(context).primaryColorLight,
                          ),
                        )),
                      ),
                      Container(
                        child: Center(
                          child: Lottie.asset(
                            'assets/images/empty-box.json',
                            width: MediaQuery.of(context).size.width > websize
                                ? 650
                                : 350,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
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
