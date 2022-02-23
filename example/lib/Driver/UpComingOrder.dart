import 'package:CaterMe/Providers/orderStatus_provider.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/widgets/order_tracking/order_cancel.dart';
import 'package:CaterMe/widgets/order_tracking/order_delivered.dart';
import 'package:CaterMe/widgets/order_tracking/order_in_the_way.dart';
import 'package:CaterMe/widgets/order_tracking/order_preparing.dart';
import 'package:CaterMe/widgets/order_tracking/order_received.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpComingOrder extends StatefulWidget {
  // int id;
  //
  // TrackingOrder(
  //   this.id,
  // );

  @override
  _UpComingOrder createState() => _UpComingOrder();
}

class _UpComingOrder extends State<UpComingOrder> {
  bool loading = true;

  // getData() async {
  //  // print(w)
  //   final orderStatus =
  //       Provider.of<OrderStatusProvider>(context, listen: false);
  //   await orderStatus.getOrderStatus(widget.id);
  //   setState(() {
  //     loading = false;
  //   });
  // }


  // @override
  // void initState() {
  //   getData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final orderStatus = Provider.of<OrderStatusProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: loading
            ? SingleChildScrollView(
              child: Container(
                  color: LightColors.kLightYellow,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF3F5521),
                    ),
                  ),
                ),
            )
            : Column(
              children: [
                orderStatus.orderStatus.statusId == 2
                    ?  OrderPreparing()
                    : Container(),
                orderStatus.orderStatus.statusId == 3
                    ?  OrderOnTheWay()
                    : Container(),
                orderStatus.orderStatus.statusId == 1
                    ? OrderReceived()
                    : Container(),
                orderStatus.orderStatus.statusId == 4
                    ? OrderDelivered()
                    : Container(),
                orderStatus.orderStatus.statusId == 5?
                OrderCancel():Container(),



                // CustomStepperOrder(text: ["text","text"],selected: 1,),
              ],
            ),
      ),
    );
  }
}
