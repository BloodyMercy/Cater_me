import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../NavigationBar/navigation_bar.dart';
import '../../Providers/surveyProvder.dart';
import '../../Providers/user.dart';
import '../../language/language.dart';
import '../../widgets/homepage.dart';

class FourthReview extends StatefulWidget {
  @override
  State<FourthReview> createState() => _FourthReviewState();
}

class _FourthReviewState extends State<FourthReview> {
  @override
  bool loading = false;


  @override
  void initState() {

    super.initState();
  }

  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    var mediaQueryWidth = MediaQuery.of(context).size.width;
    final surveyP = Provider.of<SurveyProvider>(context, listen: true);
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
                padding: EdgeInsets.only(top: mediaQueryHeight * 0.05),
                child: Text(
                  'Complaints and suggestions',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              Text(
                'الاقتراحات والشكاوى',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: mediaQueryHeight * 0.1,
                    horizontal: mediaQueryWidth * 0.05),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: '${authProvider.lg[authProvider.language]["Type your answer here..."]}'
                    ,
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.white10,
                        width: 2.0,
                      ),
                    ),
                  ),
                  controller: surveyP.comment,
                ),
              ),
             !loading? ElevatedButton(
                onPressed: () async{
                  setState(() {
                    loading = true;
                  });
              // var submit = await   surveyP.postsurvey();
               await  surveyP.postsurvey();
                 Navigator.of(context).pop();
                 setState(() {
                   loading = false;
                 });

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Navigationbar(0),
                      ));

                },
                child: Text('${authProvider.lg[authProvider.language]["Submit"]}'
                  ,
                  style: TextStyle(color: Colors.black, fontSize: 25),
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
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
              ):CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
