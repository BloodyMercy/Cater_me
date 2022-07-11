import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class customTextField extends StatefulWidget {

bool read;

String label;
TextEditingController controller;
customTextField({ this.controller,  this.label, this.read=false});
  @override
  _costumTextFieldState createState() => _costumTextFieldState();
}

class _costumTextFieldState extends State<customTextField> {
  DateFormat _dateFormat = DateFormat('yyyy/MM/dd');
  DateFormat _monthFormat = DateFormat('MMMM');
  DateFormat _yearFormat = DateFormat('yyyy');
  DateFormat _dayFormat = DateFormat('dd');

  DateTime _chosenDate=DateTime.now();
  String _chosenMonth="";
  String _chosenYear="";
  String _chosenDay="";
  void initState() {
    // TODO: implement initState
    super.initState();
    _chosenDate = DateTime.now();
    _chosenMonth = _monthFormat.format(_chosenDate);
    _chosenYear = _yearFormat.format(_chosenDate);
    _chosenDay = _dayFormat.format(_chosenDate);
  }


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

                mode: CupertinoDatePickerMode.date,



                maximumDate: DateTime(DateTime.now().year+1),
                initialDateTime: _chosenDate,

                minimumDate:_chosenDate,
                onDateTimeChanged: (dateTime) {
                  setState(() {
                    _chosenDate = dateTime;
                    _chosenDay = _dayFormat.format(dateTime);
                    _chosenMonth = _monthFormat.format(dateTime);
                    _chosenYear = _yearFormat.format(dateTime);
                    widget.controller.text = _dateFormat.format(dateTime);
                  });
                },
              ));
        });

  }


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    FocusNode focusNode = FocusNode();
    return  Container(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
readOnly: widget.read,
          controller: widget.controller,
          focusNode: focusNode,
          onTap: ()  {
  if(widget.read){
    showPicker(context);
   }
  },
          decoration: InputDecoration(



                // contentPadding:
                // EdgeInsets.only(left: mediaQuery.size.width * 0.04),

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
