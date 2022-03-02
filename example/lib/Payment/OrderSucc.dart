import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/orderById_provider.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Screens/CustomAlert/alert.dart';
import 'package:CaterMe/Screens/appointment/donation.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

import '../Screens/CustomAlert/costumedialod2.dart';

class AppointmentSuccess extends StatefulWidget {
  final int id;
  AppointmentSuccess(this.id);

  @override
  _AppointmentSuccessState createState() => _AppointmentSuccessState();
}

class _AppointmentSuccessState extends State<AppointmentSuccess> {
  var _key = GlobalKey<ScaffoldState>();
  final f = new DateFormat('MM/dd/yyyy hh:mm');


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
  AudioCache _audioCache = AudioCache();
  var audio = AudioPlayer();
  playaudio() async {
    print("play audio");
    // audio.play(
    //     'https://caterme.azurewebsites.net/uploads/caterme_car_sound.mpeg');

    _audioCache = AudioCache(
      prefix: 'audio/',
      fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
    );
    if (Platform.isIOS) {
      _audioCache.fixedPlayer?.notificationService.startHeadlessService();
    }
    _audioCache.play('car.mp3').onError((error, stackTrace) {print("error audio: $error");});

  }

  @override
  Widget build(BuildContext context) {
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _serpres = Provider.of<OrderCaterProvider>(context, listen: true);

    final address = Provider.of<AdressProvider>(context, listen: true);
    final order = Provider.of<OrderByIdProvider>(context, listen: true);

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
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: _serpres.serviceId==1? AssetImage('example/images/orderTracking/sammdaberni.png'):AssetImage('example/images/orderTracking/sammcaterme.png'),
                      fit: BoxFit.contain
                  ),
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
                    // Text(
                    //   "Thank you for choosing  ",
                    //   style: TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 13,
                    //     fontWeight: FontWeight.w700,
                    //     fontFamily: 'Ubuntu',
                    //   ),
                    // ),
                    // Text(
                    //   "Cater me",
                    //   style: TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 13,
                    //     fontWeight: FontWeight.w700,
                    //     fontFamily: 'Ubuntu',
                    //   ),
                    // ),
                  ],
                ),
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(
              //       vertical: MediaQuery.of(context).size.height * 0.020),
              // ),
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
                        color: Colors.black,
                        fontFamily: 'BerlinSansFB',
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${address.eventnamecontroller.text }",
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'BerlinSansFB',
                      ),
                    ),

                    Text(
                      "${_serpres.value.title}",
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'BerlinSansFB',
                      ),
                    ),
                     Text(
                       "${address.evendatecontroller.text}",
                       style: TextStyle(
                         color: Colors.black54,
                         fontFamily: 'BerlinSansFB',
                       ),
                     ),
                     Text(
                       "${address.DailyDatecontroller.text}",
                       style: TextStyle(
                         color: Colors.black54,
                         fontFamily: 'BerlinSansFB',
                       ),
                     ),


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
                        builder: (BuildContext context) => CustomDialog2(
                          title: "Success",
                          description:
                              "Do You Want To Donate The Rest Of Your Food?",

                          button2: ElevatedButton(
                            style:
                            ElevatedButton.styleFrom(primary: colorCustom),
                            onPressed: () async{
                              showDialog(
                                context: this.context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return WillPopScope(
                                      onWillPop: () => Future<bool>.value(false),
                                      child: AlertDialog(
                                        title: Text("Loading..."),
                                        content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[CircularProgressIndicator()]),
                                      ));
                                },
                              );

                              await order.donate(widget.id,);

                              Navigator.pop(context);
                              if(order.check4){
                                Navigator.of(context).pop();
                              }
                              else {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => DonationAdded(),
                                    ),
                                        (route) => false);
                              }




                            },
                            child: Text('Done'),
                          ),
                          oneOrtwo: true,
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
                        fontFamily: 'BerlinSansFB',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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
