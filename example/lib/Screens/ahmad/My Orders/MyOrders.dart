
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({Key key}) : super(key: key);

  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffF5F6F7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(62.0),
        child: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "My Orders",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Valencia', fontSize: 25),
          ),
          leading: IconButton(
            icon: Image.asset(
              'assets/icons/icon_back.png',
              color: Color.fromRGBO(86, 115, 116, 1),
              height: 25,
              width: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '48 orders',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Geomanist',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              width: width,
              height: height * 1.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text(
                          'Order 12345678',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Geomanist',
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon:
                              SvgPicture.asset("assets/icons/Forwardarrow.svg"),
                          onPressed: () {
                          //  changeScreen(context, OrderDetailsView());
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.2,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Container(
                              width: 100.0,
                              color: Colors.white,
                              child: Image.asset(
                                'assets/images/image-shirt.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Container(
                              width: 100.0,
                              color: Colors.white,
                              child: Image.asset(
                                'assets/images/whiteShirt.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Container(
                              width: 100.0,
                              color: Colors.white,
                              child: Image.asset(
                                'assets/images/handbag.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromRGBO(86, 115, 116, 1),
                              ),
                            ),
                            width: 40.0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '+3',
                                style: TextStyle(
                                  fontFamily: 'Geomanist',
                                  color: Color.fromRGBO(86, 115, 116, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
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
                              "Order Date: 12 November 2021",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Geomanist',
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text.rich(
                              TextSpan(
                                text: "Estimated Delivery : 3 December 2021",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Geomanist',
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Color.fromRGBO(112, 112, 112, 1),
                    indent: 25,
                    endIndent: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text(
                          'Order 12345678',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Geomanist',
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon:
                              SvgPicture.asset("assets/icons/Forwardarrow.svg"),
                          onPressed: () {
                           // changeScreen(context, OrderDetailsView());
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.2,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Container(
                              width: 100.0,
                              color: Colors.white,
                              child: Image.asset(
                                'assets/images/image_coat.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Container(
                              width: 100.0,
                              color: Colors.white,
                              child: Image.asset(
                                'assets/images/tealbag.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Container(
                              width: 100.0,
                              color: Colors.white,
                              child: Image.asset(
                                'assets/images/shirt-image.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromRGBO(86, 115, 116, 1),
                              ),
                            ),
                            width: 40.0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '+6',
                                style: TextStyle(
                                  fontFamily: 'Geomanist',
                                  color: Color.fromRGBO(86, 115, 116, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
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
                              "Order Date: 1 November 2021",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Geomanist',
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Delivery Status : ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Geomanist',
                                      fontSize: 12),
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: "DELIVERED on 10 November 2021",
                                    style: TextStyle(
                                        color: Color.fromRGBO(85, 115, 116, 1),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Geomanist',
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Color.fromRGBO(112, 112, 112, 1),
                    indent: 25,
                    endIndent: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text(
                          'Order 12345678',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Geomanist',
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon:
                              SvgPicture.asset("assets/icons/Forwardarrow.svg"),
                          onPressed: () {
                          //  changeScreen(context, OrderDetailsView());
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.2,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Container(
                              width: 100.0,
                              color: Colors.white,
                              child: Image.asset(
                                'assets/images/perfume.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Container(
                              width: 100.0,
                              color: Colors.white,
                              child: Image.asset(
                                'assets/images/belt.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
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
                              "Order Date: 12 November 2021",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Geomanist',
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text.rich(
                              TextSpan(
                                text: "Estimated Delivery : 3 December 2021",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Geomanist',
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Color.fromRGBO(112, 112, 112, 1),
                    indent: 25,
                    endIndent: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
