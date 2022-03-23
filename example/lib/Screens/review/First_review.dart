import 'package:CaterMe/Screens/Review/Second_review.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';


class FirstReview extends StatelessWidget {

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
        body: Center(
          child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: mediaQueryHeight*0.05),
                child:
              Text(
                '1- How would you rate your',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),),
              Text(
                'experience?',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Text(
                '  ما هو تقييمك لللتجربة؟*',
                  style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            Padding(
              padding: EdgeInsets.only(top:mediaQueryHeight*0.05),
              child: RatingBar.builder(
                itemSize: 55,
                unratedColor: Colors.white10,
                initialRating: 0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.white,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ),
              Padding(
                padding: EdgeInsets.only(top: mediaQueryHeight * 0.1),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SecondReview()));
                  },
                  child: SizedBox(
                    width: mediaQueryWidth*0.15,
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
      ),
    );
  }
}
