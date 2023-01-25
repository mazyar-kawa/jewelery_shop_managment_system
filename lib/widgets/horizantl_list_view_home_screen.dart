import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:jewelery_shop_managmentsystem/widgets/home_small_card_mobile.dart';
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
        initialPage: _current, viewportFraction: 0.65, keepPage: true);
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
            height: MediaQuery.of(context).size.width > websize ? 318 : 350,
            width: double.infinity,
            child: PageView.builder(
                    itemCount: products.length,
                    onPageChanged: ((value) {
                      setState(() {
                        _current = value;
                      });
                    }),
                    physics: BouncingScrollPhysics(),
                    controller: MediaQuery.of(context).size.width > websize?_pageControllerWeb :_pageControllerMobile,
                    itemBuilder: (context, index) =>
                        ChangeNotifierProvider.value(
                          value: products[index],
                          child: AnimatedBuilder(
                            animation: _pageControllerMobile,
                            builder: (context,child) {
                              return AnimatedScale(
                                curve: Curves.fastOutSlowIn,
                                scale: _current == index ? 1 : 0.8,
                                duration: Duration(milliseconds: 500),
                                child: HomeSmallCardMobile(
                                  current: _current,
                                  index: index,
                                  islogin: widget.islogin,
                                ),
                              );
                            }
                          ),
                        )),
          ),
        ],
      ),
    );
  }
}
