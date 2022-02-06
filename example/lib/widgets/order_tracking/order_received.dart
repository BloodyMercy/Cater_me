
import 'package:flutter/material.dart';

class OrderReceived extends StatelessWidget {
  const OrderReceived({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset("images/order_received.png"),
      Container(width: double.infinity,padding: EdgeInsets.symmetric(horizontal: 10),child: FittedBox(
          fit: BoxFit.contain,child: Text("Order Received",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),))),
    ],
    );
  }
}
