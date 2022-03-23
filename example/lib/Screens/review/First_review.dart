import 'package:CaterMe/Screens/Review/Second_review.dart';
import 'package:CaterMe/Screens/review/Fourth_review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/surveyProvder.dart';


class FirstReview extends StatefulWidget {

  @override
  State<FirstReview> createState() => _FirstReviewState();
}

class _FirstReviewState extends State<FirstReview> {
  getData() async {
    final surveyP = Provider.of<SurveyProvider>(context, listen: false);
    await surveyP.getsurvey();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final surveyP = Provider.of<SurveyProvider>(context, listen: true);

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
                  surveyP.stars=rating;
                },
              ),
            ),
              Padding(
                padding:  EdgeInsets.only(top: mediaQueryHeight*0.15),
                child:
                Text(
                  'Did you face any issues?',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),),
              Text(
                ' هل واجهت اي صعوبات ؟',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),

        Padding(
           padding: EdgeInsets.only(top: mediaQueryHeight * 0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SecondReview()));
                    },
                    child:
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.25,
                          child: Center(
                            child: Text(
                              'Yes/نعم',
                              style: TextStyle(color: Colors.black,fontSize: 25),
                            ),
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
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FourthReview()));
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.23,
                  child: Center(
                    child: Text(
                      'No/لا',
                      style: TextStyle(color: Colors.black,fontSize: 25),
                    ),
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
            ],
          ),
        ),
              // Padding(
              //   padding: EdgeInsets.only(top: mediaQueryHeight * 0.1),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       Navigator.of(context).push(MaterialPageRoute(
              //           builder: (context) => SecondReview()));
              //     },
              //     child: SizedBox(
              //       width: mediaQueryWidth*0.15,
              //       child: Row(
              //         children: [
              //           Text(
              //             'Ok',
              //             style: TextStyle(color: Colors.black,fontSize: 25),
              //           ),
              //           Icon(Icons.check, color: Colors.black,)
              //         ],
              //       ),
              //     ),
              //     style: ButtonStyle(
              //         shape: MaterialStateProperty.all(
              //             const RoundedRectangleBorder(
              //                 borderRadius:
              //                 BorderRadius.all(Radius.circular(15)))),
              //         backgroundColor: MaterialStateProperty.all(
              //             Colors.white)),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
