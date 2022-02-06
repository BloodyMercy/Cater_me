import 'package:CaterMe/widgets/Frriends/friends_list.dart';
import 'package:CaterMe/widgets/notifications_list.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: mediaQuery.size.height * 0.03),
              NotificationsList(),
              NotificationsList(),
              NotificationsList(),
              NotificationsList(),
              NotificationsList(),
              NotificationsList(),
              NotificationsList(),
              NotificationsList(),
              NotificationsList(),
              NotificationsList(),
              NotificationsList(),
              SizedBox(height: mediaQuery.size.height * 0.06),
            ],
          ),
        ),
      ),
    );
  }
}
