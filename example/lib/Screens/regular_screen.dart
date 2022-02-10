import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Screens/widgets/custom_cupertino_picker.dart';
import 'package:CaterMe/model/friend_model.dart';
import 'package:CaterMe/widgets/Frriends/friends_list.dart';
import 'package:CaterMe/widgets/custom_daily_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../custom_date_picker_form_field.dart';
import 'occasion/theme/colors/light_colors.dart';

class ReguarScreen extends StatefulWidget {
  ReguarScreen(List<FriendModel> friends);

  // final List<FriendModel> Friends;
  //  ReguarScreen(this.Friends);

  @override
  _ReguarScreenState createState() => _ReguarScreenState();
}

class _ReguarScreenState extends State<ReguarScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool validate() {
    if (formkey.currentState != null) {
      if (formkey.currentState.validate()) {
        print('Validated');
        return true;
      } else {
        // ignore: avoid_print
        print('Not validated');
        return false;
      }
    }
    return false;
  }
  DateTime _selectedDay = DateTime.utc(2000, 10, 16);

getData()async{
  final address=Provider.of<AdressProvider>(context,listen: false);
 await address.getRegular();
}
@override
  void initState() {
  getData();
    super.initState();
  }
  int _value = -1;
  bool loading = true;

  @override
  Widget build(BuildContext context,) {
final address=Provider.of<AdressProvider>(context,listen: true);
    var screenHeight = MediaQuery.of(context).size.height;
    return   SingleChildScrollView(
      child: Container(
        color: LightColors.kLightYellow,
        height: screenHeight * 1,
        child: Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          child: Column(
            children: [

              SizedBox(height: screenHeight * 0.03),



              Form(
                key: formkey,
                child: Column(
                  children: [

                    TextFormField(
                      controller: address.eventnamecontroller,
                      decoration: const InputDecoration(
                        labelText: 'Event Name',
                        contentPadding: EdgeInsets.only(left: 20),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Required *'),
                        // EmailValidator(errorText: 'Not a valid email'),
                      ]),

                    ),
                    SizedBox(height: screenHeight * 0.02),




                    Container(

                      height: MediaQuery.of(context).size.height/8,

                      child:CustomDatePickerFormField(

                        label: "Event Date",
                        controller: address.evendatecontroller,

                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(

                      height: MediaQuery.of(context).size.height/8,

                      child:CustomDailyDate(

                        label: "Daily Date",
                        controller: address.DailyDatecontroller,

                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),
                    CustomCupertinoPicker(
                      label:"Numbers Of Guests",
                      items:address.listnamenumber,
                      numberOfGuests: address.regular.numberOfGuests,
                      selectedValue: 1,
                      inputType: TextInputType.number,
                      controller: address.numberofguestcontrollerstring,
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    CustomCupertinoPicker(
                      label:"Type Of Event",
                      items:address.listnameevent,
                      events: address.regular.events,
                      selectedValue: 0,
                      inputType: TextInputType.number,
                      controller: address.typeofeventcontrollerstring,

                    ),


                    Center(
                      child: Text('Contact Person',style: TextStyle(
                          color: Color(0xFF3F5521),
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),),
                    ),
//                   ListView.builder(
//                       padding: const EdgeInsets.all(8),
//                       itemCount: 1,
//                       itemBuilder: (BuildContext context, int i) {
//                         return Row(
//                           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             // SizedBox(
//                             //   width: 45,
//                             // ),
//                             Radio(
//                               toggleable: true,
//                               groupValue: address.value2Index,
//                               //  value: i,
//                               onChanged: (value) {
//                                 setState(() {
// //    _value = i;
//                                   address.value2Index = i;
//                                 });
//                                 address.value = address.Friends[i];
//                               },
//                             ),
//                             Row(
//
//                               children: [
//                                 Text('Me',style: TextStyle(
//                                     color: Color(0xFF3F5521),
//                                     fontWeight: FontWeight.normal,
//                                     fontSize: 20
//                                 ),),
//                                 SizedBox(width:MediaQuery.of(context).size.width*0.28),
//                                 Radio(
//                                   toggleable: true,
//                                   groupValue: address.value1Index,
//                                   //  value: i,
//                                   onChanged: (value) {
//                                     setState(() {
// //    _value = i;
//                                       address.value2Index = i;
//                                     });
//                                     address.value = address.Friends[i];
//                                   },
//                                 ),
//                                 Text('Other',style: TextStyle(
//                                     color: Color(0xFF3F5521),
//                                     fontWeight: FontWeight.normal,
//                                     fontSize: 20
//                                 ),),
//
//
//                               ],
//                             ),
//
//                           ],
//                         );
//                       }
//                   ),



                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );










  }
}
