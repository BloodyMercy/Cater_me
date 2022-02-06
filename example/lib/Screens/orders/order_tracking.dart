import 'package:CaterMe/Providers/orderStatus_provider.dart';
import 'package:CaterMe/Screens/orders/CustomStepperOrder.dart';
import 'package:CaterMe/widgets/order_tracking/order_delivered.dart';
import 'package:CaterMe/widgets/order_tracking/order_in_the_way.dart';
import 'package:CaterMe/widgets/order_tracking/order_preparing.dart';
import 'package:CaterMe/widgets/order_tracking/order_received.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class TrackingOrder extends StatefulWidget {
  int id;
  TrackingOrder(this.id);

  @override
  _TrackingOrderState createState() => _TrackingOrderState();
}

class _TrackingOrderState extends State<TrackingOrder> {
  getData() async{
    final orderStatus = Provider.of<OrderStatusProvider>(context, listen: false);
    await orderStatus.getOrderStatus(widget.id);
  }
  @override
  void initState() {
    getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final orderStatus=Provider.of<OrderStatusProvider>(context, listen: true);

    return Scaffold(
      body: SafeArea(child: Column(
        children: [

          orderStatus.orderStatus.statusId==1?OrderReceived():Container(),
         orderStatus.orderStatus.statusId==2?OrderPreparing():Container(),
         orderStatus.orderStatus.statusId==3?OrderOnTheWay():Container(),
         orderStatus.orderStatus.statusId==4?OrderDelivered():Container(),

          CustomStepperOrder(text: ["text","text"],selected: 1,),


        ],
      ) ,),
    );
  }
}
