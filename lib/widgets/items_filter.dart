import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';
import 'package:jewelery_shop_managmentsystem/screens/items_screen.dart';

class MyWidget extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  
  final List<Categories> categories;
  bool active_filter;
 TextEditingController searchController;
  Function(bool first,{String search,
      double size_start,
      double size_end ,
      double mount_start,
      double mount_end })  AllItems;

      dynamic start_size;
      dynamic end_size;

      dynamic start_carat;
      dynamic end_carat;

      dynamic rangeSize;
      dynamic rangeCarat;
  MyWidget({super.key, required this.categories,required this.active_filter,required this.searchController,required this.AllItems,required this.start_size,required this.end_size,required this.start_carat,required this.end_carat,required this.rangeSize,required this.rangeCarat,required this.onChanged});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Object currentItem = 0;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 40,
      child: InkWell(
        onTap: () {
          Show(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: SvgPicture.asset("assets/images/sliders-solid.svg",
              fit: BoxFit.contain, color: Theme.of(context).primaryColorLight),
        ),
      ),
    );
  }

  Future Show(BuildContext context) {
    List<Categories> _categories = [
      Categories(id: 0, name: 'All'),
      for (int i = 0; i < widget.categories.length; i++)
        Categories(
            id: widget.categories.map((e) => e.id).toList().elementAt(i),
            name: widget.categories.map((e) => e.name).toList().elementAt(i))
    ];

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filtters",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          child: Icon(Icons.close,
                              color: Theme.of(context).primaryColorLight),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Types",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontFamily: 'RobotoM',
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: DropdownButtonFormField(
                          value: currentItem,
                          items: _categories
                              .map((e) => DropdownMenuItem(
                                  value: e.id,
                                  child: Text(e.name![0].toUpperCase() +
                                      e.name.toString().substring(1))))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              currentItem = value!;
                              
                            });
                          },
                        ),
                      ),
                    Text_rangeSlider(context, "Size",widget.rangeSize, 7, 32, 50),
                    Text_rangeSlider(context, "Weight", widget.rangeCarat, 12, 24, 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                               widget.active_filter = true;
                                widget.rangeSize = RangeValues(7, 32);
                                widget.rangeCarat = RangeValues(12, 24);
                               widget.searchController.text = '';
                               widget.onChanged(widget.active_filter);
                               
                              });
                              widget.AllItems(true);
                              
                              Future.delayed(
                                Duration(milliseconds: 1000),
                                () {
                                  setState(() {
                                   widget.active_filter = false;
                                    widget.onChanged(widget.active_filter);
                                  });
                                },
                              );
                            },
                            icon: Icon(Icons.refresh)),
                        InkWell(
                          onTap: () {
                            setState(() {
                              widget.active_filter = true;
                              widget.onChanged(widget.active_filter);
                            });
                           widget.AllItems(true,
                                search:widget.searchController.text,
                                size_start: widget.start_size,
                                size_end: widget.end_size,
                                mount_start: widget.start_carat,
                                mount_end: widget.end_carat);
                            Future.delayed(Duration(milliseconds: 500), () {
                              setState(() {
                                widget.active_filter = false;
                                widget.onChanged(widget.active_filter);
                              });
                            });
                          },
                          child: Container(
                            width: 75,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).primaryColorLight,
                            ),
                            child: Center(
                              child: Text(
                                "Filter",
                                style: TextStyle(
                                  color: Theme.of(context).buttonColor,
                                  fontFamily: 'RobotoM',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }
  StatefulBuilder Text_rangeSlider(BuildContext context, String lable,
      RangeValues range, double min, double max, int div) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  '${lable}: ${range.start.toStringAsFixed(1)} to ${range.end.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontFamily: 'RobotoM',
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
              ),
              RangeSlider(
                divisions: div,
                values: range,
                min: min,
                max: max,
                activeColor: Theme.of(context).primaryColorLight,
                inactiveColor:
                    Theme.of(context).primaryColorLight.withOpacity(0.3),
                labels: RangeLabels(
                  range.start.toString(),
                  range.end.toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    range = values;
                    if (lable.contains("Size")) {
                      widget.start_size = range.start;
                      widget.end_size = range.end;
                    }
                    if (lable.contains("Carat")) {
                      widget.start_carat = range.start;
                      widget.end_carat = range.end;
                    }
                  });
                },
              )
            ],
          ),
        );
      },
    );
  }
}
