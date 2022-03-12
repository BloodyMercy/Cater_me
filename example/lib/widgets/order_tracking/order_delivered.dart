import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDelivered extends StatefulWidget {
  const OrderDelivered({Key key}) : super(key: key);

  @override
  State<OrderDelivered> createState() => _OrderDeliveredState();
}

class _OrderDeliveredState extends State<OrderDelivered> {
  String language;

  getdata()async{
    SharedPreferences sh=await SharedPreferences.getInstance();
    (sh.getString("locale"));
    setState(() {
      language = sh.getString("locale");
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaquerywidth = MediaQuery.of(context).size.width;
    final mediaqueryheight = MediaQuery.of(context).size.height;
    return language=="en"?Image.asset('images/orderdlv.png',height: MediaQuery.of(context).size.height*0.8,):Image.asset('images/order tracking/1.png',height: MediaQuery.of(context).size.height*0.8,);
    //   Expanded(
    //   child: Container(
    //     color: LightColors.kLightYellow,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Image.asset("images/CaterDelivery.png"),
    //         Container(
    //           width: double.infinity,
    //           padding: EdgeInsets.symmetric(horizontal: 10),
    //           child: FittedBox(
    //             fit: BoxFit.contain,
    //             child: Text(
    //               "Order Delivered",
    //               style: TextStyle(
    //                   color: Color(0xFF3F5521), fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //         ),
    //         SizedBox(
    //           height: mediaqueryheight * 0.03,
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 20.0),
    //           child: Row(
    //             children: [
    //               Icon(Icons.circle, color: Color(0xFF3F5521)),
    //               SizedBox(
    //                 width: mediaquerywidth * 0.03,
    //               ),
    //               Text(
    //                 'Received',
    //                 style: TextStyle(fontSize: 20, color: Color(0xFF3F5521)),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 20.0),
    //           child: Row(
    //             children: [
    //               Icon(
    //                 Icons.circle,
    //                 color: Color(0xFF3F5521),
    //               ),
    //               SizedBox(
    //                 width: mediaquerywidth * 0.03,
    //               ),
    //               Text(
    //                 'Prepering Order',
    //                 style: TextStyle(fontSize: 20, color: Color(0xFF3F5521)),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 20.0),
    //           child: Row(
    //             children: [
    //               Icon(
    //                 Icons.circle,
    //                 color: colorCustom,
    //               ),
    //               SizedBox(
    //                 width: mediaquerywidth * 0.03,
    //               ),
    //               Text(
    //                 'Order Is On The Way',
    //                 style: TextStyle(fontSize: 20, color: colorCustom),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 20.0),
    //           child: Row(
    //             children: [
    //               Icon(
    //                 Icons.circle,
    //                 color: Color.fromRGBO(253, 202, 29, 1),
    //               ),
    //               SizedBox(
    //                 width: mediaquerywidth * 0.03,
    //               ),
    //               Text(
    //                 'Order Delivered',
    //                 style: TextStyle(
    //                   fontSize: 20,
    //                   color: Color.fromRGBO(253, 202, 29, 1),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
