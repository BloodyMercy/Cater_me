import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'Screens/occasion/theme/colors/light_colors.dart';
class CustomDatePickerFormField extends StatefulWidget {
  String label;
  TextEditingController controller = TextEditingController();
  CustomDatePickerFormField({ this.label ,  this.controller});

  @override
  State<CustomDatePickerFormField> createState() => _CustomDatePickerFormFieldState();
}

class _CustomDatePickerFormFieldState extends State<CustomDatePickerFormField> {

  FocusNode _focusNode = FocusNode();
  DateFormat _dateFormat = DateFormat('yyyy/MM/dd');
  DateFormat _monthFormat = DateFormat('MMMM');
  DateFormat _yearFormat = DateFormat('yyyy');
  DateFormat _dayFormat = DateFormat('dd');

  DateTime _chosenDate=DateTime.now();
  String _chosenMonth="";
  String _chosenYear="";
  String _chosenDay="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chosenDate = DateTime.now();
    _chosenMonth = _monthFormat.format(_chosenDate);
    _chosenYear = _yearFormat.format(_chosenDate);
    _chosenDay = _dayFormat.format(_chosenDate);
  }
  @override


  void showPicker(ctx) {
    DatePicker.showDatePicker(
      ctx,
      onMonthChangeStartWithFirstDate: true,
      pickerTheme: DateTimePickerTheme(
        showTitle: false,
          backgroundColor:LightColors.kLightYellow2,
        itemTextStyle: TextStyle(
            color:Color(0xFF3F5521),
        ),
      ),

      initialDateTime: _chosenDate,

      minDateTime: DateTime.now(),
      dateFormat: 'MMMM-yyyy-dd',
      onClose: () {

      },
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(() {
          _chosenDate = dateTime;
          _chosenDay = _dayFormat.format(dateTime);
          _chosenMonth = _monthFormat.format(dateTime);
          _chosenYear = _yearFormat.format(dateTime);
          widget.controller.text = _dateFormat.format(dateTime);
        });
      },
    );
  }
  @override
  Widget build(BuildContext context) {   FocusNode focusNode=FocusNode();
  double height = MediaQuery.of(context).size.height;
  return Container(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        readOnly: true,
        controller: widget.controller,
        focusNode: focusNode,
        onTap: ()  {

          showPicker(context);

        },
        decoration: InputDecoration(
            suffixIcon: Icon(Icons.keyboard_arrow_down_sharp, size: 20,),


            contentPadding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),

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
