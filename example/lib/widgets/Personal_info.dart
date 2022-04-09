import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/Screens/auth/separatedotp.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';

import '../NavigationBar/navigation_bar.dart';
import '../Screens/otpverify/phone_verification.dart';
import '../Screens/otpverify/widget/country_picker.dart';
import '../customBirthdayPicker.dart';
import '../language/language.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  bool loadingButton = false;

  @override
  void initState() {
    getData();

    super.initState();
  }

  bool loading = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var _dialCode="";
  void _callBackFunction(String name, String dialCode, String flag) {
    _dialCode = dialCode;
  }
  getData() async {
    final personalInfo = Provider.of<UserProvider>(context, listen: false);
    await personalInfo.getPersonalInfo();
    setState(() {
      loading = false;
    });
  }

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

  DateTime _newDate;

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final address = Provider.of<AdressProvider>(context, listen: true);
    final user = Provider.of<UserProvider>(context, listen: true);

    var _mediaQuery =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          centerTitle: true,
          title: Text(
            '${user.lg[user.language]["Personal Info"]}',
            style: Theme.of(context).textTheme.headline1,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: loading
            ? Container(
                color: LightColors.kLightYellow,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF3F5521),
                  ),
                ),
              )
            : Container(
                color: LightColors.kLightYellow,
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formkey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: user.name,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  contentPadding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.01),
                                  alignLabelWithHint: true,
                                  labelStyle: TextStyle(
                                    fontSize: focusNode.hasFocus ? 18 : 16.0,
                                    //I believe the size difference here is 6.0 to account padding
                                    color: focusNode.hasFocus
                                        ? Color(0xFF3F5521)
                                        : Colors.grey,
                                  ),
                                  labelText:  '${user.lg[user.language]["Full Name"]}',
                                  hintStyle: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'BerlinSansFB',
                                  ),
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
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BerlinSansFB'),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: MultiValidator([
                                RequiredValidator(errorText: '${user.lg[user.language][ "Required"]}',),
                              ]),
                            ),
                            SizedBox(height: _mediaQuery * 0.03),
                            TextFormField(
                              controller: user.email,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.mail_outline),
                                  contentPadding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.01),
                                  alignLabelWithHint: true,
                                  labelStyle: TextStyle(
                                    fontSize: focusNode.hasFocus ? 18 : 16.0,
                                    //I believe the size difference here is 6.0 to account padding
                                    color: focusNode.hasFocus
                                        ? Color(0xFF3F5521)
                                        : Colors.grey,
                                  ),
                                  labelText: '${user.lg[user.language]["Email"]}',
                                  hintStyle: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'BerlinSansFB',
                                  ),
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
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BerlinSansFB'),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: MultiValidator([
                                EmailValidator(errorText: '${user.lg[user.language]["Please enter email"]}',),
                                RequiredValidator(errorText: '${user.lg[user.language][ "Required"]}',),
                              ]),
                              keyboardType: TextInputType.emailAddress,
                            ),

                            SizedBox(height: _mediaQuery * 0.03),
                            TextFormField(
                              controller: user.phoneNumber,
                              decoration: InputDecoration(
                                prefixIcon:      CountryPicker(
                                  _callBackFunction,
                                  '${authProvider.lg[authProvider.language]["Select Country"]}',
                                  Theme.of(context).primaryColor,
                                  Colors.white,
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.01),
                                alignLabelWithHint: true,
                                labelStyle: TextStyle(
                                    fontSize: focusNode.hasFocus ? 18 : 16.0,
                                    //I believe the size difference here is 6.0 to account padding
                                    color: focusNode.hasFocus
                                        ? Color(0xFF3F5521)
                                        : Colors.grey),
                                labelText:'${user.lg[user.language]["Phone number"]}',
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
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF3F5521),
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BerlinSansFB'),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: MultiValidator([
                                RequiredValidator(errorText: '${user.lg[user.language][ "Required"]}',),
                              ]),
                              keyboardType: TextInputType.phone,
                            ),
                            SizedBox(height: _mediaQuery * 0.03),
                            Container(
                              height: MediaQuery.of(context).size.height / 8,
                              child: CustomBirthdayPicker(
                                label: '${user.lg[user.language]["birthdate"]}',
                                controller: user.birthday,
                                controllerlan: user.birthdaylan,
                                lan: user.language,
                              ),
                            ),
                            SizedBox(height: _mediaQuery * 0.07),
                            loadingButton
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () async {
                                      if(user.phoneNumber.text!=user.personalInfo.phoneNumber){
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => PhoneVerification1(check: false , contact: user.phoneNumber.text,dialcode: "+966"),
                                          ),
                                        );
                                      }else {
                                        setState(() {
                                          loadingButton = true;
                                        });
                                        validate();
                                        var update = await user.updateInfo();
                                        if (update) {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            loadingButton = false;
                                          });
                                        } else {
                                          setState(() {
                                            loadingButton = false;
                                          });
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(SnackBar(
                                          //   content: Text( '${authProvider.lg[user.language]['Cannot Update Info']',),}
                                          // ));
                                          MotionToast.error(
                                            title: "Cater me",
                                            titleStyle: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            description: "${user.lg[user
                                                .language]['Cannot Update Info']}",
                                            //  animationType: ANIMATION.FROM_LEFT,
                                          ).show(context);
                                        }
                                      }  },
                                    child: Text(
                                      '${user.lg[user.language]["Submit"]}',
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.fromLTRB(
                                          _mediaQuery * 0.18,
                                          _mediaQuery * 0.02,
                                          _mediaQuery * 0.18,
                                          _mediaQuery * 0.02),
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
              ),
      ),
    );
  }
}
