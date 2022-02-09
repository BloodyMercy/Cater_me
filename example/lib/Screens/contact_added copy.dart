import 'package:CaterMe/NavigationBar/navigation_bar.dart';

import 'package:flutter/material.dart';

class ContactAdded extends StatelessWidget {
  const ContactAdded({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: mediaQuery.size.height * 0.02,
          ),
          Column(
            children: [
              Center(
                  child: Image.asset('images/Group 1068.png',
                      height: 150, width: 150)),
              SizedBox(
                height: mediaQuery.size.height * 0.08,
              ),
              Text(
                "Sent",
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Navigationbar(0),
                ),
              );
            },
            child: Text(
              "CLOSE",
              style: Theme.of(context).textTheme.headline1,
            ),
            style: ElevatedButton.styleFrom(
              elevation: 5,
              padding: EdgeInsets.symmetric(
                horizontal: (mediaQuery.size.width * 0.3),
                vertical: (mediaQuery.size.height * 0.02),
              ),
              primary: Theme.of(context).primaryColor,
              shape: new RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
