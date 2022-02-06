import 'package:flutter/material.dart';

class OrderPreparing extends StatelessWidget {
  const OrderPreparing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset("images/order_preparing.png"),
      Container(width: double.infinity,padding: EdgeInsets.symmetric(horizontal: 10),child: FittedBox(
          fit: BoxFit.contain,child: Text("Preparing Order",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),))),

    ],
    );
  }
}
