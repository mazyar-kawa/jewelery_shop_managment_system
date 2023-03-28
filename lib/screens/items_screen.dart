import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/service/Basket_item_service.dart';
import 'package:jewelery_shop_managmentsystem/service/home_items_service.dart';
import 'package:jewelery_shop_managmentsystem/service/item_service.dart';
import 'package:jewelery_shop_managmentsystem/service/language_service.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:jewelery_shop_managmentsystem/widgets/items_filter.dart';
import 'package:jewelery_shop_managmentsystem/widgets/mobile_item_responsive.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ItemsScreen extends StatefulWidget {
  final int country_id;
  final String country_name;
  const ItemsScreen(
      {Key? key, required this.country_id, required this.country_name})
      : super(key: key);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen>
    with TickerProviderStateMixin {
  double start_size = 0;
  double end_size = 0;
  double start_weight = 0;
  double end_weight = 0;
  

  RangeValues rangeCarat = RangeValues(12, 24);
  RangeValues rangeSize = RangeValues(7, 32);
  bool active_filter = false;
  int _selectedTypeIndex = 0;
  bool isloading = true;
  bool issearch = false;
  int _current = 2;
  int category_id = 0;
  int carat_id = 0;
  String typecarat='';
  String caratNo='';
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  TextEditingController searchController = TextEditingController();

  PageController _pageController = PageController();
  Future? all;
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        all = AllItems(isloading);
        Provider.of<HomeItemsService>(context, listen: false).getCarates();
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => all);
    super.initState();
  }

  
  AllItems(
    bool first, {
    String search = '',
    String type='',
    String carat='',
    double size_start = 0,
    double size_end = 0,
    double weight_start = 0,
    double weight_end = 0,
    int categoryId = 0,

  }) async {
    // final CategoryId = ModalRoute.of(context)!.settings.arguments as int;
    if (first) {
      await Provider.of<ItemService>(context, listen: false).getItems(
          widget.country_id,
          search: search,
          size_start: start_size,
          size_end: end_size,
          weight_start: start_weight,
          weight_end: end_weight,
          category_id: categoryId,
          type: typecarat,
          carat: caratNo,
          );
    } else {
      await Provider.of<ItemService>(context, listen: false).refresh(
          search: search,
          size_start: start_size,
          size_end: end_size,
          weight_start: start_weight,
          weight_end: end_weight,
          category_id: categoryId,
          type: typecarat,
          carat: caratNo,
          );
    }
  }

  void Loading() async {
    await Future.delayed(
      Duration(seconds: 2),
      () {
        all = AllItems(
          false,
          search: searchController.text,
          size_start: start_size,
          size_end: end_size,
          weight_start: start_weight,
          weight_end: end_weight,
          categoryId: category_id,
        );
      },
    );
    refreshController.loadComplete();
  }

  void Refresh() async {
    await Future.delayed(
      Duration(seconds: 2),
      () {
        all = AllItems(true);
        searchController.text = '';
      },
    );
    refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<HomeItemsService>(context).categories;
    final carat = Provider.of<HomeItemsService>(context).carates;
    final type = Provider.of<HomeItemsService>(context).type;
    final provider = Provider.of<ItemService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          widget.country_name,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoB',
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        leading: Consumer<LanguageServ>(
          builder: (context, value, child) {
            return InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              height: 20,
              width: 25,
              child: RotatedBox(
                quarterTurns: 90,
                child: Icon(
                 Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).primaryColorLight),
              ),
            ),
          );
          },
          
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColorLight,
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
                  child: Consumer<BasketItemService>(
                      builder: (context, basket, coild) {
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
                                color: Theme.of(context).primaryColorLight,
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
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: refreshController,
        header: CustomHeader(
          builder: (context, mode) {
            Widget body;
            if (mode == LoadStatus.loading) {
              body = Lottie.asset('assets/images/refresh.json');
            } else {
              body = Lottie.asset('assets/images/refresh.json');
            }
            return Container(
              height: 75,
              child: Center(child: body),
            );
          },
        ),
        onRefresh: Refresh,
        onLoading: Loading,
        footer: CustomFooter(builder: (context, mode) {
          Widget body;
          if (provider.next_url == 'No data') {
            body = Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Lottie.asset('assets/images/not more.json'),
                ),
                Container(
                  child: Text(
                    'There\'s no more Item.',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            );
          } else if (mode == LoadStatus.loading) {
            body = Lottie.asset('assets/images/preloader.json');
          } else {
            body = Lottie.asset('assets/images/preloader.json');
          }

          return Container(
            padding: EdgeInsets.only(bottom: 10),
            height: 75.0,
            child: Center(child: body),
          );
        }),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  MediaQuery.of(context).size.width > websize
                      ? Container()
                      : Container(),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width > websize
                          ? MediaQuery.of(context).size.width / 3
                          : double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          value = searchController.text;
                          setState(() {
                            issearch = true;
                          });
                          EasyDebounce.debounce(
                              "Search", Duration(milliseconds: 500), () async {
                            await AllItems(
                              true,
                              search: value,
                              size_start: start_size,
                              size_end: end_size,
                              weight_start: start_weight,
                              weight_end: end_weight,
                              categoryId: category_id,
                              type: typecarat,
                            );
                            setState(() {
                              issearch = false;
                            });
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon:
                              MediaQuery.of(context).size.width > websize
                                  ? Container()
                                  : MyWidget(
                                    onChangedCaratNo: (value) {
                                      setState(() {
                                        caratNo=value;
                                      });
                                    },
                                    onChangedCaratType: (value) {
                                      setState(() {
                                        typecarat=value;
                                      });
                                    },
                                      categories: category,
                                      active_filter: active_filter,
                                      searchController: searchController,
                                      AllItems: AllItems,
                                      rangeSize: rangeSize,
                                      rangeCarat: rangeCarat,
                                      carates: carat,
                                      caratTypes: type,
                                      categoryId: category_id,
                                      onChangestart_size: (value) {
                                        setState(() {
                                          start_size = value;
                                        });
                                      },
                                      onChangeend_size: (value) {
                                        setState(() {
                                          end_size = value;
                                        });
                                      },
                                      onChangestart_weight: (value) {
                                        setState(() {
                                          start_weight = value;
                                        });
                                      },
                                      onChangeend_weight: (value) {
                                        setState(() {
                                          end_weight = value;
                                        });
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          active_filter = value;
                                        });
                                      },
                                      
                                      onChangedCategory: (value) {
                                        setState(() {
                                          category_id = value;
                                        });
                                      },
                                    ),
                          prefixIcon: Icon(Icons.search,
                              color: Theme.of(context).primaryColorLight),
                          filled: true,
                          fillColor: Theme.of(context).secondaryHeaderColor,
                          hintText:
                              '${AppLocalizations.of(context)!.search}...',
                          hintStyle: const TextStyle(color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              issearch == false && active_filter == false
                  ?  ItemMobileResponsive(
                          all: all,
                          searchController: searchController,
                        )
                  : Container(
                      width: 300,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(),
                          Container(
                            child: Lottie.asset(
                                'assets/images/loader_daimond.json',
                                width: 200),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
