import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:CaterMe/colors/colors.dart';

import 'package:flutter/material.dart';

class DonationAdded extends StatelessWidget {
  const DonationAdded({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: mediaQuery.size.height * 0.02,
            ),
            Column(

              children: [
                Center(
                    child: Image.asset('images/Group 1068.png',
                        height: 150, width: 150)),
                SizedBox(
                  height: mediaQuery.size.height * 0.08,
                ),
                Text(
                  "The Rest Of Your Food Will Be Donated",

                  style: TextStyle(fontSize: 18,color: colorCustom),
                ),
                Text(''),
                Text(
                  "To Days Of Hope",

                  style: TextStyle(fontSize: 18,color: colorCustom),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Navigationbar(0),
                  ),
                );
              },
              child: Text(
                "CLOSE",
                style: Theme.of(context).textTheme.headline1,
              ),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                padding: EdgeInsets.symmetric(
                  horizontal: (mediaQuery.size.width * 0.3),
                  vertical: (mediaQuery.size.height * 0.02),
                ),
                primary: Theme.of(context).primaryColor,
                shape: new RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
