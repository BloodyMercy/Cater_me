import 'package:CaterMe/model/notification.dart';
import 'package:flutter/material.dart';

class NotificationsList extends StatelessWidget {
  NotificationsList({Key? key}) : super(key: key);

  final List<Notifications> notifications = [
    Notifications(
      image:
          'https://static.wikia.nocookie.net/youtube/images/9/9c/Hecker.jpg/revision/latest/top-crop/width/360/height/360?cb=20211024200708',
      title: 'Notification',
      details: 'details...............',
    ),
    Notifications(
      image:
          'https://static.wikia.nocookie.net/youtube/images/9/9c/Hecker.jpg/revision/latest/top-crop/width/360/height/360?cb=20211024200708',
      title: 'Notification',
      details: 'details...............',
    ),
    Notifications(
      image:
          'https://static.wikia.nocookie.net/youtube/images/9/9c/Hecker.jpg/revision/latest/top-crop/width/360/height/360?cb=20211024200708',
      title: 'Notification',
      details: 'details...............',
    ),
    Notifications(
      image:
          'https://static.wikia.nocookie.net/youtube/images/9/9c/Hecker.jpg/revision/latest/top-crop/width/360/height/360?cb=20211024200708',
      title: 'Notification',
      details: 'details...............',
    ),
    Notifications(
      image:
          'https://static.wikia.nocookie.net/youtube/images/9/9c/Hecker.jpg/revision/latest/top-crop/width/360/height/360?cb=20211024200708',
      title: 'Notification',
      details: 'details...............',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Column(
      children: notifications.map((e) {
        return Container(
          alignment: Alignment.topLeft,
          width: mediaQuery.size.width * 0.87,
          height: mediaQuery.size.height * 0.1,
          child: Row(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: mediaQuery.size.height * 0.02,
                      horizontal: mediaQuery.size.height * 0.01),
                  child: CircleAvatar(
                    radius: 25.0,
                    child: ClipRRect(
                      child: Image.network(e.image),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      e.title,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      e.details,
                      style: Theme.of(context).textTheme.headline4,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
