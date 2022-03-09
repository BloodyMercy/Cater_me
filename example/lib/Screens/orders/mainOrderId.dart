import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/Screens/orders/order_details.dart';
import 'package:CaterMe/Screens/orders/order_tracking.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../Providers/user.dart';
import '../../language/language.dart';

class OrderId extends StatefulWidget {
  int id;
  int screen;

  OrderId(this.id, this.screen);

  @override
  _OrderIdState createState() => _OrderIdState();
}

class _OrderIdState extends State<OrderId> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      widget.screen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    List<Widget> _screen = [DetailsOrder(widget.id), TrackingOrder(widget.id)];
    return Scaffold(
      appBar: AppBar(
        title: Text('${LanguageTr.lg[authProvider.language]["Order Info" ]}',style: Theme.of(context).textTheme.headline1,),
        centerTitle: true,
      ),
      body: SafeArea(child: _screen[widget.screen]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:LightColors.kLightYellow,
          unselectedItemColor: Color(0xFF3F5521),
          selectedItemColor: Color.fromRGBO(253, 202, 29, 1),
          currentIndex: widget.screen,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: '${LanguageTr.lg[authProvider.language][ "Details"]}',),
            BottomNavigationBarItem(icon:FaIcon(FontAwesomeIcons.truck) , label: '${LanguageTr.lg[authProvider.language][ "Tracking"]}',),
          ]),
    );
  }
}
