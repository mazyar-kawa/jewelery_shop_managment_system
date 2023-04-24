import 'dart:convert';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jewelery_shop_managmentsystem/service/search_for_items.dart';
import 'package:jewelery_shop_managmentsystem/widgets/search_card.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:avatar_glow/avatar_glow.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  TextEditingController search = TextEditingController();
  SpeechToText _speech = SpeechToText();
  bool _isListiner = false;
  String _search = "";
  bool active_serch = false;
  dynamic lang;

  Future? fetchData;

  @override
  void initState() {
    _speech = SpeechToText();
    getLanguage();
    super.initState();
  }

  searchForItem(String name, bool issearch) async {
    if (issearch && name.isNotEmpty) {
      await Provider.of<SearchFoItems>(context, listen: false).search(name);
    } else {
      await Provider.of<SearchFoItems>(context, listen: false).pagination(name);
    }
  }

  void pagination(String name) async {
    await Future.delayed(
      Duration(seconds: 2),
      () {
        searchForItem(name, false);
      },
    );
    refreshController.loadComplete();
  }

   getLanguage()async{
     SharedPreferences prefs=await SharedPreferences.getInstance();

     setState(() {
       lang= prefs.getString("language_key");
     });
     
     return lang;

  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchFoItems>(context);
    return Scaffold(
      body: SmartRefresher(
        enablePullUp: true,
        controller: refreshController,
        onLoading: () {
          pagination(search.text);
        },
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
                     AppLocalizations.of(context)!.thereIsNoMoreJewel,
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
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    lang=="en" ? Container(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                      ):Container(
                        child: RotatedBox(
                          quarterTurns: 90,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_forward_ios_rounded),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: TextField(
                          controller: search,
                          onChanged: (value) {
                            value = search.text;
                            setState(() {
                              active_serch = true;
                            });
                            EasyDebounce.debounce(
                                "Search", Duration(milliseconds: 500),
                                () async {
                              fetchData = searchForItem(value, true);
                              setState(() {
                                active_serch = false;
                              });
                            });
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  search.clear();
                                },
                                icon: Icon(Icons.clear,
                                    color:
                                        Theme.of(context).primaryColorLight)),
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
                                  color: Theme.of(context).shadowColor,
                                  width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).shadowColor,
                                  width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                          ),
                        ),
                      ),
                      AvatarGlow(
                        animate: _isListiner,
                        endRadius: 40,
                        glowColor: Theme.of(context).primaryColorLight,
                        repeat: true,
                        repeatPauseDuration: Duration(milliseconds: 100),
                        duration: Duration(milliseconds: 2000),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Theme.of(context).primaryColorLight),
                          child: IconButton(
                            onPressed: listning,
                            icon: Icon(_isListiner ? Icons.mic : Icons.mic_none,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                search.text.isEmpty
                    ? Container(
                        width: 300,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                "You can search for Jewel",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontFamily: "RobotoB",
                                    fontSize: 18),
                              ),
                            ),
                            Container(
                              child: Lottie.asset(
                                  'assets/images/search-imm.json',
                                  width: 350),
                            ),
                          ],
                        ))
                    : active_serch
                        ? Container(
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
                          )
                        : FutureBuilder(
                            future: fetchData,
                            builder: (context, snapshot) {
                              final items =
                                  Provider.of<SearchFoItems>(context).items;
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return items.length == 0
                                    ? Container(
                                        width: 300,
                                        height: 500,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Center(
                                                  child: Text(
                                                'Not jewel found',
                                                style: TextStyle(
                                                  color: Color(0xff7dd3fc),
                                                  fontSize: 20,
                                                  fontFamily: 'RobotoB',
                                                ),
                                              )),
                                            ),
                                            Container(
                                              child: Lottie.asset(
                                                  'assets/images/not_found.json',
                                                  width: 250),
                                            ),
                                          ],
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemCount: items.length,
                                        itemBuilder: (context, index) {
                                          return ChangeNotifierProvider.value(
                                            value: items[index],
                                            builder: (context, child) {
                                              return SearchCard();
                                            },
                                          );
                                        },
                                      );
                              } else {
                                return Center(
                                  child: Lottie.asset(
                                      'assets/images/loader_daimond.json',
                                      width: 200),
                                );
                              }
                            },
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void listning() async {
    if (!_isListiner) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListiner = true);
        _speech.listen(
            onResult: (result) => setState(() {
                  _search = result.recognizedWords;

                  search.text = _search;
                  setState(() {
                    active_serch = true;
                  });
                  EasyDebounce.debounce("Search", Duration(milliseconds: 500),
                      () async {
                    fetchData = searchForItem(search.text, true);
                    setState(() {
                      active_serch = false;
                    });
                  });

                  if (result.finalResult) {
                    setState(() => _isListiner = false);
                    _speech.stop();
                  }
                }));
      }
    }
  }
}
