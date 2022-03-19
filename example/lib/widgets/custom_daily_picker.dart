import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class CustomDailyDate extends StatefulWidget {
  String label;
  String lang;
  TextEditingController controller = TextEditingController();
  TextEditingController controllerlan = TextEditingController();
  CustomDailyDate({ this.label ,this.lang,  this.controller,this.controllerlan});

  @override
  State<CustomDailyDate> createState() => _CustomDailyDateState();
}

class _CustomDailyDateState extends State<CustomDailyDate> {

  FocusNode _focusNode = FocusNode();
  DateFormat _dateFormat = DateFormat('dd:m:H');
  // DateFormat _monthFormat = DateFormat('MMMM');
  // DateFormat _yearFormat = DateFormat('yyyy');
  DateFormat _dayFormat = DateFormat('dd');
  DateFormat _minuteFormat = DateFormat('m');
  DateFormat _hourFormat = DateFormat('h:mm a');
  DateFormat _hourFormatlang = DateFormat('h:mm a');

  DateTime _chosenDate=DateTime.now();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
_hourFormatlang = DateFormat('h:mm a',widget.lang);
    _chosenDate = DateTime.now();

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
              CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                 minuteInterval: 30,
                onDateTimeChanged: (value) {
                  _chosenDate=value;
                  widget.controller.text=_hourFormat.format(value).toString();
                  widget.controllerlan.text=_hourFormatlang.format(value).toString();
                },
                initialDateTime: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,DateTime.now().hour),
              ));
        });
  }
  @override
  Widget build(BuildContext context) {
    FocusNode focusNode=FocusNode();
    double height = MediaQuery.of(context).size.height;
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(

          readOnly: true,
          controller: widget.controllerlan,
          focusNode: focusNode,
          onTap: ()  {

              showPicker(context);

          },
          decoration: InputDecoration(
suffixIcon: Icon(Icons.keyboard_arrow_down_sharp, size: 20,),


              // contentPadding:
              // EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),

              alignLabelWithHint: true,
              labelStyle: TextStyle(
                  fontSize: focusNode.hasFocus ? 18 : 16.0,//I believe the size difference here is 6.0 to account padding
                  color:
                  focusNode.hasFocus ? Color(0xFF3F5521) : Colors.grey),
              labelText: widget.label,
              hintStyle:TextStyle(
                  color: Colors.black87,
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
