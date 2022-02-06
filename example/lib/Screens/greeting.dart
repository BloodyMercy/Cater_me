import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Greeting extends StatelessWidget {
  static const routeName = '/greeting';
  String name = "Name";

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    const double fontSize = 40;
    const String fontFamily = 'Berlin Sans FB';
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        height: mediaQuery.size.height,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: mediaQuery.size.width * 0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: mediaQuery.size.height * 0.38,
                      ),
                      Text("Hi ${name},",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontFamily: fontFamily,
                            fontSize: fontSize,
                          )),
                      Text("Welcome to ",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontFamily: fontFamily,
                            fontSize: fontSize,
                          )),
                      const Text(
                        "Cater me",
                        style: TextStyle(
                          color: Color.fromRGBO(253, 202, 29, 1),
                          fontFamily: fontFamily,
                          fontSize: fontSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: mediaQuery.size.height * 0.18,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)))),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                              vertical: (mediaQuery.size.height * 0.074) * 0.3,
                              horizontal: (mediaQuery.size.width * 0.25)),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor)),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          Navigationbar(0)), (Route<dynamic> route) => false);
                    },
                    child: Text(
                      "Continue",
                      style: Theme.of(context).textTheme.headline1,
                    )),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
