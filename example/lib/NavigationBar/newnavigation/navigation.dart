

import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/Order.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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

  List<IconData> _bottomBarIcons = [FontAwesomeIcons.home, FontAwesomeIcons.calendarCheck,Icons.backpack, FontAwesomeIcons.solidUser,];
  List<String> _bottomBarLabels = ["Home", "Occasions", "Orders", "Profile"];

  int _currentBottomTabSelected = 0;

  @override
  Widget build(BuildContext context) {
    final package = Provider.of<PackagesProvider>(context, listen: true);
    final orderCaterprovider=Provider.of<OrderCaterProvider>(context,listen: true);
    final address=Provider.of<AdressProvider>(context,listen: true);
    return Scaffold(

floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
              address.value2Index=-1;
              orderCaterprovider.valueIndex=-1;
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

      body: SafeArea(
        child: Column(
          children: <Widget>[
           // _buildAppBar(),
            Expanded(child: _pages[_currentBottomTabSelected]),
            BottomAppBar(

              color: LightColors.kLightYellow,
              shape: const CircularNotchedRectangle(),
              notchMargin: 3,
              clipBehavior: Clip.antiAlias,
              child:
              ClipRRect(

                borderRadius: BorderRadius.only(topLeft: Radius.circular(26), topRight: Radius.circular(26,),),
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: _bottomBarIcons.map((icon) {
                      int position = _bottomBarIcons.indexOf(icon);
                      return Expanded(
                          flex: 1,
                          child:
                      Padding(
                        padding:const EdgeInsets.all(16),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentBottomTabSelected = position;
                            });
                          },
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _currentBottomTabSelected == position ? _getCircle(position) :_geticon(position,package.nbnotification),

                            ],
                          ),
                        ),
                      )
                      );
                    }).toList(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }







  Widget _getCircle(int position) {
    return Icon(_bottomBarIcons[position],
      size: 25, //Icon Size
      color: Color.fromRGBO(253, 202, 29, 1),);
  }

  Widget _geticon(int position,String nb) {
    return ( nb!="0"  && position==2)? Badge(
        badgeColor: Color.fromRGBO(253, 202, 29, 1),child:Icon(_bottomBarIcons[position],
      size: 25, //Icon Size
      color: Color(0xFF3F5521),)):Icon(_bottomBarIcons[position],
      size: 25, //Icon Size
      color: Color(0xFF3F5521),);
  }


}