import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NavigationBar/navigation_bar.dart';
import 'Providers/user.dart';
import 'SplachScreen.dart';
import 'main.dart';

class LanguagePicker extends StatefulWidget {
  @override
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  @override
  Widget build(BuildContext context) {
    final personalInfo = Provider.of<UserProvider>(context, listen: true);
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    var mediaQueryWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              "images/logo-white.png",
              height: MediaQuery.of(context).size.height * 0.4,
            )),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      child: Text('English'),
                      onPressed: () async {
                        personalInfo.language = "en";

                        SharedPreferences _prefs =
                            await SharedPreferences.getInstance();
                        _prefs.setString("locale", "en");
                        MyApp.setLocale(context, Locale("en", "US"));
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => appstate(),
                            ),
                            (Route<dynamic> route) => false);
                        // AppLocalizations.of(context)!.locale.toString()

                        // .language="ar";                                              },
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: mediaQueryWidth * 0.1,
                            vertical: mediaQueryHeight * 0.02),
                      )),
                  ElevatedButton(
                      onPressed: () async {
                        personalInfo.language = "ar";
                        SharedPreferences _prefs =
                            await SharedPreferences.getInstance();
                        _prefs.setString("locale", "ar");
                        MyApp.setLocale(context, Locale("ar", "AE"));
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => appstate(),
                            ),
                            (Route<dynamic> route) => false);
                      },
                      child: Text('العربية'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: mediaQueryWidth * 0.125,
                            vertical: mediaQueryHeight * 0.016),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
