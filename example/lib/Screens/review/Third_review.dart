import 'package:CaterMe/Screens/Review/Fourth_review.dart';
import 'package:flutter/material.dart';

class ThirdReview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: mediaQueryHeight * 0.12),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FourthReview()));
                },
                child: SizedBox(
                  width: mediaQueryWidth*0.135,
                  child: Row(
                    children: [
                      Text(
                        'Ok',
                        style: TextStyle(color: Colors.black,fontSize: 25),
                      ),
                      Icon(Icons.check, color: Colors.black,)
                    ],
                  ),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(15)))),
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
