import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';

import '../language/language.dart';

class AccountInfo extends StatefulWidget {
  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  bool loadingButton = false;

  final formkey = GlobalKey<FormState>();

  final newPassController = TextEditingController();

  final confirmPassController = TextEditingController();

  final oldPassController = TextEditingController();

  bool validateText() {
    if (formkey.currentState != null) {
      if (newPassController.text != confirmPassController.text) {
        final user = Provider.of<UserProvider>(context, listen: false);
        print('${user.lg[user.language][ "Passwords don't match"]}');
        return false;
      }
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

  String validatePass(value) {
    final user = Provider.of<UserProvider>(context, listen: false);

    if (value.isEmpty) {
      return '${user.lg[user.language][ "Required"]}';
    } else if(value.contains(" ")){
      return '${user.lg[user.language]["your password can only contain letters numbers and some symbols \$ @ #"]}';
    }else {
      return null;
    }
  }

  String validateConfirmPass(value) {
   // final user = Provider.of<UserProvider>(context, listen: true);
    final user = Provider.of<UserProvider>(context, listen: false);
    validatePass(value);
    if (value != newPassController.text) {
      return '${user.lg[user.language]["Passwords don't match"]}';
    } else {
      return null;
    }
  }

  bool loading = false;
  FocusNode focusNode = FocusNode();
@override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true);
    var _mediaQuery = MediaQuery.of(context).size.height;
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
            '${user.lg[user.language][ "Account Info"]}',
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
            : SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: _mediaQuery * 0.03),
                        FittedBox(
                          child: Text(
                            '${user.lg[user.language]["Change Password"]}',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        SizedBox(height: _mediaQuery * 0.06),
                        TextFormField(
                          focusNode: focusNode,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'BerlinSansFB'),
                          decoration: InputDecoration(
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              // contentPadding: EdgeInsets.only(
                              //     left:
                              //         MediaQuery.of(context).size.width * 0.01),
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                  fontSize: focusNode.hasFocus ? 18 : 16.0,
                                  //I believe the size difference here is 6.0 to account padding
                                  color: focusNode.hasFocus
                                      ? Color(0xFF3F5521)
                                      : Colors.grey),
                              labelText: '${user.lg[user.language]["Old Password"]}',
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
                          controller: user.oldPassword,
                          validator: MultiValidator([
                            RequiredValidator(errorText: '${user.lg[user.language][ "Required"]}',),
                            // EmailValidator(errorText: 'Not a valid password'),
                          ]),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                        ),
                        SizedBox(height: _mediaQuery * 0.03),
                        TextFormField(
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'BerlinSansFB'),
                            decoration: InputDecoration(
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                // contentPadding: EdgeInsets.only(
                                //     left: MediaQuery.of(context).size.width *
                                //         0.01),
                                alignLabelWithHint: true,
                                labelStyle: TextStyle(
                                    fontSize: focusNode.hasFocus ? 18 : 16.0,
                                    //I believe the size difference here is 6.0 to account padding
                                    color: focusNode.hasFocus
                                        ? Color(0xFF3F5521)
                                        : Colors.grey),
                                labelText: '${user.lg[user.language]["New Password"]}',
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
                            controller: user.password1,
                            obscureText: true,
                            validator: validatePass,

                            autovalidateMode:
                                AutovalidateMode.onUserInteraction),
                        SizedBox(height: _mediaQuery * 0.03),
                        TextFormField(
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'BerlinSansFB'),
                          decoration: InputDecoration(
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              // contentPadding: EdgeInsets.only(
                              //     left:
                              //         MediaQuery.of(context).size.width * 0.01),
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                  fontSize: focusNode.hasFocus ? 18 : 16.0,
                                  //I believe the size difference here is 6.0 to account padding
                                  color: focusNode.hasFocus
                                      ? Color(0xFF3F5521)
                                      : Colors.grey),
                              labelText: '${user.lg[user.language]["Confirm Password"]}',
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
                          controller: user.confirmpassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (user.password1.text !=
                                user.confirmpassword.text) {
                              return '${user.lg[user.language]["Password dosen't match"]}';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                        SizedBox(height: _mediaQuery * 0.09),
                        loadingButton
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () async {
                                  if (!formkey.currentState.validate()) {
                                    return;
                                  } else {
                                    setState(() {
                                      loadingButton = true;
                                    });
                                    validateText();
                                    var resetPassword =
                                        await user.ResetPasswordout();
                                    print(resetPassword);
                                    if (resetPassword.response) {
                                      print('${user.lg[user.language]["Reset succeed"]}');
                                      setState(() {
                                        loadingButton = false;
                                      });
                                      Navigator.of(context).pop();
                                    } else {
                                      setState(() {
                                        loadingButton = false;
                                      });
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(SnackBar(
                                      //   content: Text('${user.lg[user.language]["Cannot update! Old password is wrong"]}',),
                                      // ));
                                      MotionToast.error(
                                        title:  "Cater me",

                                        titleStyle:  TextStyle(fontWeight:  FontWeight.bold ,),
                                        descriptionStyle: TextStyle(fontWeight:  FontWeight.bold ,fontSize: 14),
                                        description:  '${user.lg[user.language]["Cannot update! Old password is wrong"]}',
                                        //  animationType: ANIMATION.FROM_LEFT,
                                      ).show(context);
                                    }
                                    user.clearAllTextController();
                                  }
                                },
                                child: Text(
                                  '${user.lg[user.language][ "Save"]}',
                                  style: Theme.of(context).textTheme.headline1,
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
    );
  }
}
