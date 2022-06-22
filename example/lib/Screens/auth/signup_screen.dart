import 'dart:io';

import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/Screens/auth/login_screen.dart';
import 'package:CaterMe/Screens/greeting.dart';
import 'package:CaterMe/Screens/widgets/custom_cupertino_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import "package:image_picker/image_picker.dart";
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../SplachScreen.dart';
import '../../custom_date_picker_form_field.dart';
import '../../language/language.dart';
import '../Terms_and_Conditions/Terms_and_Conditions.dart';
import '../occasion/theme/colors/light_colors.dart';
import '../otpverify/phone_verification.dart';
import '../otpverify/widget/country_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  File image;
  var _dialCode = "";
  void _callBackFunction(String name, String dialCode, String flag) {
    _dialCode = dialCode;
  }

  // ignore: non_constant_identifier_names
  Future PickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
      // ignore: nullable_type_in_catch_clause
    } on PlatformException catch (e) {
      print('Failed : $e');
    }
  }

  bool isChecked = false;
  bool isCheckedcolor = false;
  FocusNode _focusNode = FocusNode();
  DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  DateFormat _monthFormat = DateFormat('MMMM');
  DateFormat _yearFormat = DateFormat('yyyy');
  DateFormat _dayFormat = DateFormat('dd');

  DateTime _chosenDate = DateTime.now();
  String _chosenMonth = "";
  String _chosenYear = "";
  String _chosenDay = "";
  String password = '',
      mobile = '',
      confirmPassword = '',
      email = '',
      name = '';
  bool passObscure = true;
  bool confObscure = true;

  bool validate() {
    if (formkey.currentState != null) {
      if (formkey.currentState.validate()) {
        if (password == confirmPassword) {
          // ignore: avoid_print

          print('Validated');
          return true;
        }
      } else {
        // ignore: avoid_print
        print('Not validated');
        return false;
      }
    }
    return false;
  }

  String validatePass(value) {
    if (value.trim().isEmpty) {
      return "this field is required";
    }
    if (value.trim().length < 6) {
      return "this field should be at least 6 character";
    }
    if (!RegExp(r"[A-Z]").hasMatch(value) == true ||
        !RegExp(r"[a-z]").hasMatch(value) == true) {
      return "Must have Upper,LowerCase";
    }
    return null;
  }

  String validateMobile(String value) {
    if (value.length != 8) {
      return 'Mobile Number must be of 8 digit';
    } else {
      return null;
    }
  }

  String genderChoose;
  List<Map<String, dynamic>> listGender = [
    {"id": 1, "gender": "male"},
    {"id": 2, "gender": "female"},
    {"id": 3, "gender": "Rather not to say"},
  ];

  // DateTime selectedDate = DateTime.now();
//  DateTime _selectedDay = DateTime.utc(2000, 10, 16);

  final _scaffKey = GlobalKey<ScaffoldState>();
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final address = Provider.of<AdressProvider>(context, listen: true);
    address.evendatecontroller.text ='';
    // final user = Provider.of<UserProvider>(context, listen: true);
    FocusNode focusNode = FocusNode();
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF3F5521),
        title: Text(
          '${authProvider.lg[authProvider.language]["Register"]}',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.normal, fontSize: 19),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      key: _scaffKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: CircleAvatar(
                      minRadius: 16,
                      maxRadius: screenHeight * 0.1,
                      backgroundImage: image == null ? null : FileImage(image),
                      child: image == null
                          ? Image(
                              image: const AssetImage('images/profile.png'),
                              // width: 800,
                              height: screenHeight * 0.25,
                            )
                          : Container(),
                    ),
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.camera,
                                color: Color.fromRGBO(63, 85, 33, 1),
                              ),
                              title: Text(
                                '${authProvider.lg[authProvider.language]["Camera"]}',
                                style: TextStyle(
                                  fontFamily: 'BerlinSansFB',
                                  fontSize: 16,
                                  color: Color.fromRGBO(63, 85, 33, 1),
                                ),
                              ),
                              onTap: () {
                                PickImage(ImageSource.camera);
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.image,
                                color: Color.fromRGBO(63, 85, 33, 1),
                              ),
                              title: Text(
                                '${authProvider.lg[authProvider.language]["Gallery"]}',
                                style: TextStyle(
                                  fontFamily: 'BerlinSansFB',
                                  fontSize: 16,
                                  color: Color.fromRGBO(63, 85, 33, 1),
                                ),
                              ),
                              onTap: () {
                                PickImage(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 37.0, right: 37.0),
                child: Column(
                  children: [
                    Center(
                      child: Form(
//                         autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              onSaved: (value) => name = value,
                              controller: authProvider.name,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person_outline_outlined),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    // left: screenHeight * 0.01,
                                    bottom: screenHeight * 0.025,
                                    top: screenHeight * 0.025),
                                hintText:
                                    '${authProvider.lg[authProvider.language]["Name"]}',
                                hintStyle:
                                    Theme.of(context).textTheme.headline4,
                              ),
                              validator: MultiValidator([
                                RequiredValidator(
                                  errorText:
                                      '${authProvider.lg[authProvider.language]["Required"]}',
                                ),
                                // EmailValidator(errorText: 'Not a valid Name'),
                              ]),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: screenHeight * 0.015,
                            ),
                            TextFormField(
                              onSaved: (value) => email = value,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.mail_outline),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    // left: screenHeight * 0.01,
                                    bottom: screenHeight * 0.025,
                                    top: screenHeight * 0.025),
                                hintText:
                                    '${authProvider.lg[authProvider.language]["Email"]}',
                                hintStyle:
                                    Theme.of(context).textTheme.headline4,
                              ),
                              controller: authProvider.email,
                              validator: MultiValidator([
                                RequiredValidator(
                                  errorText:
                                      '${authProvider.lg[authProvider.language]["Required"]}',
                                ),
                                EmailValidator(
                                  errorText:
                                      '${authProvider.lg[authProvider.language]["Not a valid email"]}',
                                ),
                              ]),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: screenHeight * 0.015,
                            ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (value) => password = value,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(fontSize: 10),
                                prefixIcon: IconButton(
                                  icon: Icon(
                                    passObscure
                                        ? Icons.lock_outlined
                                        : Icons.lock_open_outlined,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      passObscure = !passObscure;
                                    });
                                  },
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    // left: screenHeight * 0.01,
                                    bottom: screenHeight * 0.025,
                                    top: screenHeight * 0.025),
                                hintText:
                                    '${authProvider.lg[authProvider.language]['Password']}',
                                hintStyle:
                                    Theme.of(context).textTheme.headline4,
                              ),
                              controller: authProvider.password,
                              validator: (val) {
                                if (val.isEmpty) {
                                  return '${authProvider.lg[authProvider.language]["Required"]}';
                                } else if (val.length < 6) {
                                  return '${authProvider.lg[authProvider.language]['Password should be at least 6 characters']}';
                                }

                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: passObscure,
                            ),
                            SizedBox(height: screenHeight * 0.015),

                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (value) => confirmPassword = value,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(fontSize: 10),
                                prefixIcon: IconButton(
                                  icon: Icon(
                                    confObscure
                                        ? Icons.lock_outlined
                                        : Icons.lock_open_outlined,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      confObscure = !confObscure;
                                    });
                                  },
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    // left: screenHeight * 0.01,
                                    bottom: screenHeight * 0.025,
                                    top: screenHeight * 0.025),
                                hintText:
                                    '${authProvider.lg[authProvider.language]["Confirm Password"]}',
                                hintStyle:
                                    Theme.of(context).textTheme.headline4,
                              ),
                              controller: authProvider.confirmpassword,
                              validator: (val) {
                                if (val.isEmpty)
                                  return '${authProvider.lg[authProvider.language]["Confirm Password"]}';
                                if (val != authProvider.password.text)
                                  return '${authProvider.lg[authProvider.language]["Password dosen't match"]}';
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: confObscure,
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            Container(
                                height: height / 13,
                                child: Row(children: [
                                  Expanded(
                                      child: TextFormField(
                                    controller: authProvider.phoneNumber,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(
                                        color: Colors.transparent,
                                        fontSize: 0,
                                      ),
                                      prefixIcon: InkWell(
                                        onTap: () {},
                                        child: CountryPicker(
                                          _callBackFunction,
                                          '${authProvider.lg[authProvider.language]["Select Country"]}',
                                          Theme.of(context).primaryColor,
                                          Colors.white,
                                        ),
                                      ),
                                      hintText: "xxxxxxxxxx",
                                      hintStyle: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                        color: Color(0xff9FACBD),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          )),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (String value) {
                                      if (value == "" || value == null) {
                                        return '${authProvider.lg[authProvider.language]["Please enter phone number"]}';
                                      }

                                      return null;
                                    },
                                  ))
                                ])),
                            // TextFormField(
                            //   onSaved: (value) => mobile = value,
                            //   autovalidateMode:
                            //       AutovalidateMode.onUserInteraction,
                            //   decoration: InputDecoration(
                            //     prefixIcon: Icon(Icons.phone),
                            //     filled: true,
                            //     fillColor: Colors.white,
                            //     border: OutlineInputBorder(
                            //       borderSide: BorderSide.none,
                            //       borderRadius: BorderRadius.circular(15.0),
                            //     ),
                            //     contentPadding: EdgeInsets.only(
                            //         // left: screenHeight * 0.04,
                            //         bottom: screenHeight * 0.025,
                            //         top: screenHeight * 0.025),
                            //     hintText:
                            //         '${authProvider.lg[authProvider.language]["Phone number"]}',
                            //     hintStyle:
                            //         Theme.of(context).textTheme.headline4,
                            //   ),
                            //   controller: authProvider.phoneNumber,
                            //   validator: MultiValidator([
                            //     RequiredValidator(errorText: '${authProvider.lg[authProvider.language]["Required"]}',),
                            //     // EmailValidator(errorText: 'Not a Phone number,
                            //   ]),
                            //   keyboardType: TextInputType.phone,
                            // ),
                            SizedBox(height: screenHeight * 0.015),
                            CustomCupertinoPicker(
                              label:
                                  '${authProvider.lg[authProvider.language]["Gender"]}',
                              items: [
                                '${authProvider.lg[authProvider.language]["Male"]}',
                                '${authProvider.lg[authProvider.language]["Female"]}',
                                '${authProvider.lg[authProvider.language]["Rather"]}',
                              ],
                              // events: address.regular.events,
                              selectedValue: 0,
                              inputType: TextInputType.text,
                              controller: authProvider.genderselected,
                            ),
                            SizedBox(height: screenHeight * 0.015),

                            CustomDatePickerFormField(
                                casee: "signup",
                                label:
                                    '${authProvider.lg[authProvider.language]["birthdate"]} optional',
                                controller: address.evendatecontroller,
                                controllerlan: address.evendatelancontroller,
                                lang: authProvider.language),

                            SizedBox(height: screenHeight * 0.015),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            // SizedBox(height: screenHeight * 0.015),
                            // SizedBox(height: _mediaQuery * 0.03),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: width / 17,
                                  child: Checkbox(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Color(0xFF3F5521),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    checkColor: Colors.white,
                                    activeColor: Color(0xFF3F5521),
                                    value: isChecked,
                                    onChanged: (bool value) {
                                      setState(() {
                                        if (isCheckedcolor)
                                          isCheckedcolor = false;
                                        isChecked = value;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${authProvider.lg[authProvider.language]["I agree to the "]}',
                                  style: TextStyle(
                                    color: !isCheckedcolor
                                        ? Color(0xFF3F5521)
                                        : Colors.red,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebViewExample(),
                                      ),
                                    );

                                    ///gotopage
                                  },
                                  child: Text(
                                    '${authProvider.lg[authProvider.language]["Terms & Conditions"]}',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: !isCheckedcolor
                                          ? Color(0xFF3F5521)
                                          : Colors.red,
                                      fontSize: 12,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerLeft,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: screenHeight * 0.01,
                    // ),
                    !_loading
                        ? ElevatedButton(
                            onPressed: () async {
                              // setState(() {
                              //   _loading = true;
                              // });
                              if (!formkey.currentState.validate()) {
                                // ignore: avoid_print
                                print('Not Validated');
                                MotionToast.error(
                                  title: "Cater me",
                                  titleStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  // description:   "${authProvider.lg[authProvider.language]["all fields required"]}",
                                  //  animationType: ANIMATION.FROM_LEFT,
                                ).show(context);
                                // _scaffKey.currentState.showSnackBar(
                                //   SnackBar(
                                //     content: Text(
                                //         "${authProvider.lg[authProvider.language]["all fields required"]}"),
                                //   ),
                                // );
                                setState(() {
                                  _loading = false;
                                });
                                // reset!=null?
                              } else if (!isChecked) {
                                _scaffKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "${authProvider.lg[authProvider.language]["you must agree terms and conditions"]}"),
                                  ),
                                );
                                setState(() {
                                  isCheckedcolor = true;
                                  _loading = false;
                                });
                              } else if (authProvider.name.text == "" ||
                                  authProvider.name.text == "" ||
                                  authProvider.password.text == "" ||
                                  authProvider.confirmpassword.text == "" ||
                                  authProvider.phoneNumber.text == "" ||
                                  authProvider.genderselected.text == "") {
                                _scaffKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "${authProvider.lg[authProvider.language]["all fields required"]}"),
                                  ),
                                );
                              } else {
                                await authProvider.checkingexistprovider();
                                if (authProvider.error != "true") {
                                  _scaffKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "${authProvider.lg[authProvider.language][authProvider.error]}"),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PhoneVerification(
                                            authProvider.phoneNumber.text
                                                .toString(),
                                            _dialCode,
                                            image)),
                                  );
                                }
                              }
                            },
                            child: Text(
                              '${authProvider.lg[authProvider.language]["SignUp"]}',
                              style: TextStyle(
                                  fontFamily: 'BerlinSansFB',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(
                                  screenHeight * 0.10,
                                  screenHeight * 0.02,
                                  screenHeight * 0.10,
                                  screenHeight * 0.02),
                              onPrimary: const Color.fromRGBO(255, 255, 255, 1),
                              primary: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: FittedBox(
                            child: Text(
                              '${authProvider.lg[authProvider.language]["Already have an account?"]}',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'BerlinSansFB',
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          child: FittedBox(
                            child: Text(
                              '${authProvider.lg[authProvider.language]["Log In"]}',
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'BerlinSansFB',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
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
