import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ItemDetail extends StatefulWidget {
  ItemDetail({Key? key}) : super(key: key);

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  List<String> images = [
    'assets/images/gold-ring.jpg',
    'assets/images/gold-ring.jpg',
    'assets/images/gold-ring.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    List<String> sizes = ['16.5', '17.4', '19.0', '19.9'];
    String dropdownvalue = '19.0';

    return Scaffold(
      backgroundColor: Color(0xffEDEDED),
      appBar: AppBar(
        backgroundColor: Color(0xffEDEDED),
        leading: GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff455A64),
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.favorite_border,
                size: 30,
                color: Color(0xff455A64),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.shopping_basket_outlined,
                size: 30,
                color: Color(0xff455A64),
              ),
            ),
          )
        ],
        elevation: 0,
      ),
      body: Container(
        color: Color(0xffEDEDED),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: CarouselSlider(
                options: CarouselOptions(
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    autoPlay: false),
                items: images
                    .map((e) => ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Image.asset(
                                e,
                                width: 400,
                                height: 400,
                                fit: BoxFit.fitWidth,
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  'Iraqi',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2),
                )),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Gold Ring',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff455A64)),
                    )),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '\$250',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff455A64)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Text(
                          'Details',
                          style: TextStyle(
                            color: Color(0xff455A64),
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 20,
                      thickness: 1,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                        child: Text(
                          'Gold Purity: 14K',
                          style: TextStyle(
                              color: Colors.grey[500],
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w600,
                              fontSize: 26),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
                        child: Text(
                          'Brand: Cartier!',
                          style: TextStyle(
                              color: Colors.grey[500],
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w600,
                              fontSize: 26),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
                          child: Text(
                            'Sizes:',
                            style: TextStyle(
                                color: Colors.grey[500],
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w600,
                                fontSize: 26),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        DecoratedBox(
                          decoration: ShapeDecoration(
                            color: Color(0xffEDEDED),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Color(0xffEDEDED)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            ),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: DropdownButton(
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 15),
                                dropdownColor: Color(0xffEDEDED),
                                value: dropdownvalue,
                                elevation: 16,
                                borderRadius: BorderRadius.circular(20),
                                onChanged: (value) => setState(
                                    () => dropdownvalue = value.toString()),
                                items: sizes
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text('$e'),
                                        ))
                                    .toList(),
                              )),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: ButtonTheme(
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'ADD TO CART',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
