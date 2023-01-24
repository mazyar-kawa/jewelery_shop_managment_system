import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/provider/item_provider_org.dart';
import 'package:jewelery_shop_managmentsystem/widgets/home_small_card_mobile.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ItemWebResponsive extends StatelessWidget {
  const ItemWebResponsive({
    Key? key,
    required this.all,
    required this.islogin,
  }) : super(key: key);

  final Future? all;
  final bool islogin;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          width: MediaQuery.of(context).size.width * 0.18,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 2,
                  spreadRadius: 2,
                )
              ]),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text('Price:',
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 16,
                      fontFamily: 'RobotoB',
                    )),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Checkbox(value: false, onChanged: (value) {}),
                          Text('10-100\$',
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ))
                        ],
                      ),
                    );
                  }),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text('Categories:',
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 16,
                      fontFamily: 'RobotoB',
                    )),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Checkbox(value: false, onChanged: (value) {}),
                          Text('All',
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ))
                        ],
                      ),
                    );
                  }),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text('Size:',
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 16,
                      fontFamily: 'RobotoB',
                    )),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Checkbox(value: false, onChanged: (value) {}),
                          Text('10',
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ))
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.82,
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
              future: all,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final product = Provider.of<ItemProviderORG>(context).items;
                  return product.length != 0
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: product.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, i) {
                            return ChangeNotifierProvider.value(
                              value: product[i],
                              child: HomeSmallCardMobile(index: i, islogin: islogin),
                            );
                          })
                      : Container(
                          width: 300,
                          height: 500,
                          child: Lottie.asset('assets/images/not_found.json',
                              width: 150),
                        );
                } else {
                  return Center(
                    child: Lottie.asset('assets/images/loader_daimond.json',
                        width: 200),
                  );
                }
              }),
        ),
      ],
    );
  }
}
