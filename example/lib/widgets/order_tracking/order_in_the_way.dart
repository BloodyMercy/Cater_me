import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';

class OrderOnTheWay extends StatelessWidget {
  const OrderOnTheWay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final mediaquerywidth = MediaQuery.of(context).size.width;
    // final mediaqueryheight = MediaQuery.of(context).size.height;
    return Image.asset('images/orderintheway.png',height: MediaQuery.of(context).size.height*0.8,);
    // Expanded(
    //   child: Container(
    //     color: LightColors.kLightYellow,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Image.asset("images/order_on_the_way.png"),
    //         Container(
    //           width: double.infinity,
    //           padding: EdgeInsets.symmetric(horizontal: 10),
    //           child: FittedBox(
    //             fit: BoxFit.contain,
    //             child: Text(
    //               "Order Is On The Way",
    //               style: TextStyle(
    //                   color: Color(0xFF3F5521), fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //         ),
    //
    //         SizedBox(height: mediaqueryheight * 0.03,),
    //
    //         Padding(
    //           padding: const EdgeInsets.only(left: 20.0),
    //           child: Row(
    //             children: [
    //               Icon(Icons.circle,color: colorCustom),
    //               SizedBox(
    //                 width: mediaquerywidth * 0.03,
    //               ),
    //               Text('Received',style: TextStyle(fontSize: 20,color:colorCustom),),
    //             ],
    //           ),
    //
    //
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 20.0),
    //           child: Row(
    //             children: [
    //               Icon(Icons.circle,color: colorCustom,),
    //               SizedBox(
    //                 width: mediaquerywidth * 0.03,
    //               ),
    //               Text('Prepering Order',style: TextStyle(fontSize: 20,color: colorCustom),),
    //             ],
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 20.0),
    //           child: Row(
    //             children: [
    //               Icon(Icons.circle,color:  yellowColor,),
    //               SizedBox(
    //                 width: mediaquerywidth * 0.03,
    //               ),
    //               Text('Order Is On The Way',style: TextStyle(fontSize: 20,color: yellowColor,),),
    //             ],
    //           ),
    //         ),
    //         Padding(
    //           padding:const EdgeInsets.only(left: 20.0),
    //           child: Row(
    //             children: [
    //               Icon(Icons.circle,color: colorCustom,),
    //               SizedBox(
    //                 width: mediaquerywidth * 0.03,
    //               ),
    //               Text('Order Delivered',style: TextStyle(fontSize: 20,color: colorCustom),),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
