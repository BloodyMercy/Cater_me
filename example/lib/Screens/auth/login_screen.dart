import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/SplachScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../language/language.dart';
import 'reset_password_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String password = '', confirmPassword = '', email = '';
  bool passObscure = true;
  bool confObscure = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;

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
      final authProvider = Provider.of<UserProvider>(context, listen: false);

      return "this field should be at least 6 character";
    }
    if (!RegExp(r"[A-Z]").hasMatch(value) == true ||
        !RegExp(r"[a-z]").hasMatch(value) == true) {
      return "Must have Upper,LowerCase";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    //  final authProvider = Provider.of<UserProvider>(context, listen: true);
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Center(
                  child: Image(
                    image: AssetImage('images/logo.png'),
                    // width: 800,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 37.0, right: 37.0),
                child: Column(
                  children: [
                    Center(
                      child: Form(
                        key: formkey,
                        child: Column(children: [
                          TextFormField(
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'BerlinSansFB'),
                              decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                    icon: const Icon(Icons.mail_outline),
                                    onPressed: () {},
                                  ),
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
                                  contentPadding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.01),
                                  alignLabelWithHint: true,
                                  labelStyle: TextStyle(
                                      fontSize: focusNode.hasFocus ? 18 : 16.0,
                                      textBaseline: TextBaseline.alphabetic,
                                      //I believe the size difference here is 6.0 to account padding
                                      color: focusNode.hasFocus
                                          ? Color(0xFF3F5521)
                                          : Colors.grey),
                                  labelText:
                                      '${LanguageTr.lg[authProvider.language]["Email"]}',
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
                              controller: authProvider.email,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress),
                          SizedBox(
                            height: screenHeight * 0.015,
                          ),
                          TextFormField(
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'BerlinSansFB'),
                            decoration: InputDecoration(
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
                                labelText:
                                    '${LanguageTr.lg[authProvider.language]["Password"]}',
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
                            controller: authProvider.password,

                            // validator: validatePass,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,

                            keyboardType: TextInputType.visiblePassword,
                            obscureText: passObscure,
                          ),
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InkWell(
                          child: RichText(
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text:
                                  '${LanguageTr.lg[authProvider.language]["Forgot Password"]}',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ResetPasswordScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.06,
                    ),
                    !loading
                        ? ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              // final SharedPreferences sharedPreferences =
                              //     await SharedPreferences.getInstance();
                              // sharedPreferences.setString(
                              //     'email', emailController.text);

                              if (formkey.currentState.validate() == false) {
                                // ignore: avoid_print
                                //   print('Not Validated');
                                setState(() {
                                  loading = false;
                                });
                                // reset!=null?
                              } else {
                                if (await authProvider.LogIn()) {
                                  authProvider.status = Status.Authenticated;
                                  //   print("logged");
                                  setState(() {
                                    loading = false;
                                  });

                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => SplashScreen()),
                                      (Route<dynamic> route) => false);
                                  //authProvider.status=Status.Authenticated;
                                  setState(() {});
                                } else {
                                  print("hello");
                                  setState(() {
                                    loading = false;
                                  });

                                  MotionToast.error(
                                    title: "Cater me",
                                    titleStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    description:
                                        '${LanguageTr.lg[authProvider.language][authProvider.messagelogin.toString()]}',
                                    //  animationType: ANIMATION.FROM_LEFT,
                                  ).show(context);
                                  // _scaffoldKey.currentState.showSnackBar(
                                  //   SnackBar(
                                  //     content: Text(
                                  //         "${authProvider.messagelogin.toString()}"),
                                  //   ),
                                  // );
                                  authProvider.messagelogin = "";
                                }
                              }
                            },
                            child: Text(
                                '${LanguageTr.lg[authProvider.language]["Log In"]}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'BerlinSansFB',
                                    fontSize: 15)),
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
                        : Center(child: CircularProgressIndicator()),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Center(
                      child: InkWell(
                        child: FittedBox(
                          child: Text(
                            '${LanguageTr.lg[authProvider.language]["Create New Account"]}',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                      ),
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
