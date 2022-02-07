import 'dart:io';

import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/Screens/add_friend_screen.dart';
import 'package:CaterMe/Screens/addresses_screen.dart';
import 'package:CaterMe/Screens/addresses_settings_screen.dart';
import 'package:CaterMe/Screens/auth/logout_screen.dart';
import 'package:CaterMe/Screens/contact_us_screen.dart';
import 'package:CaterMe/colors/colors.dart';

import 'package:CaterMe/widgets/Account_info.dart';

import 'package:CaterMe/widgets/Personal_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TABBar extends StatefulWidget {
  const TABBar({Key? key}) : super(key: key);

  @override
  _TABBarState createState() => _TABBarState();
}

class _TABBarState extends State<TABBar> with TickerProviderStateMixin {
  var firstField = TextEditingController();
  var thirdField = TextEditingController();

  var secondField = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

   File? image;

  // ignore: non_constant_identifier_names
  Future PickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return 'null';
      final imageTemporary = File(image.path);
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

  getdata() async {
    SharedPreferences image = await SharedPreferences.getInstance();
    setState(() {
      imageprof = image.getString('imageUrl') ?? "";
      showname = image.getString('name') ?? '';
      phoneNumb = image.getString('phoneNumber') ?? '';
    });
  }

  // TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final updateImage = Provider.of<UserProvider>(context, listen: true);
    var _mediaQueryText = MediaQuery.of(context).size.height;
    final mediaQuery = MediaQuery.of(context);
    TabController forTab = TabController(length: 3, vsync: this);
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return SafeArea(
      child: Scaffold(

          body: SingleChildScrollView(
            child: Container(
              height: mediaQuery.size.height,
              color: Colors.white,
              child: Column(
                children: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: CircleAvatar(
                          minRadius: 16,
                          maxRadius: screenHeight * 0.1,
                          backgroundImage:
                              image == null ? null : NetworkImage(imageprof),
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
                                  onTap: () {
                                    PickImage(ImageSource.camera);
                                    Navigator.pop(context);
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
                                  onTap: () async{
                                  await PickImage(ImageSource.gallery);

                               String a=   await  updateImage.updateProfile(image!);
                               if(a!="") {
                                 setState(() {
                                   imageprof = a;
                                 });
                               }

                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  showname != ''
                      ? Text(
                          '${showname}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      : Container(),
                  phoneNumb != ''
                      ? Text('${phoneNumb}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))
                      : Container(),

                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  SizedBox(
                    height: screenHeight * 0.4,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: mediaQuery.size.width * 0.03,
                                        ),
                                        Icon(Icons.person,color: Color(0xFF3F5521),),
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
                                      Icon(Icons.arrow_forward,color: Color(0xFF3F5521),),
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
                                  builder: (context) =>
                                      AddAddressSettingsScreen(),
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
                                    Icon(Icons.maps_home_work_outlined),
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
                                  Icon(Icons.arrow_forward,color: Color(0xFF3F5521),),
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
                                    Icon(Icons.info_outline,color: Color(0xFF3F5521),),
                                    SizedBox(
                                      width: mediaQuery.size.width * 0.05,
                                    ),
                                    Text(
                                      "Account Info",
                                      style: TextStyle(
                                          color: Color(0xFF3F5521),
                                          fontSize: 25,
                                          fontFamily: 'BerlinSansFB'),
                                    ),
                                  ],
                                ),
                                Row(children: [
                                  Icon(Icons.arrow_forward,color: Color(0xFF3F5521),),
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
                                  builder: (context) => ContactUsScreen(),
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
                                    Icon(Icons.email,color:Color(0xFF3F5521),),
                                    SizedBox(
                                      width: mediaQuery.size.width * 0.05,
                                    ),
                                    Text(
                                      "Contact Us",
                                      style: TextStyle(
                                          color: Color(0xFF3F5521),
                                          fontSize: 25,
                                          fontFamily: 'BerlinSansFB'),
                                    ),
                                  ],
                                ),
                                Row(children: [
                                  Icon(Icons.arrow_forward,color: Color(0xFF3F5521),),
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
                                    Icon(Icons.person_add,color: Color(0xFF3F5521),),
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
                                  Icon(Icons.arrow_forward,color: Color(0xFF3F5521),),
                                  SizedBox(
                                    width: mediaQuery.size.width * 0.03,
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LogOutScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Log Out",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: mediaQuery.size.width * 0.05,
                      ),
                      primary: Colors.red,
                    ),
                  )
                  //   ElevatedButton(onPressed:  () {
                  //   Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(
                  //       builder: (context) => PersonalInfo(),
                  //     ),
                  //   );
                  // }, child:  Text("Personal Info", style: TextStyle(color: Colors.black, fontSize: 25, fontFamily:  'BerlinSansFB'),),
                  // style: ElevatedButton.styleFrom(
                  //   textStyle: TextStyle(),
                  //         padding:  EdgeInsets.symmetric(
                  //           vertical: 20,
                  //          horizontal: mediaQuery.size.width*0.33,
                  //         ),

                  //         primary: Colors.white,
                  //       ),
                  // )
                ],
              ),
            ),
          )

          // DefaultTabController(
          //   length: 3,
          //   child: Column(children: [
          //     SizedBox(
          //       height: _mediaQueryText * 0.01,
          //       width: double.infinity,
          //     ),
          //     SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          //     SizedBox(
          //       height: (MediaQuery.of(context).size.height -
          //               // appBar.preferredSize.height -
          //               MediaQuery.of(context).padding.top -
          //               MediaQuery.of(context).padding.bottom) *
          //           0.08,
          //       child: TabB
          //         // controller: forTab,
          //         indicatorColor: Colors.transparent,
          //         indicatorWeight: 4,
          //         indicatorSize: TabBarIndicatorSize.tab,
          //         labelColor: Colors.black,
          //         unselectedLabelColor: Colors.grey,
          //         labelStyle: const TextStyle(
          //           fontWeight: FontWeight.bold,
          //         ),
          //         tabs: const [
          //           Tab(
          //             text: 'Personal info',
          //           ),
          //           Tab(
          //             text: 'Addresses',
          //           ),
          //           Tab(
          //             text: 'Account info',
          //           ),
          //         ],
          //       ),
          //     ),
          //     Flexible(
          //       flex: 5,
          //       child: Container(
          //         padding: const EdgeInsets.only(left: 10),
          //         height: (MediaQuery.of(context).size.height -
          //                 // appBar.preferredSize.height -
          //                 MediaQuery.of(context).padding.top -
          //                 MediaQuery.of(context).padding.bottom) *
          //             0.9,
          //         width: double.maxFinite,
          //         child: TabBarView(
          //           // controller: forTab,
          //           children: [
          //             PersonalInfo(),
          //             AddAddressScreen(),
          //             AccountInfo(),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ]),
          // ),
          ),
    );
  }
}
