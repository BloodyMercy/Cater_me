import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

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
        print("passwords don't match");
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
    if (value.isEmpty) {
      return 'Required *';
    } else {
      return null;
    }
  }

  String validateConfirmPass(value) {
    validatePass(value);
    if (value != newPassController.text) {
      return "Passwords don't match";
    } else {
      return null;
    }
  }

  bool loading = false;

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
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Account Info',
            style: Theme.of(context).textTheme.headline1,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: loading
            ? Container(
            color:LightColors.kLightYellow,
              child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF3F5521),

                  ),
                ),
            )
            : SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      SizedBox(height: _mediaQuery * 0.03),
                      FittedBox(
                        child: Text(
                          'Change Password',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      SizedBox(height: _mediaQuery * 0.06),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Old Password',
                          labelStyle: Theme.of(context).textTheme.headline4,
                          contentPadding: const EdgeInsets.only(left: 20),
                        ),
                        controller: user.oldPassword,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Required *'),
                          // EmailValidator(errorText: 'Not a valid password'),
                        ]),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: true,
                      ),
                      SizedBox(height: _mediaQuery * 0.03),
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: 'New Password',
                            labelStyle: Theme.of(context).textTheme.headline4,
                            contentPadding: const EdgeInsets.only(left: 20),
                          ),
                          controller: user.password1,
                          validator: validatePass,
                          autovalidateMode: AutovalidateMode.onUserInteraction),
                      SizedBox(height: _mediaQuery * 0.03),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: Theme.of(context).textTheme.headline4,
                          contentPadding: const EdgeInsets.only(left: 20),
                        ),
                        controller: user.confirmpassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (user.password1.text !=
                              user.confirmpassword.text) {
                            return "Password dosen't match";
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
                                      await user.ResetPassword();
                                  print(resetPassword);
                                  if (resetPassword) {
                                    print("Reset succeed");
                                    setState(() {
                                      loadingButton = false;
                                    });
                                    Navigator.of(context).pop();
                                  } else {
                                    setState(() {
                                      loadingButton = false;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Cannot Update Password'),
                                    ));
                                  }
                                  user.clearAllTextController();
                                }
                              },
                              child: Text(
                                'SAVE',
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
    );
  }
}
