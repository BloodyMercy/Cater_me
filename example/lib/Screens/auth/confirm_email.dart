import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'newlogin/screens/loginScreen.dart';

class ConfirmEmailSent extends StatelessWidget {
  const ConfirmEmailSent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Image.asset(
                'images/check.png',
                height: screenHeight * 0.3,
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            FittedBox(
              child:
                  Text('Sent!', style: Theme.of(context).textTheme.headline5),
            ),
            SizedBox(height: screenHeight * 0.375),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  LoginScreen()));
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
    );
  }
}
