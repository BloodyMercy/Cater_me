import 'package:CaterMe/Driver/listViewOrderDriver.dart';
import 'package:CaterMe/Driver/orderDriverDetails.dart';
import 'package:CaterMe/Providers/orderById_provider.dart';
import 'package:CaterMe/Providers/orderStatus_provider.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodayOrder extends StatefulWidget {
  // int id;
  //
  // TodayOrder(this.id);

  @override
  _TodayOrder createState() => _TodayOrder();
}

class _TodayOrder extends State<TodayOrder> {
  double Price = 0.0;
  double finaltax = 0.0;
  double finalPrice = 0.0;

  bool loading = false;
  bool donate = false;
  bool rejected = false;

  // getData() async {
  //   final orders = Provider.of<OrderByIdProvider>(context, listen: false);
  //   await orders.getOrderById(widget.id);
  //   await orders.getOrderItems();
  //   await orders.getOrderPaymentFreind();
  //   print(orders.items.length);
  //   final orderStatus =
  //       Provider.of<OrderStatusProvider>(context, listen: false);
  //   await orderStatus.getOrderStatus(widget.id);
  //
  //   if (orderStatus.orderStatus.statusId != 5) {
  //     setState(() {
  //       rejected = true;
  //     });
  //   }
  //   donate = orders.orderbyId['isDonated'] ?? false;
  //   setState(() {
  //     loading = false;
  //   });
  // }

  // Future refreshOrderData() async {
  //   final orders = Provider.of<OrderByIdProvider>(context, listen: false);
  //
  //   await orders.clearData();
  //   await orders.getOrderById(widget.id);
  //
  //   return;
  // }

  // @override
  // void initState() {
  //   getData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final order = Provider.of<OrderByIdProvider>(context, listen: true);
    final _width=MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
            onRefresh: (){},
            child: loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF3F5521),
                    ),
                  )
                : CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Today's Order",
                                style: TextStyle(color: Colors.black),
                              ),SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ),
                      SliverList(delegate:
                      SliverChildBuilderDelegate(
                              (BuildContext context,int index){
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>OrderDriverDetails()));
                          },
                          child: Card(
                              elevation: 5,
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
                                        Text("Event Name",
                                            // orders.listOrder[index].eventName,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                        Text("Order Status",
                                          // orders.listOrder[index].orderStatus,
                                          style: TextStyle(
                                            // color:
                                            // _getColorByEvent(orders
                                            //     .listOrder[index]
                                            //     .orderStatus.toString()),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "23-02-2022",
                                      // "${DateFormat("dd-MM-yyyy").format(DateTime.parse(orders.listOrder[index].eventDate))}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      // "Address: ${orders.listOrder[index].addressTitle}",
                                      "Address: KSA",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                              )),
                        );
                      }

                      ,childCount: 10)
                        ,),
                    ],
                  )),
      ),
    );
  }
}
