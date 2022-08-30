import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/model/items.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _current = 2;

  PageController _pageController = PageController();

  @override
  void initState() {
    _pageController = PageController(
        initialPage: _current, viewportFraction: 0.6, keepPage: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
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
                  hintText: 'Search...',
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
                  categoryHorizontal(context, 'All', 0),
                  categoryHorizontal(context, 'Rings', 1),
                  categoryHorizontal(context, 'Necklaces', 2),
                  categoryHorizontal(context, 'Earrings', 3),
                  categoryHorizontal(context, 'Gold', 4),
                ],
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            height: 270,
            child: PageView.builder(
              itemCount: items.length,
              onPageChanged: ((value) {
                setState(() {
                  _current = value;
                });
              }),
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    return AnimatedScale(
                        curve: Curves.fastOutSlowIn,
                        scale: _current == index ? 1 : 0.8,
                        duration: Duration(milliseconds: 500),
                        child: child!);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        )),
                    child: Column(
                      children: [
                        Container(
                          height: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              color: Color(0xffEDEDED)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Size: ${items[index].size}',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontFamily: 'RobotoB',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: items[index].isFavorite
                                            ? SvgPicture.asset(
                                                'assets/images/heart-solid.svg',
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )
                                            : SvgPicture.asset(
                                                'assets/images/heart-regular.svg',
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 90,
                                width: 90,
                                child: Image.network(items[index].image),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          width: double.infinity,
                          height: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(items[index].name,
                                  style: TextStyle(
                                    fontFamily: 'RobotoB',
                                    fontSize: 20,
                                  )),
                              Text('${items[index].price}\$',
                                  style: TextStyle(
                                    fontFamily: 'RobotoB',
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor,
                                  )),
                              SizedBox(
                                height: 1,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          HorizantleListView(title: 'New'),
          // most sale
          HorizantleListView(title: 'Most Sales'),
          // most favorite
          HorizantleListView(title: 'Most Favorite'),
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
                  'See more',
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
              itemCount: items.length,
              onPageChanged: ((value) {
                setState(() {
                  _current = value;
                });
              }),
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    return AnimatedScale(
                        curve: Curves.fastOutSlowIn,
                        scale: _current == index ? 1 : 0.8,
                        duration: Duration(milliseconds: 500),
                        child: child!);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    height: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              spreadRadius: 0.5)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  'Size: ${items[index].size}',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontFamily: 'RobotoB',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(1000),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: items[index].isFavorite
                                      ? SvgPicture.asset(
                                          'assets/images/heart-solid.svg',
                                          color: Theme.of(context).primaryColor,
                                        )
                                      : SvgPicture.asset(
                                          'assets/images/heart-regular.svg',
                                          color: Theme.of(context).primaryColor,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 90,
                          width: 90,
                          child: Image.network(items[index].image),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Text(
                                  items[index].name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'RobotoB',
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '${items[index].price}\$',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'RobotoB',
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: 31,
                          width: 111,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              'Add to Bag',
                              style: TextStyle(
                                fontFamily: 'RobotoB',
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
