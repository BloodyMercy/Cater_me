import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/Screens/orders/order_details.dart';
import 'package:CaterMe/Screens/orders/order_tracking.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'TodayOrder.dart';
import 'UpComingOrder.dart';


class DriverTracking extends StatefulWidget {
  // int id;
  // int screen;

  // OrderId(this.id, this.screen);

  @override
  _DriverTrackingState createState() => _DriverTrackingState();
}

class _DriverTrackingState extends State<DriverTracking> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    List<Widget> _screen = [TodayOrder(), UpComingOrder()];
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Tracking",style: Theme.of(context).textTheme.headline1,),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.signOutAlt,size: 20,))
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

