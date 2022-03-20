import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../providers/user.dart';

class CountryPicker extends StatefulWidget {
  CountryPicker( this.callBackFunction, this.headerText, this.headerBackgroundColor, this.headerTextColor);

  final Function callBackFunction;
  final String headerText;
  final Color headerBackgroundColor;
  final Color headerTextColor;
  bool isInit = true;

  @override
  _CountryPickerState createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  List<CountryModel> countryList = [];
 CountryModel selectedCountryData;
@override
  void initState() {
    super.initState();
    readyotp();

  }

  readyotp() async{
    final data = await DefaultAssetBundle.of(context).loadString('images/countrycodes.json');
    setState(() {

      countryList = parseJson(data);
      selectedCountryData = countryList[0];
    });
    widget.callBackFunction(selectedCountryData.name, selectedCountryData.dialCode, selectedCountryData.flag);

  }

  List<CountryModel> parseJson(String response) {
    if (response == null) {
      return [];
    }
    final parsed = json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<CountryModel>((json) => CountryModel.fromJson(json as Map<String, dynamic>)).toList() as List<CountryModel>;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: InkResponse(
        onTap: () {
          showDialogue(context);
        },
        child: Container(
          width: 70,
          alignment: Alignment.center,
          child: Wrap(
            children: [
              Text(
                selectedCountryData != null ? selectedCountryData.flag : '',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                selectedCountryData != null ? selectedCountryData.dialCode : '',
                style: const TextStyle(fontSize: 17,color:  Color(0xff9FACBD)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showDialogue(BuildContext context) async {
    final countryData = await showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
       countryList,
      widget.callBackFunction,
        widget.headerText,
      widget.headerBackgroundColor,
       widget.headerTextColor,
      ),
    );
    if (countryData != null) {
      selectedCountryData = countryData as CountryModel;
    }
    setState(() {});
  }
}


class CustomDialog extends StatefulWidget {
  const CustomDialog(
      this.searchList,
  this.callBackFunction,
      this.headerText,
      this.headerBackgroundColor,
      this.headerTextColor);

  final List<CountryModel> searchList;
  final Function callBackFunction;
  final String headerText;
  final Color headerBackgroundColor;
  final Color headerTextColor;

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  List<CountryModel> tmpList = [];

  // dialogue inner widget
  Widget dialogContent(BuildContext context) {
   // UserProvider _user = Provider.of<UserProvider>(context, listen: true);
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Picker Header
          Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: widget.headerBackgroundColor ,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                )),
            child: Stack(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.headerText ,
                    style: TextStyle(fontSize: 18, color: widget.headerTextColor ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkResponse(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child:  Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            height: 45,
            decoration: BoxDecoration(
              color: const Color.fromARGB(8, 0, 0, 0),
              borderRadius: BorderRadius.circular(36),
            ),
            child: TextField(
              decoration:  InputDecoration(
                  hintText: "Search Country",
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 18.0,
                    color: Colors.black38,
                  )),
              onChanged: filterData,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: sdk_version_ui_as_code
                  ...tmpList.map(
                    (item) => 
     GestureDetector( behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.pop(context, item);
                        widget.callBackFunction(item.name, item.dialCode, item.flag);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.flag,
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Text(
                                item.name,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              item.dialCode,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // fliter data on search bar text change
  void filterData(String text) {
    tmpList = [];
    if (text == '') {
      tmpList.addAll(widget.searchList);
    } else {
      // ignore: avoid_function_literals_in_foreach_calls
      widget.searchList.forEach((userDetail) {
        // ignore: always_put_control_body_on_new_line
        if (userDetail.name.toLowerCase().contains(text.toLowerCase())) tmpList.add(userDetail);
      });
    }
    setState(() {});
  }

  // initiation of state
  @override
  void initState() {
    super.initState();
    tmpList = widget.searchList;
  }

  // build method
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

//country model
class CountryModel {
  const CountryModel( this.name, this.dialCode,  this.code, this.flag);

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    final flag = CountryModel.getEmojiFlag(json['code'] as String);
    return CountryModel(
   json['name'] as String,json['dial_code'] as String,  json['code'] as String,  flag);
  }

  final String name, dialCode, code, flag;

  //Converting country code into emoji flag
  static String getEmojiFlag(String emojiString) {
    const flagOffset = 0x1F1E6;
    const asciiOffset = 0x41;

    final firstChar = emojiString.codeUnitAt(0) - asciiOffset + flagOffset;
    final secondChar = emojiString.codeUnitAt(1) - asciiOffset + flagOffset;

    return String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
  }
}
