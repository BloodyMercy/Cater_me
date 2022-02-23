import 'package:CaterMe/Providers/orderById_provider.dart';
import 'package:CaterMe/Providers/orderStatus_provider.dart';
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
                              Card(
                                elevation: 5,
                                child: Container(
                                  child: ListView.separated(
                                    itemCount: 3,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, i) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Launch  ",
                                                  style: TextStyle(
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.03,
                                                ),
                                                Text(
                                                  "SAR 1000",
                                                  style: TextStyle(
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    separatorBuilder: (BuildContext context, int index) { return Divider(thickness: 2,); },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              // Text('Payment'),
                              Card(
                                elevation: 5,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Tax",
                                            style: TextStyle(
                                                color: blackColor,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Text(
                                              // "SAR ${double.parse((order.orderbyId["tax"] ?? 0.0).toStringAsFixed(2))}",
                                            "SAR 100",
                                              style: TextStyle(
                                                  color: blackColor,
                                                  fontWeight: FontWeight.normal)),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("SubTotal",
                                              style: TextStyle(
                                                  color: blackColor,
                                                  fontWeight: FontWeight.normal)),
                                          Text(
                                              // "SAR ${double.parse((order.orderbyId["subTotal"] ?? 0.0).toStringAsFixed(2))}",
                                            "SAR 100",
                                              style: TextStyle(
                                                  color: blackColor,
                                                  fontWeight: FontWeight.normal)),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Total",
                                              style: TextStyle(
                                                  color: blackColor,
                                                  fontWeight: FontWeight.normal)),
                                          Text(
                                              // "SAR ${double.parse((order.orderbyId["total"] ?? 0.0).toStringAsFixed(2))}",
                                            "Sar 100",
                                              style: TextStyle(
                                                  color: blackColor,
                                                  fontWeight: FontWeight.normal)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // order.paymentFreind.length == 0? SliverToBoxAdapter(child: Container(),) :
                      // SliverToBoxAdapter(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8),
                      //     child: Column(
                      //       children: [
                      //         Text('Payments',style:TextStyle(color:Colors.black)),
                      //         SizedBox(height: 10,),
                      //         Card(
                      //           elevation: 5,
                      //           child:
                      //
                      //               Container(
                      //                   child: ListView.separated(
                      //                     itemCount: order.paymentFreind.length,
                      //                     physics:
                      //                         NeverScrollableScrollPhysics(),
                      //                     shrinkWrap: true,
                      //                     itemBuilder: (context, index) {
                      //                       return Column(
                      //                         children: [
                      //                           Padding(
                      //                             padding: const EdgeInsets.all(
                      //                                 10.0),
                      //                             child: Row(
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment
                      //                                       .spaceBetween,
                      //                               children: [
                      //                                 Container(
                      //                                   width: _width*0.4,
                      //                                   child: Text(
                      //                                     "${order.paymentFreind[index].name}",
                      //                                     style: TextStyle(
                      //                                         color:
                      //                                             blackColor,
                      //                                         fontWeight:
                      //                                             FontWeight.normal),
                      //                                   ),
                      //                                 ),
                      //                                 Text(
                      //                                   "SAR ${order.paymentFreind[index].amount}",
                      //                                   style: TextStyle(
                      //                                       color: blackColor,
                      //                                       fontWeight:
                      //                                           FontWeight
                      //                                               .normal),
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           )
                      //                         ],
                      //                       );
                      //                     }, separatorBuilder: (BuildContext context, int index) { return Divider(thickness: 2,); },
                      //                   ),
                      //                 ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // rejected
                      //     ? SliverToBoxAdapter(
                      //         child: donate
                      //             ? Center(
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.all(8.0),
                      //                   child: Text(
                      //                     "Your food is donated",
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .headline1
                      //                         .copyWith(color: Colors.black),
                      //                   ),
                      //                 ),
                      //               )
                      //             : Center(
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.all(8.0),
                      //                   child: Column(
                      //                     children: [
                      //                       Text(
                      //                         "Do you want to donate your food?",
                      //                         style: Theme.of(context)
                      //                             .textTheme
                      //                             .headline1
                      //                             .copyWith(color: Colors.black),
                      //                       ),
                      //                       order.buttonDonate
                      //                           ? Center(
                      //                               child:
                      //                                   CircularProgressIndicator(),
                      //                             )
                      //                           : ElevatedButton(
                      //                               onPressed: () {},
                      //                               // async {
                      //                               //   order.buttonDonate = true;
                      //                               //   setState(() {});
                      //                               //   donate = await order
                      //                               //       .donate();
                      //                               //   order.buttonDonate =
                      //                               //       false;
                      //                               //   setState(() {});
                      //                               // },
                      //                               child: Text(
                      //                                 "Donate",
                      //                                 style: Theme.of(context)
                      //                                     .textTheme
                      //                                     .headline1,
                      //                               )),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //       )
                      //     : SliverToBoxAdapter(
                      //         child: Center(),),

                    ],
                  )),
      ),
    );
  }
}
