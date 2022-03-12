import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderCancel extends StatefulWidget {
  const OrderCancel({Key key}) : super(key: key);

  @override
  State<OrderCancel> createState() => _OrderCancelState();
}

class _OrderCancelState extends State<OrderCancel> {
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
    return language=="en"?Image.asset('images/ordercancled.png',height: MediaQuery.of(context).size.height*0.8,):Image.asset('images/order tracking/5.png',height: MediaQuery.of(context).size.height*0.8,);

  }
}
