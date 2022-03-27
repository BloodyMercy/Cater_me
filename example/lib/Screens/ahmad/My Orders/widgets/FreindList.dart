
import 'package:CaterMe/Screens/ahmad/My%20Orders/widgets/OrderfreindCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Providers/packages.dart';
import 'OrderCard.dart';
import 'UserOrders.dart';

class OrderfreindList extends StatefulWidget {
  List<dynamic>a;
   OrderfreindList({Key key, this.a}) : super(key: key);

  @override
  State<OrderfreindList> createState() => _OrderfreindListState();
}

class _OrderfreindListState extends State<OrderfreindList> {

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.a.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
          child: OrderfreindCard(
            a:widget.a[index],
          ),
        ),
      ),
    );
  }
}
