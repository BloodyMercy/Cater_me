import 'package:CaterMe/Drawer/drawer_screen.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/Order.dart';
import 'package:CaterMe/Screens/add_friend_screen.dart';
import 'package:CaterMe/Screens/addresses_screen_fab.dart';
import 'package:CaterMe/Screens/addresses_screen.dart';
import 'package:CaterMe/Screens/dashboard.dart';
import 'package:CaterMe/Screens/my_favorites.dart';
import 'package:CaterMe/Screens/ocassionsScreens/occasion_listview.dart';

import 'package:CaterMe/Screens/ocassionsScreens/occasions.dart';
import 'package:CaterMe/Screens/occasion/screens/home_page.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/Screens/orders/yourOrders.dart';
import 'package:CaterMe/Screens/settings_screen.dart';
import 'package:CaterMe/model/occasion.dart';
import 'package:CaterMe/widgets/homepage.dart';
import 'package:CaterMe/widgets/my_favorites_card.dart';
import 'package:CaterMe/Screens/notifications.dart';
import 'package:badges/badges.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Navigationbar extends StatefulWidget {
  int _selectedIndex;

  Navigationbar(this._selectedIndex);
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<Navigationbar> {
  final List<Widget> _widgetOptions = [
    HomePage(),
    OccasionListView(),
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
    final package = Provider.of<PackagesProvider>(context, listen: true);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: widget._selectedIndex,
          children: _widgetOptions,
        ),
        floatingActionButton: SizedBox(
          height: 55,
          width: 55,
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
                  height:40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).primaryColor),
                  child: const Icon(Icons.add_rounded,
                      color:Color.fromRGBO(253, 202, 29, 1), size: 35)),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: LightColors.kLightYellow,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            backgroundColor:  LightColors.kLightYellow,
            type: BottomNavigationBarType.fixed,
            iconSize: 30,
            selectedItemColor:Color.fromRGBO(253, 202, 29, 1),
            unselectedItemColor:  Theme.of(context).primaryColor,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_today_rounded,
                ),
                label: 'Ocasions',
              ),
        package.nbnotification!="0"  ? BottomNavigationBarItem(
                icon:  Badge(
                    badgeColor: Color.fromRGBO(253, 202, 29, 1),
                   // badgeContent:Text("3"),
                    child: Icon(
                      Icons.backpack,
                      color: Theme.of(context).primaryColor,
                    )),
                label: 'Orders',
              ):BottomNavigationBarItem(
          icon:  Icon(
                Icons.backpack,
                color: Theme.of(context).primaryColor,
              ),
          label: 'Orders',
        ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Settings',
              ),
            ],
            currentIndex: widget._selectedIndex,
            onTap: _onItemTap,
          ),
        ));
  }
}
