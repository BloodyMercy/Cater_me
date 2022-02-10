import 'package:CaterMe/Providers/notification_provider.dart';
import 'package:CaterMe/Providers/orderById_provider.dart';
import 'package:CaterMe/Providers/orderStatus_provider.dart';
import 'package:CaterMe/Screens/orders/mainOrderId.dart';
import 'package:CaterMe/widgets/Frriends/friends_list.dart';
import 'package:CaterMe/widgets/notifications_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final orderStatus = Provider.of<OrderStatusProvider>(context, listen: true);
    final allNotification =
        Provider.of<NotificationProvider>(context, listen: true);
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
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
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
              : Container(
                  color: LightColors.kLightYellow,
                  child: ListView.builder(
                      itemCount: allNotification.notificationlist.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async{
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (builder) => OrderId(index, 1),
                              ),
                            );
                           await allNotification.markAsRead(allNotification.notificationlist[index].id);

                          },
                          child: Card(
                            color: LightColors.kLightYellow2,
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: CircleAvatar(
                                      minRadius: 16,
                                      maxRadius: screenHeight * 0.04,
                                      backgroundImage:
                                          AssetImage('images/food33.jpg'),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(allNotification
                                          .notificationlist[index].title),
                                      Text(allNotification
                                          .notificationlist[index].description),
                                     allNotification.notificationlist[index].seen ? Text("seen"):Text("not seen"),
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
                )),
    );
  }
}
