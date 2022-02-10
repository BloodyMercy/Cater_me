
import 'package:CaterMe/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: (5000)),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Lottie.asset(
        'images/animation/CaterMe.json',
        controller: _controller,
        height: MediaQuery.of(context).size.height * 5,

        animate: true,
        onLoaded: (composition) {
          // _controller
          //   ..duration = composition.duration
          //   ..forward().whenComplete(() => Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(builder: (context) => appstate()),
          //   ));
        },
      ),
    );
  }
}