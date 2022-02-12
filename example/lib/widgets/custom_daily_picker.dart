import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';


class CustomDailyDate extends StatefulWidget {
  String label;
  TextEditingController controller = TextEditingController();
  CustomDailyDate({ this.label ,  this.controller});

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
  DateFormat _hourFormat = DateFormat('H');

  DateTime _chosenDate=DateTime.now();
  String _chosenMin="";
  String _chosenHour="";
  String _chosenMonth="";
  String _chosenYear="";
  String _chosenDay="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chosenDate = DateTime.now();
    _chosenHour="";
    _chosenMin="";


    _chosenDay = _dayFormat.format(_chosenDate);
    _chosenMin = _minuteFormat.format(_chosenDate)  ;
    _chosenHour = _hourFormat.format(_chosenDate) ;

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
      dateFormat: 'dHm',
      onClose: () {

      },
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(() {
          _chosenDate = dateTime;
          _chosenDay = _dayFormat.format(dateTime);
          _chosenHour = _hourFormat.format(dateTime);
          _chosenMin = _minuteFormat.format(dateTime) ;
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
          color: LightColors.kLightYellow2,
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
