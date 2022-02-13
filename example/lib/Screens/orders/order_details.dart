import 'package:CaterMe/Providers/orderById_provider.dart';
import 'package:CaterMe/Providers/orderStatus_provider.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/cupertino.dart';
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
  bool donate = false;

  getData() async {
    final orders = Provider.of<OrderByIdProvider>(context, listen: false);
    await orders.getOrderById(widget.id);
    await orders.getOrderItems();
    await orders.getOrderPaymentFreind();
    print(orders.items.length);
    donate = orders.orderbyId['isDonated'] ?? false;
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
      body: SafeArea(
        child: RefreshIndicator(
            onRefresh: refreshOrderData,
            child: loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF3F5521),
                    ),
                  )
                : CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Card(
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
                                                    color: blackColor,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                    color: blackColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Tax",
                                        style: TextStyle(
                                            color: blackColor,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "SAR ${double.parse((order.orderbyId["tax"]??0.0).toStringAsFixed(2))}",
                                        style: TextStyle(
                                            color: blackColor,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
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
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "SAR ${double.parse((order.orderbyId["subTotal"]??0.0).toStringAsFixed(2))}",
                                        style: TextStyle(
                                            color: blackColor,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
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
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "SAR ${double.parse((order.orderbyId["total"]??0.0).toStringAsFixed(2))}",
                                        style: TextStyle(
                                            color: blackColor,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Card(
                          elevation: 5,
                          child: order.paymentFreind.length == 0
                              ? Container()
                              : Container(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage:
                                                          NetworkImage(order
                                                              .paymentFreind[
                                                                  index]
                                                              .image),
                                                    ),
                                                    // SizedBox(width: 5,),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "${order.paymentFreind[index].name}",
                                                              style: TextStyle(
                                                                  color:
                                                                      blackColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              "${order.paymentFreind[index].email}",
                                                              style: TextStyle(
                                                                  color:
                                                                      blackColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // SizedBox(
                                                //   height: MediaQuery.of(context)
                                                //       .size
                                                //       .height *
                                                //       0.03,
                                                // ),
                                                Text(
                                                  "SAR ${order.paymentFreind[index].amount}",
                                                  style: TextStyle(
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: donate
                            ? Center(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Your food is donated",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        .copyWith(color: colorCustom),
                                  ),
                                ),
                            )
                            : Center(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Do you want to donate your food?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1
                                            .copyWith(color: colorCustom),
                                      ),
                                      order.buttonDonate
                                          ? Center(
                                              child: CircularProgressIndicator(),
                                            )
                                          : ElevatedButton(
                                              onPressed: () async {
                                                order.buttonDonate = true;
                                                setState(() {});
                                                donate =
                                                    await order.donate(widget.id);
                                                order.buttonDonate = false;
                                                setState(() {});
                                              },
                                              child: Text(
                                                "Donate",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1,
                                              )),
                                    ],
                                  ),
                                ),
                            ),
                      )
                    ],
                  )

            //
            //     : SingleChildScrollView(
            //       child: Padding(
            //         padding: const EdgeInsets.all(15.0),
            //         child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Card(
            //                 elevation: 5,
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Container(
            //                       child: ListView.builder(
            //                         itemCount: order.items.length,
            //                         physics: NeverScrollableScrollPhysics(),
            //                         shrinkWrap: true,
            //                         itemBuilder: (context, i) {
            //                           return Column(
            //                             children: [
            //                               Padding(
            //                                 padding: const EdgeInsets.all(10.0),
            //                                 child: Row(
            //                                   mainAxisAlignment:
            //                                   MainAxisAlignment.spaceBetween,
            //                                   children: [
            //                                     Text(
            //                                       "${order.items[i].item}",
            //                                       style: TextStyle(
            //                                           color: blackColor,
            //                                           fontWeight: FontWeight.bold),
            //                                     ),
            //                                     SizedBox(
            //                                       height: MediaQuery.of(context)
            //                                           .size
            //                                           .height *
            //                                           0.03,
            //                                     ),
            //                                     Text(
            //                                       "SAR ${order.items[i].price}",
            //                                       style: TextStyle(
            //                                           color: blackColor,
            //                                           fontWeight: FontWeight.bold),
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ) ],
            //                           );
            //                         },
            //
            //                       ),
            //                     ),
            //
            //
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(height: 10,),
            //               Card(
            //                 elevation: 5,
            //                 child: Column(
            //                   children: [
            //                     Padding(
            //                       padding: const EdgeInsets.all(10.0),
            //                       child: Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Text("Tax" ,style:TextStyle(
            //                               color: blackColor,
            //                               fontWeight: FontWeight.bold)),
            //                           Text("SAR ${
            //                               double.parse((order.orderbyId["tax"]).toStringAsFixed(2))}",style:TextStyle(
            //                               color: blackColor,
            //                               fontWeight: FontWeight.bold)),
            //                         ],
            //                       ),
            //                     ),
            //                     Padding(
            //                       padding: const EdgeInsets.all(10.0),
            //                       child: Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Text("SubTotal" ,style:TextStyle(
            //                               color: blackColor,
            //                               fontWeight: FontWeight.bold)),
            //                           Text("SAR ${
            //                               double.parse((order.orderbyId["subTotal"]).toStringAsFixed(2))}",style:TextStyle(
            //                               color: blackColor,
            //                               fontWeight: FontWeight.bold)),
            //                         ],
            //                       ),
            //                     ),
            //                     Padding(
            //                       padding: const EdgeInsets.all(10.0),
            //                       child: Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Text("Total" ,style:TextStyle(
            //                               color: blackColor,
            //                               fontWeight: FontWeight.bold)),
            //                           Text("SAR ${
            //                               double.parse((order.orderbyId["total"]).toStringAsFixed(2))}",style:TextStyle(
            //                               color: blackColor,
            //                               fontWeight: FontWeight.bold)),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(height: 10,),
            //               Card(
            //                 elevation: 5,
            //                 child: order.paymentFreind.length==0?Container():  Container(
            //                   child: ListView.builder(
            //                     itemCount: order.paymentFreind.length,
            //                     physics: NeverScrollableScrollPhysics(),
            //                     shrinkWrap: true,
            //                     itemBuilder: (context, index) {
            //                       return Column(
            //                         children: [
            //                           Padding(
            //                             padding: const EdgeInsets.all(10.0),
            //                             child: Row(
            //                               mainAxisAlignment:
            //                               MainAxisAlignment.spaceBetween,
            //                               children: [
            //                                 Column(
            //                                   children: [
            //                                     Row(
            //                                       children: [
            //                                         CircleAvatar(
            //                                           radius: 25,
            //                                           backgroundImage: NetworkImage(order.paymentFreind[index].image),
            //                                         ),
            //                                         // SizedBox(width: 5,),
            //                                         Column(
            //                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                                           crossAxisAlignment: CrossAxisAlignment.start,
            //                                           children: [
            //                                             Text(
            //                                               "${order.paymentFreind[index].name}",
            //                                               style: TextStyle(
            //                                                   color: blackColor,
            //                                                   fontWeight: FontWeight.bold),
            //
            //                                             ),
            //                                             Text(
            //                                               "${order.paymentFreind[index].email}",
            //                                               style: TextStyle(
            //                                                   color: blackColor,
            //                                                   fontWeight: FontWeight.bold),
            //
            //                                             ),
            //                                           ],
            //                                         ),
            //                                       ],
            //                                     ),
            //                                   ],
            //                                 ),
            //                                 // SizedBox(
            //                                 //   height: MediaQuery.of(context)
            //                                 //       .size
            //                                 //       .height *
            //                                 //       0.03,
            //                                 // ),
            //                                 Text(
            //                                   "SAR ${order.paymentFreind[index].amount}",
            //                                   style: TextStyle(
            //                                       color: blackColor,
            //                                       fontWeight: FontWeight.bold),
            //                                 ),
            //                               ],
            //                             ),
            //                           )
            //                         ],
            //                       );
            //                     },
            //
            //                   ),
            //                 ),
            //               ),
            //            donate ?
            //               Padding(
            //                padding: const EdgeInsets.all(8.0),
            //                child: Text("Your food is donated",style: Theme.of(context).textTheme.headline1.copyWith(color: colorCustom),),
            //              )
            //
            // : Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Column(
            //                   children: [
            //                     Text("Do you want to donate your food?",style: Theme.of(context).textTheme.headline1.copyWith(color: colorCustom),),
            //
            //                order.buttonDonate ? Center(child: CircularProgressIndicator(),)
            //                   :  ElevatedButton(onPressed: ()async{
            //                     order.buttonDonate=true;
            //                    setState(() {
            //                    });
            //                   donate=await order.donate(widget.id);
            //                      order.buttonDonate=false;
            //                     setState(() {
            //                     });
            //                     }, child: Text("Donate",style: Theme.of(context).textTheme.headline1,)),
            //                   ],
            //                 ),
            //               ),
            //             ]
            //         ),
            //       ),
            //     ),
            ),
      ),
    );
  }
}
