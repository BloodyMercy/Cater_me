import 'package:CaterMe/Providers/notification_provider.dart';
import 'package:CaterMe/Providers/orderStatus_provider.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/orders/mainOrderId.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NavigationBar/navigation_bar.dart';
import '../Providers/address.dart';
import '../Providers/credit_card_provider.dart';
import '../Providers/order.dart';
import '../Providers/orderById_provider.dart';
import '../Providers/order_provider.dart';
import '../Providers/user.dart';
import '../chat/pages/chat_page.dart';
import '../language/language.dart';
import 'Order.dart';
import 'auth/login_screen.dart';
import 'auth/reset_password_screen.dart';
import 'auth/signup_screen.dart';
import 'occasion/theme/colors/light_colors.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool loading = true;
String language;
  getData() async {
    final allNotification =
        Provider.of<NotificationProvider>(context, listen: false);
    SharedPreferences sh=await SharedPreferences.getInstance();
    await allNotification.getAllNotifications(sh.getString("locale"));



     setState(() {
       language = sh.getString("locale");
     });
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }


  Future refreshdata() async {
    final allNotification =
    Provider.of<NotificationProvider>(context, listen: false);
    SharedPreferences sh=await SharedPreferences.getInstance();
    await allNotification.ClearAllNotifications();
    await allNotification.getAllNotifications(sh.getString("locale"));

    return;
  }


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
  //  final authProvider = Provider.of<UserProvider>(context, listen: true);
    final orders = Provider.of<OrderProvider>(context, listen: true);
    //  final authProvider = Provider.of<UserProvider>(context, listen: true);

    final package = Provider.of<PackagesProvider>(context, listen: true);
    final orderCaterprovider=Provider.of<OrderCaterProvider>(context,listen: true);
    final address=Provider.of<AdressProvider>(context,listen: true);
    final credit=Provider.of<CreditCardsProvider>(context,listen: true);
    final order = Provider.of<OrderByIdProvider>(context, listen: true);

    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final orderStatus = Provider.of<OrderStatusProvider>(context, listen: true);
    final allNotification =
        Provider.of<NotificationProvider>(context, listen: true);
   // final package = Provider.of<PackagesProvider>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(

          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // shape: const RoundedRectangleBorder(
            //   borderRadius: BorderRadius.vertical(
            //     bottom: Radius.circular(15),
            //   ),
            // ),
            centerTitle: true,
            title: Text('${LanguageTr.lg[authProvider.language]["Notifications"]}'
              ,
              style: Theme.of(context).textTheme.headline1,
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: loading
              ? Container(
                  color: LightColors.kLightYellow,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF3F5521),
                    ),
                  ),
                )
              : allNotification.notificationlist.length == 0? authProvider.status == Status.Authenticated
                  ? Center(child: language=="en" ?Image.asset('images/nonotificationyet.png',fit:BoxFit.contain):Image.asset('images/no address yetعربي/no addresses yetبالعربي-08.png',fit:BoxFit.contain))
              : Column(
            children: [
              language=="en" ?Image.asset('images/nonotificationyet.png',fit:BoxFit.contain):Image.asset('images/no address yetعربي/no addresses yetبالعربي-08.png',fit:BoxFit.contain),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: Text(
                  '${LanguageTr.lg[authProvider.language]["Log In"]}',
                ),
              )
            ],
          )
                  : RefreshIndicator(
            onRefresh: refreshdata,
                    child: Container(
                        color: LightColors.kLightYellow,
                        child: ListView.builder(
                            itemCount: allNotification.notificationlist.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if(  allNotification
                                      .notificationlist[index]
                                      .description.contains("Message"))

                                    {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (builder) => ChatPage(
                                            peerId: "admin",
                                            peerAvatar: "",
                                            peerNickname:
                                            "Customer Service",
                                          )
                                            ,
                                        ),
                                      );
                                    }

else       if(       allNotification
                                      .notificationlist[index].description=="Order is Payment Pending" || allNotification
                                      .notificationlist[index].description=="انتظار الدفع" )
                                  {




                                    //    if(authProvider.status == Status.Authenticated) {
                                    address.clearAddressController();
                                    orderCaterprovider.spets = 7;
                                    orderCaterprovider.vatshisha = 0.0;
                                    orderCaterprovider.vatfood = 0.0;

                                    orderCaterprovider.totale = orders.listOrder[index].total;
                                    orderCaterprovider.choosebillFriend = [];
                                    orderCaterprovider.choosebillFriend = [];
                                    orderCaterprovider.itemOrders = [];
                                    orderCaterprovider.totalssha = 0;
                                    orderCaterprovider.totalpackage = 0;
                                    orderCaterprovider.finaldonatesteps=false;
                                    orderCaterprovider.finaldonatestepsCancel=false;
                                    orderCaterprovider.orderid=orders.listOrder[index].id;
                                    credit.value = -1;
                                    orderCaterprovider.setup=false;
                                    orderCaterprovider.serviceId = 1;
                                    address.form = false;
                                    address.valueIndex = -1;
                                    // orderCaterprovider.
                                    address.phone.text = "";
                                    address.name.text = "";
                                    order.check1 = false;
                                    order.check2 = false;
                                    orderCaterprovider.finaldonatesteps=false;
                                    orderCaterprovider.paymemtstep=true;
                                    order.check3 = false;
                                    order.check4 = false;
                                    orderCaterprovider.checkotp=false;
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








                                  }
                                    else {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (builder) =>
                                            OrderId(
                                                allNotification
                                                    .notificationlist[index]
                                                    .orderId,
                                                1),
                                      ),
                                    );
                                  }
                                  allNotification.markAsRead(
                                      allNotification.notificationlist[index].id);
                                  if (!allNotification
                                      .notificationlist[index].seen) {
                                    var i = int.parse(package.nbnotification);
                                    i--;
                                    package.nbnotification = i.toString();
                                  }

                                },
                                child: Card(
                                  color: LightColors.kLightYellow2,
                                  // elevation: 5,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 10, 30, 30),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        allNotification
                                                .notificationlist[index].seen
                                            ? FaIcon(
                                                FontAwesomeIcons.checkDouble,
                                                color: colorCustom,
                                              )
                                            : Container(),
                                        Row(
                                          children: [
                                            // Padding(
                                            //   padding: const EdgeInsets.only(right: 20.0),
                                            //   child: CircleAvatar(
                                            //     minRadius: 16,
                                            //     maxRadius: screenHeight * 0.04,
                                            //     backgroundImage:
                                            //         AssetImage('images/food33.jpg'),
                                            //   ),
                                            // ),
                                            Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      allNotification
                                                          .notificationlist[index]
                                                          .title,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                                    Text(
                                                      allNotification
                                                          .notificationlist[index]
                                                          .description,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black87),
                                                    ),
                                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                                    Text(
                                                        '${DateFormat.yMd(language).add_jm().format(DateTime.parse(allNotification.notificationlist[index].date))}',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black26),
                                                    ),
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // child: ListTile(
                                    //   onTap: () {
                                    //     Navigator.of(context).push(
                                    //       MaterialPageRoute(
                                    //         builder: (builder) => OrderId(index, 1),
                                    //       ),
                                    //     );
                                    //   },
                                    //   leading: CircleAvatar(
                                    //     minRadius: 16,
                                    //     maxRadius: screenHeight * 0.1,
                                    //     backgroundImage: AssetImage('images/food33.jpg'),
                                    //   ),
                                    //
                                    //   title: Text(allNotification
                                    //       .notificationlist[index].title),
                                    //   subtitle: Text(allNotification
                                    //       .notificationlist[index].description),
                                    // ),
                                  ),
                                ),
                              );
                            }),
                      ),
                  )),
    );
  }
}
