import 'package:CaterMe/Providers/notification_provider.dart';
import 'package:CaterMe/Screens/orders/mainOrderId.dart';
import 'package:CaterMe/widgets/Frriends/friends_list.dart';
import 'package:CaterMe/widgets/notifications_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool loading=true;
  getData() async{
    final allNotification = Provider.of<NotificationProvider>(context, listen: false);
    await allNotification.getAllNotifications();
    setState(() {
      loading=false;
    });
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final allNotification = Provider.of<NotificationProvider>(context, listen: true);
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
        body: loading?Center(child: CircularProgressIndicator(),): Container(
          child: ListView.builder(
              itemCount: allNotification.notificationlist.length,itemBuilder: (context,index){
            return ListTile(
              onTap:(){
                Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>OrderId(index,1)));
              } ,
              title: Text(allNotification.notificationlist[index].title),
              subtitle: Text(allNotification.notificationlist[index].description),
            );
          }),
        )
      ),
    );
  }
}
