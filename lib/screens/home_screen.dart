import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/provider/items_provider.dart';
import 'package:jewelery_shop_managmentsystem/widgets/home_small_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/home_card_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 2;
  int _selectedIndex = 0;

  PageController _pageController = PageController();

  DateTime now = DateTime.now();
  String? time;
  getTiem() {
    if (now.hour >= 1 && now.hour <= 12) {
      time = AppLocalizations.of(context)!.goodMorning;
    } else if (now.hour >= 12 && now.hour <= 16) {
      time = AppLocalizations.of(context)!.goodAfternoon;
    } else if (now.hour >= 16 && now.hour <= 21) {
      time = AppLocalizations.of(context)!.goodEvening;
    } else if (now.hour >= 21 && now.hour <= 24) {
      time = AppLocalizations.of(context)!.goodNight;
    }

    return time;
  }

  @override
  void initState() {
    _pageController = PageController(
        initialPage: _current, viewportFraction: 0.81, keepPage: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ItemProvider>(context).item;
    final boredrUser = OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffE9E9E9), width: 2),
      borderRadius: BorderRadius.circular(15),
    );
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getTiem(),
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'RobotoR',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    Text(
                      'Mazyar!👋',
                      style: TextStyle(
                        fontSize: 26,
                        fontFamily: 'RobotoB',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  border: boredrUser,
                  enabledBorder: boredrUser,
                  disabledBorder: boredrUser,
                  hintText: '${AppLocalizations.of(context)!.search}...',
                  hintStyle:
                      TextStyle(fontFamily: 'RobotoR', color: Colors.grey),
                  prefixIcon: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: SvgPicture.asset(
                      'assets/images/search.svg',
                      width: 5,
                      height: 5,
                      color: Theme.of(context).primaryColor,
                    ),
                  )),
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                children: [
                  categoryHorizontal(
                      context, AppLocalizations.of(context)!.all, 0),
                  categoryHorizontal(
                      context, AppLocalizations.of(context)!.rings, 1),
                  categoryHorizontal(
                      context, AppLocalizations.of(context)!.necklaces, 2),
                  categoryHorizontal(
                      context, AppLocalizations.of(context)!.earrings, 3),
                  categoryHorizontal(
                      context, AppLocalizations.of(context)!.gold, 4),
                ],
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            height: 240,
            child: PageView.builder(
              itemCount: products.length,
              onPageChanged: ((value) {
                setState(() {
                  _current = value;
                });
              }),
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: products[index],
                child: HomeCardCategory(
                  pageController: _pageController,
                  current: _current,
                  index: index,
                ),
              ),
            ),
          ),

          HorizantleListView(title: AppLocalizations.of(context)!.neww),
          // most sale
          HorizantleListView(title: AppLocalizations.of(context)!.mostSales),
          // most favorite
          HorizantleListView(
              title: AppLocalizations.of(context)!.mostFavourite),
        ],
      ),
    );
  }

  categoryHorizontal(BuildContext context, String title, index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        height: 38,
        width: 81,
        decoration: BoxDecoration(
            color:
                _selectedIndex == index ? Theme.of(context).primaryColor : null,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).primaryColor)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: _selectedIndex == index
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

class HorizantleListView extends StatefulWidget {
  final String title;

  const HorizantleListView({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  State<HorizantleListView> createState() => _HorizantleListViewState();
}

class _HorizantleListViewState extends State<HorizantleListView> {
  PageController _pageController = PageController();

  int _current = 2;

  @override
  void initState() {
    _pageController = PageController(
        initialPage: _current, viewportFraction: 0.6, keepPage: true);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ItemProvider>(context).item;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                      fontSize: 14, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
          Container(
            height: 260,
            width: double.infinity,
            child: PageView.builder(
                itemCount: products.length,
                onPageChanged: ((value) {
                  setState(() {
                    _current = value;
                  });
                }),
                physics: BouncingScrollPhysics(),
                controller: _pageController,
                itemBuilder: (context, index) => ChangeNotifierProvider.value(
                      value: products[index],
                      child: HomeSmallCard(
                        pageController: _pageController,
                        current: _current,
                        index: index,
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
