import 'package:CaterMe/Driver/orderDriverDetails.dart';
import 'package:CaterMe/Driver/provider/driverOrder_provider.dart';
import 'package:CaterMe/Providers/orderById_provider.dart';
import 'package:CaterMe/Providers/orderStatus_provider.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpComingOrder extends StatefulWidget {
  // int id;
  //
  // TodayOrder(this.id);

  @override
  _UpComingOrder createState() => _UpComingOrder();
}

class _UpComingOrder extends State<UpComingOrder> {
  double Price = 0.0;
  double finaltax = 0.0;
  double finalPrice = 0.0;

  bool loading = false;
  bool donate = false;
  bool rejected = false;

  getData()async{
    final orderDriver=Provider.of<DriverOrderProvider>(context,listen: false);
    await orderDriver.getOrder();
    // print(orderDriver.todayOrder[0].id);
  }
  @override
  void initState() {
    getData();
    super.initState();
  }


  Future refreshOrderDdriverData() async {

    final orderDriver=Provider.of<DriverOrderProvider>(context,listen: false);
    await orderDriver.clearData();
    await orderDriver.getOrder();



    return;
  }



  @override
  Widget build(BuildContext context) {
    // final order = Provider.of<OrderByIdProvider>(context, listen: true);
    final _width=MediaQuery.of(context).size.width;
    final orderDriver=Provider.of<DriverOrderProvider>(context,listen: true);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
            onRefresh: refreshOrderDdriverData,
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
                          "Upcoming Order",
                          style: TextStyle(color: Colors.black),
                        ),SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
                SliverList(delegate:
                SliverChildBuilderDelegate(
                        (BuildContext context,int index){
                      return
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>OrderDriverDetails(orderDriver.todayOrder[index].id)));
                          },
                          child: Card(
                              elevation: 5,
                              color: LightColors.kLightYellow2,
                              child: Padding(
                                padding:  EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${orderDriver.todayOrder[index].eventName}",
                                        // orders.listOrder[index].eventName,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Country: ${orderDriver.upcomingOrders[index].country}",
                                        // orders.listOrder[index].eventName,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Street: ${orderDriver.upcomingOrders[index].street}",
                                        // orders.listOrder[index].eventName,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(

                                      "Date: ${DateFormat("dd-MM-yyyy").format(DateTime.parse(orderDriver.upcomingOrders[index].eventDate))}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              )),
                        );
                    }
                    ,childCount: orderDriver.upcomingOrders.length)
                  ,),
              ],
            )),
      ),
    );
  }
}
