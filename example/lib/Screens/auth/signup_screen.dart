import 'dart:io';

import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/Screens/greeting.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import "package:image_picker/image_picker.dart";
import 'package:provider/provider.dart';

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  File? image;
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

  String? password = '',
      mobile = '',
      confirmPassword = '',
      email = '',
      name = '';
  bool passObscure = true;
  bool confObscure = true;

  bool validate() {
    if (formkey.currentState != null) {
      if (formkey.currentState!.validate()) {
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

  String? validatePass(value) {
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

  String? validateMobile(String value) {
    if (value.length != 8) {
      return 'Mobile Number must be of 8 digit';
    } else {
      return null;
    }
  }

  String? genderChoose;
  List<Map<String, dynamic>> listGender = [
    {"id": 1, "gender": "male"},
    {"id": 2, "gender": "female"},
  ];
  DateTime selectedDate = DateTime.now();
  late DateTime? _newDate;
  _datePicker() async {
    _newDate = (await showDatePicker(
      context: context,
      builder: (context, child) => Theme(
          data: ThemeData().copyWith(
            colorScheme: ColorScheme.light(
                primary: Color(0xff3F5521),
                surface: Color(0xff3F5521),
                onPrimary: Colors.black),
          ),
          child: child!),
      initialDate: selectedDate,
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    ));
    setState(() {
      if (_newDate != null) {
        selectedDate = _newDate!;

      }
    });
  }

  final _scaffKey = GlobalKey<ScaffoldState>();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
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
                      backgroundImage: image == null ? null : FileImage(image!),
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
                              title: const Text(
                                'Camera',
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
                              title: const Text(
                                'Gallery',
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
                                prefixIcon:Icon(Icons.person_outline_outlined),




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
                                hintText: 'Name',
                                hintStyle:
                                    Theme.of(context).textTheme.headline4,
                              ),
                              validator: MultiValidator([
                                RequiredValidator(errorText: 'Required *'),
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
                                prefixIcon: Icon(
                                   Icons.mail_outline),


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
                                hintText: 'Email',
                                hintStyle:
                                    Theme.of(context).textTheme.headline4,
                              ),
                              controller: authProvider.email,
                              validator: MultiValidator([
                                RequiredValidator(errorText: 'Required *'),
                                EmailValidator(errorText: 'Not a valid email'),
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
                                    left: screenHeight * 0.03,
                                    bottom: screenHeight * 0.025,
                                    top: screenHeight * 0.025),
                                hintText: 'Password',
                                hintStyle:
                                    Theme.of(context).textTheme.headline4,
                              ),
                              controller: authProvider.password,
                              validator: validatePass,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: passObscure,
                            ),
                            SizedBox(height: screenHeight * 0.015),

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
                                    left: screenHeight * 0.03,
                                    bottom: screenHeight * 0.025,
                                    top: screenHeight * 0.025),
                                hintText: 'ConfirmPassword',
                                hintStyle:
                                Theme.of(context).textTheme.headline4,
                              ),
                              controller: authProvider.confirmpassword,
                              validator: validatePass,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: passObscure,
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            TextFormField(
                              onSaved: (value) => mobile = value,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                   Icons.phone),


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
                                hintText: 'Phone number',
                                hintStyle:
                                    Theme.of(context).textTheme.headline4,
                              ),
                              controller: authProvider.phoneNumber,
                              validator: MultiValidator([
                                RequiredValidator(errorText: 'Required *'),
                                // EmailValidator(errorText: 'Not a Phone number'),
                              ]),
                              keyboardType: TextInputType.phone,
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: DropdownButton(
                                underline: const SizedBox(),
                                focusColor: Colors.white,
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    "Gender",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                                dropdownColor: Colors.white,
                                iconSize: 36,
                                isExpanded: true,
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 15),
                                value: genderChoose,
                                onChanged: (newValue) {
                                  authProvider.gender.text = newValue as String;
                                  setState(() {
                                    genderChoose = newValue as String?;
                                    (value) => value == null
                                        ? 'Please fill in your gender'
                                        : null;
                                  });
                                },
                                items: listGender.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem['id'].toString(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child:
                                          Text(valueItem['gender'].toString()),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            // SizedBox(height: _mediaQuery * 0.03),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Text(selectedDate == null
                                      ? "No Date chosen!"
                                      : 'Picked date: ${DateFormat.yMd().format(selectedDate)}'),
                                  IconButton(
                                    onPressed: ()async{

                                      _newDate = (await showDatePicker(
                                        context: context,
                                        builder: (context, child) => Theme(
                                            data: ThemeData().copyWith(
                                              colorScheme: ColorScheme.light(
                                                  primary: Color(0xff3F5521),
                                                  surface: Color(0xff3F5521),
                                                  onPrimary: Colors.black),
                                            ),
                                            child: child!),
                                        initialDate: selectedDate,
                                        firstDate: DateTime(1930),
                                        lastDate: DateTime.now(),
                                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                                      ));

                                      setState(() {
                                        if (_newDate != null) {
                                          selectedDate = _newDate!;
                                          authProvider.birthday.text=_newDate!.toString() ;

                                        }
                                      });
                                    },

                                    icon: Icon(
                                      Icons.date_range,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    !_loading
                        ? ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _loading = true;
                              });
                              if (formkey.currentState!.validate() == false) {
                                // ignore: avoid_print
                                print('Not Validated');
                                setState(() {
                                  _loading = false;
                                });
                                // reset!=null?
                              } else {
                                if (await authProvider.signUp(image!,DateFormat.yMd().format(selectedDate).toString())) {
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
                                  _scaffKey.currentState!.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "${authProvider.messageSignUp.toString()}"),
                                    ),
                                  );
                                  authProvider.messageSignUp = "";
                                }
                              }
                            },
                            child: const Text(
                              'SignUp',
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
                        const Center(
                          child: FittedBox(
                            child: Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'BerlinSansFB',
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          child: const FittedBox(
                            child: Text(
                              ' LogIn',
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
                                builder: (context) => const LoginScreen(),
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
