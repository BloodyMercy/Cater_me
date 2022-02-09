import 'package:flutter/material.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  const ConfirmPasswordScreen({Key key}) : super(key: key);

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String password = '', confirmPassword = '';
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
      return "Must have Upper,LowerCase,Special Character & Number";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.12),
            Text(
              'Please enter your new password',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: screenHeight * 0.12),
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
                          onChanged: (value) => password = value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              icon: Icon(
                                passObscure
                                    ? Icons.lock_open_outlined
                                    : Icons.lock_outlined,
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
                          validator: validatePass,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFormField(
                          onChanged: (value) => confirmPassword = value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              icon: Icon(
                                passObscure
                                    ? Icons.lock_open_outlined
                                    : Icons.lock_outlined,
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
                            hintText: 'Confirm Password',
                            hintStyle: Theme.of(context).textTheme.headline4,
                          ),
                          validator: validatePass,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.3),
                  ElevatedButton(
                    onPressed: () {
                      validate();
                    },
                    child: Text(
                      'Done',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(
                          screenHeight * 0.18,
                          screenHeight * 0.02,
                          screenHeight * 0.18,
                          screenHeight * 0.02),
                      onPrimary: const Color.fromRGBO(255, 255, 255, 1),
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
