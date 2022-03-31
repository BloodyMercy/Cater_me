import 'package:CaterMe/Providers/orderStatus_provider.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/widgets/order_tracking/order_cancel.dart';
import 'package:CaterMe/widgets/order_tracking/order_delivered.dart';
import 'package:CaterMe/widgets/order_tracking/order_in_the_way.dart';
import 'package:CaterMe/widgets/order_tracking/order_preparing.dart';
import 'package:CaterMe/widgets/order_tracking/order_received.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/user.dart';
import '../../widgets/order_tracking/OTP_Pending.dart';

class TrackingOrder extends StatefulWidget {
  int id;

  TrackingOrder(
    this.id,
  );

  @override
  _TrackingOrderState createState() => _TrackingOrderState();
}

class _TrackingOrderState extends State<TrackingOrder> {
  bool loading = true;

  getData() async {
   // print(w)
    final orderStatus =
        Provider.of<OrderStatusProvider>(context, listen: false);
    await orderStatus.getOrderStatus(widget.id);
    setState(() {
      loading = false;
    });
  }


  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderStatus = Provider.of<OrderStatusProvider>(context, listen: true);

    final authProvider = Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${authProvider.lg[authProvider.language][ "Tracking"]}'),
        leading:  IconButton(
          icon: Icon(Icons.arrow_back_rounded,
            color:Colors.white,size: 30,

          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
              child:  loading
                  ?Center(
                child: Container(
                    color: LightColors.kLightYellow,
                    child: CircularProgressIndicator(
                      color: Color(0xFF3F5521),
                    ),
                  ),
              )

            : Column(
              children: [
                orderStatus.orderStatus.statusId == 3
                    ?  OrderPreparing()
                    : Container(),
                orderStatus.orderStatus.statusId == 4
                    ?  OrderOnTheWay()
                    : Container(),
                orderStatus.orderStatus.statusId == 2
                    ? OrderReceived()
                    : Container(),
                orderStatus.orderStatus.statusId == 1
                    ? OTPPending()
                    : Container(),
                orderStatus.orderStatus.statusId == 5
                    ? OrderDelivered()
                    : Container(),
                orderStatus.orderStatus.statusId == 6?

                OrderCancel():Container(),




                // CustomStepperOrder(text: ["text","text"],selected: 1,),
              ],
            )),
      ),
    );
  }
}
