import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/screens/signin_screen.dart';
import 'package:jewelery_shop_managmentsystem/service/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_service.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:jewelery_shop_managmentsystem/widgets/dashed_separator.dart';
import 'package:provider/provider.dart';

class ItemDetialsWidget extends StatefulWidget {
  final ishiddin;
  const ItemDetialsWidget({super.key, this.ishiddin = false});

  @override
  State<ItemDetialsWidget> createState() => _ItemDetialsWidgetState();
}

class _ItemDetialsWidgetState extends State<ItemDetialsWidget> {
  int current = 0;
  @override
  Widget build(BuildContext context) {
    final islogin = Provider.of<Checkuser>(context).islogin;
    final item = Provider.of<SingleItem>(context);
    return Consumer<SingleItem>(builder: (context, service, child) {
      return Container(
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(3, (index) {
                            return InkWell(
                              splashColor: Theme.of(context).primaryColorLight,
                              onTap: (){
                                setState(() {
                                  current=index;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 15),
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: current==index?Colors.grey.withOpacity(0.4):Colors.white,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                    child: AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Image(
                                    image: NetworkImage(item.img!),
                                    width: 40,
                                  ),
                                )),
                              ),
                            );
                          })),
                      Container(
                        margin: EdgeInsets.only(right: 25),
                        child: Center(
                            child: AspectRatio(
                          aspectRatio: 0.6,
                          child: Image(image: NetworkImage(item.img!)),
                        )),
                      ),
                    ],
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Theme.of(context).buttonColor,
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    right: 15, top: 5, bottom: 5),
                                child: Text(
                                  item.name!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'RobotoB',
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Container(
                        child: Text(
                          item.countryName!,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'RobotoM',
                            fontSize: 16,
                          ),
                        ),
                      ),
                            ],
                          ),
                          islogin
                              ? Container(
                                  height: 30,
                                  width: 30,
                                  
                                  child: Center(
                                    child: InkWell(
                                        onTap: () async {
                                          ApiProvider response = await service
                                              .FavouriteAndUnfavouriteItem(
                                                  item.id!, context);
                                          if (response.data != null) {
                                            showSnackBar(
                                                context,
                                                response.data['message'],
                                                response.data['message']
                                                        .contains("added")
                                                    ? false
                                                    : true);
                                          }
                                        },
                                        child: service.isFavourited!
                                            ? SvgPicture.asset(
                                                'assets/images/heart-solid.svg',
                                                width: 25,
                                                color: Colors.red,
                                              )
                                            : SvgPicture.asset(
                                                'assets/images/heart-regular.svg',
                                                width: 25,
                                                color: Colors.red,
                                              )),
                                  ),
                                )
                              : Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  height: 30,
                                  width: 30,
                                  
                                ),
                        ],
                      ),
                      
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconTitle(context, 'assets/images/ruler.svg',item.size! ==0?'NaN':item.size!.toString()),
                            IconTitle(context, 'assets/images/balance.svg',item.weight!.toString()+"g"),
                            Container(
                                      padding: const EdgeInsets.all(5),
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: item.caratType == 'gold'
                                            ? Color(0xffFFD700).withOpacity(0.1)
                                            : Color(0xffC0C0C0)
                                                .withOpacity(0.1),
                                         borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${item.caratType!} ${item.caratMs!}',
                                          style: TextStyle(
                                            color: item.caratType == 'gold'
                                                ? Color(0xffFFD700)
                                                : Color(0xFFA3A3A3),
                                            fontFamily: 'RobotoM',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Description',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'RobotoB',
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(
                                  item.description!,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color:Colors.white,
                                    fontFamily: 'RobotoB',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                        
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           
                             Container(
                                    child: Text(
                                      '\$${item.price!.round()}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color:Colors.white,
                                        fontFamily: 'RobotoB',
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: ()async{
                                      if (islogin) {
                                  ApiProvider response =
                                      await service.basketAndUnbasketItems(
                                          item.id!, context);
                                  if (response.data != null) {
                                    showSnackBar(
                                        context,
                                        response.data['message'],
                                        response.data['message']
                                                .contains("Added")
                                            ? false
                                            : true);
                                  }
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SignIn()));
                                }
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(
                                        child: Text(
                                      item.inBasket! ? "Added" : "Add to cart",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .buttonColor,
                                        fontFamily: 'RobotoM',
                                        fontSize: 18,
                                      ),
                                    ),
                                      ),
                                    ),
                                  ),
                              
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      );
    });
  }

  Column IconTitle(BuildContext context,String image,String title) {
    return Column(
                            children: [
                              Container(
                                child: SvgPicture.asset(
                                    image,
                                    color:Colors.white,
                                       width: 22,
                                        ),
                              ),
                              Container(
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    color:Colors.white,
                                    fontFamily: 'RobotoM',
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          );
  }
}



/*

 Flex(
                          children: List.generate(3, (_) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 25),
                              width: current == _
                                  ? MediaQuery.of(context).size.width * 0.05
                                  : 6,
                              height: 6,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(1000),
                                  color: current == _
                                      ? Theme.of(context)
                                          .scaffoldBackgroundColor
                                      : Theme.of(context)
                                          .scaffoldBackgroundColor
                                          .withOpacity(0.3),
                                ),
                              ),
                            );
                          }),
                          mainAxisAlignment: MainAxisAlignment.center,
                          direction: Axis.horizontal,
                        ),


*/
/*
ApiProvider response = await value
                                            .FavouriteAndUnfavouriteItem(
                                                item.id!, context);
                                        if (response.data != null) {
                                          showSnackBar(
                                              context,
                                              response.data['message'],
                                              response.data['message']
                                                      .contains("added")
                                                  ? false
                                                  : true);
                                        }

*/


/*
if (islogin) {
                                  ApiProvider response =
                                      await value.basketAndUnbasketItems(
                                          item.id!, context);
                                  if (response.data != null) {
                                    showSnackBar(
                                        context,
                                        response.data['message'],
                                        response.data['message']
                                                .contains("Added")
                                            ? false
                                            : true);
                                  }
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SignIn()));
                                }
*/