import 'package:CaterMe/Screens/orders/order_details.dart';
import 'package:CaterMe/Screens/orders/order_tracking.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
class OrderId extends StatefulWidget {
  int id;
  int screen;
  OrderId(this.id,this.screen);

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
    List<Widget> _screen=[DetailsOrder(widget.id),TrackingOrder(widget.id)];
    return Scaffold(
      appBar: AppBar(title: Text("Order Info"),),
      body:SafeArea(child: _screen[widget.screen]),
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: colorCustom.shade100,
          selectedItemColor: colorCustom,
          currentIndex: widget.screen,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list),
                label: "Details"),
            BottomNavigationBarItem(icon: Icon(Icons.add),
                label: "Tracking")
          ]),
    );
  }
}
