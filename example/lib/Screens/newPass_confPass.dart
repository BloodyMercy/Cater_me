import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/Screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';

class NewPassConfPass extends StatefulWidget {
  @override
  State<NewPassConfPass> createState() => _NewPassConfPassState();
}

class _NewPassConfPassState extends State<NewPassConfPass> {
  bool loadingButton = false;

  final formkey = GlobalKey<FormState>();

  final newPassController = TextEditingController();

  final confirmPassController = TextEditingController();

  bool validateText() {
    if (formkey.currentState != null) {
      if (newPassController.text != confirmPassController.text) {
        final user = Provider.of<UserProvider>(context, listen: false);
        print('${user.lg[user.language]["Passwords don't match"]}');
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
      final user = Provider.of<UserProvider>(context, listen: false);
      return '${user.lg[user.language]["Required"]}';
    } else {
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
        title: Text("Update Password"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: _mediaQuery*0.1, horizontal: _mediaQuery*0.05),
            child: Column(
              children: [
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
                    autovalidateMode: AutovalidateMode.onUserInteraction),
                Padding(
                  padding:  EdgeInsets.only(top: _mediaQuery*0.1),
                  child: TextFormField(
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
                      if (user.password1.text != user.confirmpassword.text) {
                        return '${user.lg[user.language]["Password dosen't match"]}';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                ),
                loadingButton
                    ? CircularProgressIndicator()
                    : Padding(
                      padding:  EdgeInsets.only(top:_mediaQuery*0.2),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (!formkey.currentState.validate()) {
                              return;
                            } else {
                              setState(() {
                                loadingButton = true;
                              });
                              validateText();
                              var resetPassword = await user.ResetPassword();
                              print(resetPassword);

                              user.LogIn();
                              if (resetPassword) {
                                print('${user.lg[user
                                    .language]["Reset succeed"]}');
                                setState(() {
                                  loadingButton = false;
                                });
                                Navigator.of(context).pop();


                                user.clearAllTextController();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (context) =>
                                        LoginScreen()), (
                                    Route<dynamic> route) => false);
                              }
                            else{
                                MotionToast.error(
                                  title: "Cater me",
                                  titleStyle: TextStyle(
                                      fontWeight: FontWeight.bold),
                                  description: "${user.lg[user
                                      .language]['Cannot Update Info']}",
                                  //  animationType: ANIMATION.FROM_LEFT,
                                ).show(context);
                              }
                            }
                          },
                          child: Text(
                            'Update Password',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(
                                _mediaQuery * 0.075,
                                _mediaQuery * 0.02,
                                _mediaQuery * 0.075,
                                _mediaQuery * 0.02),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            primary: const Color(0xff3F5521),
                          ),
                        ),
                    )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
