import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AccountInfo extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();
  final oldPassController = TextEditingController();

  bool validate() {
    if (formkey.currentState != null) {
      if (newPassController.text != confirmPassController.text) {
        print("passwords don't match");
        return false;
      }
      if (formkey.currentState!.validate()) {
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

  String? validatePass(value) {
    if (value.isEmpty) {
      return 'Required *';
    } else if (value.length < 6) {
      return 'Should Se At Least 6 Characters';
    } else if (value.length > 15) {
      return 'Should Not Be More Than 15 characters';
    } else {
      return null;
    }
  }

  String? validateConfirmPass(value) {
    validatePass(value);
    if (value != newPassController.text) {
      return "Passwords don't match";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
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
        body: SingleChildScrollView(
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
                controller: oldPassController,
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
                controller: newPassController,
                validator: validatePass,
              ),
              SizedBox(height: _mediaQuery * 0.03),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: Theme.of(context).textTheme.headline4,
                  contentPadding: const EdgeInsets.only(left: 20),
                ),
                controller: confirmPassController,
                validator: validateConfirmPass,
                obscureText: true,
              ),
              SizedBox(height: _mediaQuery * 0.09),
              ElevatedButton(
                onPressed: () {
                  validate();
                },
                child: Text(
                  'SAVE',
                  style: Theme.of(context).textTheme.headline1,
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(_mediaQuery * 0.18,
                      _mediaQuery * 0.02, _mediaQuery * 0.18, _mediaQuery * 0.02),
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
    );
  }
}
