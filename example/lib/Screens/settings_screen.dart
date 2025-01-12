import 'dart:io';

import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/Screens/CustomAlert/alert.dart';
import 'package:CaterMe/Screens/Terms_and_Conditions/Terms_and_Conditions.dart';
import 'package:CaterMe/Screens/add_friend_screen.dart';
import 'package:CaterMe/Screens/addresses_settings_screen.dart';
import 'package:CaterMe/Screens/auth/reset_password_screen.dart';
import 'package:CaterMe/Screens/auth/signup_screen.dart';
import 'package:CaterMe/Screens/saved_orders.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/main.dart';
import 'package:CaterMe/widgets/Account_info.dart';
import 'package:CaterMe/widgets/Payment/credit_cards_settings.dart';
import 'package:CaterMe/widgets/Personal_info.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../Providers/occasion.dart';
import '../Providers/packages.dart';
import '../SplachScreen.dart';
import '../language/language.dart';
import '../widgets/contact_us.dart';
import 'auth/login_screen.dart';
import 'check out/SetupItems.dart';
import 'occasion/theme/colors/light_colors.dart';

class TABBar extends StatefulWidget {
  const TABBar({Key key}) : super(key: key);

  @override
  _TABBarState createState() => _TABBarState();
}

class _TABBarState extends State<TABBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPersonalInfo();
    // getdata();
    //  getLanguage();
  }

  getLanguage() async {
    final user = Provider.of<UserProvider>(context, listen: false);
    await user.getLanguage();
    // print(user.lg[user.language]["Home"]);
    //  user.status=Status.Authenticated;
  }

  getPersonalInfo() async {
    final personalInfo =
        await Provider.of<UserProvider>(context, listen: false);
    await personalInfo.getLanguage();
    //personalInfo.loading = true;
    await personalInfo.getPersonalInfo();
    // personalInfo.loading = false;
  }

  File image;

  // ignore: non_constant_identifier_names
  Future PickImage(ImageSource source) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return 'null';
      final imageTemporary = File(image.path);
      pref.setString("imageUrl", File(image.path).path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed : $e');
    }
  }

  String showname = '';
  String phoneNumb = '';
  String imageprof = "";
  bool loadingImage = false;

  setData(String imageUrl) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      imageprof = pref.setString('imageUrl', imageUrl) as String;
    });
  }

  getdata() async {
    SharedPreferences image = await SharedPreferences.getInstance();
    setState(() {
      imageprof = image.getString('imageUrl') ?? "";
      showname = image.getString('name') ?? '';
      phoneNumb = image.getString('phoneNumber') ?? '';
    });
    print("image ${imageprof}");
  }

  // TextEditingController controller = TextEditingController();
  bool loadingimage = false;

  @override
  Widget build(BuildContext context) {
    // final updateImage = Provider.of<UserProvider>(context, listen: true);
    final personalInfo = Provider.of<UserProvider>(context, listen: true);
    var _mediaQueryText = MediaQuery.of(context).size.height;
    var _mediaWidth = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    final mediaQuery = MediaQuery.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: LightColors.kLightYellow,
            height: mediaQuery.size.height + 100,
            child: Column(
              children: [
                personalInfo.status == Status.Authenticated
                    ? Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          leading: const Icon(
                                            Icons.camera,
                                            color:
                                                Color.fromRGBO(63, 85, 33, 1),
                                          ),
                                          title: Text(
                                            '${personalInfo.lg[personalInfo.language]["Camera"]}',
                                            style: TextStyle(
                                              fontFamily: 'BerlinSansFB',
                                              fontSize: 14,
                                              color:
                                                  Color.fromRGBO(63, 85, 33, 1),
                                            ),
                                          ),
                                          onTap: () async {
                                            Navigator.pop(context);
                                            setState(() {
                                              loadingImage = true;
                                            });
                                            await PickImage(ImageSource.camera);
                                            await personalInfo
                                                .updateProfile(image);
                                            setState(() {
                                              loadingImage = false;
                                            });
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(
                                            Icons.image,
                                            color:
                                                Color.fromRGBO(63, 85, 33, 1),
                                          ),
                                          title: Text(
                                            '${personalInfo.lg[personalInfo.language]["Gallery"]}',
                                            style: TextStyle(
                                              fontFamily: 'BerlinSansFB',
                                              fontSize: 14,
                                              color:
                                                  Color.fromRGBO(63, 85, 33, 1),
                                            ),
                                          ),
                                          onTap: () async {
                                            Navigator.pop(context);
                                            setState(() {
                                              loadingImage = true;
                                            });
                                            await PickImage(
                                                ImageSource.gallery);
                                            await personalInfo
                                                .updateProfile(image);
                                            setState(() {
                                              loadingImage = false;
                                            });
                                            //    personalInfo.notifyListeners();
                                            // if (a != "") {
                                            //   setState(() {
                                            //     imageprof = a;
                                            //   });
                                            // }

                                            // personalInfo.loading=false;
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.05,
                                  bottom: height * 0.03,
                                  left: width * 0.1,
                                  right: width * 0.1),
                              child: ClipOval(
                                child: Container(
                                  color: Colors.white,
                                  child: Image.network(
                                      personalInfo.personalInfo.imageUrl ,
                                    errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                                      return Icon(Icons.do_not_disturb,color:Colors.red);
                                    },
                                    loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Padding(
                                        padding: const EdgeInsets.all(25.0),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Color.fromRGBO(63, 85, 33, 1),

                                            value: loadingProgress.expectedTotalBytes != null ?
                                            loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),

),
                                ),
                              ),
                            ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  personalInfo.personalInfo.name,
                                  style: TextStyle(
                                      // color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      // fontFamily: 'Geomanist',
                                      fontSize: 19),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: personalInfo.personalInfo.phoneNumber,
                                    style: TextStyle(
                                        //  color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        // fontFamily: 'Geomanist',
                                        fontSize: 17),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                              backgroundColor: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20.0)),
                                              child: Stack(
                                                overflow: Overflow.visible,
                                                alignment: Alignment.topCenter,
                                                children: [
                                                  Container(
                                                    height: MediaQuery.of(context).size.height *
                                                        0.30,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                              0.09,
                                                          left: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                              0.05,
                                                          right: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                              0.05),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            '${authProvider.lg[authProvider.language]["Sad to see you leave"]}',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 20,
                                                                color: Colors.white),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                top: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.02),
                                                            child: Divider(
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                top: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.01),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                      MediaQuery.of(context)
                                                                          .size
                                                                          .width *
                                                                          0.05),
                                                                  child: TextButton(
                                                                    child: Text(
                                                                      '${authProvider.lg[authProvider.language]["Logout"]}',
                                                                      style: TextStyle(
                                                                          color: Colors.white),
                                                                    ),
                                                                    onPressed: () async {
                                                                      final SharedPreferences
                                                                      sharedPreferences =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                      final occa = Provider.of<
                                                                          OccasionProvider>(
                                                                          context,
                                                                          listen: false);
                                                                      occa.all = [];
                                                                      personalInfo.status =
                                                                          Status.Unauthenticated;
                                                                      // sharedPreferences.remove('Email');
                                                                      //  sharedPreferences.remove('Password');
                                                                      personalInfo
                                                                          .clearAllTextController();
                                                                      bool a = sharedPreferences
                                                                          .getBool("startintro");
                                                                      bool aw = sharedPreferences
                                                                          .getBool("wlkdone") ??
                                                                          false;
                                                                      String l = sharedPreferences
                                                                          .getString("locale") ??
                                                                          "en";
                                                                      sharedPreferences.clear();
                                                                      sharedPreferences.setBool(
                                                                          "startintro", a);
                                                                      sharedPreferences.setBool(
                                                                          "wlkdone", aw);
                                                                      sharedPreferences.setString(
                                                                          "locale", l);
                                                                      Navigator.of(context).pop();

                                                                      Navigator.of(context)
                                                                          .pushAndRemoveUntil(
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                Navigationbar(0),
                                                                          ),
                                                                              (route) => false);
                                                                    },
                                                                  ),
                                                                ),
                                                                Divider(
                                                                  color: Colors.white,
                                                                ),
                                                                TextButton(
                                                                  child: Text(
                                                                    '${authProvider.lg[authProvider.language]["No"]}',
                                                                    style: TextStyle(
                                                                        color: Colors.white),
                                                                  ),
                                                                  onPressed: () {
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: -MediaQuery.of(context).size.height *
                                                          0.06,
                                                      child: Image.asset(
                                                        'images/Logoicon.png',
                                                        height: 100,
                                                      )),
                                                ],
                                              ));
                                            CustomDialog(
                                            title:
                                                '${personalInfo.lg[personalInfo.language]["Sad to see you leave"]}',
                                            description: "",
                                            oneOrtwo: true,
                                            button2: ElevatedButton(
                                              onPressed: () async {
                                                final SharedPreferences
                                                    sharedPreferences =
                                                    await SharedPreferences
                                                        .getInstance();
                                                final occa = Provider.of<
                                                        OccasionProvider>(
                                                    context,
                                                    listen: false);
                                                occa.all = [];
                                                personalInfo.status =
                                                    Status.Unauthenticated;
                                                // sharedPreferences.remove('Email');
                                                //  sharedPreferences.remove('Password');
                                                personalInfo
                                                    .clearAllTextController();
                                                bool a = sharedPreferences
                                                    .getBool("startintro");
                                                bool aw = sharedPreferences
                                                        .getBool("wlkdone") ??
                                                    false;
                                                String l = sharedPreferences
                                                        .getString("locale") ??
                                                    "en";
                                                sharedPreferences.clear();
                                                sharedPreferences.setBool(
                                                    "startintro", a);
                                                sharedPreferences.setBool(
                                                    "wlkdone", aw);
                                                sharedPreferences.setString(
                                                    "locale", l);
                                                Navigator.of(context).pop();

                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              Navigationbar(0),
                                                        ),
                                                        (route) => false);
                                              },
                                              child: Text(
                                                '${personalInfo.lg[personalInfo.language]["Logout"]}',
                                                style: TextStyle(
                                                    fontFamily: 'BerlinSansFB'),
                                              ),
                                            ),
                                            button1: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                  '${personalInfo.lg[personalInfo.language]["No"]}',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'BerlinSansFB')),
                                            ),
                                          );
                                        });
                                  },
                                  child: Text(
                                    '${personalInfo.lg[personalInfo.language]["Logout"]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Geomanist',
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(63, 85, 33, 1),
                                    side: BorderSide(
                                      color: Color.fromRGBO(63, 85, 33, 1),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Image.asset(
                        "images/CaterMe.png",
                        height: 100,
                      ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                personalInfo.status == Status.Authenticated
                    ? Container()
                    : ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          '${personalInfo.lg[personalInfo.language]["Log In"]}',
                        ),
                      ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Expanded(
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      personalInfo.status == Status.Authenticated
                          ? GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PersonalInfo(),
                                  ),
                                );
                              },
                              child: Card(
                                color: const Color.fromARGB(206, 255, 255, 255),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        mediaQuery.size.width *
                                                            0.03,
                                                  ),
                                                  Icon(
                                                    FontAwesomeIcons.solidUser,
                                                    size: 20,
                                                    //Icon Size
                                                    color: Color(
                                                        0xFF3F5521), //Color Of Icon
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        mediaQuery.size.width *
                                                            0.05,
                                                  ),
                                                  Text(
                                                    '${personalInfo.lg[personalInfo.language]["Personal Info"]}',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF3F5521),
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'BerlinSansFB',
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              ),
                                              Row(children: [
                                                Icon(
                                                  Icons.chevron_right,
                                                  color: Color(0xFF3F5521),
                                                ),
                                                SizedBox(
                                                  width: mediaQuery.size.width *
                                                      0.03,
                                                ),
                                              ]),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      personalInfo.status == Status.Authenticated
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: GestureDetector(
                                onTap: () {
                                  personalInfo.clearAllTextController();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AccountInfo(),
                                    ),
                                  );
                                },
                                child: Card(
                                  color:
                                      const Color.fromARGB(206, 255, 255, 255),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: mediaQuery.size.width *
                                                      0.03,
                                                ),
                                                Icon(
                                                  Icons.vpn_key_sharp,
                                                  size: 20, //Icon Size
                                                  color: Color(
                                                      0xFF3F5521), //Color Of Icon
                                                ),
                                                SizedBox(
                                                  width: mediaQuery.size.width *
                                                      0.05,
                                                ),
                                                Text(
                                                  '${personalInfo.lg[personalInfo.language]["Reset Password"]}',
                                                  style: TextStyle(
                                                      color: Color(0xFF3F5521),
                                                      fontSize: 20,
                                                      fontFamily:
                                                          'BerlinSansFB',
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.chevron_right,
                                                  color: Color(0xFF3F5521),
                                                ),
                                                SizedBox(
                                                  width: mediaQuery.size.width *
                                                      0.03,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      personalInfo.status == Status.Authenticated
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AddAddressSettingsScreen(),
                                    ),
                                  );
                                },
                                child: Card(
                                  color:
                                      const Color.fromARGB(206, 255, 255, 255),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width:
                                                      mediaQuery.size.width *
                                                          0.03,
                                                ),
                                                Icon(
                                                  FontAwesomeIcons.building,
                                                  size: 20, //Icon Size
                                                  color: Color(
                                                      0xFF3F5521), //Color Of Icon
                                                ),
                                                SizedBox(
                                                  width:
                                                      mediaQuery.size.width *
                                                          0.05,
                                                ),
                                                Text(
                                                  '${personalInfo.lg[personalInfo.language]["My Addresses"]}',
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xFF3F5521),
                                                      fontSize: 20,
                                                      fontFamily:
                                                          'BerlinSansFB',
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                            Row(children: [
                                              Icon(
                                                Icons.chevron_right,
                                                color: Color(0xFF3F5521),
                                              ),
                                              SizedBox(
                                                width: mediaQuery.size.width *
                                                    0.03,
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),

                                      // Divider(
                                      //   thickness: 1,

                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: GestureDetector(  behavior: HitTestBehavior.translucent,
                                      //     onTap: () {
                                      //       Navigator.of(context).push(
                                      //         MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               SavedOrders(),
                                      //         ),
                                      //       );
                                      //     },
                                      //     child: Row(
                                      //       mainAxisAlignment:
                                      //           MainAxisAlignment.spaceBetween,
                                      //       children: [
                                      //         Row(
                                      //           children: [
                                      //             SizedBox(
                                      //               width: mediaQuery.size.width *
                                      //                   0.03,
                                      //             ),
                                      //             Icon(
                                      //               Icons.backpack,size: 20,
                                      //                 color: Color(0xFF3F5521),
                                      //
                                      //
                                      //             ),
                                      //             SizedBox(
                                      //               width: mediaQuery.size.width *
                                      //                   0.05,
                                      //             ),
                                      //             Text(
                                      //               '${authProvider.lg[personalInfo.language]["Saved Orders"]}',
                                      //               style: TextStyle(
                                      //                   color: Color(0xFF3F5521),
                                      //                   fontSize: 20,
                                      //                   fontFamily:
                                      //                       'BerlinSansFB',
                                      //                   fontWeight:
                                      //                       FontWeight.normal),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //         Row(
                                      //           children: [
                                      //             Icon(
                                      //               Icons.chevron_right,
                                      //               color: Color(0xFF3F5521),
                                      //             ),
                                      //             SizedBox(
                                      //               width: mediaQuery.size.width *
                                      //                   0.03,
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      personalInfo.status == Status.Authenticated
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: GestureDetector(
    onTap: () {
    Navigator.of(context).push(
    MaterialPageRoute(
    builder: (context) =>
    CreditCardsSettings(),
    ),
    );
    },
                                child: Card(
                                  color:
                                      const Color.fromARGB(206, 255, 255, 255),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: mediaQuery.size.width *
                                                      0.03,
                                                ),
                                                Icon(
                                                  FontAwesomeIcons.creditCard,
                                                  size: 20, //Icon Size
                                                  color: Color(
                                                      0xFF3F5521), //Color Of Icon
                                                ),
                                                SizedBox(
                                                  width: mediaQuery.size.width *
                                                      0.05,
                                                ),
                                                Text(
                                                  '${personalInfo.lg[personalInfo.language]["My Credit Cards"]}',
                                                  style: TextStyle(
                                                      color: Color(0xFF3F5521),
                                                      fontSize: 20,
                                                      fontFamily:
                                                          'BerlinSansFB',
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.chevron_right,
                                                  color: Color(0xFF3F5521),
                                                ),
                                                SizedBox(
                                                  width: mediaQuery.size.width *
                                                      0.03,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      personalInfo.status == Status.Authenticated
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddFriendScreen(),
                                    ),
                                  );
                                },
                                child: Card(
                                  color:
                                      const Color.fromARGB(206, 255, 255, 255),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: mediaQuery.size.width *
                                                      0.03,
                                                ),
                                                Icon(
                                                  FontAwesomeIcons.userPlus,
                                                  size: 20, //Icon Size
                                                  color: Color(
                                                      0xFF3F5521), //Color Of Icon
                                                ),
                                                SizedBox(
                                                  width: mediaQuery.size.width *
                                                      0.05,
                                                ),
                                                Text(
                                                  '${personalInfo.lg[personalInfo.language]["My Friends"]}',
                                                  style: TextStyle(
                                                      color: Color(0xFF3F5521),
                                                      fontSize: 20,
                                                      fontFamily:
                                                          'BerlinSansFB',
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.chevron_right,
                                                  color: Color(0xFF3F5521),
                                                ),
                                                SizedBox(
                                                  width: mediaQuery.size.width *
                                                      0.03,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: GestureDetector(
                          onTap: () {
                            if (personalInfo.language == "en") {
                              showDialog(
                                  context: context,
                                  builder: (_) => Dialog(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Stack(
                                        overflow: Overflow.visible,
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Container(
                                            height:
                                                mediaQuery.size.height * 0.25,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: mediaQuery.size.height *
                                                      0.09,
                                                  left: mediaQuery.size.width *
                                                      0.05,
                                                  right: mediaQuery.size.width *
                                                      0.05),
                                              child: Column(
                                                children: [
                                                  Text(
                                                      '${personalInfo.lg[personalInfo.language]["Choose language"]}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 19,
                                                      )),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: mediaQuery
                                                                .size.height *
                                                            0.02),
                                                    child: Divider(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: mediaQuery
                                                                .size.height *
                                                            0.01),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      mediaQuery
                                                                              .size
                                                                              .width *
                                                                          0.05),
                                                          child: TextButton(
                                                            child: Text(
                                                              'العربيّة',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              personalInfo
                                                                      .language =
                                                                  "ar";
                                                              SharedPreferences
                                                                  _prefs =
                                                                  await SharedPreferences
                                                                      .getInstance();
                                                              _prefs.setString(
                                                                  "locale",
                                                                  "ar");
                                                              MyApp.setLocale(
                                                                  context,
                                                                  Locale("ar",
                                                                      "AE"));
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              Navigator.of(
                                                                      context)
                                                                  .pushAndRemoveUntil(
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                Navigationbar(0),
                                                                      ),
                                                                      (Route<dynamic>
                                                                              route) =>
                                                                          false);
                                                              // AppLocalizations.of(context)!.locale.toString()

                                                              // .language="ar";
                                                            },
                                                          ),
                                                        ),
                                                        Divider(
                                                          color: Colors.white,
                                                        ),
                                                        TextButton(
                                                            child: Text(
                                                              '${personalInfo.lg[personalInfo.language]["Close"]}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              top: -mediaQuery.size.height *
                                                  0.06,
                                              child: Image.asset(
                                                'images/Logoicon.png',
                                                height: 100,
                                              )),
                                        ],
                                      ))
                                  //     AlertDialog(
                                  //   shape: const RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.all(
                                  //       Radius.circular(25),
                                  //     ),
                                  //   ),
                                  //   title: Center(
                                  //     child: Text('${personalInfo.lg[personalInfo.language]["Choose language"]}',
                                  //         style: TextStyle(
                                  //           color: Colors.black,
                                  //           fontSize: 19,
                                  //         )),
                                  //   ),
                                  //   actions: [
                                  //     Padding(
                                  //       padding: EdgeInsets.symmetric(
                                  //           horizontal: _mediaWidth * 0.08),
                                  //       child: Row(
                                  //         mainAxisAlignment:
                                  //         MainAxisAlignment
                                  //             .spaceBetween,
                                  //         children: [
                                  //           TextButton(
                                  //             child: Text('العربيّة'),
                                  //             onPressed: () async {
                                  //               personalInfo.language =
                                  //               "ar";
                                  //               SharedPreferences _prefs =
                                  //               await SharedPreferences
                                  //                   .getInstance();
                                  //               _prefs.setString(
                                  //                   "locale", "ar");
                                  //               MyApp.setLocale(context,
                                  //                   Locale("ar", "AE"));
                                  //                Navigator.of(context).pop();
                                  //               Navigator.of(context)
                                  //                   .pushAndRemoveUntil(
                                  //                   MaterialPageRoute(
                                  //                     builder: (context) =>
                                  //                         Navigationbar(0),
                                  //                   ),
                                  //                       (Route<dynamic>
                                  //                   route) =>
                                  //                   false);
                                  //               // AppLocalizations.of(context)!.locale.toString()
                                  //
                                  //               // .language="ar";
                                  //             },
                                  //           ),
                                  //           TextButton(
                                  //               child: Text(
                                  //                 '${personalInfo.lg[personalInfo.language]["Close"]}',
                                  //               ),
                                  //               onPressed: (){
                                  //                 Navigator.of(context).pop();
                                  //               }),
                                  //         ],
                                  //       ),
                                  //     )
                                  //   ],
                                  //
                                  //
                                  // ))
                                  );
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (_) => Dialog(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Stack(
                                        overflow: Overflow.visible,
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Container(
                                            height:
                                                mediaQuery.size.height * 0.25,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: mediaQuery.size.height *
                                                      0.09,
                                                  left: mediaQuery.size.width *
                                                      0.05,
                                                  right: mediaQuery.size.width *
                                                      0.05),
                                              child: Column(
                                                children: [
                                                  Text(
                                                      '${personalInfo.lg[personalInfo.language]["Choose language"]}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 19,
                                                      )),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: mediaQuery
                                                                .size.height *
                                                            0.02),
                                                    child: Divider(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: mediaQuery
                                                                .size.height *
                                                            0.01),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      mediaQuery
                                                                              .size
                                                                              .width *
                                                                          0.05),
                                                          child: TextButton(
                                                              child: Text(
                                                                'English',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                personalInfo
                                                                        .language =
                                                                    "en";
                                                                SharedPreferences
                                                                    _prefs =
                                                                    await SharedPreferences
                                                                        .getInstance();
                                                                _prefs.setString(
                                                                    "locale",
                                                                    "en");
                                                                MyApp.setLocale(
                                                                    context,
                                                                    Locale("en",
                                                                        "US"));
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                Navigator.of(
                                                                        context)
                                                                    .pushAndRemoveUntil(
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              Navigationbar(0),
                                                                        ),
                                                                        (Route<dynamic>
                                                                                route) =>
                                                                            false);
                                                                // AppLocalizations.of(context)!.locale.toString()

                                                                // .language="ar";                                              },
                                                              }),
                                                        ),
                                                        Divider(
                                                          color: Colors.white,
                                                        ),
                                                        TextButton(
                                                            child: Text(
                                                              '${personalInfo.lg[personalInfo.language]["Close"]}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              top: -mediaQuery.size.height *
                                                  0.06,
                                              child: Image.asset(
                                                'images/Logoicon.png',
                                                height: 100,
                                              )),
                                        ],
                                      ))
                                  //     AlertDialog(
                                  //   shape: const RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.all(
                                  //       Radius.circular(25),
                                  //     ),
                                  //   ),
                                  //   title: Center(
                                  //     child: Text('${personalInfo.lg[personalInfo.language]["Choose language"]}',
                                  //         style: TextStyle(
                                  //           color: Colors.black,
                                  //           fontSize: 19,
                                  //         )),
                                  //   ),
                                  //   actions: [
                                  //     Padding(
                                  //       padding: EdgeInsets.symmetric(
                                  //           horizontal: _mediaWidth * 0.08),
                                  //       child: Row(
                                  //         mainAxisAlignment:
                                  //         MainAxisAlignment
                                  //             .spaceBetween,
                                  //         children: [
                                  //           TextButton(
                                  //               child: Text(
                                  //                 'English',
                                  //               ),
                                  //               onPressed: () async {
                                  //                 personalInfo.language =
                                  //                 "en";
                                  //                 SharedPreferences _prefs =
                                  //                 await SharedPreferences
                                  //                     .getInstance();
                                  //                 _prefs.setString(
                                  //                     "locale", "en");
                                  //                 MyApp.setLocale(context,
                                  //                     Locale("en", "US"));
                                  //                 Navigator.of(context).pop();
                                  //                 Navigator.of(context)
                                  //                     .pushAndRemoveUntil(
                                  //                     MaterialPageRoute(
                                  //                       builder:
                                  //                           (context) =>
                                  //                               Navigationbar(0),
                                  //                     ),
                                  //                         (Route<dynamic>
                                  //                     route) =>
                                  //                     false);
                                  //                 // AppLocalizations.of(context)!.locale.toString()
                                  //
                                  //                 // .language="ar";                                              },
                                  //               }),
                                  //           TextButton(
                                  //               child: Text(
                                  //                 '${personalInfo.lg[personalInfo.language]["Close"]}',
                                  //               ),
                                  //               onPressed: (){
                                  //                 Navigator.of(context).pop();
                                  //               }),
                                  //         ],
                                  //       ),
                                  //     )
                                  //   ],
                                  // )
                                  );
                            }
                          },
                          child: Card(
                            color: const Color.fromARGB(206, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: GestureDetector(
                              onTap: () {
                                if (personalInfo.language == "en") {
                                  showDialog(
                                      context: context,
                                      builder: (_) => Dialog(
                                          backgroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          child: Stack(
                                            overflow: Overflow.visible,
                                            alignment: Alignment.topCenter,
                                            children: [
                                              Container(
                                                height: mediaQuery.size.height *
                                                    0.25,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: mediaQuery
                                                              .size.height *
                                                          0.09,
                                                      left: mediaQuery
                                                              .size.width *
                                                          0.05,
                                                      right: mediaQuery
                                                              .size.width *
                                                          0.05),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                          '${personalInfo.lg[personalInfo.language]["Choose language"]}',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 19,
                                                          )),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top: mediaQuery.size
                                                                    .height *
                                                                0.02),
                                                        child: Divider(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top: mediaQuery.size
                                                                    .height *
                                                                0.01),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      mediaQuery
                                                                              .size
                                                                              .width *
                                                                          0.05),
                                                              child: TextButton(
                                                                child: Text(
                                                                  'العربيّة',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  personalInfo
                                                                          .language =
                                                                      "ar";
                                                                  SharedPreferences
                                                                      _prefs =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  _prefs.setString(
                                                                      "locale",
                                                                      "ar");
                                                                  MyApp.setLocale(
                                                                      context,
                                                                      Locale(
                                                                          "ar",
                                                                          "AE"));
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pushAndRemoveUntil(
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                Navigationbar(0),
                                                                          ),
                                                                          (Route<dynamic> route) =>
                                                                              false);
                                                                  // AppLocalizations.of(context)!.locale.toString()

                                                                  // .language="ar";
                                                                },
                                                              ),
                                                            ),
                                                            Divider(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            TextButton(
                                                                child: Text(
                                                                  '${personalInfo.lg[personalInfo.language]["Close"]}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  top: -mediaQuery.size.height *
                                                      0.06,
                                                  child: Image.asset(
                                                    'images/Logoicon.png',
                                                    height: 100,
                                                  )),
                                            ],
                                          ))
                                      // AlertDialog(
                                      //   shape: const RoundedRectangleBorder(
                                      //     borderRadius: BorderRadius.all(
                                      //       Radius.circular(25),
                                      //     ),
                                      //   ),
                                      //   title: Center(
                                      //     child: Text('${personalInfo.lg[personalInfo.language]["Choose language"]}',
                                      //         style: TextStyle(
                                      //           color: Colors.black,
                                      //           fontSize: 19,
                                      //         )),
                                      //   ),
                                      //   actions: [
                                      //     Padding(
                                      //       padding: EdgeInsets.symmetric(
                                      //           horizontal: _mediaWidth * 0.08),
                                      //       child: Row(
                                      //         mainAxisAlignment:
                                      //             MainAxisAlignment
                                      //                 .spaceBetween,
                                      //         children: [
                                      //           TextButton(
                                      //             child: Text('العربيّة'),
                                      //             onPressed: () async {
                                      //               personalInfo.language =
                                      //                   "ar";
                                      //               SharedPreferences _prefs =
                                      //                   await SharedPreferences
                                      //                       .getInstance();
                                      //               _prefs.setString(
                                      //                   "locale", "ar");
                                      //               MyApp.setLocale(context,
                                      //                   Locale("ar", "AE"));
                                      //               Navigator.of(context).pop();
                                      //               Navigator.of(context)
                                      //                   .pushAndRemoveUntil(
                                      //                       MaterialPageRoute(
                                      //                         builder: (context) =>
                                      //                             Navigationbar(0),
                                      //                       ),
                                      //                       (Route<dynamic>
                                      //                               route) =>
                                      //                           false);
                                      //               // AppLocalizations.of(context)!.locale.toString()
                                      //
                                      //               // .language="ar";
                                      //             },
                                      //           ),
                                      //           TextButton(
                                      //               child: Text(
                                      //                   '${personalInfo.lg[personalInfo.language]["Close"]}',
                                      //               ),
                                      //               onPressed: (){
                                      //                 Navigator.of(context).pop();
                                      //               }),
                                      //         ],
                                      //       ),
                                      //     )
                                      //   ],
                                      // )
                                      );
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) => Dialog(
                                          backgroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          child: Stack(
                                            overflow: Overflow.visible,
                                            alignment: Alignment.topCenter,
                                            children: [
                                              Container(
                                                height: mediaQuery.size.height *
                                                    0.25,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: mediaQuery
                                                              .size.height *
                                                          0.09,
                                                      left: mediaQuery
                                                              .size.width *
                                                          0.05,
                                                      right: mediaQuery
                                                              .size.width *
                                                          0.05),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                          '${personalInfo.lg[personalInfo.language]["Choose language"]}',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 19,
                                                          )),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top: mediaQuery.size
                                                                    .height *
                                                                0.02),
                                                        child: Divider(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top: mediaQuery.size
                                                                    .height *
                                                                0.01),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      mediaQuery
                                                                              .size
                                                                              .width *
                                                                          0.05),
                                                              child: TextButton(
                                                                  child: Text(
                                                                    'English',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    personalInfo
                                                                            .language =
                                                                        "en";
                                                                    SharedPreferences
                                                                        _prefs =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    _prefs.setString(
                                                                        "locale",
                                                                        "en");
                                                                    MyApp.setLocale(
                                                                        context,
                                                                        Locale(
                                                                            "en",
                                                                            "US"));
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pushAndRemoveUntil(
                                                                            MaterialPageRoute(
                                                                              builder: (context) => Navigationbar(0),
                                                                            ),
                                                                            (Route<dynamic> route) =>
                                                                                false);
                                                                    // AppLocalizations.of(context)!.locale.toString()

                                                                    // .language="ar";                                              },
                                                                  }),
                                                            ),
                                                            Divider(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            TextButton(
                                                                child: Text(
                                                                  '${personalInfo.lg[personalInfo.language]["Close"]}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  top: -mediaQuery.size.height *
                                                      0.06,
                                                  child: Image.asset(
                                                    'images/Logoicon.png',
                                                    height: 100,
                                                  )),
                                            ],
                                          ))
                                      //     AlertDialog(
                                      //   shape: const RoundedRectangleBorder(
                                      //     borderRadius: BorderRadius.all(
                                      //       Radius.circular(25),
                                      //     ),
                                      //   ),
                                      //   title: Center(
                                      //     child: Text('${personalInfo.lg[personalInfo.language]["Choose language"]}',
                                      //         style: TextStyle(
                                      //           color: Colors.black,
                                      //           fontSize: 19,
                                      //         )),
                                      //   ),
                                      //   actions: [
                                      //     Padding(
                                      //       padding: EdgeInsets.symmetric(
                                      //           horizontal: _mediaWidth * 0.08),
                                      //       child: Row(
                                      //         mainAxisAlignment:
                                      //         MainAxisAlignment
                                      //             .spaceBetween,
                                      //         children: [
                                      //           TextButton(
                                      //               child: Text(
                                      //                 'English',
                                      //               ),
                                      //               onPressed: () async {
                                      //                 personalInfo.language =
                                      //                 "en";
                                      //                 SharedPreferences _prefs =
                                      //                 await SharedPreferences
                                      //                     .getInstance();
                                      //                 _prefs.setString(
                                      //                     "locale", "en");
                                      //                 MyApp.setLocale(context,
                                      //                     Locale("en", "US"));
                                      //                 Navigator.of(context).pop();
                                      //                 Navigator.of(context)
                                      //                     .pushAndRemoveUntil(
                                      //                     MaterialPageRoute(
                                      //                       builder:
                                      //                           (context) =>
                                      //                               Navigationbar(0),
                                      //                     ),
                                      //                         (Route<dynamic>
                                      //                     route) =>
                                      //                     false);
                                      //                 // AppLocalizations.of(context)!.locale.toString()
                                      //
                                      //                 // .language="ar";                                              },
                                      //               }),
                                      //           TextButton(
                                      //               child: Text(
                                      //                 '${personalInfo.lg[personalInfo.language]["Close"]}',
                                      //               ),
                                      //               onPressed: (){
                                      //                 Navigator.of(context).pop();
                                      //               }),
                                      //         ],
                                      //       ),
                                      //     )
                                      //   ],
                                      // )
                                      );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: mediaQuery.size.width * 0.03,
                                        ),
                                        Image.asset('images/language-01.png',
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.020),
                                        // ImageIcon(AssetImage('images/language icon-01.png'),color: colorCustom,),
                                        SizedBox(
                                          width: mediaQuery.size.width * 0.05,
                                        ),
                                        Text(
                                          '${personalInfo.lg[personalInfo.language]["Language"]}',
                                          style: TextStyle(
                                              color: Color(0xFF3F5521),
                                              fontSize: 20,
                                              fontFamily: 'BerlinSansFB',
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    Row(children: [
                                      Icon(
                                        Icons.chevron_right,
                                        color: Color(0xFF3F5521),
                                      ),
                                      SizedBox(
                                        width: mediaQuery.size.width * 0.03,
                                      ),
                                    ]),
                                    // InkWell(
                                    //     onTap: () async {
                                    //       if(  personalInfo.language == "en") {
                                    //         personalInfo.language ="ar";
                                    //         SharedPreferences _prefs =
                                    //         await SharedPreferences
                                    //             .getInstance();
                                    //         _prefs.setString("locale", "ar");
                                    //         MyApp.setLocale(
                                    //             context, Locale("ar", "AE"));
                                    //         Navigator.of(context).pushAndRemoveUntil(
                                    //           MaterialPageRoute(
                                    //             builder: (context) =>
                                    //                 SplashScreen(),
                                    //           ),
                                    //
                                    //                 (Route<dynamic> route) => false   );
                                    //         // AppLocalizations.of(context)!.locale.toString()
                                    //
                                    //
                                    //         // .language="ar";
                                    //
                                    //       }
                                    //       else{
                                    //         personalInfo.language = "en";
                                    //         SharedPreferences _prefs =
                                    //         await SharedPreferences
                                    //             .getInstance();
                                    //         _prefs.setString("locale", "en");
                                    //       MyApp.setLocale(context, Locale("en", "US"));
                                    //         Navigator.of(context).pushAndRemoveUntil(
                                    //           MaterialPageRoute(
                                    //             builder: (context) =>
                                    //                 SplashScreen(),
                                    //           ),
                                    //                 (Route<dynamic> route) => false  );
                                    //         // AppLocalizations.of(context)!.locale.toString()
                                    //
                                    //
                                    //         // .language="ar";
                                    //
                                    //       }
                                    //     },
                                    //     child: Row(
                                    //       children: [
                                    //         personalInfo.language == "en"?   Text("English",
                                    //             style: TextStyle(
                                    //                 fontWeight:
                                    //                     FontWeight.normal)):Text("العربية",
                                    //             style: TextStyle(
                                    //                 fontWeight:
                                    //                 FontWeight.normal)),
                                    //         SizedBox(
                                    //           width: mediaQuery.size.width * 0.03,
                                    //         ),
                                    //       ],
                                    //     )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => WebViewExample(),
                              ),
                            );
                          },
                          child: Card(
                            color: const Color.fromARGB(206, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => WebViewExample(),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width:
                                                  mediaQuery.size.width * 0.03,
                                            ),
                                            Icon(
                                              Icons.article_rounded,
                                              size: 20, //Icon Size
                                              color: Color(
                                                  0xFF3F5521), //Color Of Icon
                                            ),
                                            SizedBox(
                                              width:
                                                  mediaQuery.size.width * 0.05,
                                            ),
                                            Text(
                                              '${personalInfo.lg[personalInfo.language]["Terms & Conditions"]}',
                                              style: TextStyle(
                                                  color: Color(0xFF3F5521),
                                                  fontSize: 20,
                                                  fontFamily: 'BerlinSansFB',
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.chevron_right,
                                              color: Color(0xFF3F5521),
                                            ),
                                            SizedBox(
                                              width:
                                                  mediaQuery.size.width * 0.03,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Contact_Us(),
                              ),
                            );
                          },
                          child: Card(
                            color: const Color.fromARGB(206, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: mediaQuery.size.width * 0.03,
                                          ),
                                          Icon(
                                            FontAwesomeIcons.info,
                                            size: 20, //Icon Size
                                            color: Color(
                                                0xFF3F5521), //Color Of Icon
                                          ),
                                          SizedBox(
                                            width: mediaQuery.size.width * 0.05,
                                          ),
                                          Text(
                                            '${personalInfo.lg[personalInfo.language]["Contact Us"]}',
                                            style: TextStyle(
                                                color: Color(0xFF3F5521),
                                                fontSize: 20,
                                                fontFamily: 'BerlinSansFB',
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.chevron_right,
                                            color: Color(0xFF3F5521),
                                          ),
                                          SizedBox(
                                            width: mediaQuery.size.width * 0.03,
                                          ),
 ],
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //           Padding(
                      //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      //   child: GestureDetector(
                      //     onTap: () {},
                      //
                      //     child: Card(
                      //       color: const Color.fromARGB(206, 255, 255, 255),
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(20.0)),
                      //       child: Column(
                      //         children: [
                      //           Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Row(
                      //               mainAxisAlignment:
                      //               MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Row(
                      //                   children: [
                      //                     SizedBox(
                      //                       width: mediaQuery.size.width * 0.03,
                      //                     ),
                      //                     Icon(
                      //                        FontAwesomeIcons.trash,
                      //                       size: 20, //Icon Size
                      //                       color: Color.fromARGB(255, 163, 9, 9), //Color Of Icon
                      //                     ),
                      //                     SizedBox(
                      //                       width: mediaQuery.size.width * 0.05,
                      //                     ),
                      //                     // Text(
                      //                     //   '${personalInfo.lg[personalInfo.language]["Delete Account"]}',
                      //                     //   style: TextStyle(
                      //                     //       color: Color(0xFF3F5521),
                      //                     //       fontSize: 20,
                      //                     //       fontFamily: 'BerlinSansFB',
                      //                     //       fontWeight: FontWeight.normal),
                      //                     // ),
                      //                   ],
                      //                 ),
                      //                 Row(
                      //                   children: [
                      //
                      //                     SizedBox(
                      //                       width: mediaQuery.size.width * 0.03,
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //
                      //
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      
                      

                      // IconButton(
                      //     icon: Icon(Icons.add_circle_outlined),
                      //     onPressed: () {
                      //       showModalBottomSheet(
                      //         isScrollControlled: true,
                      //         backgroundColor: Colors.white,
                      //         elevation: 0,
                      //         context: context,
                      //         builder: (context) {
                      //           return SafeArea(
                      //             child: Container(
                      //               child: Column(
                      //                 children: [
                      //                   Padding(
                      //                     padding:
                      //                         EdgeInsets.only(top: 15.0),
                      //                     child: Row(
                      //                       children: [
                      //                         IconButton(
                      //                             onPressed: () {
                      //                               Navigator.pop(context);
                      //                             },
                      //                             icon: Icon(
                      //                               Icons.clear,
                      //                               size: 30,
                      //                             )),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                   SingleChildScrollView(
                      //                     child: Column(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 25.0),
                      //                           child: Center(
                      //                             child: Image(
                      //                               image: AssetImage(
                      //                                   'images/logo.png'),
                      //                               // width: 800,
                      //                               height: MediaQuery.of(
                      //                                           context)
                      //                                       .size
                      //                                       .height *
                      //                                   0.4,
                      //                             ),
                      //                           ),
                      //                         ),
                      //                         SizedBox(
                      //                             height:
                      //                                 screenHeight * 0.05),
                      //                         Container(
                      //                           width: double.infinity,
                      //                           padding:
                      //                               const EdgeInsets.only(
                      //                                   left: 37.0,
                      //                                   right: 37.0),
                      //                           child: Column(
                      //                             children: [
                      //                               Center(
                      //                                 child: Column(
                      //                                     children: [
                      //                                       TextFormField(
                      //                                           style: const TextStyle(
                      //                                               color: Colors
                      //                                                   .grey,
                      //                                               fontSize:
                      //                                                   15,
                      //                                               fontWeight:
                      //                                                   FontWeight
                      //                                                       .normal,
                      //                                               fontFamily:
                      //                                                   'BerlinSansFB'),
                      //                                           decoration: InputDecoration(
                      //                                               prefixIcon: IconButton(
                      //                                                 icon:
                      //                                                     const Icon(Icons.mail_outline),
                      //                                                 onPressed:
                      //                                                     () {},
                      //                                               ),
                      //                                               focusedErrorBorder: OutlineInputBorder(
                      //                                                 borderRadius:
                      //                                                     BorderRadius.circular(5.0),
                      //                                                 borderSide:
                      //                                                     const BorderSide(
                      //                                                   color:
                      //                                                       Colors.red,
                      //                                                 ),
                      //                                               ),
                      //                                               errorBorder: OutlineInputBorder(
                      //                                                 borderRadius:
                      //                                                     BorderRadius.circular(5.0),
                      //                                                 borderSide:
                      //                                                     const BorderSide(
                      //                                                   color:
                      //                                                       Colors.red,
                      //                                                 ),
                      //                                               ),
                      //                                               contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
                      //                                               alignLabelWithHint: true,
                      //                                               labelStyle: TextStyle(
                      //                                                   //fontSize: focusNode.hasFocus ? 18 : 16.0,
                      //                                                   //I believe the size difference here is 6.0 to account padding
                      //                                                   color:
                      //                                                       // focusNode.hasFocus
                      //                                                       //?
                      //                                                       Color(0xFF3F5521)
                      //                                                   // : Colors.grey
                      //                                                   ),
                      //                                               labelText: "Email",
                      //                                               hintStyle: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'BerlinSansFB'),
                      //                                               filled: true,
                      //                                               fillColor: Colors.white,
                      //                                               enabledBorder: OutlineInputBorder(
                      //                                                 borderRadius:
                      //                                                     BorderRadius.circular(5.0),
                      //                                                 borderSide:
                      //                                                     const BorderSide(
                      //                                                   color:
                      //                                                       Colors.grey,
                      //                                                 ),
                      //                                               ),
                      //                                               focusedBorder: OutlineInputBorder(
                      //                                                   borderRadius: BorderRadius.circular(5.0),
                      //                                                   borderSide: const BorderSide(
                      //                                                     color: Color(0xFF3F5521),
                      //                                                   ))),
                      //                                           //controller: authProvider.email,
                      //                                           autovalidateMode: AutovalidateMode.onUserInteraction,
                      //                                           keyboardType: TextInputType.emailAddress),
                      //                                       SizedBox(
                      //                                         height:
                      //                                             screenHeight *
                      //                                                 0.015,
                      //                                       ),
                      //                                       TextFormField(
                      //                                         style: const TextStyle(
                      //                                             color: Colors
                      //                                                 .grey,
                      //                                             fontSize:
                      //                                                 15,
                      //                                             fontWeight:
                      //                                                 FontWeight
                      //                                                     .normal,
                      //                                             fontFamily:
                      //                                                 'BerlinSansFB'),
                      //                                         decoration: InputDecoration(
                      //                                             prefixIcon: IconButton(
                      //                                               icon: Icon(
                      //                                                   //passObscure
                      //                                                   //?
                      //                                                   Icons.lock_outlined
                      //                                                   //: Icons.lock_open_outlined,
                      //                                                   ),
                      //                                               onPressed:
                      //                                                   () {
                      //                                                 setState(
                      //                                                     () {
                      //                                                   //passObscure = !passObscure;
                      //                                                 });
                      //                                               },
                      //                                             ),
                      //                                             focusedErrorBorder: OutlineInputBorder(
                      //                                               borderRadius:
                      //                                                   BorderRadius.circular(5.0),
                      //                                               borderSide:
                      //                                                   const BorderSide(
                      //                                                 color:
                      //                                                     Colors.red,
                      //                                               ),
                      //                                             ),
                      //                                             errorBorder: OutlineInputBorder(
                      //                                               borderRadius:
                      //                                                   BorderRadius.circular(5.0),
                      //                                               borderSide:
                      //                                                   const BorderSide(
                      //                                                 color:
                      //                                                     Colors.red,
                      //                                               ),
                      //                                             ),
                      //                                             contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
                      //                                             alignLabelWithHint: true,
                      //                                             labelStyle: TextStyle(
                      //                                                 //fontSize: focusNode.hasFocus ? 18 : 16.0,
                      //                                                 //I believe the size difference here is 6.0 to account padding
                      //                                                 color: //focusNode.hasFocus
                      //                                                     // ?
                      //                                                     Color(0xFF3F5521)
                      //                                                 //   : Colors.grey
                      //                                                 ),
                      //                                             labelText: 'Password',
                      //                                             hintStyle: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'BerlinSansFB'),
                      //                                             filled: true,
                      //                                             fillColor: Colors.white,
                      //                                             enabledBorder: OutlineInputBorder(
                      //                                               borderRadius:
                      //                                                   BorderRadius.circular(5.0),
                      //                                               borderSide:
                      //                                                   const BorderSide(
                      //                                                 color:
                      //                                                     Colors.grey,
                      //                                               ),
                      //                                             ),
                      //                                             focusedBorder: OutlineInputBorder(
                      //                                                 borderRadius: BorderRadius.circular(5.0),
                      //                                                 borderSide: const BorderSide(
                      //                                                   color:
                      //                                                       Color(0xFF3F5521),
                      //                                                 ))),
                      //                                         //controller: authProvider.password,
                      //                                         // validator: validatePass,
                      //                                         autovalidateMode:
                      //                                             AutovalidateMode
                      //                                                 .onUserInteraction,
                      //
                      //                                         keyboardType:
                      //                                             TextInputType
                      //                                                 .visiblePassword,
                      //                                         //obscureText: passObscure,
                      //                                       ),
                      //                                     ]),
                      //                               ),
                      //                               SizedBox(
                      //                                 height: screenHeight *
                      //                                     0.01,
                      //                               ),
                      //                               Column(
                      //                                 crossAxisAlignment:
                      //                                     CrossAxisAlignment
                      //                                         .stretch,
                      //                                 children: [
                      //                                   InkWell(
                      //                                     child: RichText(
                      //                                       textAlign:
                      //                                           TextAlign
                      //                                               .end,
                      //                                       overflow:
                      //                                           TextOverflow
                      //                                               .ellipsis,
                      //                                       text: TextSpan(
                      //                                         text:
                      //                                             "Forgot Password",
                      //                                         style: Theme.of(
                      //                                                 context)
                      //                                             .textTheme
                      //                                             .headline3,
                      //                                       ),
                      //                                     ),
                      //                                     onTap: () {
                      //                                       Navigator.push(
                      //                                           context,
                      //                                           MaterialPageRoute(
                      //                                               builder:
                      //                                                   (context) =>
                      //                                                       const ResetPasswordScreen()));
                      //                                     },
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                               SizedBox(
                      //                                 height: screenHeight *
                      //                                     0.06,
                      //                               ),
                      //                               // !loading
                      //                               // ?
                      //                               ElevatedButton(
                      //                                 onPressed: () async {
                      //                                   setState(() {
                      //                                     //loading = true;
                      //                                   });
                      //                                   // final SharedPreferences sharedPreferences =
                      //                                   //     await SharedPreferences.getInstance();
                      //                                   // sharedPreferences.setString(
                      //                                   //     'email', emailController.text);
                      //
                      //                                   if (false) {
                      //                                     // ignore: avoid_print
                      //                                     print(
                      //                                         'Not Validated');
                      //                                     setState(() {
                      //                                       //loading = false;
                      //                                     });
                      //                                     // reset!=null?
                      //                                   } else {
                      //                                     if (true) {
                      //                                       print("logged");
                      //                                       setState(() {
                      //                                         // loading = false;
                      //                                       });
                      //                                       SharedPreferences
                      //                                           sh =
                      //                                           await SharedPreferences
                      //                                               .getInstance();
                      //                                       sh.setBool(
                      //                                           "logged",
                      //                                           true);
                      //
                      //                                       Navigator.of(context).pushAndRemoveUntil(
                      //                                           MaterialPageRoute(
                      //                                               builder: (context) =>
                      //                                                   Navigationbar(
                      //                                                       0)),
                      //                                           (Route<dynamic>
                      //                                                   route) =>
                      //                                               false);
                      //                                       //authProvider.status=Status.Authenticated;
                      //                                       setState(() {});
                      //                                     } else {
                      //
                      //                                     }
                      //                                   }
                      //                                 },
                      //                                 child: Text('Log In',
                      //                                     style: TextStyle(
                      //                                         color: Colors
                      //                                             .white,
                      //                                         fontWeight:
                      //                                             FontWeight
                      //                                                 .bold,
                      //                                         fontFamily:
                      //                                             'BerlinSansFB',
                      //                                         fontSize:
                      //                                             16)),
                      //                                 style: ElevatedButton
                      //                                     .styleFrom(
                      //                                   padding: EdgeInsets
                      //                                       .fromLTRB(
                      //                                           screenHeight *
                      //                                               0.14,
                      //                                           screenHeight *
                      //                                               0.02,
                      //                                           screenHeight *
                      //                                               0.14,
                      //                                           screenHeight *
                      //                                               0.02),
                      //                                   onPrimary: const Color
                      //                                           .fromRGBO(
                      //                                       255,
                      //                                       255,
                      //                                       255,
                      //                                       1),
                      //                                   primary: Theme.of(
                      //                                           context)
                      //                                       .primaryColor,
                      //                                   shape:
                      //                                       RoundedRectangleBorder(
                      //                                     borderRadius:
                      //                                         BorderRadius
                      //                                             .circular(
                      //                                                 15.0),
                      //                                   ),
                      //                                 ),
                      //                               ),
                      //                               //: Center(child: CircularProgressIndicator()),
                      //                               SizedBox(
                      //                                 height: screenHeight *
                      //                                     0.03,
                      //                               ),
                      //                               Center(
                      //                                 child: InkWell(
                      //                                   child: FittedBox(
                      //                                     child: Text(
                      //                                       "Create New Account",
                      //                                       style: Theme.of(
                      //                                               context)
                      //                                           .textTheme
                      //                                           .headline3,
                      //                                     ),
                      //                                   ),
                      //                                   onTap: () {
                      //                                     Navigator.push(
                      //                                       context,
                      //                                       MaterialPageRoute(
                      //                                         builder:
                      //                                             (context) =>
                      //                                                 const SignupScreen(),
                      //                                       ),
                      //                                     );
                      //                                   },
                      //                                 ),
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           );
                      //         },
                      //       );
                      //     },
                      //   )
                    ],
                  ),
                )
                        
                        ],
            ),
          ),
            
              
            )));
    
  }
}
