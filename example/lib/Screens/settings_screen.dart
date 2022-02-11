import 'dart:io';

import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/Screens/add_friend_screen.dart';
import 'package:CaterMe/Screens/addresses_screen.dart';
import 'package:CaterMe/Screens/addresses_settings_screen.dart';
import 'package:CaterMe/Screens/auth/logout_screen.dart';
import 'package:CaterMe/Screens/contact_us_screen.dart';
import 'package:CaterMe/colors/colors.dart';

import 'package:CaterMe/widgets/Account_info.dart';
import 'package:CaterMe/widgets/Payment/credit_cards_settings.dart';

import 'package:CaterMe/widgets/Personal_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'auth/login_screen.dart';
import 'auth/newlogin/screens/loginScreen.dart';
import 'occasion/theme/colors/light_colors.dart';

class TABBar extends StatefulWidget {
  const TABBar({Key key}) : super(key: key);

  @override
  _TABBarState createState() => _TABBarState();
}

class _TABBarState extends State<TABBar>  {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPersonalInfo();
  }
  getPersonalInfo()async{
    final personalInfo=await Provider.of<UserProvider>(context,listen: false);
    personalInfo.loading=true;
    await personalInfo.getPersonalInfo();
    personalInfo.loading=false;
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
      // ignore: nullable_type_in_catch_clause
    } on PlatformException catch (e) {
      print('Failed : $e');
    }
  }

  String showname = '';
  String phoneNumb = '';
  String imageprof = "";
  bool loadingImage=false;
setData(String imageUrl) async{
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

  @override
  Widget build(BuildContext context) {
    // final updateImage = Provider.of<UserProvider>(context, listen: true);
    final personalInfo=Provider.of<UserProvider>(context,listen: true);
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

              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        // color: Colors.white,
                        // child: Text('TestDataTest'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child:personalInfo.loading?Center(child: CircularProgressIndicator(),): Center(
                            child:
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: screenHeight * 0.1,
                              backgroundImage: NetworkImage(personalInfo.imageUrl),
                              // child:ClipOval(child: Image.network(
                              //   personalInfo.imageUrl,
                              //   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                              //     if (loadingProgress == null) return child;
                              //     return Center(
                              //       child: CircularProgressIndicator(
                              //        // color: ColorConstants.themeColor,
                              //         value: loadingProgress.expectedTotalBytes != null &&
                              //             loadingProgress.expectedTotalBytes != null
                              //             ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                              //             : null,
                              //       ),
                              //     );
                              //   },
                              //   errorBuilder: (context, object, stackTrace) {
                              //     return Icon(
                              //       Icons.account_circle,
                              //       size: 35,
                              //    //   color: ColorConstants.greyColor,
                              //     );
                              //   },
                              //   width: 150,
                              //   height: 150,
                              //   fit: BoxFit.fill,
                              // )),
                            ),
                          ),
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
                                        color: Color.fromRGBO(63, 85, 33, 1),
                                      ),
                                      title: const Text(
                                        'Camera',
                                        style: TextStyle(
                                          fontFamily: 'BerlinSansFB',
                                          fontSize: 16,
                                          color: Color.fromRGBO(63, 85, 33, 1),
                                        ),
                                      ),
                                      onTap: () async{
                                        Navigator.pop(context);
                                      await  PickImage(ImageSource.camera);
                                      await personalInfo.updateProfile(image);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(
                                        Icons.image,
                                        color: Color.fromRGBO(63, 85, 33, 1),
                                      ),
                                      title: const Text(
                                        'Gallery',
                                        style: TextStyle(
                                          fontFamily: 'BerlinSansFB',
                                          fontSize: 16,
                                          color: Color.fromRGBO(63, 85, 33, 1),
                                        ),
                                      ),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        await PickImage(ImageSource.gallery);
                                       // personalInfo.loading=true;

                                            await personalInfo.updateProfile(image);
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
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: EdgeInsets.only(right: 10),
                        child: IconButton(icon:Icon(Icons.logout,color: Color(0xFF3F5521),),onPressed:() async {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Are you sure you want to\nlog out?",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: "BerlinSansFB",
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.06,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: const Text(
                                          "Close",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "BerlinSansFB",
                                              color: Colors.black),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          final SharedPreferences
                                          sharedPreferences =
                                          await SharedPreferences.getInstance();
                                          sharedPreferences.remove('Email');
                                          sharedPreferences.remove('Password');
                                          personalInfo.clearAllTextController();

                                          sharedPreferences.clear();

                                          Navigator.of(ctx).pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen(),
                                              ),
                                                  (route) => false);
                                        },
                                        child: const Text(
                                          "LogOut",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "BerlinSansFB",
                                            color: Color.fromRGBO(234, 77, 71, 1),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );},),
                      )
                      ),
                    ),

                ],
              ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: BorderRadius.circular(20),
          ),
          // child: Image.network(
          //   personalInfo.imageUrl,
          //   loadingBuilder: (BuildContext context, Widget child,
          //       ImageChunkEvent loadingProgress) {
          //     if (loadingProgress == null) {
          //       return child;
          //     }
          //     return Center(
          //       child: CircularProgressIndicator(
          //         value: loadingProgress.expectedTotalBytes != null
          //             ? loadingProgress.cumulativeBytesLoaded /
          //             loadingProgress.expectedTotalBytes
          //             : null,
          //       ),
          //     );
          //   },
          // ),
        ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(personalInfo.name.text,style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(personalInfo.phoneNumber.text,style: TextStyle(fontWeight: FontWeight.bold)),


              SizedBox(
                height: screenHeight * 0.05,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PersonalInfo(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: mediaQuery.size.width * 0.03,
                                    ),
                                    Icon(FontAwesomeIcons.solidUser,
                                      size: 20, //Icon Size
                                      color: Color(0xFF3F5521),//Color Of Icon
                                    ),
                                    SizedBox(
                                      width: mediaQuery.size.width * 0.05,
                                    ),
                                    Text(
                                      "Personal Info",
                                      style: TextStyle(
                                          color: Color(0xFF3F5521),
                                          fontSize: 25,
                                          fontFamily: 'BerlinSansFB'),
                                    ),
                                  ],
                                ),
                                Row(children: [
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Color(0xFF3F5521),
                                  ),
                                  SizedBox(
                                    width: mediaQuery.size.width * 0.03,
                                  ),
                                ]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddAddressSettingsScreen(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: mediaQuery.size.width * 0.03,
                                ),
                                Icon(FontAwesomeIcons.building,
                                  size: 20, //Icon Size
                                  color: Color(0xFF3F5521),//Color Of Icon
                                ),
                                SizedBox(
                                  width: mediaQuery.size.width * 0.05,
                                ),
                                Text(
                                  "Addresses",
                                  style: TextStyle(
                                      color: Color(0xFF3F5521),
                                      fontSize: 25,
                                      fontFamily: 'BerlinSansFB'),
                                ),
                              ],
                            ),
                            Row(children: [
                              Icon(
                                Icons.arrow_forward,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CreditCardsSettings(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: mediaQuery.size.width * 0.03,
                                ),
                                Icon(FontAwesomeIcons.creditCard,
                                  size: 20, //Icon Size
                                  color: Color(0xFF3F5521),//Color Of Icon
                                ),
                                SizedBox(
                                  width: mediaQuery.size.width * 0.05,
                                ),
                                Text(
                                  "My Credit Cards",
                                  style: TextStyle(
                                      color: Color(0xFF3F5521),
                                      fontSize: 25,
                                      fontFamily: 'BerlinSansFB'),
                                ),
                              ],
                            ),
                            Row(children: [
                              Icon(
                                Icons.arrow_forward,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddFriendScreen(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: mediaQuery.size.width * 0.03,
                                ),
                                Icon(FontAwesomeIcons.userPlus,
                                  size: 20, //Icon Size
                                  color: Color(0xFF3F5521),//Color Of Icon
                                ),
                                SizedBox(
                                  width: mediaQuery.size.width * 0.05,
                                ),
                                Text(
                                  "Add Friends",
                                  style: TextStyle(
                                      color: Color(0xFF3F5521),
                                      fontSize: 25,
                                      fontFamily: 'BerlinSansFB'),
                                ),
                              ],
                            ),
                            Row(children: [
                              Icon(
                                Icons.arrow_forward,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AccountInfo(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: mediaQuery.size.width * 0.03,
                                ),
                                Icon(
                                  Icons.vpn_key_sharp,
                                  color: Color(0xFF3F5521),
                                ),
                                SizedBox(
                                  width: mediaQuery.size.width * 0.05,
                                ),
                                Text(
                                  "Reset Password",
                                  style: TextStyle(
                                      color: Color(0xFF3F5521),
                                      fontSize: 25,
                                      fontFamily: 'BerlinSansFB'),
                                ),
                              ],
                            ),
                            Row(children: [
                              Icon(
                                Icons.arrow_forward,
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
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 20),
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Navigator.of(context).push(
                    //         MaterialPageRoute(
                    //           builder: (context) => ContactUsScreen(),
                    //         ),
                    //       );
                    //     },
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Row(
                    //           children: [
                    //             SizedBox(
                    //               width: mediaQuery.size.width * 0.03,
                    //             ),
                    //             Icon(
                    //               Icons.email,
                    //               color: Color(0xFF3F5521),
                    //             ),
                    //             SizedBox(
                    //               width: mediaQuery.size.width * 0.05,
                    //             ),
                    //             Text(
                    //               "Contact Us",
                    //               style: TextStyle(
                    //                   color: Color(0xFF3F5521),
                    //                   fontSize: 25,
                    //                   fontFamily: 'BerlinSansFB'),
                    //             ),
                    //           ],
                    //         ),
                    //         Row(children: [
                    //           Icon(
                    //             Icons.arrow_forward,
                    //             color: Color(0xFF3F5521),
                    //           ),
                    //           SizedBox(
                    //             width: mediaQuery.size.width * 0.03,
                    //           ),
                    //         ]),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                  ],
                ),
              ),

            ],
          ),
        ),
      )
          ),
    );
  }
}
