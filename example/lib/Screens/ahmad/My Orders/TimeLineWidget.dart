// import 'package:flutter/material.dart';
//
//
// class DeliveryTimeLine extends StatefulWidget {
//   const DeliveryTimeLine({Key key}) : super(key: key);
//
//   @override
//   _DeliveryTimeLineState createState() => _DeliveryTimeLineState();
// }
//
// class _DeliveryTimeLineState extends State<DeliveryTimeLine> {
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Column(
//       children: [
//         TimelineTile(
//           contents: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Order Received\n9:00 AM, 12 November 2021',
//               style: TextStyle(
//                   color: Colors.black, fontFamily: 'Geomanist', fontSize: 13),
//             ),
//           ),
//           node: TimelineNode(
//             indicator: DotIndicator(
//               color: Color(0xff557374),
//               size: 20,
//             ),
//             endConnector: SizedBox(
//               height: 80.0,
//               child: DecoratedLineConnector(
//                 thickness: 3,
//                 decoration: BoxDecoration(
//                   color: Color(0xff557374),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         TimelineTile(
//           contents: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Order Dispatched\n9:00 AM, 12 November 2021',
//               style: TextStyle(
//                   color: Colors.black, fontFamily: 'Geomanist', fontSize: 13),
//             ),
//           ),
//           node: TimelineNode(
//             indicator: DotIndicator(
//               color: Color(0xff557374),
//               size: 20,
//             ),
//             startConnector: SizedBox(
//               height: 30.0,
//               child: DecoratedLineConnector(
//                 thickness: 3,
//                 decoration: BoxDecoration(
//                   color: Color(0xff557374),
//                 ),
//               ),
//             ),
//             endConnector: SizedBox(
//               height: 30.0,
//               child: DecoratedLineConnector(
//                 thickness: 3,
//                 decoration: BoxDecoration(
//                   color: Color(0xff557374),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         TimelineTile(
//           contents: Container(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 50,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'In Transit\n9:00 AM, 15 November 2021',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: 'Geomanist',
//                         fontSize: 13),
//                   ),
//                 ),
//                 Container(
//                   width: width * 0.2,
//                     height: height*0.04,
//                     decoration: BoxDecoration(
//                         color: Color.fromRGBO(239, 216, 203, 1),
//                         border: Border.all(
//                           color: Color.fromRGBO(239, 216, 203, 1),
//                         ),
//                         borderRadius: BorderRadius.all(
//                             Radius.circular(8))
//                     ),
//                     child: Center(
//                       child: Text('Tracking',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'Geomanist',
//                         fontSize: 13
//                       ),),
//                     )
//                 )
//               ],
//             ),
//           ),
//           node: TimelineNode(
//             indicator: DotIndicator(
//               color: Color(0xff557374),
//               size: 20,
//             ),
//             startConnector: SizedBox(
//               height: 70.0,
//               child: DecoratedLineConnector(
//                 thickness: 3,
//                 decoration: BoxDecoration(
//                   color: Color(0xff557374),
//                 ),
//               ),
//             ),
//             endConnector: SizedBox(
//               height: 70.0,
//               child: DecoratedLineConnector(
//                 thickness: 3,
//                 decoration: BoxDecoration(
//                   color: Color.fromRGBO(112, 112, 112, 1),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         TimelineTile(
//           contents: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Text(
//               'Delivered',
//               style: TextStyle(
//                   color: Colors.black, fontFamily: 'Geomanist', fontSize: 13),
//             ),
//           ),
//           node: TimelineNode(
//             indicator: DotIndicator(
//               color: Color.fromRGBO(112, 112, 112, 1),
//               size: 20,
//             ),
//             startConnector: SizedBox(
//               height: 30.0,
//               child: DecoratedLineConnector(
//                 thickness: 3,
//                 decoration: BoxDecoration(
//                   color: Color.fromRGBO(112, 112, 112, 1),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
