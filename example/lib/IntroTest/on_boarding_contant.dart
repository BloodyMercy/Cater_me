import 'package:CaterMe/IntroTest/size_config.dart';
import 'package:flutter/material.dart';

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);

  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: getScreenWidth(1000),
      height: getScreenHeight(700),
    );
  }
}
