
import 'package:CaterMe/Providers/orderById_provider.dart';
import 'package:CaterMe/Screens/ahmad/My%20Orders/widgets/FreindList.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Providers/orderStatus_provider.dart';
import '../../../Providers/user.dart';
import '../../../colors/colors.dart';
import '../../orders/order_tracking.dart';
import 'OrderTimeline.dart';
import 'widgets/OrderList.dart';

class OrderDetailsView extends StatefulWidget {
  int id;
 OrderDetailsView(this.id);

  @override
  _OrderDetailsViewState createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
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
    await orders.getOrderPaymentFreind();
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final _width=MediaQuery.of(context).size.width;
    final _order= Provider.of<OrderByIdProvider>(context,listen:true);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF5F6F7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(62.0),
        child: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Order Details",
            style: TextStyle(
                fontWeight: FontWeight.w600,
               fontSize: 25),
          ),
          leading: IconButton(
            icon: Image.asset(
              'images/icon_back.png',
              color: Color.fromRGBO(86, 115, 116, 1),
              height: 25,
              width: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: _order.loading?SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${_order.orderbyId["event"]["eventName"]}",
                        style: TextStyle(

                            fontWeight: FontWeight.w600,

                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text.rich(
                        TextSpan(
                          text: "Order Date: ${
                              DateFormat("dd-MM-yyyy").format(DateTime.parse(_order.orderbyId["event"]["eventDate"]))
                              } ",
                          style: TextStyle(

                              fontWeight: FontWeight.w400,

                              fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),

                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 220,
              width: width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Delivery Address :",
                      style: TextStyle(


                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${_order.orderbyId["address"]["title"]}",
                              style: TextStyle(

                                  fontWeight: FontWeight.w400,

                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text.rich(
                              TextSpan(
                                text: "Street :${_order.orderbyId["address"]["street"]},Building ${_order.orderbyId["address"]["buildingName"]}",
                                style: TextStyle(

                                    fontWeight: FontWeight.w400,

                                    fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text.rich(
                              TextSpan(
                                text: "City ${_order.orderbyId["address"]["city"]}, Country ${_order.orderbyId["address"]["country"]}",
                                style: TextStyle(

                                    fontWeight: FontWeight.w400,

                                    fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            // Text.rich(
                            //   TextSpan(
                            //     text: "0000",
                            //     style: TextStyle(
                            //
                            //         fontWeight: FontWeight.w400,
                            //
                            //         fontSize: 14),
                            //   ),
                            // ),

                            SizedBox(
                              height: 5,
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              width: width,
              height: height * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    child: Text(
                      'Items Ordered',
                      style: TextStyle(
                        //color: Color.fromRGBO(146, 156, 170, 1),
                       // fontFamily: 'Geomanist',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Divider(
                    color: Color.fromRGBO(112, 112, 112, 1),
                    indent: 20,
                    endIndent: 20,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  OrderList(a:_order.items),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),


            _order.paymentFreind.length == 0?  Container() :   Container(
              color: Colors.white,
              width: width,
              height: height * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    child: Text(
                      '${authProvider.lg[authProvider.language]["Bill sharing"]}',
                      style: TextStyle(
                        //color: Color.fromRGBO(146, 156, 170, 1),
                        // fontFamily: 'Geomanist',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Divider(
                    color: Color.fromRGBO(112, 112, 112, 1),
                    indent: 20,
                    endIndent: 20,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  OrderfreindList(a:_order.paymentFreind),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: ElevatedButton(

                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          TrackingOrder(widget.id),
                    ),
                  );
                //  TrackingOrder(widget.id)
               //   changeScreen(context, OrderTimeLine());
                },
                child: Container(
                  width: width/3.75,
                  child: Row(
                    children: [
                      Text(
                        '${authProvider.lg[authProvider.language]["Tracking"]}',
                        style: TextStyle(
                            color: Color.fromRGBO(85, 115, 116, 1),
                            fontSize: 13,
                            fontFamily: 'Geomanist',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5,),
                      FaIcon(FontAwesomeIcons.truck,color:Color(0xFF3F5521)
                    ,)

                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(

                  primary: Color(0xffF5F6F7),
                  side: BorderSide(
                    color: Color.fromRGBO(85, 115, 116, 1),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),




            SizedBox(
              height: 30,
            ),

            Container(
              color: Colors.white,
              height: height * 0.12,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    child: Text(
                      'Payment Details : ',
                      style: TextStyle(


                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "${_order.orderbyId["creditCard"]["type"]} **** **** **${_order.orderbyId["creditCard"]["cardNumber"]}",
                      style: TextStyle(fontFamily: 'Geomanist', fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.white,
              height: height * 0.25,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Total : ",
                              style: TextStyle(
                                  color: Color.fromRGBO(146, 156, 170, 1),
                                  fontFamily: 'Geomanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: "${authProvider.lg[authProvider.language]["Tax"]}",
                                    style: TextStyle(

                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 25.0),
                                  child: Text(
                                    "${authProvider.lg[authProvider.language]["SAR"]} ${double.parse((_order.orderbyId["tax"] ?? 0.0).toStringAsFixed(2))}",
                                    style: TextStyle(

                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),


                            Row(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: "${authProvider.lg[authProvider.language]["Total"]} ",
                                    style: TextStyle(

                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 25.0),
                                  child: Text(
                                    "${authProvider.lg[authProvider.language]["SAR"]} ${double.parse((_order.orderbyId["total"] ?? 0.0).toStringAsFixed(2))}",
                                    style: TextStyle(

                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ):Center(child: CircularProgressIndicator(color:Color(0xFF3F5521)),),
    );
  }
}
