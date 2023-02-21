import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/item_provider_org.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../widgets/item_detials_widget.dart';

class ItemDetails extends StatefulWidget {
  // final SingleItem item;
  final int item_id;
  const ItemDetails({super.key, required this.item_id});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  bool isloading = false;
  
  @override
  void initState() {
    loadItem().then((value) {
      setState(() {
        isloading=true;
      });
    });
    super.initState();
  }

  Future loadItem() async {
    return await Provider.of<ItemProviderORG>(context, listen: false)
        .getItemById(widget.item_id);
  }

  

  @override
  Widget build(BuildContext context) {
    
    final item = Provider.of<ItemProviderORG>(context).ItemDetails;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: Container(
            padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: MediaQuery.of(context).size.width > websize ? 10 : 35),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    )),
                Text(
                  "Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoB',
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: isloading
            ? ChangeNotifierProvider.value(
              value:item,
              builder: (context, child) {
              return ItemDetialsWidget();
            },)
            : Center(
                child: Lottie.asset('assets/images/loader_daimond.json',
                    width: 200),
              ));
  }
}
