import 'package:CaterMe/model/package.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Providers/user.dart';
import '../../../../model/orderById.dart';
import '../../../../model/packages.dart';
import 'UserOrders.dart';

class OrderCard extends StatefulWidget {
  OrderItems a;
   OrderCard({Key key, this.a}) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  String lang="en";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlang();
  }
  getlang() async {
    SharedPreferences _pref= await SharedPreferences.getInstance();
    lang=_pref.getString("locale")??"en";

  }
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: 100.0,
              color: Colors.white,
              child: Image.network(
             widget.a.image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                  ),
                  child: Text("x${widget.a.quantity}",
                      style: TextStyle(
                        //  color: Colors.black,
                         // fontFamily: 'Valencia',
                          fontSize: 15)),
                )),
          ],
        ),
        SizedBox(
          width: 15,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text.rich(
                  TextSpan(
                    text:widget.a.item,
                    style: TextStyle(
                      // color: Colors.black,
                      fontSize: 17,
                      //  fontFamily: 'Geomanist',
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 6,
              ),

              SizedBox(
                height: 2,
              ),

              SizedBox(
                height: 2,
              ),


              Text.rich(
                TextSpan(
                  text: "${authProvider.lg[authProvider.language]["QTY:"]} ${widget.a.quantity}",
                  style: TextStyle(
                  //  color: Color.fromRGBO(180, 187, 197, 1),
                    fontSize: 13,
                  //  fontFamily: 'Geomanist',
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text("${authProvider.lg[authProvider.language]["PRICE"]} : ${widget.a.price*widget.a.quantity} ${authProvider.lg[authProvider.language]["SAR"]}",
                  style: TextStyle(
                    // fontFamily: 'Geomanist',
                    fontSize: 13,
                    //  color: Color.fromRGBO(180, 187, 197, 1),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
