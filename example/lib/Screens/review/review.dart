import 'package:CaterMe/Screens/Review/First_review.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/surveyProvder.dart';
import '../../Providers/user.dart';
import '../../language/language.dart';

class Review extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    var mediaQueryHeight = MediaQuery.of(context).size.height;
    var mediaQueryWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Center(child: Image.asset('images/logo-white.png', height: mediaQueryHeight*0.5,)),
            Padding(
              padding:  EdgeInsets.only(top: mediaQueryHeight*0.01),
              child: Text(
                'Your feedback is important to',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            Text(
              'us. Help us improve',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            Text(
              'يهمنا تقييمك لتحسين خدمتنا.',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            Padding(
              padding: EdgeInsets.only(top: mediaQueryHeight * 0.1),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FirstReview()));
                  },
                  child: Text('${authProvider.lg[authProvider.language]['Start']}'
                    ,
                    style: TextStyle(color: Colors.black,fontSize: 25),
                  ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(15)))),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                          vertical: (mediaQueryHeight * 0.074) * 0.3,
                          horizontal: (mediaQueryWidth * 0.35)),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
