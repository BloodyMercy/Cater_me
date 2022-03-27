import 'package:CaterMe/model/package.dart';
import 'package:flutter/material.dart';

import '../../../../model/packages.dart';
import 'UserOrders.dart';

class OrderCard extends StatefulWidget {
  final Package userOrder;
  const OrderCard({Key key, this.userOrder}) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: 100.0,
              color: Colors.white,
              child: Image.network(
                widget.userOrder.image,
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
                  child: Text("x${widget.userOrder.min}",
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
              Text("${widget.userOrder.price}\$",
                  style: TextStyle(
                   // fontFamily: 'Geomanist',
                    fontSize: 16,
                  //  color: Color.fromRGBO(180, 187, 197, 1),
                  )),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Text.rich(
                  TextSpan(
                    text: widget.userOrder.title,
                    style: TextStyle(
                     // color: Colors.black,
                      fontSize: 13,
                    //  fontFamily: 'Geomanist',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),

              SizedBox(
                height: 2,
              ),

              SizedBox(
                height: 2,
              ),
              Text.rich(
                TextSpan(
                  text: "QTY: " + widget.userOrder.min.toString(),
                  style: TextStyle(
                  //  color: Color.fromRGBO(180, 187, 197, 1),
                    fontSize: 13,
                  //  fontFamily: 'Geomanist',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
