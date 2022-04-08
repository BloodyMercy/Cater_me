
import 'package:CaterMe/Providers/orderById_provider.dart';
import 'package:CaterMe/Screens/ahmad/My%20Orders/widgets/FreindList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Pdf/pdf.dart';


import '../../../Providers/address.dart';
import '../../../Providers/orderStatus_provider.dart';
import '../../../Providers/user.dart';
import '../../../colors/colors.dart';
import '../../orders/order_tracking.dart';

import 'widgets/OrderList.dart';

class OrderDetailsView extends StatefulWidget {
  int id;
 OrderDetailsView(this.id);

  @override
  _OrderDetailsViewState createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  bool loading = true;
  bool donate = false;
  bool rejected = false;
  String language="";


  getData() async {
    final orders = Provider.of<OrderByIdProvider>(context, listen: false);
    await orders.getOrderById(widget.id);
    SharedPreferences sh =await SharedPreferences.getInstance();
    language=sh.getString("locale");
    await orders.getOrderItems(sh.getString("locale"));
    await orders.getOrderPaymentFreind(sh.getString("locale"));
    print(orders.items.length);
    final orderStatus =
    Provider.of<OrderStatusProvider>(context, listen: false);
    await orderStatus.getOrderStatus(widget.id);

    if (orderStatus.orderStatus.statusId != 5) {
      setState(() {
        rejected = true;
      });
    }
    donate = orders.orderbyId['isDonated'] ?? false;
    setState(() {
      loading = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
bool butload =true ;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final _width=MediaQuery.of(context).size.width;
    final _order= Provider.of<OrderByIdProvider>(context,listen:true);
    final orderStatus = Provider.of<OrderStatusProvider>(context, listen: true);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    FocusNode focusNode =FocusNode();
    return Scaffold(
      backgroundColor: Color(0xffF5F6F7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(62.0),
        child: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            '${authProvider.lg[authProvider.language][ "Order Details"]}',
            style: TextStyle(
                fontWeight: FontWeight.w600,
               fontSize: 25),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded,
              color: Color.fromRGBO(86, 115, 116, 1),

            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

        ),
      ),
      body: _order.loading?_order.orderbyId["message"]==null?SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${_order.orderbyId["event"]["eventName"]}",
                        style: TextStyle(

                            fontWeight: FontWeight.w600,

                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text.rich(
                        TextSpan(
                          text: "'${authProvider.lg[authProvider.language][ "Order Date:"]}' ${
                              DateFormat("dd-MM-yyyy  hh:mm").format(DateTime.parse(_order.orderbyId["event"]["eventDate"]))
                              } ",
                          style: TextStyle(

                              fontWeight: FontWeight.w400,

                              fontSize: 14),

                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      butload? Card(
                        color: colorCustom,
                        child:
                        orderStatus.orderStatus.statusId == 2 ||  orderStatus.orderStatus.statusId == 3|| orderStatus.orderStatus.statusId == 4|| orderStatus.orderStatus.statusId == 5?
                        TextButton(
                          child: Text("Generate Invoice",style: TextStyle(color: Colors.white),),
                        onPressed:  () async{
    setState(() {
      butload=false;
    });
                           await _order.GeneratePDF(widget.id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyPdf()),

                          );
    setState(() {
      butload=true;
    });
                        }
                        ):Container()):Center(child: CircularProgressIndicator(color:Color(0xFF3F5521)),),
                      SizedBox(
                        height: 3,
                      ),

                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 220,
              width: width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      '${authProvider.lg[authProvider.language][ "Delivery Address :"]}',
                      style: TextStyle(


                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${_order.orderbyId["address"]["title"]}",
                              style: TextStyle(

                                  fontWeight: FontWeight.w400,

                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text.rich(
                              TextSpan(
                                text: "${authProvider.lg[authProvider.language][ "Street"]} :${_order.orderbyId["address"]["street"]},${authProvider.lg[authProvider.language][ "Building"]} ${_order.orderbyId["address"]["buildingName"]}",
                                style: TextStyle(

                                    fontWeight: FontWeight.w400,

                                    fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text.rich(
                              TextSpan(
                                text: "${_order.orderbyId["address"]["city"]}, ${_order.orderbyId["address"]["country"]}",
                                style: TextStyle(

                                    fontWeight: FontWeight.w400,

                                    fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                           Text(

                             '${authProvider.lg[authProvider.language]["Contact info"]}',
                             style: TextStyle(

                                 fontWeight: FontWeight.w400,

                                 fontSize: 14),
                           ),
                            Row(children: [
                              Text(

                                '${_order.orderbyId["event"]["contactName"]} , ${_order.orderbyId["event"]["contactPhoneNumber"]}',
                                style: TextStyle(

                                    fontWeight: FontWeight.w400,

                                    fontSize: 14),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 10.0 ,right: 10),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      final _address= Provider.of<AdressProvider>(context, listen: false );
                                      _address.name.text=_order.orderbyId["event"]["contactName"];
                                      _address.phone.text=_order.orderbyId["event"]["contactPhoneNumber"];
                                      showDialog(context: context, builder: (context){
                                        return Dialog(
                                          child: Container(
                                            height: height/3,
                                            child: Column(children: [
                                              Text(

                                                '${authProvider.lg[authProvider.language]["Contact info"]}',
                                                style: TextStyle(

                                                    fontWeight: FontWeight.w400,

                                                    fontSize: 24),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: TextFormField(
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.normal,
                                                        fontFamily: 'BerlinSansFB'),
                                                    decoration: InputDecoration(
                                                        contentPadding: EdgeInsets.only(
                                                            left:
                                                            MediaQuery.of(context).size.width *
                                                                0.04),
                                                        alignLabelWithHint: true,
                                                        labelStyle: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize:
                                                            focusNode.hasFocus ? 18 : 16.0,
                                                            //I believe the size difference here is 6.0 to account padding
                                                            color: focusNode.hasFocus
                                                                ? Color(0xFF3F5521)
                                                                : Colors.grey),
                                                        labelText: '${authProvider.lg[authProvider.language]["Name"]}',
                                                        hintStyle: TextStyle(
                                                            color: Colors.black87,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: 'BerlinSansFB'),
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(5.0),
                                                          borderSide: const BorderSide(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(5.0),
                                                            borderSide: const BorderSide(
                                                              color: Color(0xFF3F5521),
                                                            ))),
                                                     controller: _address.name,

                                                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                                                    keyboardType: TextInputType.text),
                                              ),

                                              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                              Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: TextFormField(
                                              style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'BerlinSansFB'),
                                              decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                              left:
                                              MediaQuery.of(context).size.width *
                                              0.04),
                                              alignLabelWithHint: true,
                                              labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                              16.0,
                                              //I believe the size difference here is 6.0 to account padding
                                              color: focusNode.hasFocus
                                              ? Color(0xFF3F5521)
                                                  : Colors.grey),
                                              labelText: '${authProvider.lg[authProvider.language][ "Phone number"]}',
                                              hintStyle: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'BerlinSansFB'),
                                              filled: true,
                                              fillColor: Colors.white,
                                              enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5.0),
                                              borderSide: const BorderSide(
                                              color: Colors.grey,
                                              ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(5.0),
                                              borderSide: const BorderSide(
                                              color: Color(0xFF3F5521),
                                              ))),
                                                controller: _address.phone,

                                              // autovalidateMode: AutovalidateMode.onUserInteraction,
                                              keyboardType: TextInputType.phone),
                                              ),
Center(child:  Padding(
  padding: const EdgeInsets.only(left: 10.0 ,right: 10),
  child: ElevatedButton(
    onPressed: () async {
     if(await _address.updatecontact(widget.id.toString())){
      _order.orderbyId["event"]["contactName"]= _address.name.text;
     _order.orderbyId["event"]["contactPhoneNumber"]= _address.phone.text;
     setState(() {

     });
     Navigator.pop(context);
      }else{
       MotionToast.error(
         title: "Cater me",
         titleStyle: TextStyle(
             fontWeight: FontWeight.bold),
         description:
         '${authProvider.lg[authProvider.language]["Update failed"]}',
         //  animationType: ANIMATION.FROM_LEFT,
       ).show(context);
     }
    },
    child: Container(
      width: width/3.65,
      child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${authProvider.lg[authProvider.language]["change"]}',
            style: TextStyle(
                color: Color.fromRGBO(85, 115, 116, 1),
                fontSize: 13,
                fontFamily: 'Geomanist',
                fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 5,),
          FaIcon(Icons.person,color:Color(0xFF3F5521)
            ,)
        ],
      ),
    ),
    style: ElevatedButton.styleFrom(
      primary: Color(0xffF5F6F7),
      side: BorderSide(
        color: Color.fromRGBO(85, 115, 116, 1),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  ),
),)
                                            ]),
                                          ),

                                        );
                                      });
                                    },
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            '${authProvider.lg[authProvider.language]["Change contact info"]}',
                                            style: TextStyle(
                                                color: Color.fromRGBO(85, 115, 116, 1),
                                                fontSize: 13,
                                                fontFamily: 'Geomanist',
                                                fontWeight: FontWeight.bold),

                                            )
                                        ],
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xffF5F6F7),
                                      side: BorderSide(
                                        color: Color.fromRGBO(85, 115, 116, 1),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),)
                            ]),

                            SizedBox(
                              height: 5,
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              width: width,
              height: height * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    child: Text(
                      '${authProvider.lg[authProvider.language]['Items Ordered']}',
                      style: TextStyle(
                        //color: Color.fromRGBO(146, 156, 170, 1),
                       // fontFamily: 'Geomanist',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Divider(
                    color: Color.fromRGBO(112, 112, 112, 1),
                    indent: 20,
                    endIndent: 20,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  OrderList(a:_order.items),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            _order.paymentFreind.length == 0?  Container() :   Container(
              color: Colors.white,
              width: width,
              height: height * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    child: Text(
                      '${authProvider.lg[authProvider.language]["Bill sharing"]}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Divider(
                    color: Color.fromRGBO(112, 112, 112, 1),
                    indent: 20,
                    endIndent: 20,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  OrderfreindList(a:_order.paymentFreind),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0 ,right: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          TrackingOrder(widget.id),
                    ),
                  );
                },
                child: Container(
                  width: width/2.65,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${authProvider.lg[authProvider.language]["Tracking"]}',
                          style: TextStyle(
                              color: Color.fromRGBO(85, 115, 116, 1),
                              fontSize: 13,
                              fontFamily: 'Geomanist',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 5,),
                      FaIcon(FontAwesomeIcons.truck,color:Color(0xFF3F5521)
                    ,)
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffF5F6F7),
                  side: BorderSide(
                    color: Color.fromRGBO(85, 115, 116, 1),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 30,
            ),
            _order.orderbyId["creditCard"]!=null?   Container(
              color: Colors.white,
              height: height * 0.12,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    child: Text(
                      '${authProvider.lg[authProvider.language]['Payment Details : ']}',
                      style: TextStyle(


                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 9.0,right: 10),
                    child: Text(
                      "${_order.orderbyId["creditCard"]["type"]} **** **** **${_order.orderbyId["creditCard"]["cardNumber"]}",
                      style: TextStyle(fontFamily: 'Geomanist', fontSize: 14),
                    ),
                  )
                ],
              ),
            ):Container(),
            SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.white,
              height: height * 0.25,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${authProvider.lg[authProvider.language]["Order Total : "]}',
                              style: TextStyle(
                                  color: Color.fromRGBO(146, 156, 170, 1),
                                  fontFamily: 'Geomanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: "${authProvider.lg[authProvider.language]["Tax from total"]}",
                                    style: TextStyle(

                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 25.0,left: 10),
                                  child: Text(
                                    "${authProvider.lg[authProvider.language]["SAR"]} ${double.parse((_order.orderbyId["tax"] ?? 0.0).toStringAsFixed(2))}",
                                    style: TextStyle(

                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: "${authProvider.lg[authProvider.language]["Total including VAT"]} ",
                                    style: TextStyle(

                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 25.0,left: 10),
                                  child: Text(
                                    "${authProvider.lg[authProvider.language]["SAR"]} ${double.parse((_order.orderbyId["total"] ?? 0.0).toStringAsFixed(2))}",
                                    style: TextStyle(

                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),


                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),

          ],
        ),
      ):Center(child: Text(_order.orderbyId["message"]),):Center(child: CircularProgressIndicator(color:Color(0xFF3F5521)),),
    );
  }
}
