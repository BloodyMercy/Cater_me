import 'package:CaterMe/Providers/user.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'splash_screen.dart';

class IntroScreen extends StatelessWidget {
  final List<PageViewModel> pages = [
    PageViewModel(
        title: 'First page',
        body: 'description',
        image: Center(
          child: Image.asset(
            'images/logo.png',
          ),
        ),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(
            fontSize: 25,
            fontFamily: 'BerlinSansFB',
          ),
        )
        // footer: ElevatedButton(
        //   onPressed: (){},
        //   child: Text('Lets Gooo'),
        // )
        ),
    PageViewModel(
        title: 'scnd page',
        body: 'description two',
        image: Center(
          child: Image.asset(
            'images/logo.png',
          ),
        ),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(
            fontSize: 25,
            fontFamily: 'BerlinSansFB',
          ),
        )
        // footer: ElevatedButton(
        //   onPressed: (){},
        //   child: Text('Lets Gooo'),
        // )
        ),
    PageViewModel(
      title: 'thrd page',
      body: 'description three',
      image: Center(
        child: Image.asset(
          'images/logo.png',
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 25,
          fontFamily: 'BerlinSansFB',
        ),
      ),
      // footer: ElevatedButton(
      //   onPressed: (){},
      //   child: Text('Lets Gooo'),
      // )
    ),
  ];

  IntroScreen({Key key}) : super(key: key);

  void onDone(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {


    final userprovider=Provider.of<UserProvider>(context,listen: true);
    return Scaffold(
      body: IntroductionScreen(
        pages: pages,
        dotsDecorator: DotsDecorator(
          size: const Size(
            10,
            10,
          ),
          color: Theme.of(context).primaryColor,
          activeSize: const Size.square(15),
          activeColor: Colors.red,
        ),
        showDoneButton: true,
        //you can put an icon
        done: const Text(
          'Done',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'BerlinSansFB',
          ),
        ),
        showSkipButton: true,
        //you can put an icon
        skip: const Text(
          'Skip',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'BerlinSansFB',
          ),
        ),
        showNextButton: true,
        //you can put an icon
        next: const Text(
          'Next',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'BerlinSansFB',
          ),
        ),
        onDone: () async{
          SharedPreferences sh= await SharedPreferences.getInstance();
          sh.setBool("wlkdone", true);
          userprovider.status=Status.Unauthenticated;
        //  onDone(context);
        },
        curve: Curves.easeInOutQuart,
      ),
    );
  }
}
