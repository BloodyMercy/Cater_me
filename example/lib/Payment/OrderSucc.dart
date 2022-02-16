import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Screens/CustomAlert/alert.dart';
import 'package:CaterMe/Screens/appointment/donation.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AppointmentSuccess extends StatefulWidget {
  AppointmentSuccess();

  @override
  _AppointmentSuccessState createState() => _AppointmentSuccessState();
}

class _AppointmentSuccessState extends State<AppointmentSuccess> {
  var _key = GlobalKey<ScaffoldState>();
  final f = new DateFormat('MM/dd/yyyy hh:mm');
  AudioCache _audioCache;
//  Widget svg = SvgPicture.asset('assets/images/reset_success.svg');
  // Widget svg1 = SvgPicture.asset('assets/images/cube.svg');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // startinto();
      playaudio();
  //  inAppMessaging(context,SplashScreen());

  }
  playaudio() async{
    _audioCache = AudioCache(
      prefix: 'audio/',
      fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
    );
    _audioCache.play('car.mpeg');

  }

  @override
  Widget build(BuildContext context) {
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _serpres = Provider.of<OrderCaterProvider>(context, listen: true);

    final address = Provider.of<AdressProvider>(context, listen: true);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _key,
      backgroundColor: Colors.transparent,
      body: Container(
        height: height,
        width: width,
        color: LightColors.kLightYellow,
        child: Stack(children: [
          // Container(
          //   width: width,
          //   height: height,
          //   child: Container(
          //     height: height/3,
          //     width: width,
          //     padding: EdgeInsets.only(bottom: height/2.5),
          //     child:
          //     svg,
          //   ),
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(
                flex: 1,
              ),
              Container(
                // width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/Samlogo.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 50),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Thank you for choosing  ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                    Text(
                      "Cater me",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 70),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Details",
                      style: TextStyle(
                        color: Color(0xff8792A4),
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 100),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //color: Color(0xff9FACBD),
                    border: Border.all(
                      color: Color(0xff9FACBD),
                    )),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 25),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: width / 10,
                          height: height / 20,
                          child: Icon(
                            Icons.access_time,
                            size: 18,
                            color: Color(0xff9FACBD),
                          ),
                        ),
                        Container(
                          width: width / 5,
                          height: height / 20,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Time:",
                                style: TextStyle(
                                  color: Color(0xff9FACBD),
                                  fontFamily: 'Ubuntu',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(height: height / 30),
                            Text(
                              "${address.evendatecontroller.text}",
                              style: TextStyle(
                                color:  Color(0xff9FACBD),
                                fontSize: 12,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            Container(height: height / 150),
                            Text(
                              "${f.format(
                                DateTime.now(),
                              )}",
                              style: TextStyle(
                                color: Color(0xff00A9A5),
                                fontSize: 12,
                                fontFamily: 'Ubuntu',
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: width / 9,
                          height: height / 20,
                          child: Icon(
                            Icons.location_on_outlined,
                            size: 18,
                            color: Color(0xff9FACBD),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: width / 6,
                            height: height / 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${_serpres.value.title}",
                                  style: TextStyle(
                                    color: Color(0xff9FACBD),
                                    fontFamily: 'Ubuntu',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: width / 10,
                          height: height / 20,
                          child: Column(
                            children: [
                              _serpres.serviceId == 1
                                  ? Image.asset(
                                      ('images/CaterMe.png'),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                    )
                                  : Image.asset(
                                      'images/daberneLogo.png',
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,

                                    ),
                            ],
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _serpres.serviceId == 1
                                ? Text(
                                    'Cater me',
                                    style: TextStyle(
                                      color: Color(0xff9FACBD),
                                      fontFamily: 'Ubuntu',
                                    ),
                                  )
                                : Text('Daberni',
                                    style: TextStyle(
                                      color: Color(0xff9FACBD),
                                      fontFamily: 'Ubuntu',
                                    ))
                          ],
                        ),
                      ],
                    ),

                    Row(children: [
                      Container(
                        width: width / 10,
                        height: height / 20,
                        child: Icon(
                          FontAwesomeIcons.info,
                          size: 15,
                          color: Color(0xff9FACBD),
                        ),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('${address.eventnamecontroller.text}q',style: TextStyle(color: Color(0xff9FACBD)),),
                                Text('${address.numberofguestcontroller.text}a',style: TextStyle(color: Color(0xff9FACBD)),),
                                Text('${address.typeofeventcontroller.text}z',style: TextStyle(color: Color(0xff9FACBD)),),
                              ],
                            )
                          ]),
                    ]),
                    // Row(
                    //     children: [
                    //       Container(
                    //         width:width/10,
                    //         height: height/20,
                    //         child: Icon(Icons.person_outline_rounded,
                    //           size: 15,
                    //           color: Color(0xff9FACBD),
                    //         ),
                    //       ),
                    //       Container(
                    //         width:width/5,
                    //         height: height/20,
                    //         child:  Row(
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             Text(
                    //               "${keysLang[_user.language]!["Stylist:"]}",
                    //               style: TextStyle(
                    //                 color: Color(0xff9FACBD),
                    //                 fontFamily: 'Ubuntu',
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //
                    //       ),
                    //       Column(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(widget.prof.shopname,
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 12,
                    //               fontFamily: 'Ubuntu',
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ]
                    // ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                  width: width,
                  height: height / 13,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 25),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomDialog(
                          title: "Success",
                          description:
                          "Do You Want To Donate The Rest Of Your Food?"
                        ,
                          button1: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DonationAdded(),
                                  ),
                                      (route) => false);
                            },
                            child: Text('Donate'),
                          ),button2:  ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.grey),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Navigationbar(0),
                                ),
                                    (route) => false);
                          },
                          child: Text('No'),
                        ), oneOrtwo: true,



                        ),
                      );


                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(
                      //         builder: (context) => Navigationbar(0)),
                      //     (Route<dynamic> route) => false);
                    },
                    child: Text(
                      "Finish",
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(
                          screenHeight * 0.14,
                          screenHeight * 0.02,
                          screenHeight * 0.14,
                          screenHeight * 0.02),
                      onPrimary: const Color.fromRGBO(255, 255, 255, 1),
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  )),
              Container(
                height: height / 50,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
