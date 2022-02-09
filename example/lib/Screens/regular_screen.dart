import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Screens/widgets/custom_cupertino_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../custom_date_picker_form_field.dart';

class ReguarScreen extends StatefulWidget {
  const ReguarScreen({Key  key}) : super(key: key);

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

  bool loading = true;
  @override
  Widget build(BuildContext context) {
final address=Provider.of<AdressProvider>(context,listen: true);
    var screenHeight = MediaQuery.of(context).size.height;
    return  SizedBox(
      height: screenHeight * 1,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
        child: Column(
          children: [
            // Center(
            //   child: Image.asset(
            //     'images/REGULAR.png',
            //     height: screenHeight * 0.275,
            //   ),
            // ),
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

                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     labelText: 'Event Date',
                  //     labelStyle: Theme.of(context).textTheme.headline4,
                  //     contentPadding: const EdgeInsets.only(left: 20),
                  //   ),
                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                  //   validator: MultiValidator([
                  //     RequiredValidator(errorText: 'Required *'),
                  //     // EmailValidator(errorText: 'Not a valid email'),
                  //   ]),
                  // ),

                  Container(
                    height: MediaQuery.of(context).size.height/8,

                    child:CustomDatePickerFormField(

                      label: "Event Date",
                      controller: address.evendatecontroller,
                    ),
                  ),
                  // SizedBox(height: screenHeight * 0.02),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     labelText: 'Number of guests',
                  //     labelStyle: Theme.of(context).textTheme.headline4,
                  //     contentPadding: const EdgeInsets.only(left: 20),
                  //   ),
                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                  //   validator: MultiValidator([
                  //     RequiredValidator(errorText: 'Required *'),
                  //     // EmailValidator(errorText: 'Not a valid email'),
                  //   ]),
                  // ),
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
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     labelText: 'Type of Event',
                  //     labelStyle: Theme.of(context).textTheme.headline4,
                  //     contentPadding: const EdgeInsets.only(left: 20),
                  //   ),
                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                  //   validator: MultiValidator([
                  //     RequiredValidator(errorText: 'Required *'),
                  //     // EmailValidator(errorText: 'Not a valid email'),
                  //   ]),
                  // ),
                  CustomCupertinoPicker(
                    label:"Type Of Event",
                    items:address.listnameevent,
                    events: address.regular.events,
                    selectedValue: 0,
                    inputType: TextInputType.number,
                    controller: address.typeofeventcontrollerstring,

                  ),
                  // SizedBox(height: screenHeight * 0.0125),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     validate();
                  //   },
                  //   child: Text(
                  //     'Next',
                  //     style: Theme.of(context).textTheme.headline1,
                  //   ),
                  //   style: ElevatedButton.styleFrom(
                  //     padding: EdgeInsets.fromLTRB(
                  //         screenHeight * 0.18,
                  //         screenHeight * 0.02,
                  //         screenHeight * 0.18,
                  //         screenHeight * 0.02),
                  //     onPrimary: Theme.of(context).primaryColor,
                  //     primary: const Color.fromRGBO(63, 85, 33, 1),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(15.0),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
