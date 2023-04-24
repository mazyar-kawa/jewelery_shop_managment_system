import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/screens/item_details.dart';
import 'package:provider/provider.dart';

class SearchCard extends StatefulWidget {
  const SearchCard({super.key});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
 

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<SingleItem>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetails(
                item_id: item.id!,
              ),
              
            ));
            
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        height: 80,
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
                  padding: EdgeInsets.all(5),
                  child: AspectRatio(
                      aspectRatio: 1.5,
                      child: Image.network(
                          "http://192.168.1.32:8000" + item.img!,
                          fit: BoxFit.contain)),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          item.name!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontFamily: 'RobotoB',
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 13.0),
                        child: Text(
                          item.countryName!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontFamily: 'RobotoB',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
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
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: Text(
                '\$ ${item.price!.round()}',
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontFamily: 'RobotoB',
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
