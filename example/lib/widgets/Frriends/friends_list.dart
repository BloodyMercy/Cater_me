import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/model/friend_model.dart';
import 'package:flutter/material.dart';

class FriendsList extends StatelessWidget {
  final List<FriendModel> friend;

  FriendsList(this.friend);

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SizedBox(
        height: _mediaQuery * 0.9,
        child: friend.isEmpty
            ? Center(
             child: Container(
               child: Image.asset('images/NoFriendsYet.png'),
             ),
              )
            : ListView.builder(
                itemCount: friend.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    color: LightColors.kLightYellow2,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: _mediaQuery * 0.02,
                              horizontal: _mediaQuery * 0.01),
                          child: CircleAvatar(
                            radius: 25.0,
                            child: ClipRRect(
                              child: Image.network(
                                 friend[index].image,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              friend[index].name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              friend[index].email,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.normal),
                            ),
                            // SizedBox(height: _mediaQuery * 0.01),
                            Text(
                              friend[index].phoneNumber,
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
      ),
    );
  }
}
