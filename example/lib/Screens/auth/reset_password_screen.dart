import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'confirm_email.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String validate() {
    if (formkey.currentState.validate()) {
      // ignore: avoid_print
      print('Validated');
      // reset!=null?
    } else {
      // ignore: avoid_print
      print('Not validated');
    }
  }

  final TextEditingController reset = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      title: Text(
        'Forgot Password',
        style: Theme.of(context).textTheme.headline3,
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      elevation: 0,
    );
    var screenHeight = MediaQuery.of(context).size.height -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        appBar: appbar,
        body: SingleChildScrollView(
          child: Container(
            color: LightColors.kLightYellow,
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.12),
                Text(
                  'Enter your email and will send\nyou instructions on how to reset it',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: screenHeight * 0.12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 37.0, right: 37.0),
                  child: Column(
                    children: [
                      Center(
                        child: Form(
                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: formkey,
                          child: Column(children: [
                            TextFormField(
                              controller: reset,
                              // onSaved: (value) => email = value,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                prefixIcon: IconButton(
                                  icon: const Icon(Icons.mail_outline),
                                  onPressed: () {},
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: screenHeight * 0.03,
                                    bottom: screenHeight * 0.025,
                                    top: screenHeight * 0.025),
                                hintText: 'Email or Phone number',
                                hintStyle:
                                    Theme.of(context).textTheme.headline4,
                              ),

                              validator: MultiValidator([
                                RequiredValidator(errorText: 'Required *'),
                              ]),

                              keyboardType: TextInputType.emailAddress,
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.4),
                      ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState.validate() == false) {
                            // ignore: avoid_print
                            print('Not Validated');
                            // reset!=null?
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ConfirmEmailSent()));
                          }
                        },
                        child: Text(
                          'Send',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(
                              screenHeight * 0.18,
                              screenHeight * 0.02,
                              screenHeight * 0.18,
                              screenHeight * 0.02),
                          onPrimary: const Color.fromRGBO(255, 255, 255, 1),
                          primary: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
