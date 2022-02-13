import 'package:CaterMe/IntroTest/size_config.dart';
import 'package:flutter/material.dart';


import 'constant.dart';
import 'homepage.dart';
import 'on_boarding_contant.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> onBoardingData = [
    {
      'text': '',
      'image': 'images/IntroductionScreen/introductionscreen1.png',
    },
    {
      'text': '',
      'image': 'imagesIntroductionScreen/introductionscreen2.png',
    },
    {
      'text': '',
      'image': 'images/IntroductionScreen/introductionscreen3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: onBoardingData.length,
                  itemBuilder: (context, index) => OnBoardingContent(
                    text: onBoardingData[index]['text'],
                    image: onBoardingData[index]['image'],
                  )),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onBoardingData.length,
                          (index) => buildDot(index),
                    ),
                  ),
                  Spacer(
                    flex: 5,
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: getScreenWidth(20)),
                    child: SizedBox(
                      width: double.infinity,
                      height: getScreenHeight(60),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: kSecondaryColor,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 18,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      width: currentPage == index ? 20 : 6,
      height: 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: currentPage == index ? kSecondaryColor : Colors.black38,
      ),
    );
  }
}
