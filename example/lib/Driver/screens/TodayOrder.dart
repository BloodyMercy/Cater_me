
import 'package:CaterMe/Driver/provider/driverOrder_provider.dart';
import 'package:CaterMe/Driver/screens/orderDriverDetails.dart';
import 'package:CaterMe/Providers/orderById_provider.dart';
import 'package:CaterMe/Providers/orderStatus_provider.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  getData()async{
    final orderDriver=Provider.of<DriverOrderProvider>(context,listen: false);
    await orderDriver.getOrder();
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
    final orderDriver=Provider.of<DriverOrderProvider>(context,listen: true);
    return Stack(
      children: <Widget>[
        AnimatedOpacity(
          opacity: (orderDriver.loading )? 0 : 1.0,
          duration: Duration(milliseconds: 500),
          child: buildbody(context),
        ),
        AnimatedOpacity(
          opacity: (orderDriver.loading ) ? 1.0 : 0,
          duration: Duration(milliseconds: 500),
          child: buildLoading(context),
        ),
      ],
    );
  }
  Widget buildLoading(BuildContext context){
    return Align(
      child: Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
      alignment: Alignment.center,
    );
  }

  Widget buildbody(BuildContext context){
    // final order = Provider.of<OrderByIdProvider>(context, listen: true);
    final _width=MediaQuery.of(context).size.width;
    final orderDriver=Provider.of<DriverOrderProvider>(context,listen: true);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
            onRefresh:refreshOrderDdriverData,
            child: CustomScrollView(
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
                                    Text("Country: ${orderDriver.todayOrder[index].country}",
                                        // orders.listOrder[index].eventName,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Street: ${orderDriver.todayOrder[index].street}",
                                        // orders.listOrder[index].eventName,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(

                                      "Date: ${DateFormat("dd-MM-yyyy").format(DateTime.parse(orderDriver.todayOrder[index].eventDate))}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              )),
                        );
                    }
                    ,childCount: orderDriver.todayOrder.length)
                  ,),
              ],
            )),
      ),
    );
  }
}
