import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderReceived extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    final mediaquerywidth = MediaQuery.of(context).size.width;
    final mediaqueryheight = MediaQuery.of(context).size.height;
    return Expanded(
      child: Container(
        color:  LightColors.kLightYellow,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("images/order_received.png"),
            Container(

              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  "Order Received",
                  style: TextStyle(color:Color(0xFF3F5521), fontWeight: FontWeight.bold),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
