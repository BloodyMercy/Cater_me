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

import '../chat/pages/chat_page.dart';
import 'occasion/theme/colors/light_colors.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool loading = true;

  getData() async {
    final allNotification =
        Provider.of<NotificationProvider>(context, listen: false);
    await allNotification.getAllNotifications();

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

    await allNotification.ClearAllNotifications();
    await allNotification.getAllNotifications();

    return;
  }


  @override
  Widget build(BuildContext context) {
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final orderStatus = Provider.of<OrderStatusProvider>(context, listen: true);
    final allNotification =
        Provider.of<NotificationProvider>(context, listen: true);
    final package = Provider.of<PackagesProvider>(context, listen: false);
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
            title: Text(
              'Notifications',
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
              : allNotification.notificationlist.length == 0
                  ? Center(child: Image.asset('images/nonotificationyet.png'))
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
                                                        '${DateFormat.yMd().add_jm().format(DateTime.parse(allNotification.notificationlist[index].date))}',
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
