import 'package:flutter/material.dart';

class OrderReceived extends StatelessWidget {
  const OrderReceived({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaquerywidth = MediaQuery.of(context).size.width;
    final mediaqueryheight = MediaQuery.of(context).size.height;
    return Center(child: Image.asset("images/orderrecieved.png"));
    // Expanded(
    //   child: Container(
    //     color: LightColors.kLightYellow,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //
    //         Container(
    //           width: double.infinity,
    //           padding: EdgeInsets.symmetric(horizontal: 10),
    //           child: FittedBox(
    //             fit: BoxFit.contain,
    //             child: Text(
    //               "Order Received! ",
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
    //               Icon(
    //                 Icons.circle,
    //                   color: Color.fromRGBO(253, 202, 29, 1),
    //               ),
    //               SizedBox(
    //                 width: mediaquerywidth * 0.03,
    //               ),
    //               Text(
    //                 'Order Received',
    //                 style: TextStyle( color: Color.fromRGBO(253, 202, 29, 1), fontSize: 20),
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
    //                 'Prepering Order',
    //                 style: TextStyle(
    //                   fontSize: 20,
    //                   color: colorCustom
    //                 ),
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
    //                 'Order Is On The Way',
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
    //                 'Order Delivered',
    //                 style: TextStyle(fontSize: 20, color: Color(0xFF3F5521)),
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
