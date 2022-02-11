import 'package:CaterMe/Providers/orderById_provider.dart';
import 'package:CaterMe/Providers/orderStatus_provider.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsOrder extends StatefulWidget {
  int id;

  DetailsOrder(this.id);

  @override
  _DetailsOrderState createState() => _DetailsOrderState();
}

class _DetailsOrderState extends State<DetailsOrder> {
  double Price = 0.0;
  double finaltax = 0.0;
  double finalPrice = 0.0;

  bool loading = true;

  getData() async {
    final orders = Provider.of<OrderByIdProvider>(context, listen: false);
    await orders.getOrderById(widget.id);
   await orders.getOrderItems();
   await orders.getOrderPaymentFreind();
   print(orders.paymentFreind.length);



    setState(() {
      loading = false;
    });

  }

  Future refreshOrderData() async {
    final orders = Provider.of<OrderByIdProvider>(context, listen: false);

    await orders.clearData();
    await orders.getOrderById(widget.id);

    return;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderByIdProvider>(context, listen: true);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: RefreshIndicator(
              onRefresh: refreshOrderData,
              child: loading
                  ? Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF3F5521),
                    ),
                  )
                  : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: ListView.builder(
                                    itemCount: order.items.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, i) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "${order.items[i].item}",
                                                  style: TextStyle(
                                                      color: Color(0xFF3F5521),
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.03,
                                                ),
                                                Text(
                                                  "SAR ${order.items[i].price}",
                                                  style: TextStyle(
                                                      color: Color(0xFF3F5521),
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ) ],
                                      );
                                    },

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Tax" ,style:TextStyle(
                                  color: Color(0xFF3F5521),
                                    fontWeight: FontWeight.bold)),
                                      Text("SAR ${
                                          double.parse((order.orderListDetails[0].tax).toStringAsFixed(2))}",style:TextStyle(
                                          color: Color(0xFF3F5521),
                                    fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("SubTotal" ,style:TextStyle(
                                          color: Color(0xFF3F5521),
                                          fontWeight: FontWeight.bold)),
                                      Text("SAR ${
                                          double.parse((order.orderListDetails[0].subTotal).toStringAsFixed(2))}",style:TextStyle(
                                          color: Color(0xFF3F5521),
                                          fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Total" ,style:TextStyle(
                                          color: Color(0xFF3F5521),
                                          fontWeight: FontWeight.bold)),
                                      Text("SAR ${
                                          double.parse((order.orderListDetails[0].total).toStringAsFixed(2))}",style:TextStyle(
                                          color: Color(0xFF3F5521),
                                          fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                    ],
                                  ),
                                ),
                              order.paymentFreind.length==0?Container():  Container(
                                  child: ListView.builder(
                                    itemCount: order.paymentFreind.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "${order.paymentFreind[index].email}",
                                                  style: TextStyle(
                                                      color: Color(0xFF3F5521),
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.03,
                                                ),
                                                Text(
                                                  "SAR ${order.paymentFreind[index].amount}",
                                                  style: TextStyle(
                                                      color: Color(0xFF3F5521),
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ) ],
                                      );
                                    },

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
