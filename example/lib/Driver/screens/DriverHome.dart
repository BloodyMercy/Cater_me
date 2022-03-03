import 'package:CaterMe/Driver/auth/driver_login.dart';
import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/Screens/CustomAlert/alert.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'TodayOrder.dart';
import 'UpComingOrder.dart';


class DriverHome extends StatefulWidget {
  // int id;
  // int screen;

  // OrderId(this.id, this.screen);

  @override
  _DriverHomeState createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    final personalInfo=Provider.of<UserProvider>(context,listen: true);
    List<Widget> _screen = [TodayOrder(), UpComingOrder()];
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Tracking",style: Theme.of(context).textTheme.headline1,),
        centerTitle: true,
        actions: [
          IconButton(onPressed: ()async{
            showDialog(context: context,
                builder: (BuildContext context) {
                  return CustomDialog(
                    title: 'Sad to see you leave',
                    description: "",
                    oneOrtwo: true,
                    button2: ElevatedButton(
                      onPressed: () async {
                        final SharedPreferences
                        sharedPreferences =
                        await SharedPreferences.getInstance();
                        // sharedPreferences.remove('Email');
                        //  sharedPreferences.remove('Password');
                        personalInfo.clearAllTextController();
                        bool a=sharedPreferences.getBool("startintro");
                        sharedPreferences.clear();
                        sharedPreferences.setBool("startintro", a);


                        Navigator.of(context)
                            .pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) =>
                                  DriverLoginScreen(),
                            ),
                                (route) => false);
                      }, child: Text("Logout",style: TextStyle(fontFamily: 'BerlinSansFB'),),),
                    button1: ElevatedButton(onPressed: () {
                      Navigator.of(context).pop();
                    }, child: Text("No",style: TextStyle(fontFamily: 'BerlinSansFB')),

                    )
                    ,);
                });

          }, icon: Icon(FontAwesomeIcons.signOutAlt,size: 20,))
        ],
      ),
      body: SafeArea(child: _screen[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor:LightColors.kLightYellow,
          unselectedItemColor: Color(0xFF3F5521),
          selectedItemColor: Color.fromRGBO(253, 202, 29, 1),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Today"),
            BottomNavigationBarItem(icon:FaIcon(FontAwesomeIcons.truck) , label: "Upcoming")
          ]),
    );
  }
}

