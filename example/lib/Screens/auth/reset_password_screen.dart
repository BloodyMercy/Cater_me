import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/Screens/auth/separatedotp.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/Screens/otpverify/widget/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../language/language.dart';
import 'confirm_email.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var _dialCode = "";

  void _callBackFunction(String name, String dialCode, String flag) {
    _dialCode = dialCode;
  }
TextEditingController alpha =TextEditingController();

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

  bool loading = false;
  final TextEditingController reset = TextEditingController();
  final _scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<UserProvider>(context, listen: true);
    var appbar = AppBar(
      title: Text(
        '${authprovider.lg[authprovider.language]["Forgot Password"]}',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'BerlinSansFB',
            fontSize: 16),
      ),
      centerTitle: true,
      // backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          color: Colors.white,
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
      key: _scaffold,
      appBar: appbar,
      body: SingleChildScrollView(
        child: Container(
          color: LightColors.kLightYellow,
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.3, child: Center(child: Text('Change Password by Phone OTP'),),),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 37.0, right: 37.0),
                child: Column(children: [
                  Center(
                    child: Form(
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: formkey,
                      child: Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(10.0),
                              child:
                               TextFormField(
                                 controller:alpha ,
                                // controller: friends.phonecontroller,
                                // focusNode: focusnode,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '${authprovider.lg[authprovider.language]["Please enter phone number"]}';
                                  } else
                                    return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide()),
                                    // contentPadding: EdgeInsets.only(
                                    //     left: MediaQuery.of(context).size.width * 0.04),
                                    alignLabelWithHint: true,
                                    labelStyle: TextStyle(
                                        //fontSize: focusnode.hasFocus ? 18 : 16.0,
                                        //I believe the size difference here is 6.0 to account padding
                                        // color: focusnode.hasFocus
                                        //     ? Color(0xFF3F5521)
                                        //     : Colors.grey
                                        ),
                                    prefixIcon: CountryPicker(
                                      _callBackFunction,
                                      '${authprovider.lg[authprovider.language]["Select Country"]}',
                                      Theme.of(context).primaryColor,
                                      Colors.white,
                                    ),
                                    labelText:
                                        '${authprovider.lg[authprovider.language]['Phone number']}',
                                    hintStyle: TextStyle(
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
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          color: Color(0xFF3F5521),
                                        ))),
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'BerlinSansFB'),
                              )),

                        ],
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(height: screenHeight * 0.3),
              !loading
                  ? ElevatedButton(
                      onPressed: () async {

                        Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                             PhoneVerification1(check: true,contact: "+966"+alpha.text, dialcode: "+966")));

                       },
                      child: Text(
                        '${authprovider.lg[authprovider.language]["Send"]}',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(
                            screenHeight * 0.14,
                            screenHeight * 0.02,
                            screenHeight * 0.14,
                            screenHeight * 0.02),
                        onPrimary: const Color.fromRGBO(255, 255, 255, 1),
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    )
                  : Center(child: CircularProgressIndicator())
            ],
          ),
        ),
      ),
    ));
  }
}
