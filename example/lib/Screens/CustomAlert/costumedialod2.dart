import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/orderById_provider.dart';
import 'const.dart';

class CustomDialog2 extends StatelessWidget {
  final String title, description;
  final Widget button2;
  final bool oneOrtwo;

  CustomDialog2({
    @required this.title,
    @required this.description,

    @required this.oneOrtwo,
    this.button2,
  });

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final order = Provider.of<OrderByIdProvider>(context, listen: true);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.only(
          top: Consts.avatarRadius + Consts.padding,
          bottom: Consts.padding,
          left: Consts.padding,
          right: Consts.padding,
        ),
        margin: EdgeInsets.only(top: Consts.avatarRadius),
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(Consts.padding),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 10.0,
              offset: const Offset(0.0, 0.0),
            ),
          ],
        ),
        child: Column(
          // To make the card compact
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),textAlign: TextAlign.center,
            ),
            SizedBox(height: 40,),
            GestureDetector(
                onTap: (){
                  order.check1=!order.check1;
                },
                child:  Row(
                  children: [
                    Icon(
                      Icons.check_circle_outlined,
                      color: !order.check1? Color.fromRGBO(
                          149, 147, 147, 0.4): Color.fromRGBO(63, 85, 33, 1),
                      size: 20,
                    ),
                    Container(width: width/50,),
                    Expanded(
                      child: Text(
                        "Without equipment",
                        style: TextStyle(
                          color: !order.check1?Color.fromRGBO(
                              149, 147, 147, 0.4): Color.fromRGBO(63, 85, 33, 1),
                          fontSize: 20,
                        ),),
                    ),
                  ],
                )),
            Container(height: height/100),
            GestureDetector(
                onTap: (){
                  order.check2=!order.check2;
                },
                child:Row(
                  children: [
                    Icon(
                      Icons.check_circle_outlined,
                      color: !order.check2?Color.fromRGBO(
                          149, 147, 147, 0.4): Color.fromRGBO(63, 85, 33, 1),
                      size: 20,
                    ),
                    Container(width: width/50,),
                    Expanded(
                        child:  Text(
                          "Without service team",
                          style: TextStyle(
                            color: !order.check2?Color.fromRGBO(
                                149, 147, 147, 0.4): Color.fromRGBO(63, 85, 33, 1),
                            fontSize: 20,
                          ),)),
                  ],
                )),

            Container(height: height/100),
            GestureDetector(
              onTap: (){
                order.check4=!order.check4;
              },
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outlined,
                    color: !order.check4?Color.fromRGBO(
                        149, 147, 147, 0.4): Color.fromRGBO(63, 85, 33, 1),
                    size: 20,
                  ),
                  Container(width: width/50,),
                  Expanded(
                      child:  Text(
                        "Don't donate the rest of food",
                        style: TextStyle(
                          color: !order.check4? Color.fromRGBO(
                              149, 147, 147, 0.4): Color.fromRGBO(63, 85, 33, 1),
                          fontSize: 20,
                        ),)),
                ],
              ),
            ),

            SizedBox(height: 16.0),


            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Align(
                  alignment: Alignment.bottomRight,
                  child: button2,
                ),
              ],
            )

          ],
        ),
      ),
    );
  }


}
