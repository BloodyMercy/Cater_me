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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  }

  getPersonalInfo() async {
    final personalInfo =
        await Provider.of<UserProvider>(context, listen: false);
    personalInfo.loading = true;
    await personalInfo.getPersonalInfo();
    personalInfo.loading = false;
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
    final mediaQuery = MediaQuery.of(context);

    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: LightColors.kLightYellow,
            height: mediaQuery.size.height,
            child: Column(
              children: [
                loadingImage
                    ? Center(child: CircularProgressIndicator())
                    : personalInfo.status == Status.Authenticated
                        ? Center(
                            child: GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: personalInfo.loading
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Center(
                                        child: CircleAvatar(
                                            radius: (52),
                                            backgroundColor: Colors.white,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Image.network(
                                                personalInfo.imageUrl,
                                                errorBuilder:
                                                    (BuildContext context,
                                                        Object exception,
                                                        StackTrace stackTrace) {
                                                  return Icon(
                                                      Icons.do_not_disturb,
                                                      color: Colors.red);
                                                },
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent
                                                            loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            25.0),
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes
                                                            : null,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                fit: BoxFit.fill,
                                                width: 100,
                                                height: 100,
                                              ),
                                            ))),
                              ),
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
                                              '${LanguageTr.lg[personalInfo.language]["Camera"]}',
                                              style: TextStyle(
                                                fontFamily: 'BerlinSansFB',
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    63, 85, 33, 1),
                                              ),
                                            ),
                                            onTap: () async {
                                              Navigator.pop(context);
                                              setState(() {
                                                loadingImage = true;
                                              });
                                              await PickImage(
                                                  ImageSource.camera);
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
                                              '${LanguageTr.lg[personalInfo.language]["Gallery"]}',
                                              style: TextStyle(
                                                fontFamily: 'BerlinSansFB',
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    63, 85, 33, 1),
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
                            ),
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
                    ? Column(
                        children: [
                          Text(
                            personalInfo.name.text,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Text(personalInfo.phoneNumber.text,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )
                    : ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          '${LanguageTr.lg[personalInfo.language]["Log In"]}',
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
                          ? Card(
                              color: const Color.fromARGB(206, 255, 255, 255),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => PersonalInfo(),
                                        ),
                                      );
                                    },
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
                                                    '${LanguageTr.lg[personalInfo.language]["Personal Info"]}',
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
                                  ),
                                  Divider(),



                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => AccountInfo(),
                                          ),
                                        );
                                      },
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
                                                color: Color(0xFF3F5521),
                                              ),
                                              SizedBox(
                                                width: mediaQuery.size.width *
                                                    0.05,
                                              ),
                                              Text(
                                                '${LanguageTr.lg[personalInfo.language]["Reset Password"]}',
                                                style: TextStyle(
                                                    color: Color(0xFF3F5521),
                                                    fontSize: 20,
                                                    fontFamily: 'BerlinSansFB',
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
                                              width:
                                                  mediaQuery.size.width * 0.03,
                                            ),
                                          ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      personalInfo.status == Status.Authenticated
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Card(
                                color: const Color.fromARGB(206, 255, 255, 255),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddAddressSettingsScreen(),
                                            ),
                                          );
                                        },
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
                                                  FontAwesomeIcons.building,
                                                  size: 20, //Icon Size
                                                  color: Color(
                                                      0xFF3F5521), //Color Of Icon
                                                ),
                                                SizedBox(
                                                  width: mediaQuery.size.width *
                                                      0.05,
                                                ),
                                                Text(
                                                  '${LanguageTr.lg[personalInfo.language]["My Address"]}',
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
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CreditCardsSettings(),
                                            ),
                                          );
                                        },
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
                                                  '${LanguageTr.lg[personalInfo.language]["My Credit Cards"]}',
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
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddFriendScreen(),
                                            ),
                                          );
                                        },
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
                                                  '${LanguageTr.lg[personalInfo.language]["My Friends"]}',
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
                                    ),
                                    // Divider(
                                    //   thickness: 1,

                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: GestureDetector(
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
                                    //               '${LanguageTr.lg[personalInfo.language]["Saved Orders"]}',
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
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Card(
                          color: const Color.fromARGB(206, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(25),
                                          ),
                                        ),
                                        title: Center(
                                          child: Text('Choose language',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 19,
                                              )),
                                        ),
                                        actions: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: _mediaWidth * 0.08),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton(
                                                  child: Text('Arabic'),
                                                  onPressed: () async {
                                                    personalInfo.language =
                                                        "ar";
                                                    SharedPreferences _prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    _prefs.setString(
                                                        "locale", "ar");
                                                    MyApp.setLocale(context,
                                                        Locale("ar", "AE"));
                                                    Navigator.of(context)
                                                        .pushAndRemoveUntil(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SplashScreen(),
                                                            ),
                                                            (Route<dynamic>
                                                                    route) =>
                                                                false);
                                                    // AppLocalizations.of(context)!.locale.toString()

                                                    // .language="ar";
                                                  },
                                                ),
                                                TextButton(
                                                    child: Text(
                                                      'English',
                                                    ),
                                                    onPressed: () async {
                                                      personalInfo.language =
                                                          "en";
                                                      SharedPreferences _prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      _prefs.setString(
                                                          "locale", "en");
                                                      MyApp.setLocale(context,
                                                          Locale("en", "US"));
                                                      Navigator.of(context)
                                                          .pushAndRemoveUntil(
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        SplashScreen(),
                                                              ),
                                                              (Route<dynamic>
                                                                      route) =>
                                                                  false);
                                                      // AppLocalizations.of(context)!.locale.toString()

                                                      // .language="ar";                                              },
                                                    }),
                                              ],
                                            ),
                                          )
                                        ],
                                      ));
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
                                        '${LanguageTr.lg[personalInfo.language]["Language"]}',
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
                                      Padding(padding: EdgeInsets.only(right: 16),
                                        child: Icon(
                                        Icons.chevron_right,
                                        color: Color(0xFF3F5521),
                                    ),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                                      builder: (context) =>
                                          TermsAndConditions(),
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
                                            width: mediaQuery.size.width * 0.03,
                                          ),
                                          Icon(
                                            Icons.article_rounded,
                                            size: 20, //Icon Size
                                            color: Color(
                                                0xFF3F5521), //Color Of Icon
                                          ),
                                          SizedBox(
                                            width: mediaQuery.size.width * 0.05,
                                          ),
                                          Text(
                                            '${LanguageTr.lg[personalInfo.language]["Terms & Conditions"]}',
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
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Contact_Us(),
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
                                            '${LanguageTr.lg[personalInfo.language]["Contact Us"]}',
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
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      personalInfo.status == Status.Authenticated
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Card(
                                color: const Color.fromARGB(206, 255, 255, 255),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialog(
                                            title:
                                                '${LanguageTr.lg[personalInfo.language]["Sad to see you leave"]}',
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
                                                    .getBool("wlkdone")??false;
                                                String l = sharedPreferences
                                                    .getString("locale")??"en";
                                                sharedPreferences.clear();
                                                sharedPreferences.setBool(
                                                    "startintro", a);
                                                sharedPreferences.setBool(
                                                    "wlkdone", aw);
                                                sharedPreferences.setString("locale", l);


                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              SplashScreen(),
                                                        ),
                                                        (route) => false);
                                              },
                                              child: Text(
                                                '${LanguageTr.lg[personalInfo.language]["Logout"]}',
                                                style: TextStyle(
                                                    fontFamily: 'BerlinSansFB'),
                                              ),
                                            ),
                                            button1: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                  '${LanguageTr.lg[personalInfo.language]["No"]}',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'BerlinSansFB')),
                                            ),
                                          );
                                        });
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
                                            const Icon(
                                              FontAwesomeIcons.signOutAlt,
                                              size: 20, //Icon Size
                                              color: Color(
                                                  0xFF3F5521), //Color Of Icon
                                            ),
                                            SizedBox(
                                              width:
                                                  mediaQuery.size.width * 0.05,
                                            ),
                                            Text(
                                              '${LanguageTr.lg[personalInfo.language]["Logout"]}',
                                              style: TextStyle(
                                                  color: Color(0xFF3F5521),
                                                  fontSize: 20,
                                                  fontFamily: 'BerlinSansFB',
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        Row(children: [
                                          const Icon(
                                            Icons.chevron_right,
                                            color: Color(0xFF3F5521),
                                          ),
                                          SizedBox(
                                            width: mediaQuery.size.width * 0.03,
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
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
        ),
      ),
    );
  }
}
