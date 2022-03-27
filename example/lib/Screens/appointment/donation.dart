import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Providers/user.dart';
import '../../language/language.dart';

class DonationAdded extends StatefulWidget {
  const DonationAdded({Key key}) : super(key: key);

  @override
  State<DonationAdded> createState() => _DonationAddedState();
}

class _DonationAddedState extends State<DonationAdded> {

  String language;

  getdata()async{
    SharedPreferences sh=await SharedPreferences.getInstance();
    (sh.getString("locale"));
    setState(() {
      language = sh.getString("locale");
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

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
                    child: language=="en"?Image.asset('images/Donated.png',
                        fit: BoxFit.contain,):Image.asset('images/no address yetعربي/no addresses yetبالعربي-02.png',
                      fit: BoxFit.contain,)),
                // SizedBox(
                //   height: mediaQuery.size.height * 0.08,
                // ),
                // Text(
                //   "The Rest Of Your Food Will Be Donated",
                //
                //   style: TextStyle(fontSize: 18,color: colorCustom),
                // ),
                // Text(''),
                // Text(
                //   "To Days Of Hope",
                //
                //   style: TextStyle(fontSize: 18,color: colorCustom),
                // ),
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
                '${authProvider.lg[authProvider.language][ "Close"]}',
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
