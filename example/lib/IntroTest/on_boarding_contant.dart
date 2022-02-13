import 'package:CaterMe/IntroTest/size_config.dart';
import 'package:flutter/material.dart';


import 'constant.dart';

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);

  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(
          flex: 5,
        ),
        // Text(
        //   'Drizzzle',
        //   style: TextStyle(
        //     color: kPrimaryColor,
        //     fontSize: 36,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        SizedBox(
          height: getScreenHeight(5),
        ),
        Text(
          text,
          style: TextStyle(
            color: kTextColor,
            fontSize: 16,
          ),
        ),
        Spacer(),
        Image.asset(
          image,
          width: getScreenWidth(675),
          height: getScreenHeight(675),
        ),
      ],
    );
  }
}
