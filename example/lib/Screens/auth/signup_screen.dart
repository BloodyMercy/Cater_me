import 'dart:io';

import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/Screens/auth/login_screen.dart';
import 'package:CaterMe/Screens/greeting.dart';
import 'package:CaterMe/Screens/widgets/custom_cupertino_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import "package:image_picker/image_picker.dart";
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../language/language.dart';
import '../occasion/theme/colors/light_colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  File image;

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
  ];

  // DateTime selectedDate = DateTime.now();
  DateTime _selectedDay = DateTime.utc(2000, 10, 16);

  // _datePicker() async {
  //   _newDate = (await showDatePicker(
  //     context: context,
  //     builder: (context, child) => Theme(
  //         data: ThemeData().copyWith(
  //           colorScheme: ColorScheme.light(
  //               primary: Color(0xff3F5521),
  //               surface: Color(0xff3F5521),
  //               onPrimary: Colors.black),
  //         ),
  //         child: child),
  //     initialDate: selectedDate,
  //     firstDate: DateTime(1930),
  //     lastDate: DateTime.now(),
  //     initialEntryMode: DatePickerEntryMode.calendarOnly,
  //   ));
  //   setState(() {
  //     if (_newDate != null) {
  //       selectedDate = _newDate;
  //
  //     }
  //   });
  // }

  final _scaffKey = GlobalKey<ScaffoldState>();
  bool _loading = false;

  @override
  void showPicker(ctx) {
    final address = Provider.of<AdressProvider>(context, listen: false);
    DatePicker.showDatePicker(
      ctx,
      onMonthChangeStartWithFirstDate: true,
      pickerTheme: DateTimePickerTheme(
        showTitle: false,
        backgroundColor: LightColors.kLightYellow2,
        itemTextStyle: TextStyle(
          color: Color(0xFF3F5521),
        ),
      ),
      initialDateTime: _chosenDate,
      maxDateTime: DateTime.now(),
      minDateTime: DateTime(1950),
      dateFormat: 'MMMM-yyyy-dd',
      onClose: () {},
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(
          () {
            _chosenDate = dateTime;
            _chosenDay = _dayFormat.format(dateTime);
            _chosenMonth = _monthFormat.format(dateTime);
            _chosenYear = _yearFormat.format(dateTime);
            address.evendatecontroller.text = _dateFormat.format(dateTime);
          },
        );
      },
    );
  }

  Widget build(BuildContext context) {
    final address = Provider.of<AdressProvider>(context, listen: true);

    // final user = Provider.of<UserProvider>(context, listen: true);
    FocusNode focusNode = FocusNode();
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      key: _scaffKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                    size: 30,
                  )),
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
                                '${LanguageTr.lg[authProvider.language]["Camera"]}',
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
                                '${LanguageTr.lg[authProvider.language]["Gallery"]}',
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
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                  // left: screenHeight * 0.03,
                                  bottom: screenHeight * 0.025,
                                  top: screenHeight * 0.025,
                                ),
                                hintText:
                                    '${LanguageTr.lg[authProvider.language]["Name"]}',
                                hintStyle:
                                    Theme.of(context).textTheme.headline4,
                              ),
                              validator: MultiValidator([
                                RequiredValidator(errorText:  '${LanguageTr.lg[authProvider.language]["Required"]}',),
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
                                    // left: screenHeight * 0.03,
                                    bottom: screenHeight * 0.025,
                                    top: screenHeight * 0.025),
                                hintText:
                                    '${LanguageTr.lg[authProvider.language]["Email"]}',
                                hintStyle:
                                    Theme.of(context).textTheme.headline4,
                              ),
                              controller: authProvider.email,
                              validator: MultiValidator([
                                RequiredValidator(errorText: '${LanguageTr.lg[authProvider.language]["Required"]}',),
                                EmailValidator(errorText: '${LanguageTr.lg[authProvider.language]["Not a valid email"]}',),
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
                                    '${LanguageTr.lg[authProvider.language]['Password']}',
                                hintStyle:
                                    Theme.of(context).textTheme.headline4,
                              ),
                              controller: authProvider.password,
                              validator: (val) {
                                if (val.isEmpty) {
                                  return '${LanguageTr.lg[authProvider.language]["Confirm Password"]}';
                                } else if (val.length < 6) {
                                  return 'Password should be at least 6 characters';
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
                                    // left: screenHeight * 0.03,
                                    bottom: screenHeight * 0.025,
                                    top: screenHeight * 0.025),
                                hintText:
                                    '${LanguageTr.lg[authProvider.language]["Confirm Password"]}',
                                hintStyle:
                                    Theme.of(context).textTheme.headline4,
                              ),
                              controller: authProvider.confirmpassword,
                              validator: (val) {
                                if (val.isEmpty) return '${LanguageTr.lg[authProvider.language]["Confirm Password"]}';
                                if (val != authProvider.password.text)
                                  return '${LanguageTr.lg[authProvider.language]["Password dosen't match"]}';
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: confObscure,
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            TextFormField(
                              onSaved: (value) => mobile = value,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    // left: screenHeight * 0.03,
                                    bottom: screenHeight * 0.025,
                                    top: screenHeight * 0.025),
                                hintText:
                                    '${LanguageTr.lg[authProvider.language]["Phone number"]}',
                                hintStyle:
                                    Theme.of(context).textTheme.headline4,
                              ),
                              controller: authProvider.phoneNumber,
                              validator: MultiValidator([
                                RequiredValidator(errorText: '${LanguageTr.lg[authProvider.language]["Required"]}',),
                                // EmailValidator(errorText: 'Not a Phone number'),
                              ]),
                              keyboardType: TextInputType.phone,
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            CustomCupertinoPicker(
                              label:
                                  '${LanguageTr.lg[authProvider.language]["Gender"]}',
                              items: [
                                '${LanguageTr.lg[authProvider.language]["Female"]}',
                                '${LanguageTr.lg[authProvider.language]["Male"]}',
                              ],
                              // events: address.regular.events,
                              selectedValue: 0,
                              inputType: TextInputType.text,
                              controller: authProvider.genderselected,
                            ),
                            SizedBox(height: screenHeight * 0.015),

                            Container(
                              height: MediaQuery.of(context).size.height / 11,
                              // margin: EdgeInsets.only(bottom: 5),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.white, //white
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                    alignLabelWithHint: true,
                                    labelStyle: TextStyle(
                                        fontFamily: 'BerlinSansFB',
                                        fontSize:
                                            _focusNode.hasFocus ? 20 : 18.0,
                                        //I believe the size difference here is 6.0 to account padding
                                        color: _focusNode.hasFocus
                                            ? Color(0xFF3F5521)
                                            : Colors.grey),
                                    labelText:
                                        '${LanguageTr.lg[authProvider.language]["birthdate"]}',
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
                                style: TextStyle(color: Colors.black),
                                focusNode: _focusNode,
                                controller: address.evendatecontroller,
                                onTap: () {
                                  _focusNode.unfocus();
                                  showPicker(context);
                                },
                                readOnly: true,
                              ),
                            ),
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

                              // child: Row(
                              //   children: [
                              //     Text(selectedDate == null
                              //         ? "No Date chosen!"
                              //         : 'Birthdate: ${DateFormat.yMd().format(selectedDate)}'),
                              //     IconButton(
                              //       onPressed: ()async{
                              //
                              //         _newDate = (await showDatePicker(
                              //           context: context,
                              //           builder: (context, child) => Theme(
                              //               data: ThemeData().copyWith(
                              //                 colorScheme: ColorScheme.light(
                              //                     primary: Color(0xff3F5521),
                              //                     surface: Color(0xff3F5521),
                              //                     onPrimary: Colors.black),
                              //               ),
                              //               child: child),
                              //           initialDate: selectedDate,
                              //           firstDate: DateTime(1930),
                              //           lastDate: DateTime.now(),
                              //           initialEntryMode: DatePickerEntryMode.calendarOnly,
                              //         ));
                              //
                              //         setState(() {
                              //           if (_newDate != null) {
                              //             selectedDate = _newDate;
                              //             authProvider.birthday.text=_newDate.toString() ;
                              //
                              //           }
                              //         });
                              //       },
                              //
                              //       icon: Icon(
                              //         Icons.date_range,
                              //         color: Theme.of(context).primaryColor,
                              //       ),
                              //     )
                              //   ],
                              // ),
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
                              setState(() {
                                _loading = true;
                              });
                              if (formkey.currentState.validate() == false) {
                                // ignore: avoid_print
                                print('Not Validated');
                                setState(() {
                                  _loading = false;
                                });
                                // reset!=null?
                              } else {
                                if (await authProvider.signUp(
                                    image, address.evendatecontroller.text)) {
                                  setState(() {
                                    _loading = false;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Greeting(),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    _loading = false;
                                  });
                                  _scaffKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "${authProvider.messageSignUp.toString()}"),
                                    ),
                                  );
                                  authProvider.messageSignUp = "";
                                }
                              }
                            },
                            child: Text(
                              '${LanguageTr.lg[authProvider.language]["SignUp"]}',
                              style: TextStyle(
                                  fontFamily: 'BerlinSansFB',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
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
                              '${LanguageTr.lg[authProvider.language]["Already have an account?"]}',
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
                              '${LanguageTr.lg[authProvider.language]["Log In"]}',
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
