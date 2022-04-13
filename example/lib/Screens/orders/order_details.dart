import 'package:CaterMe/Providers/orderById_provider.dart';
import 'package:CaterMe/Providers/orderStatus_provider.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Providers/user.dart';
import '../../language/language.dart';

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
  bool rejected = false;
String language="";
getData() async {
    final orders = Provider.of<OrderByIdProvider>(context, listen: false);
    await orders.getOrderById(widget.id);
    SharedPreferences sh =await SharedPreferences.getInstance(); 
    language=sh.getString("locale");
    await orders.getOrderItems(sh.getString("locale"));
    await orders.getOrderPaymentFreind(sh.getString("locale"));
    print(orders.items.length);
    final orderStatus =
        Provider.of<OrderStatusProvider>(context, listen: false);
    await orderStatus.getOrderStatus(widget.id);

    if (orderStatus.orderStatus.statusId != 5) {
      setState(() {
        rejected = true;
      });
    }
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
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final order = Provider.of<OrderByIdProvider>(context, listen: true);
    final _width=MediaQuery.of(context).size.width;

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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                          '${authProvider.lg[authProvider.language]["Invoice"]}',
                                style: TextStyle(color: Colors.black),
                              ),SizedBox(height: 10,),
                              Card(
                                elevation: 5,
                                child: Container(
                                  child: ListView.separated(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "${order.items[i].item}  ",
                                                    style: TextStyle(
                                                        color: blackColor,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ),
                                                Text(
                                                  " ${authProvider.lg[authProvider.language]["QTY"]} ${order.items[i].quantity} ${authProvider.lg[authProvider.language]["SAR"]} ",
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
                                                  "${authProvider.lg[authProvider.language]["Total"]}  ${order.items[i].price}",
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
                                            '${authProvider.lg[authProvider.language]["Tax"]}',
                                            style: TextStyle(
                                                color: blackColor,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Text(
                                              "${authProvider.lg[authProvider.language]["SAR"]} ${double.parse((order.orderbyId["tax"] ?? 0.0).toStringAsFixed(2))}",
                                              style: TextStyle(
                                                  color: blackColor,
                                                  fontWeight: FontWeight.normal)),
                                        ],
                                      ),
                                    ),
                                    // Divider(
                                    //   thickness: 2,
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(10.0),
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       Text('${authProvider.lg[authProvider.language]["SubTotal"]}',
                                    //           style: TextStyle(
                                    //               color: blackColor,
                                    //               fontWeight: FontWeight.normal)),
                                    //       Text(
                                    //           "${authProvider.lg[authProvider.language]["SAR"]} ${double.parse((order.orderbyId["SubTotal"] ?? 0.0).toStringAsFixed(2))}",
                                    //           style: TextStyle(
                                    //               color: blackColor,
                                    //               fontWeight: FontWeight.normal)),
                                    //     ],
                                    //   ),
                                    // ),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('${authProvider.lg[authProvider.language]["Total"]}',
                                              style: TextStyle(
                                                  color: blackColor,
                                                  fontWeight: FontWeight.normal)),
                                          Text(
                                              "${authProvider.lg[authProvider.language]["SAR"]} ${double.parse((order.orderbyId["total"] ?? 0.0).toStringAsFixed(2))}",
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
                      order.paymentFreind.length == 0? SliverToBoxAdapter(child: Container(),) :
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Text('${authProvider.lg[authProvider.language]["Bill sharing"]}',style:TextStyle(color:Colors.black)),
                              SizedBox(height: 10,),
                              Card(
                                elevation: 5,
                                child:

                                    Container(
                                        child: ListView.separated(
                                          itemCount: order.paymentFreind.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: _width*0.4,
                                                        child: Text(
                                                          "${order.paymentFreind[index].name}",
                                                          style: TextStyle(
                                                              color:
                                                                  blackColor,
                                                              fontWeight:
                                                                  FontWeight.normal),
                                                        ),
                                                      ),
                                                      Text(
                                                        "${authProvider.lg[authProvider.language]["SAR"]} ${order.paymentFreind[index].amount}",
                                                        style: TextStyle(
                                                            color: blackColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            );
                                          }, separatorBuilder: (BuildContext context, int index) { return Divider(thickness: 2,); },
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      false
                          ? SliverToBoxAdapter(
                              child: false
                                  ? Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${authProvider.lg[authProvider.language]["Your food is donated"]}",

                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1
                                              .copyWith(color: Colors.black),
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              '${authProvider.lg[authProvider.language]["Do you want to donate the rest of your food?"]}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1
                                                  .copyWith(color: Colors.black),
                                            ),
                                            order.buttonDonate
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : ElevatedButton(
                                                    onPressed: () async {
                                                      order.buttonDonate = true;
                                                      setState(() {});
                                                      donate = await order
                                                          .donate(widget.id);
                                                      order.buttonDonate =
                                                          false;
                                                      setState(() {});
                                                    },
                                                    child: Text(
                                                      '${authProvider.lg[authProvider.language]["Donate"]}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1,
                                                    )),
                                          ],
                                        ),
                                      ),
                                    ),
                            )
                          : SliverToBoxAdapter(
                              child: Center(),),

                    ],
                  )),
      ),
    );
  }
}
