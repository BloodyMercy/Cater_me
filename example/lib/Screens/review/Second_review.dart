import 'package:CaterMe/Screens/Review/Third_review.dart';
import 'package:flutter/material.dart';

class SecondReview extends StatelessWidget {
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
            children: [
              Padding(
                padding:  EdgeInsets.only(top: mediaQueryHeight*0.01),
                child: Text(
                  '2- What do we need to improve?',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              Text(
                ' كيف يمكننا تحسين تجربتك؟ *',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: mediaQueryWidth*0.1, vertical: mediaQueryHeight*0.05),
                child:Column(children: [
                  Padding(
                    padding:  EdgeInsets.only(bottom: mediaQueryHeight*0.01),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ThirdReview()));
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '  A- Website/Appالتطبيق/الموقع',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                              vertical: mediaQueryHeight * 0.015,)),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.white)),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(bottom: mediaQueryHeight*0.01),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ThirdReview()));
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '  B- Quality of order delivered جودة الطلب',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                vertical: mediaQueryHeight * 0.015,)),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.white)),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(bottom: mediaQueryHeight*0.01),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ThirdReview()));
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '  C-Delivery التوصيل',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                vertical: mediaQueryHeight * 0.015,)),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.white)),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(bottom: mediaQueryHeight*0.01),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ThirdReview()));
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '  D- Variety of gifts تنوع االهدايا',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                vertical: mediaQueryHeight * 0.015,)),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.white)),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(bottom: mediaQueryHeight*0.01),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ThirdReview()));
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '  E- Designs of arrangements تنسيقات الورد',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                vertical: mediaQueryHeight * 0.015,)),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.white)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ThirdReview()));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '  F- Customer Service خدمة العملاء',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(
                              vertical: mediaQueryHeight * 0.015,)),
                        backgroundColor: MaterialStateProperty.all(
                            Colors.white)),
                  ),
                ],)

              ),

            ],
          ),
        ),
      ),
    );
  }
}
