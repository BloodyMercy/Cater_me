import 'package:CaterMe/Providers/order.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';

import 'package:CaterMe/Screens/orders/mainOrderId.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class YourOrders extends StatefulWidget {
  const YourOrders({Key? key}) : super(key: key);

  @override
  _YourOrdersState createState() => _YourOrdersState();
}

class _YourOrdersState extends State<YourOrders> {
  bool loading = true;

  Future getData() async {
    final orders = Provider.of<OrderProvider>(context, listen: false);
    await orders.getAllOrders();

    setState(() {
      loading = false;
    });
    return;
  }

  Future refreshOrderData() async {
    final orders = Provider.of<OrderProvider>(context, listen: false);

    await orders.clearData();
    await orders.getAllOrders();
    return;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Color _getColorByEvent(String orderStatus) {
    if (orderStatus == "Accepted") return  Color(0xFF3F5521);
    if (orderStatus == "Rejected") return Colors.red;
    if (orderStatus == "Pending ") return  Color.fromRGBO(253, 202, 29, 1);
    if (orderStatus == "Delivered") return Color(0xFF3F5521,);
    return Colors.blue;
  }

  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: refreshOrderData,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                  color: LightColors.kLightYellow,
                        child: ListView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (builder) =>
                                      OrderId(orders.listOrder[index].id!, 0),
                                ),
                              );
                            },
                            child: Card(
                              color: LightColors.kLightYellow2,
                                child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(orders.listOrder[index].eventName,
                                          style: TextStyle(
                                              color: Color(0xFF3F5521),
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        orders.listOrder[index].orderStatus,
                                        style: TextStyle(
                                          color: _getColorByEvent(orders
                                              .listOrder[index]
                                              .orderStatus.toString()),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${DateFormat("dd-MM-yyyy").format(DateTime.parse(orders.listOrder[index].eventDate))}",
                                    style: TextStyle(
                                        color: Color(0xFF3F5521),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Address: ${orders.listOrder[index].addressTitle}",
                                    style: TextStyle(
                                        color: Color(0xFF3F5521),
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )),
                          );
                        },
                        itemCount: orders.listOrder.length,
                      ))),
          ),
        ),
      ),
    );
  }
}
