import 'dart:io';

import 'package:CaterMe/Providers/friend.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/Screens/widgets/Costumtextfield.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../Providers/user.dart';
import '../../Screens/otpverify/widget/country_picker.dart';
import '../../language/language.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class FreindsTextField extends StatefulWidget {
  final Function addFriend;

  FreindsTextField(this.addFriend);

  @override
  State<FreindsTextField> createState() => _FreindsTextFieldState();
}

class _FreindsTextFieldState extends State<FreindsTextField> {
  var _dialCode = "";
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void _callBackFunction(String name, String dialCode, String flag) {
    _dialCode = dialCode;
  }

  bool validate() {
    if (formkey.currentState != null) {
      if (formkey.currentState.validate()) {
        // ignore: avoid_print
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

  bool loading = false;
  var _key = GlobalKey<ScaffoldState>();
  permissionServiceCall() async {
    await permissionServices().then(
          (value) {
        if (value != null) {
          if (
              value[Permission.contacts].isGranted) {
            /* ========= New Screen Added  ============= */
            //
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => SplashScreen()),
            // );
          }
        }
      },
    );
  }

  /*Permission services*/
  Future<Map<Permission, PermissionStatus>> permissionServices() async {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [


      Permission.contacts
      //add more permission to request here.
    ].request();

    if (statuses[Permission.contacts].isPermanentlyDenied) {
      openAppSettings();
      //setState(() {});
    } else {
      if (statuses[Permission.contacts].isDenied) {
        permissionServiceCall();
      }
    }





    /*{Permission.camera: PermissionStatus.granted, Permission.storage: PermissionStatus.granted}*/
    return statuses;
  }
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    FocusNode focusnode = FocusNode();
    final friends = Provider.of<FriendsProvider>(context, listen: true);
    final mediaQuery = MediaQuery.of(context);

    var _mediaQueryText = MediaQuery.of(context).size.height;
    return Card(
      key: _key,
      child: SingleChildScrollView(
        child: Container(
          color: LightColors.kLightYellow,
          child: Padding(
            padding: EdgeInsets.only(
                right: 10,
                left: 10,
                top: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: _mediaQueryText * 0.06),

                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      // controller: widget.controller,

                      controller: friends.namecontroller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.isEmpty) {
                          return '${authProvider.lg[authProvider.language]["Please enter the name"]}';
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                          // contentPadding:
                          // EdgeInsets.only(left: mediaQuery.size.width * 0.04),

                          alignLabelWithHint: true,
                          labelStyle: TextStyle(
                              fontSize: 16.0,
                              //I believe the size difference here is 6.0 to account padding
                              color: Color(0xFF3F5521)),
                          labelText:
                              '${authProvider.lg[authProvider.language]['Full Name']}',
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
                          suffixIcon: IconButton(
                              onPressed: () async {


                                await Permission.contacts.request();
                               // final canUseStorage = await requestPermission(Permission.storage);



                                // permissionServiceCall();
                                if (await Permission.contacts.request()
                                    .isGranted || Platform.isIOS) {
                                  Contact a = await ContactsService
                                      .openDeviceContactPicker();
                                  //
                                  // PhoneNumber number = await PhoneNumber
                                  //     .getRegionInfoFromPhoneNumber(
                                  //         a.phones.first.value);

                                  friends.namecontroller.text = a.displayName;
                                  friends.phonecontroller.text =
                                      a.phones.first.value;
                                }
                                else{
                                  print("no permission");
                                }
                              },
                              icon: Icon(Icons.contact_phone))),
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BerlinSansFB'),
                    ),
                  ),

                  // customTextField(
                  //   read: false,
                  //   label:
                  //       '${authProvider.lg[authProvider.language]['Full Name']}',
                  //   controller: friends.namecontroller,
                  //
                  // ),
                  SizedBox(height: _mediaQueryText * 0.02),
                  // Container(
                  //     padding: const EdgeInsets.all(10.0),
                  //     child: TextFormField(
                  //       controller: friends.emailcontroller,
                  //
                  //       autovalidateMode: AutovalidateMode.onUserInteraction,
                  //       validator: (value) {
                  //         if (value.isEmpty) {
                  //           return '${authProvider.lg[authProvider.language]["Please enter email"]}';
                  //         } else
                  //           return null;
                  //       },
                  //       decoration: InputDecoration(
                  //         // contentPadding: EdgeInsets.only(
                  //         //     left: mediaQuery.size.width * 0.04),
                  //         alignLabelWithHint: true,
                  //         labelStyle: TextStyle(
                  //             fontSize:  16.0,
                  //             //I believe the size difference here is 6.0 to account padding
                  //             color:
                  //                  Color(0xFF3F5521)
                  //                ),
                  //         labelText:
                  //             '${authProvider.lg[authProvider.language]["Email"]}',
                  //         hintStyle: TextStyle(
                  //             color: Colors.black87,
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.bold,
                  //             fontFamily: 'BerlinSansFB'),
                  //         filled: true,
                  //         fillColor: Colors.white,
                  //         enabledBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(5.0),
                  //           borderSide: const BorderSide(
                  //             color: Colors.grey,
                  //           ),
                  //         ),
                  //         errorBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(5.0),
                  //             borderSide: BorderSide(
                  //               color: redColor,
                  //             )),
                  //         focusedBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(5.0),
                  //           borderSide: const BorderSide(
                  //             color: Color(0xFF3F5521),
                  //           ),
                  //         ),
                  //       ),
                  //       style: const TextStyle(
                  //           color: Colors.grey,
                  //           fontSize: 15,
                  //           fontWeight: FontWeight.bold,
                  //           fontFamily: 'BerlinSansFB'),
                  //     )),
                  // InternationalPhoneNumberInput(
                  //   locale: authProvider.language,
                  //
                  //   onInputChanged: (PhoneNumber number) {
                  //     print(number.phoneNumber);
                  //   },
                  //
                  //   onInputValidated: (bool value) {
                  //     print(value);
                  //   },
                  //
                  //   selectorConfig: SelectorConfig(
                  //
                  //     selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  //   ),
                  //   ignoreBlank: false,
                  //   autoValidateMode: AutovalidateMode.disabled,
                  //   selectorTextStyle: TextStyle(color: Colors.black),
                  //
                  //   textFieldController: friends.phonecontroller,
                  //   formatInput: false,
                  //   keyboardType:
                  //   TextInputType.numberWithOptions(signed: true, decimal: true),
                  //   inputBorder: OutlineInputBorder(),
                  //   onSaved: ( number) {
                  //     print('On Saved: $number');
                  //   },
                  // ),
                  Container(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: friends.phonecontroller,
                        focusNode: focusnode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return '${authProvider.lg[authProvider.language]["Please enter phone number"]}';
                          } else
                            return null;
                        },
                        textDirection:TextDirection.ltr ,
                        textAlign:authProvider.language=="ar"?TextAlign.end:TextAlign.start ,

                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: redColor,
                                )),
                            // contentPadding: EdgeInsets.only(
                            //     left: MediaQuery.of(context).size.width * 0.04),
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                                fontSize: focusnode.hasFocus ? 18 : 16.0,
                                //I believe the size difference here is 6.0 to account padding
                                color: focusnode.hasFocus
                                    ? Color(0xFF3F5521)
                                    : Colors.grey),
                            // prefixIcon: CountryPicker(
                            //   _callBackFunction,
                            //   '${authProvider.lg[authProvider.language]["Select Country"]}',
                            //   Theme.of(context).primaryColor,
                            //   Colors.white,
                            // ),
                            labelText:
                                '${authProvider.lg[authProvider.language]['Phone number']}',
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
                                ))),
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'BerlinSansFB'),
                      )),
                  SizedBox(height: _mediaQueryText * 0.03),
                  SizedBox(height: _mediaQueryText * 0.03),
                  !loading
                      ? ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            if (formkey.currentState.validate() == false) {
                              // ignore: avoid_print
                              print(
                                  '${authProvider.lg[authProvider.language]['Not Validated']}');
                              setState(() {
                                loading = false;
                              });
                              // reset!=null?
                            } else {
                              if (await friends.createNewFriend()) {
                                setState(() {
                                  loading = false;
                                });

                                Navigator.of(context).pop();
                              } else {
                                setState(() {
                                  loading = false;
                                });
                                showDialog(
                                  context: this.context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                          '${authProvider.lg[authProvider.language]["error"]}'),
                                      content: Text(
                                          '${authProvider.lg[authProvider.language]["friend already exists!"]}'),
                                      actions: <Widget>[
                                        TextButton(
                                            child: Text(
                                                '${authProvider.lg[authProvider.language]["Ok"]}'),
                                            onPressed: () =>
                                                Navigator.pop(context))
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          },
                          child: Text(
                            '${authProvider.lg[authProvider.language]['Add']}',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(
                              left: 35,
                              right: 35,
                              top: 15,
                              bottom: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            primary: Theme.of(context).primaryColor,
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

bool isEmailValid(String email) {
  RegExp regex = new RegExp(
      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$");
  return regex.hasMatch(email);
}
