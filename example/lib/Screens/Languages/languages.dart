import 'package:flutter/material.dart';

class Languages extends StatefulWidget {
  const Languages({Key key}) : super(key: key);

  @override
  _LanguagesState createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {

  @override
  Widget build(BuildContext context) {
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Center(
                  child: Image(
                    image: AssetImage('images/logo.png'),
                    // width: 800,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.12),
              Center(
                  child: Text(
                'Choose Language',
                style: TextStyle(
                    fontFamily: 'BerlinSansFB',
                    fontSize: 25,
                    color: Theme.of(context).primaryColor),
              )),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.15),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(120, 60),
                            primary:
                                Theme.of(context).primaryColor
                                ,
                          ),
                          onPressed: () {

                          },
                          child: Container(
                            child: Text(
                              'English',
                              style: TextStyle(
                                  fontFamily: 'BerlinSansFB',
                                  color:
                                     Colors.white ),
                            ),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(120, 60),
                            primary:
                                 Theme.of(context).primaryColor
                                ,
                          ),
                          onPressed: () {

                          },
                          child: Container(
                            child: Text(
                              'Arabic',
                              style: TextStyle(
                                  fontFamily: 'BerlinSansFB',
                                  color: Colors.white ),
                            ),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
