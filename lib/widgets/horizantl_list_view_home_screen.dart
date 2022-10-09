import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/home_items_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/item_provider_org.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:jewelery_shop_managmentsystem/widgets/home_small_card_mobile.dart';
import 'package:jewelery_shop_managmentsystem/widgets/home_small_card_web.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HorizantleListView extends StatefulWidget {
  final String title;
  final bool islogin;
  final List<SingleItem> provder;

  const HorizantleListView({
    required this.title,
    required this.islogin,
    required this.provder,
    Key? key,
  }) : super(key: key);

  @override
  State<HorizantleListView> createState() => _HorizantleListViewState();
}

class _HorizantleListViewState extends State<HorizantleListView> {
  PageController _pageControllerMobile = PageController();
  PageController _pageControllerWeb = PageController();

  int _current = 2;

  @override
  void initState() {
    _pageControllerMobile = PageController(
        initialPage: _current, viewportFraction: 0.6, keepPage: true);
    _pageControllerWeb = PageController(
        initialPage: _current, viewportFraction: 0.3, keepPage: true);

    super.initState();
  }

  @override
  void dispose() {
    _pageControllerMobile.dispose();
    _pageControllerWeb.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = widget.provder;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  AppLocalizations.of(context)!.seeMore,
                  style: TextStyle(
                      fontSize: 14, color: Theme.of(context).primaryColorLight),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.width > websize ? 318 : 310.79,
            width: double.infinity,
            child: MediaQuery.of(context).size.width > websize
                ? PageView.builder(
                    itemCount: products.length,
                    onPageChanged: ((value) {
                      setState(() {
                        _current = value;
                      });
                    }),
                    physics: BouncingScrollPhysics(),
                    controller: _pageControllerWeb,
                    itemBuilder: (context, index) =>
                        ChangeNotifierProvider.value(
                      value: products[index],
                      child: HomeSmallCardweb(
                        pageController: _pageControllerWeb,
                        current: _current,
                        index: index,
                      ),
                    ),
                  )
                : PageView.builder(
                    itemCount: products.length,
                    onPageChanged: ((value) {
                      setState(() {
                        _current = value;
                      });
                    }),
                    physics: BouncingScrollPhysics(),
                    controller: _pageControllerMobile,
                    itemBuilder: (context, index) =>
                        ChangeNotifierProvider.value(
                          value: products[index],
                          child: HomeSmallCardMobile(
                            pageController: _pageControllerMobile,
                            current: _current,
                            index: index,
                            islogin: widget.islogin,
                          ),
                        )),
          ),
        ],
      ),
    );
  }
}
