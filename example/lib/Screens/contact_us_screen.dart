import 'package:CaterMe/Screens/contact_added%20copy.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'occasion/theme/colors/light_colors.dart';

class ContactUsScreen extends StatelessWidget {
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
bool loading=false;
  @override
  Widget build(BuildContext context) {
    var _mediaQueryText = MediaQuery.of(context).size.height;
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(
              );
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            iconSize: 30,
          ),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Contact Us',
            style: Theme.of(context).textTheme.headline1,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: _mediaQueryText*1,
            color: LightColors.kLightYellow,
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(height: _mediaQueryText * 0.05),
                  FittedBox(
                    child: Text(
                      'To get in touch, Please fill the below fields',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  SizedBox(height: _mediaQueryText * 0.07),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: Theme.of(context).textTheme.headline4,
                      contentPadding: const EdgeInsets.only(left: 20),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Required *'),
                    ]),
                  ),
                  SizedBox(height: _mediaQueryText * 0.04),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: Theme.of(context).textTheme.headline4,
                      contentPadding: const EdgeInsets.only(left: 20),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Required *'),
                    ]),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: _mediaQueryText * 0.04),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: Theme.of(context).textTheme.headline4,
                      contentPadding: const EdgeInsets.only(left: 20),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Required *'),
                    ]),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: _mediaQueryText * 0.04),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Subject',
                      labelStyle: Theme.of(context).textTheme.headline4,
                      contentPadding: const EdgeInsets.only(left: 20),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Required *'),
                    ]),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: _mediaQueryText * 0.04),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Message',
                      labelStyle: Theme.of(context).textTheme.headline4,
                      contentPadding: const EdgeInsets.only(left: 20),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Required *'),
                    ]),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: _mediaQueryText * 0.05),
                  ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState.validate() == false) {
                        // ignore: avoid_print
                        print('Not Validated');
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ContactAdded()),
                        );
                      }
                    },
                    child: Text(
                      'SEND',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(
                          _mediaQueryText * 0.18,
                          _mediaQueryText * 0.02,
                          _mediaQueryText * 0.18,
                          _mediaQueryText * 0.02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: const Color(0xff3F5521),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
