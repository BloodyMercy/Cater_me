import 'package:CaterMe/IntroTest/size_config.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: getScreenWidth(375),
            height: getScreenHeight(375),
            child: Image.asset('assets/images/Completed.png'),
          ),
        ],
      ),
    );
  }
}
