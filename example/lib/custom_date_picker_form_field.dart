import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';
class CustomDatePickerFormField extends StatefulWidget {
  String label;
  TextEditingController controller = TextEditingController();
  CustomDatePickerFormField({required this.label , required this.controller});

  @override
  State<CustomDatePickerFormField> createState() => _CustomDatePickerFormFieldState();
}

class _CustomDatePickerFormFieldState extends State<CustomDatePickerFormField> {

  FocusNode _focusNode = FocusNode();
  DateFormat _dateFormat = DateFormat('dd/MM/yy');
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
          backgroundColor: Color(0xFF3F5521),
        itemTextStyle: TextStyle(
            color: Colors.white
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
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(

      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              focusNode: _focusNode,
              controller:widget.controller,
              onTap: (){
                _focusNode.unfocus();
                showPicker(context);
              },
              readOnly: true,
              maxLines: null,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                contentPadding: EdgeInsets.symmetric(horizontal: 13,vertical:0),
                labelText: this.widget.label,
                //hintText: 'sdsad',
                floatingLabelStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w300,

                ),
                labelStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w300
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.keyboard_arrow_down,color: Color(0xff9FACBD),size: 14,)
        ],
      ),
    );
  }
}
