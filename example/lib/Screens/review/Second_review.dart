import 'package:CaterMe/Screens/Review/Third_review.dart';
import 'package:CaterMe/Screens/review/Fourth_review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Providers/surveyProvder.dart';
import '../../Providers/user.dart';
import '../../language/language.dart';

class SecondReview extends StatefulWidget {

  @override
  State<SecondReview> createState() => _SecondReviewState();
}

class _SecondReviewState extends State<SecondReview> {

  String language;
  getData() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    setState(() {

      language = sh.getString("locale");
    });
  }
  @override
  void initState() {

    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final survey = Provider.of<SurveyProvider>(context, listen: true);
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    var mediaQueryWidth = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<UserProvider>(context, listen: true);

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
            children: [
              Padding(
                padding: EdgeInsets.only(top: mediaQueryHeight * 0.01),
                child:
                language == "en" ?
                Text(
                  'What do we need to improve ?',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ):Text(
                  '? What do we need to improve',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )
                ,
              ),
              Text(
                ' كيف يمكننا تحسين تجربتك؟ ',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: mediaQueryWidth * 0.1,
                    vertical: mediaQueryHeight * 0.05),
                child: Column(
                  children: [
                    Container(
                      width: mediaQueryWidth,
                      height: mediaQueryHeight / 1.8,
                      child: ListView.builder(
                        itemCount: survey.listsurvey.length,
                        itemBuilder: (context, index) {

                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: mediaQueryHeight * 0.01),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: mediaQueryHeight * 0.015,
                              ),
                              child: InkWell(
                                onTap: () {
           survey.changelistid(index);
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: mediaQueryWidth * 0.05),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Center(
                                                  child: Text(
                                                    survey.listsurvey[index].title,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: survey
                                                                .listsurvey[index]
                                                                .isChecked
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                ),
                                              ),

                                              survey.listsurvey[index].isChecked
                                                  ?  Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child:
                                                RatingBar.builder(
                                                  itemSize: 30,
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
                                                 survey.updaterating(index, rating);
                                                  },
                                                ),
                                              ):Container(),
                                            ],

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: survey.listsurvey[index].isChecked
                                          ? Theme.of(context).primaryColor
                                          : Colors.white),
                                ),
                              ),
                            ),
                          );

                        },

                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(top: mediaQueryHeight * 0.05),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FourthReview()));
            },
            child: Text('${authProvider.lg[authProvider.language]["Next"]}'
              ,
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            style: ButtonStyle(
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)))),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(
                      vertical: (mediaQueryHeight * 0.074) * 0.3,
                      horizontal: (mediaQueryWidth * 0.3)),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.white)),
          ),
        ),
      ),
    );
  }
}
