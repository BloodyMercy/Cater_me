import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/occasion.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/model/address/city.dart';
import 'package:CaterMe/model/address/country.dart';
import 'package:CaterMe/model/address/regular.dart';
import 'package:CaterMe/model/occasions/occasiontype.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomCupertinoPicker extends StatefulWidget {
  String label;
  TextInputType inputType;
  List<String> items;
  List<City> city;
  List<Country> country;
  List<NumberOfGuests> numberOfGuests;
  List<Events> events;
  List<OccassionType> listoccasiontype;
  int selectedValue;

  TextEditingController controller = TextEditingController();

  CustomCupertinoPicker(
      {required this.label,
      required this.inputType,
      required this.items,
      this.city = const [],
      this.country = const [],
      this.numberOfGuests = const [],
      this.events = const [],
      this.listoccasiontype = const [],
      this.selectedValue = 0,
      required this.controller});

  @override
  State<CustomCupertinoPicker> createState() => _CustomCupertinoPickerState();
}

class _CustomCupertinoPickerState extends State<CustomCupertinoPicker> {
  FocusNode _focusNode = FocusNode();
  buildItems() {
    List<Widget> items = [];
    for (int i = 0; i < widget.items.length; i++) {
      items.add(
        Center(
            child: Text(
          widget.items[i].toString(),
          style: TextStyle(color: Colors.white),
        )),
      );
    }
    return items;
  }

  @override
  void dispose() {
    // widget.controller.dispose();

    super.dispose();
  }

  // @override
  // void initState(){
  //   if(widget.selectedValue==-1 || widget.selectedValue == null) {
  //     widget.selectedValue = 0;
  //     setState(() {
  //
  //     });
  //   }
  //   else{
  //     widget.controller.text = widget.items[widget.selectedValue];
  //     setState(() {
  //
  //     });
  //   }
  // }
  void showPicker(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: colorCustom,
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xffE6E4EA),
                      width: 0.25,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text(
                        "Pick " + widget.label.toLowerCase(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                      onPressed: () {
                        if (widget.label == 'Country') {
                          final adress =
                              Provider.of<AdressProvider>(ctx, listen: false);
                          adress.listcityname.clear();
                          adress.listcity.clear();
                          adress.countrycontroller.text = widget
                              .country[widget.selectedValue].id
                              .toString();
                          adress.countrycontrollerstring.text = widget
                              .country[widget.selectedValue].name
                              .toString();
                          adress.getallcity(
                              widget.country[widget.selectedValue].id!);
                          Navigator.of(context).pop();
                        }

                        if (widget.label == "City") {
                          final adress =
                              Provider.of<AdressProvider>(ctx, listen: false);
                          adress.citycontroller.text =
                              widget.city[widget.selectedValue].id.toString();
                          adress.citycontrollerstring.text =
                              widget.city[widget.selectedValue].name.toString();
                          Navigator.of(context).pop();
                        }
                        if (widget.label == "Numbers Of Guests") {
                          final adress =
                              Provider.of<AdressProvider>(ctx, listen: false);
                          adress.numberofguestcontroller.text = widget
                              .numberOfGuests[widget.selectedValue].id
                              .toString();
                          Navigator.of(context).pop();
                        }
                        if (widget.label == "Type Of Event") {
                          final adress =
                              Provider.of<AdressProvider>(ctx, listen: false);
                          adress.typeofeventcontroller.text =
                              widget.events[widget.selectedValue].id.toString();
                          Navigator.of(context).pop();
                        }
                        if (widget.label == 'Type of Occasion') {
                          final occa=Provider.of<OccasionProvider>(context,listen: false);
                          occa.typeofoccasioncontroller.text =
                              widget.listoccasiontype[widget.selectedValue].id.toString();
                          Navigator.of(context).pop();
                        }
                      },
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 5.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 250,
                child: CupertinoPicker(
                  backgroundColor: colorCustom,
                  onSelectedItemChanged: (value) {
                    setState(() {
                      widget.selectedValue = value;
                      widget.controller.text =
                          widget.items[widget.selectedValue];
                    });
                    if (widget.label == 'Country') {
                      final adress =
                          Provider.of<AdressProvider>(ctx, listen: false);
                      adress.listcityname.clear();
                      adress.listcity.clear();
                      adress.countrycontroller.text =
                          widget.country[widget.selectedValue].id.toString();
                      adress
                          .getallcity(widget.country[widget.selectedValue].id!);
                    }
                    if (widget.label == 'City') {
                      final adress =
                          Provider.of<AdressProvider>(ctx, listen: false);
                      adress.citycontroller.text =
                          widget.city[widget.selectedValue].id.toString();
                    }

                    if (widget.label == "Numbers Of Guests") {
                      final adress =
                          Provider.of<AdressProvider>(ctx, listen: false);
                      adress.numberofguestcontroller.text = widget
                          .numberOfGuests[widget.selectedValue].id
                          .toString();
                      adress.numberofguestcontrollerstring.text = widget
                          .numberOfGuests[widget.selectedValue].title
                          .toString();
                    }
                    if (widget.label == "Type Of Event") {
                      final adress =
                          Provider.of<AdressProvider>(ctx, listen: false);
                      adress.typeofeventcontroller.text =
                          widget.events[widget.selectedValue].id.toString();
                      adress.typeofeventcontrollerstring.text =
                          widget.events[widget.selectedValue].name.toString();
                    }

                    if (widget.label == 'Type of Occasion') {
                      final occa=Provider.of<OccasionProvider>(context,listen: false);
                      occa.typeofoccasioncontroller.text =
                          widget.listoccasiontype[widget.selectedValue].id.toString();
                    }
                  },
                  scrollController: FixedExtentScrollController(
                      initialItem: widget.selectedValue),
                  itemExtent: 40.0,
                  children: [...buildItems()],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
          color: Colors.white, //white
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              focusNode: _focusNode,
              controller: widget.controller,
              onTap: () {
                _focusNode.unfocus();
                showPicker(context);
              },
              readOnly: true,
              keyboardType: this.widget.inputType,
              maxLines: null,
              style: TextStyle(
                color: Colors.black, //black
                fontSize: 12,
              ),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 13, vertical: 0),
                labelText: this.widget.label,
                floatingLabelStyle: Theme.of(context).textTheme.headline4,
                labelStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
            size: 14,
          )
        ],
      ),
    );
  }
}
