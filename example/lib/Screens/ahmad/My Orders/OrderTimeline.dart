// import 'package:flutter/material.dart';
//
// import 'TimeLineWidget.dart';
//
// class OrderTimeLine extends StatefulWidget {
//   const OrderTimeLine({Key key}) : super(key: key);
//
//   @override
//   _OrderTimeLineState createState() => _OrderTimeLineState();
// }
//
// class _OrderTimeLineState extends State<OrderTimeLine> {
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Color(0xffF5F6F7),
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(62.0),
//         child: AppBar(
//           centerTitle: true,
//           elevation: 0,
//           backgroundColor: Colors.white,
//           title: Text(
//             "Order Details",
//             style: TextStyle(
//                 color: Colors.black, fontFamily: 'Valencia', fontSize: 25),
//           ),
//           leading: IconButton(
//             icon: Image.asset(
//               'assets/icons/icon_back.png',
//               color: Color.fromRGBO(86, 115, 116, 1),
//               height: 25,
//               width: 25,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Text(
//                 "Order Status: In Transit",
//                 style: TextStyle(
//                     fontFamily: 'Geomanist', color: Colors.black, fontSize: 16),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               color: Colors.white,
//               width: width,
//               height: height * 1,
//               child: Padding(
//                   padding: const EdgeInsets.only(top: 20.0, right: 95),
//                   child: DeliveryTimeLine()),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             Center(
//               child: Container(
//                 width: width * 0.8,
//                 height: height < 750 ? height * 0.06 : height * 0.07,
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   child: Text(
//                     "CONFIRM DELIVERY",
//                     style: TextStyle(
//                       fontFamily: 'Geomanist',
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     primary: Color(0xff557374),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
