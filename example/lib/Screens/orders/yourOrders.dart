import 'package:CaterMe/Providers/order.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/Screens/orders/mainOrderId.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../NavigationBar/navigation_bar.dart';
import '../../Providers/user.dart';
import '../../language/language.dart';
import '../auth/login_screen.dart';
import '../auth/reset_password_screen.dart';
import '../auth/signup_screen.dart';

class YourOrders extends StatefulWidget {
  const YourOrders({Key key}) : super(key: key);

  @override
  _YourOrdersState createState() => _YourOrdersState();
}

class _YourOrdersState extends State<YourOrders> {
  bool loading = true;

  String language;


  Future getData() async {
    final orders = Provider.of<OrderProvider>(context, listen: false);
    SharedPreferences sh=await SharedPreferences.getInstance();
    await orders.getAllOrders(sh.getString("locale"));
setState(() {
  language=sh.getString("locale");
});
    setState(() {
      loading = false;
    });
    return;
  }

  Future refreshOrderData() async {
    final orders = Provider.of<OrderProvider>(context, listen: false);

    await orders.clearData();
    SharedPreferences sh=await SharedPreferences.getInstance();
    await orders.getAllOrders(sh.getString("locale"));
    return;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Color _getColorByEvent(String orderStatus) {
    if (orderStatus == "Preparing") return Color(0xFF3F5521);
    if (orderStatus == "جاري التحضير") return Color(0xFF3F5521);
    if (orderStatus == "Received") return Color(0xFF3F5521);
    if (orderStatus == "تم تلقي طلبك") return Color(0xFF3F5521);
    if (orderStatus == "Rejected") return Color(0xFFEA4D47);
    if (orderStatus == "تم رفض الطلب") return Color(0xFFEA4D47);
    if (orderStatus == "On The Way ") return Color(0xFFEAB316);
    if (orderStatus == "على الطريق ") return Color(0xFFEAB316);
    if (orderStatus == "Delivered") return Color(0xFF272833);
    if (orderStatus ==" تم التوصيل") return Color(0xFF272833);

    return Colors.blue;
  }

  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final orders = Provider.of<OrderProvider>(context, listen: true);
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(

        body: RefreshIndicator(
          onRefresh: refreshOrderData,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : orders.listOrder.length == 0
                        ? authProvider.status == Status.Authenticated
                            ? Center(
                                child:
                                   language=="en" ?Image.asset('images/noorderyet.png'):Image.asset('images/no address yetعربي/no addresses yetبالعربي-09.png'))
                            : Column(
                                children: [
                                  language=="en" ?Image.asset('images/noorderyet.png'):Image.asset('images/no address yetعربي/no addresses yetبالعربي-09.png'),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              LoginScreen()));
                                    },
                                    child: Text(
                                      '${LanguageTr.lg[authProvider.language]["Log In"]}',
                                    ),
                                  )
                                ],
                              )
                        : Container(
                            color: LightColors.kLightYellow,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (builder) => OrderId(
                                            orders.listOrder[index].id, 0),
                                      ),
                                    );
                                  },
                                  child: Card(
                                      elevation: 5,
                                      color: LightColors.kLightYellow2,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    orders.listOrder[index]
                                                        .eventName,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                  orders.listOrder[index]
                                                      .orderStatus,
                                                  style: TextStyle(
                                                    color: _getColorByEvent(
                                                        orders.listOrder[index]
                                                            .orderStatus
                                                            .toString()),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "${DateFormat("dd-MM-yyyy").format(DateTime.parse(orders.listOrder[index].eventDate))}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "${LanguageTr.lg[authProvider.language]["Address"]}, ${orders.listOrder[index].addressTitle}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )
                                          ],
                                        ),
                                      )),
                                );
                              },
                              itemCount: orders.listOrder.length,
                            ))),
          ),
        ),
      ),
    );
  }
}
