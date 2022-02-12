

import 'package:flutter/material.dart';

import '../../Screens/ocassionsScreens/occasion_listview.dart';
import '../../Screens/orders/yourOrders.dart';
import '../../Screens/settings_screen.dart';
import '../../widgets/homepage.dart';

class HomenavigationPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomenavigationPage> {

  List<Widget> _pages = [  HomePage(),
    OccasionListView(),
    YourOrders(),
    TABBar()
  ];

  List<IconData> _bottomBarIcons = [Icons.home, Icons.favorite_border, Icons.calendar_today, Icons.person_outline,];
  List<String> _bottomBarLabels = ["Menu", "Liked", "Orders", "Profile"];

  int _currentBottomTabSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
           // _buildAppBar(),
            Expanded(child: _pages[_currentBottomTabSelected]),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }


  Widget _buildAppBar() {
    // return Padding(
    //   padding: const EdgeInsets.all(20.0),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       Expanded(child: Text("Menu", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, ),)),
    //       ActionButton(icon: Icons.add_shopping_cart,),
    //     ],
    //   ),
    // );
  }


  Widget _buildBottomBar() {
    return Container(
      color: Color(0xffB9D7D5),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(26), topRight: Radius.circular(26,),),
        child: Container(
          color: Colors.white,
          child: Row(
            children: _bottomBarIcons.map((icon) {
              int position = _bottomBarIcons.indexOf(icon);
              return Expanded(child:
              Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentBottomTabSelected = position;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _currentBottomTabSelected == position ? _getCircle() : Icon(_bottomBarIcons[position]),
                      Visibility(
                        visible: position == _currentBottomTabSelected,
                        child: Text(_bottomBarLabels[position],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Theme.of(context).accentColor, fontSize: 12,),),
                      )
                    ],
                  ),
                ),
              )
              );
            }).toList(),
          ),
        ),
      ),
    );
  }


  Widget _getCircle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: CircleAvatar(
        backgroundColor: Theme.of(context).accentColor,
        radius: 4,
      ),
    );
  }




}