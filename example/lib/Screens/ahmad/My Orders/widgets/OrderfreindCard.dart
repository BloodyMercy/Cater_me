import 'package:CaterMe/model/package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Providers/user.dart';
import '../../../../colors/colors.dart';
import '../../../../model/orderById.dart';
import '../../../../model/packages.dart';
import 'UserOrders.dart';

class OrderfreindCard extends StatefulWidget {
  PaymentFriend a;

  OrderfreindCard({Key key, this.a}) : super(key: key);

  @override
  State<OrderfreindCard> createState() => _OrderfreindCardState();
}

class _OrderfreindCardState extends State<OrderfreindCard> {
  String lang = "en";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlang();
  }

  getlang() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    lang = _pref.getString("locale") ?? "en";
  }

  @override
  Color _getColorByEvent(int orderStatus) {
    if (orderStatus == 1) return Color(0xFFEA4D47);
    else  return Color(0xFFEA4D47);

    return Colors.blue;
  }

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
            // Positioned(
            //     bottom: 0,
            //     child: Container(
            //       padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
            //       decoration: BoxDecoration(
            //         color: Colors.white.withOpacity(0.8),
            //         borderRadius: BorderRadius.only(
            //           bottomRight: Radius.circular(4),
            //           topRight: Radius.circular(4),
            //         ),
            //       ),
            //       child: Text("${widget.a.}",
            //           style: TextStyle(
            //             //  color: Colors.black,
            //              // fontFamily: 'Valencia',
            //               fontSize: 15)),
            //     )),
          ],
        ),
        SizedBox(
          width: 15,
        ),
        Flexible(
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.a.name}",
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
                        text: widget.a.phoneNumber,
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
                      text:
                          "${authProvider.lg[authProvider.language]["SAR"]} ${widget.a.amount}",
                      style: TextStyle(
                        //  color: Color.fromRGBO(180, 187, 197, 1),
                        fontSize: 13,
                        //  fontFamily: 'Geomanist',
                      ),
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: '${widget.a.paymentStatus}',
                      // text: "${authProvider.lg[authProvider.language]["Bill"]} ${widget.a.amount}",
                      style: TextStyle(
                        color: _getColorByEvent(
                          widget.a.paymentStatusId
                        ),

                        //  color: Color.fromRGBO(180, 187, 197, 1),
                        fontSize: 13,
                        //  fontFamily: 'Geomanist',
                      ),
                    ),
                  ),

                ],
              ),
              widget.a.paymentStatusId==1?Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(

                    color: colorCustom,
                    child:
                    TextButton(

                        child: Center(child: Text("${authProvider.lg[authProvider.language]["Share Bill"]}",style: TextStyle(color: Colors.white),)),onPressed: (){
                    share(widget.a.sharelink);
                  },)),
                ),
              ):Container()
            ],
          ),
        ),
      ],
    );
  }
  Future<void> share(String link) async {
    await FlutterShare.share(
        title: 'cater me',
        text: 'Share bill',
        linkUrl: link,
        chooserTitle: 'Share bill');
  }
}
