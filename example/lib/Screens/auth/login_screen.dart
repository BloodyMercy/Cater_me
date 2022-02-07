import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:CaterMe/Providers/user.dart';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'reset_password_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String? password = '', confirmPassword = '', email = '';
  bool passObscure = true;
  bool confObscure = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
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

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 35.0),
                child: Center(
                  child: Image(
                    image: AssetImage('images/logo.png'),
                    // width: 800,
                    height: 300,
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
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: formkey,
                        child: Column(children: [
                          TextFormField(
                              controller: authProvider.email,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                prefixIcon: IconButton(
                                  icon: const Icon(Icons.mail_outline),
                                  onPressed: () {},
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
                                hintText: 'Email or Phone number',
                                hintStyle:
                                    Theme.of(context).textTheme.headline4,
                              ),
                              validator: MultiValidator([
                                RequiredValidator(errorText: 'Required *'),
                                // EmailValidator(errorText: 'Not a valid email'),
                              ]),
                              keyboardType: TextInputType.emailAddress),
                          SizedBox(
                            height: screenHeight * 0.015,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: authProvider.password,
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
                              hintStyle: Theme.of(context).textTheme.headline4,
                            ),
                            // validator: validatePass,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'this field is Required *'),
                              // EmailValidator(errorText: 'Not a valid email'),
                            ]),
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
                              text: 'Forgot Password ?',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ResetPasswordScreen()));
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

                              if (formkey.currentState!.validate() == false) {
                                // ignore: avoid_print
                                print('Not Validated');
                                setState(() {
                                  loading = false;
                                });
                                // reset!=null?
                              } else {
                                if (await authProvider.LogIn()) {
                                  print("logged");
                                  setState(() {
                                    loading = false;
                                  });
                                  SharedPreferences sh =
                                      await SharedPreferences.getInstance();
                                  sh.setBool("logged", true);

                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Navigationbar(0)),
                                      (Route<dynamic> route) => false);
                                  //authProvider.status=Status.Authenticated;
                                  setState(() {});
                                } else {
                                  print("hello");
                                  setState(() {
                                    loading = false;
                                  });
                                  _scaffoldKey.currentState!.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "${authProvider.messagelogin.toString()}"),
                                    ),
                                  );
                                  authProvider.messagelogin = "";
                                }
                              }
                            },
                            child: Text(
                              'Log In',
                              style: TextStyle(color: Colors.white)
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
                        : Center(child: CircularProgressIndicator()),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Center(
                      child: InkWell(
                        child: FittedBox(
                          child: Text(
                            'Create New Account',
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
