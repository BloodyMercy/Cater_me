import 'package:CaterMe/Drawer/drawer_screen.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/Order.dart';
import 'package:CaterMe/Screens/add_friend_screen.dart';
import 'package:CaterMe/Screens/addresses_screen_fab.dart';
import 'package:CaterMe/Screens/addresses_screen.dart';
import 'package:CaterMe/Screens/dashboard.dart';
import 'package:CaterMe/Screens/my_favorites.dart';
import 'package:CaterMe/Screens/ocassionsScreens/occasions.dart';
import 'package:CaterMe/Screens/orders/yourOrders.dart';
import 'package:CaterMe/Screens/settings_screen.dart';
import 'package:CaterMe/widgets/homepage.dart';
import 'package:CaterMe/widgets/my_favorites_card.dart';
import 'package:CaterMe/Screens/notifications.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Navigationbar extends StatefulWidget {
  int _selectedIndex;
  Navigationbar(this._selectedIndex);
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<Navigationbar> {
  final List<Widget> _widgetOptions = const [
    HomePage(),
    Ocasions(),
    YourOrders(),
    TABBar()
  ];

  void _onItemTap(int index) {
    setState(() {
      widget._selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context){
    final packageprovider=Provider.of<PackagesProvider>(context,listen: true);

    return Stack(
      children: <Widget>[


        AnimatedOpacity(
          opacity: (packageprovider.loading )? 1.0 : 0.2,
          duration: Duration(milliseconds: 500),
          child: buildbody(context),
        ),
        AnimatedOpacity(
          opacity: (packageprovider.loading ) ? 0.0 : 1.0,
          duration: Duration(milliseconds: 500),
          child: buildLoading(context),
        ),
      ],
    );
  }
  Widget buildLoading(BuildContext context){
    return Align(
      child: Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
      alignment: Alignment.center,
    );
  }
  Widget buildbody(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: widget._selectedIndex,
          children: _widgetOptions,
        ),
        floatingActionButton: SizedBox(
          height: 60,
          width: 60,
          child: FittedBox(
            child: FloatingActionButton(
              elevation: 0,
              foregroundColor: Colors.transparent,
              shape: CircleBorder(
                side: BorderSide(
                    color: Theme.of(context).primaryColor, width: 0.5),
              ),
              backgroundColor: Colors.transparent,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Order(),
                  ),
                );
              },
              child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).primaryColor),
                  child: const Icon(Icons.add_rounded,
                      color: Colors.white, size: 35)),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 30,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_today_outlined,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  children: const [
                    Icon(
                      Icons.backpack,
                    ),
                    /*Positioned(
                    top: -1.0,
                    right: -1.0,
                    child: Stack(children: [
                     new Icon(
                        Icons.brightness_1,
                        color: Colors.red,
                        size: 12,
                      )
                    ])),*/
                  ],
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: '',
              ),
            ],
            currentIndex: widget._selectedIndex,
            onTap: _onItemTap,
          ),
        ));
  }
}
