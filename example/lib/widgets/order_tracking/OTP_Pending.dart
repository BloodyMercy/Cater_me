import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPPending extends StatefulWidget {
  const OTPPending({Key key}) : super(key: key);

  @override
  State<OTPPending> createState() => _OTPPending();
}

class _OTPPending extends State<OTPPending> {
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
    return Center(child: language=="en"?Image.asset("images/new order tracking english/OTPPending.png",fit:BoxFit.contain,height: MediaQuery.of(context).size.height*0.75):Image.asset("images/order trackingArabic/1.png",height: MediaQuery.of(context).size.height*0.75,fit:BoxFit.contain));
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
