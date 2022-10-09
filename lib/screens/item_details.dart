import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:lottie/lottie.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({Key? key}) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    super.initState();
  }

  bool addbasket = false;

  startAnimation() async {
    addbasket = true;
    if (addbasket == true) {
      await animationController.forward();
      await Future.delayed(
        Duration(milliseconds: 150),
        () {
          if (animationController.isCompleted) {
            setState(() {
              animationController.reverse();
            });
          }
        },
      );
    }
  }

  int _currentPage = 0;
  int quantity = 1;
  int maxline = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            child: Column(
              children: [
                Flexible(
                    flex: 3,
                    child: Container(
                      color: Theme.of(context).buttonColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 60, horizontal: 25),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.4),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.only(right: 1),
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                                  iconSize: 20,
                                  color: Colors.grey.withOpacity(0.8),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 40, bottom: 20),
                              width: 300,
                              height: 250,
                              child: PageView.builder(
                                onPageChanged: (value) {
                                  setState(() {
                                    _currentPage = value;
                                  });
                                },
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    color: Colors.amber,
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0; i < 3; i++) SliderDot(i),
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
                Flexible(
                  flex: 2,
                  child: Container(
                    color: Theme.of(context).buttonColor,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    'NameItems',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontFamily: 'RobotoB',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.4),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/heart-solid.svg',
                                  width: 15,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                            width: 90,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).secondaryHeaderColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text(
                              'Description',
                              style: TextStyle(
                                color: Theme.of(context).buttonColor,
                                fontFamily: 'RobotoM',
                                fontSize: 16,
                              ),
                            )),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (maxline != 10) {
                                    maxline = 10;
                                  } else {
                                    maxline = 3;
                                  }
                                });
                              },
                              child: RichText(
                                maxLines: maxline,
                                softWrap: true,
                                text: TextSpan(
                                  text:
                                      'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontFamily: 'RobotoM',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).secondaryHeaderColor,
                                ),
                                child: Center(
                                  child: Text(
                                    'Size: 14',
                                    style: TextStyle(
                                      color: Theme.of(context).buttonColor,
                                      fontFamily: 'RobotoM',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).secondaryHeaderColor,
                                ),
                                child: Center(
                                  child: Text(
                                    'Mount: 22',
                                    style: TextStyle(
                                      color: Theme.of(context).buttonColor,
                                      fontFamily: 'RobotoM',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).secondaryHeaderColor,
                                ),
                                child: Center(
                                  child: Text(
                                    'Gold',
                                    style: TextStyle(
                                      color: Theme.of(context).buttonColor,
                                      fontFamily: 'RobotoM',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 25,
                            right: 25,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                    '200\$',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontFamily: 'RobotoB',
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black,
                                    )),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      '+',
                                      style: TextStyle(
                                        fontFamily: 'RobotoB',
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      '${quantity}',
                                      style: TextStyle(
                                        fontFamily: 'RobotoM',
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      '-',
                                      style: TextStyle(
                                        fontFamily: 'RobotoB',
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container SliderDot(index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      width: _currentPage == index ? 20 : 5,
      height: 6,
      decoration: BoxDecoration(
          color: _currentPage == index
              ? Theme.of(context).secondaryHeaderColor
              : Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10000)),
    );
  }
}
