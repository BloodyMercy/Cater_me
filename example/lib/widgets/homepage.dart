import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:CaterMe/Providers/occasion.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/add_new_occasion.dart';
import 'package:CaterMe/Screens/auth/login_screen.dart';
import 'package:CaterMe/Screens/my_favorites.dart';
import 'package:CaterMe/Screens/notifications.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/chat/pages/chat_page.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/intro/flutter_intro.dart';
import 'package:CaterMe/model/occasions/cuisin_card.dart';
import 'package:CaterMe/model/occasions/cuisins_screen.dart';
import 'package:CaterMe/widgets/Packages/packages_card.dart';
import 'package:CaterMe/widgets/addOns/add_on_list.dart';
import 'package:CaterMe/widgets/occasions/occasion_card.dart';
import 'package:CaterMe/widgets/occasions/occasions_list.dart';
import 'package:CaterMe/widgets/seeallgallery.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Providers/GalleryProvider.dart';
import '../Providers/contact_us_provider.dart';
import '../Providers/user.dart';
import '../Screens/ahmad/My Orders/OrderDetails.dart';
import '../Screens/full_photo_page.dart';
import '../Screens/settings_screen.dart';
import '../language/language.dart';
import 'Packages/test_package_add_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isSearch = false;
  String language;
  Intro intro;

  // String language="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getalldata();
    getData();

    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: false);
    offsetAnimation = Tween<Offset>(
      begin: Offset(-1.5, 0.0),
      end: Offset(1.5, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.slowMiddle));

    offsetAnimation2 = Tween<Offset>(
      begin: Offset(1.5, 0.0),
      end: Offset(-1.5, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.slowMiddle));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool loading = false;
  List<String> listitemssearch = [];

  Future refreshdata() async {
    final package = Provider.of<PackagesProvider>(context, listen: false);

    //package.loading=false;
    // package.loading = false;
    await package.cleardata();
    SharedPreferences sh = await SharedPreferences.getInstance();

    await package.getallpacakges(context, sh.getString("locale"));

    return;
  }

  TextEditingController controllersearch = TextEditingController();

  getalldata() async {
    SharedPreferences sh = await SharedPreferences.getInstance();

    final package = Provider.of<PackagesProvider>(context, listen: false);
    await package.getallpacakges(context, sh.getString("locale"));
    package.loading = true;
    for (int i = 0; i < package.listItems.length; i++) {
      listitemssearch.add(package.listItems[i].title.toLowerCase());
    }
  }

  Future getData() async {
    final occasion = Provider.of<OccasionProvider>(context, listen: false);
    final gallery = Provider.of<GalleryProvider>(context, listen: false);
    gallery.gethomepage();
    SharedPreferences sh = await SharedPreferences.getInstance();

    await occasion.getallnewoccasion(sh.getString("locale"));
    // await occasion.getAllOccasionType(a);

    setState(() {
      loading = false;
    });
    setState(() {
      language = sh.getString("locale");
    });
    return;
  }

  AnimationController _controller;
  Animation<Offset> offsetAnimation;
  Animation<Offset> offsetAnimation2;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final gallery = Provider.of<GalleryProvider>(context, listen: true);
    final package = Provider.of<PackagesProvider>(context, listen: true);
    final contact = Provider.of<ContactUsProvider>(context, listen: true);
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
          body: !isSearch
              ? RefreshIndicator(
                  onRefresh: refreshdata,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: ColoredBox(
                      color: LightColors.kLightYellow,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    width: mediaQuery.size.width * 0.7,
                                    height: mediaQuery.size.height / 13,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: TextField(
                                        showCursor: true,
                                        readOnly: true,
                                        autofocus: false,
                                        onTap: () {
                                          setState(() {
                                            isSearch = true;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: colorCustom,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                          filled: true,
                                          fillColor: LightColors.kLightYellow2,
                                          hintText:
                                              '${authProvider.lg[authProvider.language]["Search"]}',
                                          prefixIcon: const Icon(Icons.search),
                                          prefixIconColor:
                                              Theme.of(context).primaryColor,
                                          hintStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 13,
                                              fontFamily: 'Segoe UI'),
                                        ),
                                      ),
                                    )),
                                Expanded(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          authProvider.status ==
                                                  Status.Authenticated
                                              ? Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatPage(
                                                      peerId: "admin",
                                                      peerAvatar: "",
                                                      peerNickname:
                                                          '${authProvider.lg[authProvider.language]["Customer Service"]}',
                                                    ),
                                                  ),
                                                )
                                              : Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen(),
                                                  ),
                                                );
                                        },
                                        icon: Icon(
                                          Icons.chat,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      // IconButton(
                                      //   onPressed: () {
                                      //     Navigator.of(context).push(
                                      //       MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             MyFavorites(),
                                      //       ),
                                      //     );
                                      //   },
                                      //   icon: Icon(
                                      //     Icons.favorite,
                                      //     color: Theme.of(context).primaryColor,
                                      //   ),
                                      // ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Notifications(),
                                            ),
                                          );
                                        },
                                        icon: int.parse(package.nbnotification
                                                    .toString()) !=
                                                0
                                            ? Badge(
                                                badgeColor: Color.fromRGBO(
                                                    253, 202, 29, 1),
                                                badgeContent: Text(
                                                  int.parse(package
                                                              .nbnotification
                                                              .toString()) >
                                                          99
                                                      ? "99+"
                                                      : package.nbnotification,
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                                child: Icon(
                                                  Icons.notifications,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ))
                                            : Icon(
                                                Icons.notifications,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 30),
                              child: Text(
                                '${authProvider.lg[authProvider.language]["Menus"]}',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                            Center(child: PackagesCard()),
                            // SizedBox(height: MediaQuery.of(context).size.height*0.05),
                            Column(children: [
                              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                              authProvider.status == Status.Unauthenticated
                                  ? language == "en"
                                      ? SlideTransition(
                                          position: offsetAnimation,
                                          transformHitTests: true,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen(),
                                              ));
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.055,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                              child: Image.asset(
                                                "images/login-01.png",
                                              ),
                                            ),
                                          ),
                                        )
                                      : SlideTransition(
                                          position: offsetAnimation2,
                                          transformHitTests: true,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen(),
                                              ));
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.055,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                              child: Image.asset(
                                                "images/login-04.png",
                                              ),
                                            ),
                                          ),
                                        )
                                  : Container(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20

                                        // top: mediaQuery.size.height * 0.05
                                        ),
                                    child: Text(
                                      '${authProvider.lg[authProvider.language]["Upcoming Occasions"]}',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Navigationbar(1),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          '${authProvider.lg[authProvider.language]["See All"]}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'BerlinSansFB',
                                              fontSize: 12),
                                        ),
                                      ))
                                ],
                              ),
                              ((getOccasionsToday(package.occasions).length ==
                                      0))
                                  ? InkWell(
                                      onTap: authProvider.status ==
                                              Status.Authenticated
                                          ? () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddNewOccasion(0),
                                                ),
                                              );
                                            }
                                          : () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen()),
                                              );
                                            },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              mediaQuery.size.width * 0.01,
                                        ),
                                        child: Column(children: [
                                          SizedBox(
                                            width: mediaQuery.size.width * 0.97,
                                            // height: mediaQuery.size.height * 0.15,
                                            child: Card(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        mediaQuery.size.height *
                                                            0.17,
                                                    width:
                                                        mediaQuery.size.width *
                                                            0.23,
                                                    child: Card(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(20),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              DateFormat.MMM(
                                                                      authProvider
                                                                          .language)
                                                                  .format(DateTime
                                                                      .now()),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                                DateFormat.d(
                                                                        authProvider
                                                                            .language)
                                                                    .format(DateTime
                                                                        .now()),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))
                                                          ],
                                                        )),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: mediaQuery
                                                                        .size
                                                                        .width *
                                                                    0.02),
                                                        child: FittedBox(
                                                          child: Text(
                                                            '${authProvider.lg[authProvider.language]["You don't have any upcoming occasions"]}',
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'BerlinSansFB'),
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .add_circle_outline_rounded,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                          Text(
                                                            '${authProvider.lg[authProvider.language]["Add an occasion"]}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'BerlinSansFB'),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Center(
                                          //     child:
                                          //         OccasionCard(Axis.horizontal)),
                                        ]),
                                      ))
                                  : Center(
                                      child: OccasionCard(Axis.horizontal)),
                              SizedBox(height: MediaQuery.of(context).size.height*0.02,),

                              //     SizedBox(height: MediaQuery.of(context).size.height*0.005),
                              package.cuisins.id != 0
                                  ? Container(
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 10,
                                              ),
                                              child: Text(
                                                '${authProvider.lg[authProvider.language]["Shishas"]}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              ),
                                            ),
                                            // SizedBox(width: mediaQuery.size.width*0.6),
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20,vertical: 10 ),
                                                child: GestureDetector(
                                                    child: Text(
                                                        '${authProvider.lg[authProvider.language]["See All"]}',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'BerlinSansFB')),
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              CuisinsScreen(
                                                                  package
                                                                      .cuisins
                                                                      .id),
                                                        ),
                                                      );
                                                    }))
                                          ],
                                        ),
                                        SizedBox(
                                            height:
                                                mediaQuery.size.height * 0.15,
                                            //width: mediaQuery.size.width,
                                            child: CuisinCard()),
                                        // SizedBox(height:mediaQuery.size.height * 0.212,
                                        //   child:adss[0]),
                                        //  SizedBox(height:mediaQuery.size.height * 0.212,
                                        //  child:adss[1]),
                                      ]),
                                    )
                                  : Container(),
                              // SizedBox(height: mediaQuery.size.height*0.05,)
                            ]),
                            // SizedBox(height: mediaQuery.size.height * 0.1,),

                            ...getAddOnsCard(package.addonsall),





                              Container(
                  height: mediaQuery.size.height/4,
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Padding(padding:
                        EdgeInsets.symmetric(
                          horizontal: 20,),
                          child: Text(
                            '${authProvider.lg[authProvider.language]["Gallery"]}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                              child:  Text('${authProvider.lg[authProvider.language]["See All"]}',

                                  style: TextStyle( fontSize: 12)),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => seeAllGallery()),

                                );
                              }),
                        )




                      ],
                    ),
                    package.allgallery.length!=0? Container(
                        height: MediaQuery.of(context).size.height/5,

                        child:     ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: package.allgallery.length+1,
                          itemBuilder: (context, i) {
                            //  final cards = widget.card[i];
                            return           InkWell(
                              onTap: () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullPhotoPage(url:  package.allgallery , ind: package.allgallery.length<i?(i-1):i),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 4),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: NetworkImage(package.allgallery[i].link,),fit: BoxFit.cover,),
                                    border: Border.all(style: BorderStyle.none),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  width: mediaQuery.size.width*0.43,
                                  height: mediaQuery.size.height*0.1,
                                ),
                              ),
                            );
                          },
                        )):Container(),
                  ]
                  )),







                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children:[ Text('${authProvider.lg[authProvider.language]["Follow Us"]}'
                                ,style:Theme.of(context)
                                  .textTheme
                                  .headline2,),



                            ]),
                            SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                         Column(
                           children: [
                             Padding(padding: EdgeInsets.all(8.0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                 children: [
                                   IconButton(onPressed: ()async{
                                     final url = 'https://www.facebook.com/caterme.ksa/';
                                     if(await canLaunch(url)){
                                       await launch(url,forceSafariVC: false);
                                     }


                                   } ,
                                     icon:Icon(

                                       FontAwesomeIcons.facebook,

                                       color: colorCustom,
                                       size: 40,
                                     ),),

                                   IconButton(onPressed: ()async{
                                     final url = 'https://www.instagram.com/caterme.online/?hl=en';
                                     if(await canLaunch(url)){
                                       await launch(url,forceSafariVC: false,);
                                     }


                                   },
                                     icon:Icon(

                                       FontAwesomeIcons.instagram,

                                       color: colorCustom,
                                       size: 40,
                                     ),),






                                   IconButton(
                                     onPressed: ()async{
                                       final url = 'https://www.linkedin.com/company/cater-me/';
                                       if(await canLaunch(url)){
                                         await launch(url,forceSafariVC: false);
                                       }


                                     } ,
                                     icon:Icon(

                                       FontAwesomeIcons.linkedin,

                                       color: colorCustom,
                                       size: 40,
                                     ),),
                                   IconButton(onPressed: ()async{
                                     final url = 'https://www.snapchat.com/add/caterme.online?share_id=Q0UzMUVF&locale=en_US';
                                     if(await canLaunch(url)){
                                       await launch(url,forceSafariVC: false);
                                     }


                                   } ,
                                     icon:Icon(

                                       FontAwesomeIcons.snapchat,

                                       color: colorCustom,
                                       size: 40,
                                     ),),


                                 ],
                               ),
                             ),

                             Padding(padding: EdgeInsets.all(8.0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                 children: [
                                   IconButton(onPressed: ()async{
                                     final url = "https://wa.me/${contact.UsContact.phoneNumber}";
                                     if(await canLaunch(url)){
                                       await launch(url,forceSafariVC: false);
                                     }


                                   } ,
                                     icon:Icon(

                                       FontAwesomeIcons.whatsapp,

                                       color: colorCustom,
                                       size: 40,
                                     ),),

                                   IconButton(onPressed: ()async{
                                     final url = 'https://twitter.com/caterme_online';
                                     if(await canLaunch(url)){
                                       await launch(url,forceSafariVC: false,);
                                     }


                                   },
                                     icon:Icon(

                                       FontAwesomeIcons.twitter,

                                       color: colorCustom,
                                       size: 40,
                                     ),),






                                   IconButton(
                                     onPressed: ()async{
                                       Navigator.of(context).push(
                                           MaterialPageRoute(
                                             builder: (context) =>
                                                 ChatPage(
                                                   peerId: "admin",
                                                   peerAvatar: "",
                                                   peerNickname:
                                                   '${authProvider.lg[authProvider.language]["Customer Service"]}',
                                                 ),
                                           ));



                                     } ,
                                     icon:Icon(

                                       Icons.live_help,

                                       color: colorCustom,
                                       size: 40,
                                     ),),
                                   IconButton(onPressed: ()async{
                                     final url = 'https://www.caterme.online/';
                                     if(await canLaunch(url)){
                                       await launch(url,forceSafariVC: false);
                                     }


                                   } ,
                                     icon:Icon(

                                       Icons.language,

                                       color: colorCustom,
                                       size: 40,
                                     ),),


                                 ],
                               ),
                             ),
                           ],
                         ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                          ]),
                    ),
                  ),
                )
              : ListView(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isSearch = false;
                            });
                          },
                          icon: Icon(Icons.arrow_back),
                        ),
                        SizedBox(
                            width: mediaQuery.size.width * 0.8,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: TextField(
                                autofocus: false,
                                onChanged: (searchText) {
                                  searchText = searchText.toLowerCase();
                                  setState(() {
                                    isSearch = true;
                                  });
                                  if (searchText == "")
                                    setState(() {
                                      isSearch = false;
                                    });
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(232, 232, 232, 1)),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(232, 232, 232, 1),
                                  hintText:
                                      '${authProvider.lg[authProvider.language]["Search"]}',
                                  prefixIcon: const Icon(Icons.search),
                                  prefixIconColor: Colors.black,
                                  hintStyle: TextStyle(
                                      color: Colors.grey[850],
                                      fontSize: 16,
                                      fontFamily: 'Segoe UI'),
                                ),
                                controller: controllersearch,
                              ),
                            )),

                      ],
                    ),

                    //items
                    Container(
                      color: LightColors.kLightYellow,
                      height: mediaQuery.size.height / 1.35,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(25),
                        itemCount: package.listItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return listitemssearch[index]
                                  .contains(controllersearch.text.toLowerCase())
                              ? Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              packageAdsDetailTest(
                                                  package.listItems[index]),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      color: LightColors.kLightYellow2,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      child: Container(
                                        // width: mediaQuery.size.width*0.8 ,
                                        height: mediaQuery.size.height * 0.1,
                                        child: Row(
                                          children: [
                                            Image.network(
                                              package.listItems[index].image,
                                              loadingBuilder: ((context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;

                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    // strokeWidth: 1,
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes
                                                        : null,
                                                  ),
                                                );
                                              }),
                                              height: 100,
                                              width: 100,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${package.listItems[index].title}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container();
                        },
                      ),
                    ),

                  ],
                )),
    );
  }
}
