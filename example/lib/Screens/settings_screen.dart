import 'dart:io';

import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/Screens/CustomAlert/alert.dart';
import 'package:CaterMe/Screens/add_friend_screen.dart';
import 'package:CaterMe/Screens/addresses_settings_screen.dart';
import 'package:CaterMe/widgets/Account_info.dart';
import 'package:CaterMe/widgets/Payment/credit_cards_settings.dart';
import 'package:CaterMe/widgets/Personal_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/login_screen.dart';
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
bool loadingimage=false;
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
              loadingImage?Center(child:CircularProgressIndicator()):Center(
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child:personalInfo.loading?Center(child: CircularProgressIndicator(),): Center(
                      child:
                      CircleAvatar(radius: (52),
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius:BorderRadius.circular(50),
                            child: Image.network(
                             personalInfo.imageUrl,
                              errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                                return Icon(Icons.do_not_disturb,color:Colors.red);
                              },
                              loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null ?
                                      loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                          : null,
                                    ),
                                  ),
                                );
                              },
                              fit: BoxFit.fill,
                              width: 100,
                              height: 100,
                            ),
                          )
                      )

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
                                    fontSize: 14,
                                    color: Color.fromRGBO(63, 85, 33, 1),
                                  ),
                                ),
                                onTap: () async{
                                  Navigator.pop(context);
                                  setState(() {
                                    loadingImage=true;
                                  });
                                await  PickImage(ImageSource.camera);
                                await personalInfo.updateProfile(image);
                                  setState(() {
                                    loadingImage=false;
                                  });
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
                                    fontSize: 14,
                                    color: Color.fromRGBO(63, 85, 33, 1),
                                  ),
                                ),
                                onTap: () async {
                                  Navigator.pop(context);
                                  setState(() {
                                    loadingImage=true;
                                  });
                                  await  PickImage(ImageSource.gallery);
                                  await personalInfo.updateProfile(image);
                                  setState(() {
                                    loadingImage=false;
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
              Text(personalInfo.name.text,style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(personalInfo.phoneNumber.text,style: TextStyle(fontWeight: FontWeight.bold)),


              SizedBox(
                height: screenHeight * 0.02,
              ),
              Expanded(
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Card(
                      color:  const Color.fromARGB(206, 255, 255, 255),
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Card(

                        color:  const Color.fromARGB(206, 255, 255, 255),
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                          "My Addresses",
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

                            Divider(thickness: 1,),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                            Divider(thickness: 1,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                          "My Friends",
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
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Card(

                        color:  const Color.fromARGB(206, 255, 255, 255),
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
                        child: GestureDetector(
                          onTap: ()  {
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: mediaQuery.size.width * 0.03,
                                    ),
                                    Icon(FontAwesomeIcons.language,
                                      size: 20, //Icon Size
                                      color: Color(0xFF3F5521),//Color Of Icon
                                    ),
                                    SizedBox(
                                      width: mediaQuery.size.width * 0.05,
                                    ),
                                    Text(
                                      "Language ",
                                      style: TextStyle(
                                          color: Color(0xFF3F5521),
                                          fontSize: 20,
                                          fontFamily: 'BerlinSansFB',
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),

                                Row(children: [
                                  Text("English",style:TextStyle(
                                      fontWeight: FontWeight.normal)),
                                  SizedBox(
                                    width: mediaQuery.size.width * 0.03,
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Card(

                        color:  const Color.fromARGB(206, 255, 255, 255),
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(context: context,
                                builder: (BuildContext context) {
                                 return CustomDialog(
                                    title: 'Sad to see you leave',
                                    description: "",
                                    oneOrtwo: true,
                                    button2: ElevatedButton(
                                      onPressed: () async {
                                        final SharedPreferences
                                        sharedPreferences =
                                        await SharedPreferences.getInstance();
                                       // sharedPreferences.remove('Email');
                                      //  sharedPreferences.remove('Password');
                                        personalInfo.clearAllTextController();
                                        bool a=sharedPreferences.getBool("startintro");
                                        sharedPreferences.clear();
                                        sharedPreferences.setBool("startintro", a);


                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen(),
                                            ),
                                                (route) => false);
                                      }, child: Text("Logout",style: TextStyle(fontFamily: 'BerlinSansFB'),),),
                                    button1: ElevatedButton(onPressed: () {
                                      Navigator.of(context).pop();
                                    }, child: Text("No",style: TextStyle(fontFamily: 'BerlinSansFB')),

                                    )
                                    ,);
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: mediaQuery.size.width * 0.03,
                                    ),
                                    const Icon(FontAwesomeIcons.signOutAlt,
                                      size: 20, //Icon Size
                                      color: Color(0xFF3F5521),//Color Of Icon
                                    ),
                                    SizedBox(
                                      width: mediaQuery.size.width * 0.05,
                                    ),
                                    const Text( "Logout ",
                                      style: TextStyle(
                                          color: Color(0xFF3F5521),
                                          fontSize: 20,
                                          fontFamily: 'BerlinSansFB',
                                          fontWeight: FontWeight.normal),
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
                        )
                      ),
                    ),

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
