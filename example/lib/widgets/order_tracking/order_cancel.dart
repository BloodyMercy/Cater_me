import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';

class OrderCancel extends StatelessWidget {
  const OrderCancel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final mediaquerywidth = MediaQuery.of(context).size.width;
    // final mediaqueryheight = MediaQuery.of(context).size.height;
    return Image.asset('images/ordercancled.png',height: MediaQuery.of(context).size.height*0.8,);

  }
}
