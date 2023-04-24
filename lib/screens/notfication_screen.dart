import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/notification.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_service.dart';
import 'package:jewelery_shop_managmentsystem/widgets/unauthentication.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotficationScreen extends StatelessWidget {
  List<Notifications> notfiy = [
    Notifications(
        title: "Complited",
        body: "your order #.53 is complited",
        status: false,
        date: "1Mo"),
    Notifications(
        title: "Accepted",
        body: "your order #.54 is accepted",
        status: true,
        date: "1d")
  ];

  @override
  Widget build(BuildContext context) {
    final islogin = Provider.of<Checkuser>(context).islogin;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            centerTitle: true,
            title: Text(
               AppLocalizations.of(context)!.notifications,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoB',
                color: Theme.of(context).primaryColorLight,
              ),
            ),
          ),
          body: !islogin
              ? UnAuthentication(
                  title:  AppLocalizations.of(context)!.thereIsNoMoreJewel,
                )
              : notfiy.length == 0
                  ? Container(
                      height: 500,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                               AppLocalizations.of(context)!.yourNotificationsIsEmpty,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'RobotoB',
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                          ),
                          Container(
                            child: Lottie.asset(
                              'assets/images/notification.json',
                              width: 350,
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(
                      child: ListView.builder(
                        itemCount: notfiy.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 80,
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: notfiy[index].status!
                                  ? Theme.of(context)
                                      .secondaryHeaderColor
                                      .withOpacity(0.8)
                                  : Theme.of(context).secondaryHeaderColor,
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context).shadowColor,
                                    blurRadius: 5,
                                    offset: Offset(0, 3)),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(1000),
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                      child: Center(
                                          child: Icon(
                                        notfiy[index].status!
                                            ? Icons.mark_email_read_rounded
                                            : Icons.mail,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      )),
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Text(notfiy[index].title!,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                  fontFamily: 'RobotoB',
                                                  fontSize: 16,
                                                )),
                                          ),
                                          Container(
                                            child: Text(notfiy[index].body!,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColorLight
                                                      .withOpacity(0.5),
                                                  fontFamily: 'RobotoM',
                                                  fontSize: 14,
                                                )),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(notfiy[index].date!,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .primaryColorLight
                                            .withOpacity(0.5),
                                        fontFamily: 'RobotoR',
                                        fontSize: 12,
                                      )),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )),
    );
  }
}
/*


*/