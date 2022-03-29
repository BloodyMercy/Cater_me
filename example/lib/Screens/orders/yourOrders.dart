import 'package:CaterMe/Providers/order.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/Screens/orders/mainOrderId.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../NavigationBar/navigation_bar.dart';
import '../../Providers/address.dart';
import '../../Providers/credit_card_provider.dart';
import '../../Providers/orderById_provider.dart';
import '../../Providers/order_provider.dart';
import '../../Providers/packages.dart';
import '../../Providers/user.dart';
import '../../language/language.dart';
import '../Order.dart';
import '../ahmad/My Orders/OrderDetails.dart';
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
    SharedPreferences sh = await SharedPreferences.getInstance();
    await orders.getAllOrders();
    setState(() {
      language = sh.getString("locale");
    });
    setState(() {
      loading = false;
    });
    return;
  }

  Future refreshOrderData() async {
    final orders = Provider.of<OrderProvider>(context, listen: false);
    setState(() {
      loading = true;
    });
    SharedPreferences sh = await SharedPreferences.getInstance();
    await orders.clearData();

    await orders.getAllOrders();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Color _getColorByEvent(String orderStatus) {

    if (orderStatus == "Preparing") return Color(0xFFEAB316);
    if (orderStatus == "جاري التحضير") return Color(0xFFEAB316);

    if (orderStatus == "Received") return Color(0xFFEAB316);

    if (orderStatus == "تم تلقي طلبك") return Color(0xFFEAB316);
    if (orderStatus == "Rejected") return Color(0xFFEA4D47);
    if (orderStatus == "تم رفض الطلب") return Color(0xFFEA4D47);
    if (orderStatus == "On The Way") return Color(0xFFEAB316);
    if (orderStatus == "على الطريق") return Color(0xFFEAB316);
    if (orderStatus == "Delivered") return Color(0xFF3F5521);
    if (orderStatus == "تم التوصيل") return Color(0xFF3F5521);
    if (orderStatus == "OTP Pending") return Color(0xFFEAB316);
    if (orderStatus == "بانتظار الرمز التحققي") return Color(0xFFEAB316);
    if (orderStatus == "Payment Pending") return Color(0xFFEAB316);
    if (orderStatus == "انتظار الدفع") return Color(0xFFEAB316);

    return Colors.blue;
  }

  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final orders = Provider.of<OrderProvider>(context, listen: true);
    //  final authProvider = Provider.of<UserProvider>(context, listen: true);

    final package = Provider.of<PackagesProvider>(context, listen: true);
    final orderCaterprovider =
        Provider.of<OrderCaterProvider>(context, listen: true);
    final address = Provider.of<AdressProvider>(context, listen: true);
    final credit = Provider.of<CreditCardsProvider>(context, listen: true);
    final order = Provider.of<OrderByIdProvider>(context, listen: true);
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refreshOrderData,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : orders.listOrder.length == 0
                        ? authProvider.status == Status.Authenticated
                            ? Center(
                                child: language == "en"
                                    ? Image.asset('images/noorderyet.png')
                                    : Image.asset(
                                        'images/no address yetعربي/no addresses yetبالعربي-09.png'))
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  language == "en"
                                      ? Image.asset('images/noorderyet.png')
                                      : Image.asset(
                                          'images/no address yetعربي/no addresses yetبالعربي-09.png'),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    },
                                    child: Text(
                                      '${authProvider.lg[authProvider.language]["Log In"]}',
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
                                    if (orders.listOrder[index].orderStatus ==
                                            "Payment Pending" ||
                                        orders.listOrder[index].orderStatus ==
                                            "انتظار الدفع") {
                                      //    if(authProvider.status == Status.Authenticated) {
                                      address.clearAddressController();
                                      orderCaterprovider.spets = 7;
                                      orderCaterprovider.vatshisha = 0.0;
                                      orderCaterprovider.vatfood = 0.0;

                                      orderCaterprovider.totale =
                                          orders.listOrder[index].total;
                                      orderCaterprovider.choosebillFriend = [];
                                      orderCaterprovider.choosebillFriend = [];
                                      orderCaterprovider.itemOrders = [];
                                      orderCaterprovider.totalssha = 0;
                                      orderCaterprovider.totalpackage = 0;
                                      orderCaterprovider.finaldonatesteps =
                                          false;
                                      orderCaterprovider
                                          .finaldonatestepsCancel = false;
                                      orderCaterprovider.orderid =
                                          orders.listOrder[index].id;
                                      credit.value = -1;
                                      orderCaterprovider.setup = false;
                                      orderCaterprovider.serviceId = 1;
                                      address.form = false;
                                      address.valueIndex = -1;
                                      // orderCaterprovider.
                                      address.phone.text = "";
                                      address.name.text = "";
                                      order.check1 = false;
                                      order.check2 = false;
                                      orderCaterprovider.finaldonatesteps =
                                          false;
                                      orderCaterprovider.paymemtstep = true;
                                      order.check3 = false;
                                      order.check4 = false;
                                      orderCaterprovider.checkotp = false;
                                      // orderCaterprovider.listFriend=[];
                                      address.value2Index = -1;
                                      orderCaterprovider.valueIndex = -1;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Order(),
                                        ),
                                      );
                                      //    }
                                      //   else{

                                      //   }

                                    } else {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (builder) =>
                                              OrderDetailsView(
                                            orders.listOrder[index].id,
                                          ),
                                        ),
                                      );
                                    }
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
                                                Expanded(
                                                  child: Text(
                                                      orders.listOrder[index]
                                                          .eventName,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
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
                                              "${authProvider.lg[authProvider.language]["Address:"]} ${orders.listOrder[index].addressTitle}",
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
