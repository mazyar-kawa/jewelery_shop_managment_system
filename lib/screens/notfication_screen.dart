import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_service.dart';
import 'package:jewelery_shop_managmentsystem/service/notifications_service.dart';
import 'package:jewelery_shop_managmentsystem/widgets/unauthentication.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotficationScreen extends StatefulWidget {
  @override
  State<NotficationScreen> createState() => _NotficationScreenState();
}

class _NotficationScreenState extends State<NotficationScreen> {
  Future? notifications;
  bool isload=false;

@override
  void initState() {
  notifications= fetchNotify();
    super.initState();
  }
 
 
fetchNotify() async {
  await Future.delayed(
      Duration(milliseconds: 150),
      () async{
          await Provider.of<NotificationsService>(context, listen: false).getNotification();
      },
    ).then((value){
      setState(() {
        isload=true;
      });
    });
  
  }
  @override
  Widget build(BuildContext context) {
    final notfiy =Provider.of<NotificationsService>(context).notify;
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
                  title: AppLocalizations.of(context)!.thereIsNoMoreJewel,
                )
              : !isload?Container(
                    child: Center(
                      child: Lottie.asset('assets/images/loader_daimond.json',
                          width: 200),
                    ),
                  ) :notfiy.length == 0
                  ? Container(
                      height: 500,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              AppLocalizations.of(context)!
                                  .yourNotificationsIsEmpty,
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
                      child: FutureBuilder(
                        future: notifications,
                        builder: (context, snapshot) {
                          if(snapshot.connectionState==ConnectionState.done){
                            return ListView.builder(
                        itemCount: notfiy.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 80,
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Theme.of(context).secondaryHeaderColor,
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
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                      child: Center(
                                          child: Icon(
                                        Icons.mail,
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
                                            child: Text('${notfiy[index].title}',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                  fontFamily: 'RobotoB',
                                                  fontSize: 16,
                                                )),
                                          ),
                                          Container(
                                            child: Text('${notfiy[index].body}',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColorLight
                                                      .withOpacity(0.5),
                                                  fontFamily: 'RobotoM',
                                                  fontSize: 12,
                                                )),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text('${timeAgo(notfiy[index].createdAt!)}',
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
                      );
                          }else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Container(
                    child: Center(
                      child: Lottie.asset('assets/images/loader_daimond.json',
                          width: 200),
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
                        },
                      )
                    )),
    );
  }
  String timeAgo(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inDays >= 365) {
    // Display in years
    final years = (difference.inDays / 365).floor();
    return '$years ${years == 1 ? 'y' : 'y'} ago';
  } else if (difference.inDays >= 30) {
    // Display in months
    final months = (difference.inDays / 30).floor();
    return '$months ${months == 1 ? 'mo' : 'mo'} ago';
  } else if (difference.inDays >= 1) {
    // Display in days
    return '${difference.inDays} ${difference.inDays == 1 ? 'd' : 'd'} ago';
  } else if (difference.inHours >= 1) {
    // Display in hours
    return '${difference.inHours} ${difference.inHours == 1 ? 'h' : 'h'} ago';
  } else if (difference.inMinutes >= 1) {
    // Display in minutes
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'm' : 'm'} ago';
  } else {
    // Display in seconds
    return '${difference.inSeconds} ${difference.inSeconds == 1 ? 's' : 's'} ago';
  }
}
}

