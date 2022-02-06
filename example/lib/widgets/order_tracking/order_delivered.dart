import 'package:flutter/material.dart';

class OrderDelivered extends StatelessWidget {
  const OrderDelivered({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset("images/order_delivered.png"),
      Container(width: double.infinity,padding: EdgeInsets.symmetric(horizontal: 10),child: FittedBox(
          fit: BoxFit.contain,child: Text("Order Delivered",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),))),
    ],
    );
  }
}
