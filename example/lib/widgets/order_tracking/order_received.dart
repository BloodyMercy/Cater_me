import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
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
            Container(

              padding: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Row(
                children: [
                  Icon(Icons.circle,color:  Color.fromRGBO(253, 202, 29, 1),),
                  SizedBox(
                    width: mediaquerywidth * 0.03,
                  ),
                  Text('Received',style: TextStyle(fontSize: 20,color: Color.fromRGBO(253, 202, 29, 1),),) ,

                ],
              ),


                Row(
                children: [
                  Icon(Icons.circle,color: Color(0xFF3F5521),),
                  SizedBox(
                    width: mediaquerywidth * 0.03,
                  ),
                  Text('Prepering Order',style: TextStyle(fontSize: 20,color: Color(0xFF3F5521)),),
                ],
              ),
                Container(
                  alignment: Alignment.center,

                  child: Row(
                    children: [
                      VerticalDivider(
                        color: Colors.black,
                        thickness: 3,
                      )
                    ],
                  ),
                ),
                 Row(
                children: [
                  Icon(Icons.circle,color: Color(0xFF3F5521),),
                  SizedBox(
                    width: mediaquerywidth * 0.03,
                  ),
                  Text('Order Is On The Way',style: TextStyle(fontSize: 20,color: Color(0xFF3F5521)),),
                ],
              ), Row(
                children: [
                  Icon(Icons.circle,color: Color(0xFF3F5521),),
                  SizedBox(
                    width: mediaquerywidth * 0.03,
                  ),
                  Text('Order Delivered',style: TextStyle(fontSize: 20,color: Color(0xFF3F5521)),),
                ],
              ),


              ],),
            ),
            // SizedBox(height: mediaqueryheight * 0.015,),


            SizedBox(height: mediaqueryheight * 0.015,),
          ],
        ),
      ),
    );
  }
}
