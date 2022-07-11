import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'Screens/occasion/theme/colors/light_colors.dart';

class CustomDatePickerFormField extends StatefulWidget {
  String label;
  String lang;
  String casee;
  TextEditingController controller ;
  TextEditingController controllerlan ;

  CustomDatePickerFormField({this.label,this.lang, this.controller,this.controllerlan,this.casee});

  @override
  State<CustomDatePickerFormField> createState() =>
      _CustomDatePickerFormFieldState();
}

class _CustomDatePickerFormFieldState extends State<CustomDatePickerFormField> {
  FocusNode _focusNode = FocusNode();
  DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  DateFormat _dateFormatlan = DateFormat('yyyy-MM-dd');
  DateFormat _monthFormat = DateFormat('MMMM');
  DateFormat _yearFormat = DateFormat('yyyy');
  DateFormat _dayFormat = DateFormat('dd');
  DateFormat alpha = DateFormat.yMMMMd("ar");
TextEditingController lol =TextEditingController();
  DateTime _chosenDate = DateTime.now().add(Duration(hours: 3));
  String _chosenMonth = "";
  String _chosenYear = "";
  String _chosenDay = "";
  DateTime beta = DateTime.now().add(Duration(hours: 3));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dateFormatlan=DateFormat.yMMMd('${widget.lang}');
//    _chosenDate = DateTime.now().add(Duration(hours: 3));
    if(widget.controller.text==""){
      print('EMMMMMMMMMMPTYYYYYYYYYYYYYYYYY');
//    widget.controller.text=_dateFormat.format(DateTime.now().add(Duration(hours: 3))).toString();
    }
//    beta =DateTime.parse(widget.controller.text);
    if(widget.controllerlan.text==""){
//    widget.controllerlan.text=_dateFormatlan.format(DateTime.now().add(Duration(hours: 3))).toString();

    }
    _chosenMonth = _monthFormat.format(_chosenDate);
    _chosenYear = _yearFormat.format(_chosenDate);
    _chosenDay = _dayFormat.format(_chosenDate);
//    widget.controller.text=_dateFormat.format(_chosenDate);
  }

  @override
  void showPicker(ctx) {
    showCupertinoModalPopup(
        context: context,

        builder: (BuildContext builder) {
          return Container(
              height: MediaQuery
                  .of(context)
                  .copyWith()
                  .size
                  .height * 0.25,
              color: Colors.white,
              child:
                  widget.casee=="signup"?
              CupertinoDatePicker(

                mode: CupertinoDatePickerMode.date,
minimumDate: DateTime(1900),

                maximumDate: DateTime.now(),
maximumYear: DateTime.now().year,
                onDateTimeChanged: (value) {
                  // _chosenDate = dateTime;
                  // _chosenDay = _dayFormat.format(dateTime);
                  // _chosenMonth = _monthFormat.format(dateTime);
                  // _chosenYear = _yearFormat.format(dateTime);
                  // widget.controller.text = _dateFormat.format(dateTime);
                 // lol.text=alpha.format(dateTime);
                  _chosenDate=value;
                  widget.controller.text=_dateFormat.format(value).toString();
                  widget.controllerlan.text=_dateFormatlan.format(value).toString();
                },
                 initialDateTime: DateTime(1900,1,1),
              ):                  widget.casee=="order"?
                  CupertinoDatePicker(

                    mode: CupertinoDatePickerMode.date,

                    minimumDate: DateTime.now(),
                    maximumYear:DateTime.now().year+1,
                    minimumYear: DateTime.now().year,
                    //minimumDate: DateTime.now(),

                    maximumDate: DateTime(DateTime.now().year+1,DateTime.now().month,DateTime.now().day),

                    onDateTimeChanged: (value) {
                      // _chosenDate = dateTime;
                      // _chosenDay = _dayFormat.format(dateTime);
                      // _chosenMonth = _monthFormat.format(dateTime);
                      // _chosenYear = _yearFormat.format(dateTime);
                      // widget.controller.text     _dateFormat.format(dateTime);
                      // lol.text=alpha.format(dateTime);
                      _chosenDate=value;
                      widget.controller.text=_dateFormat.format(value).toString();
                      widget.controllerlan.text=_dateFormatlan.format(value).toString();
                    },
                    initialDateTime: DateTime.now(),
                  ):
                  CupertinoDatePicker(

                    mode: CupertinoDatePickerMode.date,

                    minimumDate: DateTime.now(),
                    maximumYear:DateTime.now().year+1,
                    minimumYear: DateTime.now().year,
                    //minimumDate: DateTime.now(),

                    maximumDate: DateTime(DateTime.now().year+1),

                    onDateTimeChanged: (value) {
                      // _chosenDate = dateTime;
                      // _chosenDay = _dayFormat.format(dateTime);
                      // _chosenMonth = _monthFormat.format(dateTime);
                      // _chosenYear = _yearFormat.format(dateTime);
                      // widget.controller.text = _dateFormat.format(dateTime);
                      // lol.text=alpha.format(dateTime);
                      _chosenDate=value;
                      widget.controller.text=_dateFormat.format(value).toString();
                      widget.controllerlan.text=_dateFormatlan.format(value).toString();
                    },
                    initialDateTime: DateTime(1900,1,1),
                  )
          );
        });
    // DatePicker.showDatePicker(
    //
    //   ctx,
    //   onMonthChangeStartWithFirstDate: true,
    //   pickerTheme: DateTimePickerTheme(
    //
    //     showTitle: false,
    //     backgroundColor: LightColors.kLightYellow2,
    //     itemTextStyle: TextStyle(
    //       color: Color(0xFF3F5521),
    //     ),
    //   ),
    //   locale: DateTimePickerLocale.ar,
    //   initialDateTime: _chosenDate,
    //   minDateTime: DateTime.now(),
    //   maxDateTime: DateTime(DateTime.now().year+1),
    //
    //   onClose: () {},
    //   onCancel: () => print('onCancel'),
    //   onChange: (dateTime, List<int> index) {
    //     setState(
    //       () {
    //         _chosenDate = dateTime;
    //         _chosenDay = _dayFormat.format(dateTime);
    //         _chosenMonth = _monthFormat.format(dateTime);
    //         _chosenYear = _yearFormat.format(dateTime);
    //         widget.controller.text = _dateFormat.format(dateTime);
    //         lol.text=alpha.format(dateTime);
    //       },
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    double height = MediaQuery.of(context).size.height;
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          readOnly: true,
          controller: widget.controller,
          focusNode: focusNode,
          onTap: () {
            showPicker(context);
          },
          decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.keyboard_arrow_down_sharp,
                size: 20,
              ),
              // contentPadding: EdgeInsets.only(
              //     left: MediaQuery.of(context).size.width * 0.01),
              alignLabelWithHint: true,
              labelStyle: TextStyle(
                  fontSize: focusNode.hasFocus ? 18 : 16.0,
                  //I believe the size difference here is 6.0 to account padding
                  color: focusNode.hasFocus ? Color(0xFF3F5521) : Colors.grey),
              labelText: widget.label,
              hintStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BerlinSansFB'),
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
          style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'BerlinSansFB'),
        ));
  }
}
