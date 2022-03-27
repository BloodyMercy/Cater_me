import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/occasion.dart';
import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/model/address/city.dart';
import 'package:CaterMe/model/address/country.dart';
import 'package:CaterMe/model/address/regular.dart';
import 'package:CaterMe/model/occasions/occasiontype.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../language/language.dart';

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
      { this.label,
       this.inputType,
       this.items,
      this.city = const [],
      this.country = const [],
      this.numberOfGuests = const [],
      this.events = const [],
      this.listoccasiontype = const [],
      this.selectedValue = 0,
       this.controller});

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
          style: TextStyle(color: Color(0xFF3F5521),),
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
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.text=widget.items[1];

  }

  void showPicker(BuildContext ctx) {

    final authProvider = Provider.of<UserProvider>(context, listen: false);
    showCupertinoModalPopup(

        context: ctx,
        builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
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
                        "${authProvider.lg[authProvider.language]["Pick"]} " + widget.label.toLowerCase(),
                        style: TextStyle(
                            color: Color(0xFF3F5521), fontWeight: FontWeight.w300),
                      ),

                      onPressed: () {
                        if (widget.label == '${authProvider.lg[authProvider.language]["Country"]}') {
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
                              widget.country[widget.selectedValue].id);
                          Navigator.of(context).pop();
                        }

                        if (widget.label == "${authProvider.lg[authProvider.language]["City"]}") {
                          final adress =
                              Provider.of<AdressProvider>(ctx, listen: false);
                          adress.citycontroller.text =
                              widget.city[widget.selectedValue].id.toString();
                          adress.citycontrollerstring.text =
                              widget.city[widget.selectedValue].name.toString();
                          Navigator.of(context).pop();
                        }
                        if (widget.label == "${authProvider.lg[authProvider.language]["Number Of Guests"]}") {
                          final adress =
                              Provider.of<AdressProvider>(ctx, listen: false);
                          adress.numberofguestcontroller.text = widget
                              .numberOfGuests[widget.selectedValue].id
                              .toString();
                          adress.numberofguestcontrollerstring.text = widget
                              .numberOfGuests[widget.selectedValue].title
                              .toString();
                          Navigator.of(context).pop();
                        }
                        if (widget.label == "${authProvider.lg[authProvider.language]["Type Of Event"]}") {
                          final adress =
                              Provider.of<AdressProvider>(ctx, listen: false);

                          adress.typeofeventcontroller.text =
                              widget.events[widget.selectedValue].id.toString();
                          adress.typeofeventcontrollerstring.text =
                              widget.events[widget.selectedValue].name.toString();
                          Navigator.of(context).pop();
                        }
                        if (widget.label == "${authProvider.lg[authProvider.language]["Type of Occasion"]}") {
                          final occa=Provider.of<OccasionProvider>(context,listen: false);
                          occa.typeofoccasioncontroller.text =
                              widget.listoccasiontype[widget.selectedValue+1].id.toString();

                          occa.typeofoccasioncontrollername.text =
                              widget.listoccasiontype[widget.selectedValue+1].name.toString();

                          Navigator.of(context).pop();
                        }
                        if (widget.label == "${authProvider.lg[authProvider.language]["Gender"]}") {
                          final authProvider = Provider.of<UserProvider>(context,listen: false);
                      authProvider.genderselected.text=widget.items[widget.selectedValue].toString();

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

                  backgroundColor: Colors.white,
                  onSelectedItemChanged: (value) {
                    setState(() {
                      widget.selectedValue = value;
                      widget.controller.text =
                          widget.items[widget.selectedValue];

                    });
                    if (widget.label == '${authProvider.lg[authProvider.language]["Country"]}') {
                      final adress =
                          Provider.of<AdressProvider>(ctx, listen: false);
                      adress.listcityname.clear();
                      adress.listcity.clear();
                      adress.countrycontroller.text =
                          widget.country[widget.selectedValue].id.toString();
                      adress
                          .getallcity(widget.country[widget.selectedValue].id);
                    }
                    if (widget.label =='${authProvider.lg[authProvider.language]["City"]}' ) {
                      final adress =
                          Provider.of<AdressProvider>(ctx, listen: false);
                      adress.citycontroller.text =
                          widget.city[widget.selectedValue].id.toString();
                    }

                    if (widget.label == '${authProvider.lg[authProvider.language]["Number Of Guests"]}') {
                      final adress =
                          Provider.of<AdressProvider>(ctx, listen: false);
                      adress.numberofguestcontroller.text = widget
                          .numberOfGuests[widget.selectedValue].id
                          .toString();
                      adress.numberofguestcontrollerstring.text = widget
                          .numberOfGuests[widget.selectedValue].title
                          .toString();
                    }
                    if (widget.label == '${authProvider.lg[authProvider.language]["Type Of Event"]}') {
                      final adress =
                          Provider.of<AdressProvider>(ctx, listen: false);
                      adress.typeofeventcontroller.text =
                          widget.events[widget.selectedValue].id.toString();
                      adress.typeofeventcontrollerstring.text =
                          widget.events[widget.selectedValue].name.toString();
                    }

                    if (widget.label == '${authProvider.lg[authProvider.language]["Type of Occasion"]}') {
                      final occa=Provider.of<OccasionProvider>(context,listen: false);
                      occa.typeofoccasioncontroller.text =
                          widget.listoccasiontype[widget.selectedValue].id.toString();
                    }
                  },

                  scrollController: FixedExtentScrollController(
                      initialItem: widget.selectedValue-1),
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
      height: MediaQuery.of(context).size.height/11,
     // margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white, //white
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextFormField(



        decoration: InputDecoration(


suffixIcon:Icon(
  Icons.keyboard_arrow_down,
  color: Colors.black,
  size: 24,
) ,

            alignLabelWithHint: true,
            labelStyle: TextStyle(
            fontFamily: 'BerlinSansFB',
                fontSize: _focusNode.hasFocus ? 20 : 18.0,//I believe the size difference here is 6.0 to account padding
                color:
                _focusNode.hasFocus ? Color(0xFF3F5521) : Colors.grey),
            labelText: widget.label,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(

                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: Color(0xFF3F5521),
                ))),
        style: TextStyle(color: Colors.black),

        focusNode: _focusNode,
        controller: widget.controller,
        onTap: () {
          _focusNode.unfocus();
          showPicker(context);
        },
        readOnly: true,
        keyboardType: this.widget.inputType,

      ),
    );
  }
}
