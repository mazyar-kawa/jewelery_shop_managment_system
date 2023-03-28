import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:intl/intl.dart';
import 'package:jewelery_shop_managmentsystem/screens/orderDetails_screen.dart';
import 'package:jewelery_shop_managmentsystem/service/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/order.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  Future? Orders;

  @override
  void initState() {
    Orders = LoadingOrders();
    super.initState();
  }

  LoadingOrders() async {
    await Provider.of<OrderService>(context, listen: false).getMyOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.myOrders,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoB',
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        leading: InkWell(
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
                color: Theme.of(context).primaryColorLight,
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: Orders,
        builder: (context, snapshot) {
          final Orders = Provider.of<OrderService>(context).Orders;
          if (snapshot.connectionState == ConnectionState.done) {
            return Orders.length == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Center(
                            child: Text(
                          AppLocalizations.of(context)!.yourOrdersisempty,
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
                  )
                : ListView.builder(
                    itemCount: Orders.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>OrderDetails(idOrder: Orders[index].id!)));
                        },
                        child: Slidable(
                          endActionPane: Orders[index].status == "Requested"
                              ? ActionPane(
                                  extentRatio: 1 / 5,
                                  motion: ScrollMotion(),
                                  children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: Text(AppLocalizations.of(context)!.warning),
                                              content:  Text(
                                                  '${AppLocalizations.of(context)!.areYouSureToCancle}'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () => Navigator.pop(
                                                      context, 'Cancel'),
                                                  child:  Text(AppLocalizations.of(context)!.cancle),
                                                ),
                                                Consumer<OrderService>(
                                                  builder: (context, order, child) {
                                                   return TextButton(
                                                    onPressed: () async{ 
                                                    ApiProvider response=await  order.DeleteOrder(Orders[index].id!,context);
                                                    if(response.error==null){
                                                      showSnackBar(context, response.data!['message'], false);
                                                    }else{
                                                      showSnackBar(context, response.data!['errors']['orderId'], false);
                                                    }
                                                      Navigator.pop(context, 'OK');
                                                    },
                                                    child: Text(AppLocalizations.of(context)!.yes),
                                                  ); 
                                                  },
                                                  
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Color(0xffFED4D5),
                                          ),
                                          child: Center(
                                            child: Icon(FontAwesome5.trash,
                                                color: Color(0xffFA515C)),
                                          ),
                                        ),
                                      ),
                                    ])
                              : null,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            height: MediaQuery.of(context).size.height * 0.12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).shadowColor,
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                )
                              ],
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColorLight
                                              .withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Lottie.asset(
                                            'assets/images/box.json',
                                            width: 60),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '#. ${Orders[index].id}',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontFamily: 'RobotoM',
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                             AppLocalizations.of(context)!.total +': \$${Orders[index].total!.round()}',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontFamily: 'RobotoM',
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!.dateOrder+": " +
                                                  DateFormat.yMd().format(
                                                      Orders[index].createdAt!),
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontFamily: 'RobotoM',
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Orders[index].status == "Requested"
                                      ? SvgPicture.asset(
                                          'assets/images/requested.svg',
                                          color:
                                              Theme.of(context).primaryColorLight,
                                          width: 25,
                                        )
                                      : Orders[index].status == "Completed" ||
                                              Orders[index].status == "Accepted"
                                          ? SvgPicture.asset(
                                              'assets/images/check.svg',
                                              color: Orders[index].status ==
                                                      "Accepted"
                                                  ? Colors.blue
                                                  : Colors.green,
                                              width: 25,
                                            )
                                          : SvgPicture.asset(
                                              'assets/images/reject.svg',
                                              color: Color(0xFFfda4af)),
                                ),
                                //Orders[index].status == "Requested"? SvgPicture.asset('assets/images/requested.svg',color: Color(0xff7dd3fc),):Orders[index].status == "Accepted"?SvgPicture.asset('assets/images/accept.svg',color:Orders[index].status == "Completed"?Colors.green:Colors.blue,):SvgPicture.asset('assets/images/reject.svg',color: Color(0xFFfda4af)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child:
                  Lottie.asset('assets/images/loader_daimond.json', width: 200),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
