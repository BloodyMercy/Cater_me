import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderOnTheWay extends StatefulWidget {
  const OrderOnTheWay({Key key}) : super(key: key);

  @override
  State<OrderOnTheWay> createState() => _OrderOnTheWayState();
}

class _OrderOnTheWayState extends State<OrderOnTheWay> {
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
    // final mediaquerywidth = MediaQuery.of(context).size.width;
    // final mediaqueryheight = MediaQuery.of(context).size.height;
    return language=="en"?Image.asset("images/new order tracking english/OrderIsOnTheWay.jpg",height: MediaQuery.of(context).size.height*0.75,fit:BoxFit.contain):
    Image.asset("images/new order tracking english/4.jpg",height: MediaQuery.of(context).size.height*0.75,fit:BoxFit.contain);
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
