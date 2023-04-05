import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelery_shop_managmentsystem/model/filter_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyWidget extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final ValueChanged<String> onChangedCaratType;
  final ValueChanged<String> onChangedCaratNo;
  final ValueChanged<int> onChangedCategory;
  final ValueChanged<double> onChangestart_size;
  final ValueChanged<double> onChangeend_size;
  final ValueChanged<double> onChangestart_weight;
  final ValueChanged<double> onChangeend_weight;
  final List<Category> categories;
  final List<String> carates;
  final List<String> caratTypes;
  final ValueChanged<bool> onChangedfilter;
  bool active_filter;
  TextEditingController searchController;
  Function(
    bool first, {
    String search,
    double size_start,
    double size_end,
    double weight_start,
    double weight_end,
    int categoryId,   
  }) AllItems;

  dynamic rangeSize;
  dynamic rangeCarat;

  int categoryId;
  MyWidget({
    super.key,
    required this.categories,
    required this.active_filter,
    required this.searchController,
    required this.AllItems,
    required this.rangeSize,
    required this.rangeCarat,
    required this.onChanged,
    required this.carates,
    required this.caratTypes,
    required this.categoryId,
    required this.onChangestart_size,
    required this.onChangeend_size,
    required this.onChangestart_weight,
    required this.onChangeend_weight,
    required this.onChangedCategory,
    required this.onChangedCaratType,
    required this.onChangedCaratNo,
   required this.onChangedfilter
  });


  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int currentType = 0;
  int currentCaratType = 0;
  int currentCaratNo = 0;
  double startSize = 0;
  double endSize = 0;
  double startWeight = 0;
  double endWeight = 0;
  String type='';
  String caratNo='';

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
    List<Category> _categories = [
      Category(id: 0, name: 'All'),
      for (int i = 0; i < widget.categories.length; i++)
        Category(
            id: widget.categories.map((e) => e.id).toList().elementAt(i),
            name: widget.categories.map((e) => e.name).toList().elementAt(i))
    ];

    List<Carats> _carates = [
      Carats(id: 0,carat: "All"),
      for (int i = 0; i < widget.carates.length; i++)
         Carats(id: i+1,carat: widget.carates.map((e) => e).toList().elementAt(i))
    ];

    List<CaratType> _carattype = [
      CaratType(id: 0,caratType: "All"),
      for (int i = 0; i < widget.caratTypes.length; i++)
         CaratType(id: i+1,caratType: widget.caratTypes.map((e) => e).toList().elementAt(i))
    ];
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            elevation: 5,
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                         AppLocalizations.of(context)!.filters,
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
                         AppLocalizations.of(context)!.types,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontFamily: 'RobotoM',
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: DropdownButtonFormField(
                           dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                          value: currentType,
                          items: _categories
                              .map((e) => DropdownMenuItem(
                                  value: e.id,
                                  child: Text(e.name![0].toUpperCase() +
                                      e.name.toString().substring(1))))
                              .toList(),
                          onChanged: (int? value) {
                            setState(() {
                              currentType = value!;

                            });
                          },
                        ),
                      ),
                      Text(
                         AppLocalizations.of(context)!.carat,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontFamily: 'RobotoM',
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: DropdownButtonFormField(
                           dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                          value: currentCaratNo,
                          items: _carates
                              .map((e) => DropdownMenuItem(
                                  value: e.id,
                                  child: Text(e.carat!),
                                      ))
                              .toList(),
                          onChanged: (value) {
                           currentCaratNo=value as int;
                          int index= _carates.indexWhere((element) => element.id==currentCaratNo);
                         if(_carates[index].carat=='All'){
                          caratNo='';
                         }else{
                          caratNo=_carates[index].carat!;
                         }
                         widget.onChangedCaratNo(caratNo);
                          },
                        ),
                      ),
                      Text(
                         AppLocalizations.of(context)!.caratTypes,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontFamily: 'RobotoM',
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: DropdownButtonFormField(
                           dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                          value: currentCaratType,
                          items: _carattype
                              .map((e) => DropdownMenuItem(
                                  value: e.id,
                                  // child: Text(e.caratType!),
                                  child: Text(e.caratType![0].toUpperCase() +
                                      e.caratType.toString().substring(1))
                                      ))
                              .toList(),
                          onChanged: (value) {
                           currentCaratType=value as int;
                          int index= _carattype.indexWhere((element) => element.id==currentCaratType);
                         if(_carattype[index].caratType=='All'){
                          type='';
                         }else{
                          type=_carattype[index].caratType!;
                         }
                         widget.onChangedCaratType(type);
                         
                          },
                        ),
                      ),
                      Text_rangeSlider(
                          context,  AppLocalizations.of(context)!.size, widget.rangeSize, 7, 32, 50),
                      Text_rangeSlider(
                          context,  AppLocalizations.of(context)!.weight , widget.rangeCarat, 12, 24, 12),
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
                                  startSize = 0;
                                  endSize = 0;
                                  widget.onChangeend_size(0);
                                  widget.onChangestart_size(0);
                                  startWeight = 0;
                                  endWeight = 0;
                                  widget.onChangestart_weight(0);
                                  widget.onChangeend_weight(0);
                                  widget.onChangedCategory(0);
                                  widget.onChangedCaratNo('');
                                  widget.onChangedCaratType('');
                                  currentCaratType = 0;
                                  currentCaratNo=0;
                                  currentType = 0;
                                  Navigator.pop(context);
                                });
                                widget.AllItems(true);

                                Future.delayed(
                                  Duration(milliseconds: 1000),
                                  () {
                                    setState(() {
                                      widget.active_filter = false;
                                      widget.onChanged(widget.active_filter);
                                       widget.onChangedfilter(false);
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
                                 widget.onChangedfilter(true);
                                Navigator.pop(context);
                              });
                              widget.AllItems(
                                true,
                                search: widget.searchController.text,
                                size_start: startSize,
                                size_end: endSize,
                                weight_start: startWeight,
                                weight_end: endWeight,
                                categoryId: currentType,
                              );
                              widget.onChangedCaratNo(caratNo);
                              widget.onChangedCategory(currentType);
                              widget.onChangedCaratType(type);
                              Future.delayed(Duration(milliseconds: 500), () {
                                setState(() {
                                  widget.active_filter = false;
                                  widget.onChanged(widget.active_filter);
                                  // widget.onChangedfilter(true);
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
                                   AppLocalizations.of(context)!.filter,
                                  style: TextStyle(
                                    color: Theme.of(context).scaffoldBackgroundColor,
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
                      startSize = range.start;
                      widget.onChangestart_size(startSize);

                      endSize = range.end;
                      widget.onChangeend_size(endSize);
                    }
                    if (lable.contains("Weight")) {
                      startWeight = range.start;
                      widget.onChangestart_weight(startWeight);
                      endWeight = range.end;
                      widget.onChangeend_weight(endWeight);
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
