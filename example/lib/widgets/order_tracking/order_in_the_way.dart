import 'package:flutter/material.dart';

class OrderOnTheWay extends StatelessWidget {
  const OrderOnTheWay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset("images/order_on_the_way.png"),
      Container(width: double.infinity,padding: EdgeInsets.symmetric(horizontal: 10),child: FittedBox(
          fit: BoxFit.contain,child: Text("Order Is On The Way",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),))),
    ],
    );
  }
}
