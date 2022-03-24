import 'package:CaterMe/Screens/Review/Third_review.dart';
import 'package:CaterMe/Screens/review/Fourth_review.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/surveyProvder.dart';

class SecondReview extends StatefulWidget {
  @override
  State<SecondReview> createState() => _SecondReviewState();
}

class _SecondReviewState extends State<SecondReview> {
  @override
  Widget build(BuildContext context) {
    final survey = Provider.of<SurveyProvider>(context, listen: true);
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
            children: [
              Padding(
                padding: EdgeInsets.only(top: mediaQueryHeight * 0.01),
                child: Text(
                  'What do we need to improve?',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              Text(
                ' كيف يمكننا تحسين تجربتك؟ *',
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
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if(survey.listsurvey[index].isChecked){
                                      survey.feedbackoptionid
                                          .remove(survey.listsurvey[index].id);
                                      survey.listsurvey[index].isChecked=false;
                                    }
                                    else{
                                      survey.feedbackoptionid
                                          .add(survey.listsurvey[index].id);
                                      survey.listsurvey[index].isChecked=true;
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:  EdgeInsets.only(left: mediaQueryWidth*0.05),
                                        child: Text(
                                          survey.listsurvey[index].title,
                                          style: TextStyle(color: survey.listsurvey[index].isChecked? Colors.white: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)))),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(
                                      vertical: mediaQueryHeight * 0.015,
                                    )),
                                    backgroundColor: survey.listsurvey[index].isChecked?  MaterialStateProperty.all(Theme.of(context).primaryColor): MaterialStateProperty.all(
                                        Colors.white)),
                              ),
                            );
                          },
                        ),
                      ),

                    ],
                  )),
            ],
          ),
        ),

    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:  Padding(
          padding:  EdgeInsets.only(top:mediaQueryHeight*0.05),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FourthReview()));
            },
            child: Text(
              'Next',
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
                      horizontal: (mediaQueryWidth * 0.3)),
                ),
                backgroundColor: MaterialStateProperty.all(
                    Colors.white)),
          ),
        ),
      ),
    );
  }
}
