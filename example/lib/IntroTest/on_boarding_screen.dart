

import 'package:CaterMe/IntroTest/size_config.dart';
import 'package:flutter/material.dart';

import 'body.dart';


class OnBoardingScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
