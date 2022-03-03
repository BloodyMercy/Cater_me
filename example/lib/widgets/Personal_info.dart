import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../customBirthdayPicker.dart';

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
    final address = Provider.of<AdressProvider>(context, listen: true);
    final user = Provider.of<UserProvider>(context, listen: true);

    var _mediaQuery =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            iconSize: 30,
          ),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Personal Info',
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
                                          0.04),
                                  alignLabelWithHint: true,
                                  labelStyle: TextStyle(
                                    fontSize: focusNode.hasFocus ? 18 : 16.0,
                                    //I believe the size difference here is 6.0 to account padding
                                    color: focusNode.hasFocus
                                        ? Color(0xFF3F5521)
                                        : Colors.grey,
                                  ),
                                  labelText: 'Full Name',
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
                                RequiredValidator(errorText: 'Required *'),
                              ]),
                            ),
                            SizedBox(height: _mediaQuery * 0.03),
                            TextFormField(
                              controller: user.email,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.mail_outline),
                                  contentPadding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.04),
                                  alignLabelWithHint: true,
                                  labelStyle: TextStyle(
                                    fontSize: focusNode.hasFocus ? 18 : 16.0,
                                    //I believe the size difference here is 6.0 to account padding
                                    color: focusNode.hasFocus
                                        ? Color(0xFF3F5521)
                                        : Colors.grey,
                                  ),
                                  labelText: 'Email',
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
                                EmailValidator(errorText: "Please enter email"),
                                RequiredValidator(errorText: 'Required *'),
                              ]),
                              keyboardType: TextInputType.emailAddress,
                            ),

                            // TextFormField(
                            //   controller: user.email,
                            //   decoration: InputDecoration(
                            //       prefixIcon: Icon(Icons.mail_outline),
                            //       contentPadding: EdgeInsets.only(
                            //           left: MediaQuery.of(context).size.width *
                            //               0.04),
                            //       alignLabelWithHint: true,
                            //       labelStyle: TextStyle(
                            //           fontSize: focusNode.hasFocus ? 18 : 16.0,
                            //           //I believe the size difference here is 6.0 to account padding
                            //           color: focusNode.hasFocus
                            //               ? Color(0xFF3F5521)
                            //               : Colors.grey),
                            //       labelText: "Email",
                            //       hintStyle: TextStyle(
                            //           color: Colors.white,
                            //           fontSize: 15,
                            //           fontWeight: FontWeight.bold,
                            //           fontFamily: 'BerlinSansFB'),
                            //       filled: true,
                            //       fillColor: Colors.white,
                            //       enabledBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(5.0),
                            //         borderSide: const BorderSide(
                            //           color: Colors.grey,
                            //         ),
                            //       ),
                            //       focusedBorder: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(5.0),
                            //           borderSide: const BorderSide(
                            //             color: Color(0xFF3F5521),
                            //           ))),
                            //   autovalidateMode:
                            //       AutovalidateMode.onUserInteraction,
                            //   validator: MultiValidator([
                            //     EmailValidator(errorText: "Please enter email"),
                            //     RequiredValidator(errorText: 'Required *'),
                            //   ]),
                            //   keyboardType: TextInputType.emailAddress,
                            // ),
                            SizedBox(height: _mediaQuery * 0.03),
                            TextFormField(
                              controller: user.phoneNumber,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                contentPadding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.04),
                                alignLabelWithHint: true,
                                labelStyle: TextStyle(
                                    fontSize: focusNode.hasFocus ? 18 : 16.0,
                                    //I believe the size difference here is 6.0 to account padding
                                    color: focusNode.hasFocus
                                        ? Color(0xFF3F5521)
                                        : Colors.grey),
                                labelText: 'Phone number',
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
                                RequiredValidator(errorText: 'Required *'),
                              ]),
                              keyboardType: TextInputType.phone,
                            ),
                            SizedBox(height: _mediaQuery * 0.03),
                            Container(
                              height: MediaQuery.of(context).size.height / 8,
                              child: CustomBirthdayPicker(
                                label: "Birthdate",
                                controller: address.evendatecontroller,
                              ),
                            ),
                            SizedBox(height: _mediaQuery * 0.07),
                            loadingButton
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () async {
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
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Cannot Update Info'),
                                        ));
                                      }
                                    },
                                    child: Text(
                                      'SUBMIT',
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
