
import 'package:flutter/material.dart';

import 'OrderCard.dart';

class OrderList extends StatefulWidget {
  List<dynamic>a;
   OrderList({Key key, this.a}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.a.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
          child: OrderCard(
            a:widget.a[index],
          ),
        ),
      ),
    );
  }
}
