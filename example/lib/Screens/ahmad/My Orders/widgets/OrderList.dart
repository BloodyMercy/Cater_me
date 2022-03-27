
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Providers/packages.dart';
import 'OrderCard.dart';
import 'UserOrders.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {

  @override
  Widget build(BuildContext context) {
    final package = Provider.of<PackagesProvider>(context, listen: true);
    return Flexible(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: package.allpackages.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
          child: OrderCard(
            userOrder:package.allpackages[index],
          ),
        ),
      ),
    );
  }
}
