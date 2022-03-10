import 'package:CaterMe/Providers/notification_provider.dart';
import 'package:CaterMe/Providers/orderStatus_provider.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/orders/mainOrderId.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NavigationBar/navigation_bar.dart';
import '../Providers/user.dart';
import '../chat/pages/chat_page.dart';
import '../language/language.dart';
import 'auth/reset_password_screen.dart';
import 'auth/signup_screen.dart';
import 'occasion/theme/colors/light_colors.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool loading = true;

  getData() async {
    final allNotification =
        Provider.of<NotificationProvider>(context, listen: false);
    await allNotification.getAllNotifications();

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }


  Future refreshdata() async {
    final allNotification =
    Provider.of<NotificationProvider>(context, listen: false);

    await allNotification.ClearAllNotifications();
    await allNotification.getAllNotifications();

    return;
  }


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);


    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final orderStatus = Provider.of<OrderStatusProvider>(context, listen: true);
    final allNotification =
        Provider.of<NotificationProvider>(context, listen: true);
    final package = Provider.of<PackagesProvider>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(

          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // shape: const RoundedRectangleBorder(
            //   borderRadius: BorderRadius.vertical(
            //     bottom: Radius.circular(15),
            //   ),
            // ),
            centerTitle: true,
            title: Text('${LanguageTr.lg[authProvider.language]["Notifications"]}'
              ,
              style: Theme.of(context).textTheme.headline1,
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: loading
              ? Container(
                  color: LightColors.kLightYellow,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF3F5521),
                    ),
                  ),
                )
              : allNotification.notificationlist.length == 0? authProvider.status == Status.Authenticated
                  ? Column(
                    children: [
                      Image.asset('images/nonotificationyet.png'),

                    ],
                  )
              : Column(
            children: [
              Image.asset('images/noorderyet.png'),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    context: context,
                    builder: (context) {
                      return SafeArea(
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 15.0),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(
                                              context);
                                        },
                                        icon: Icon(
                                          Icons.clear,
                                          size: 30,
                                        )),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    Padding(
                                      padding:
                                      EdgeInsets.only(
                                          left: 25.0),
                                      child: Center(
                                        child: Image(
                                          image: AssetImage(
                                              'images/logo.png'),
                                          // width: 800,
                                          height: MediaQuery.of(
                                              context)
                                              .size
                                              .height *
                                              0.4,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                        screenHeight *
                                            0.05),
                                    Container(
                                      width:
                                      double.infinity,
                                      padding:
                                      const EdgeInsets
                                          .only(
                                          left: 37.0,
                                          right: 37.0),
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Column(
                                                children: [
                                                  TextFormField(
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.normal,
                                                          fontFamily: 'BerlinSansFB'),
                                                      decoration: InputDecoration(
                                                          prefixIcon: IconButton(
                                                            icon: const Icon(Icons.mail_outline),
                                                            onPressed: () {},
                                                          ),
                                                          focusedErrorBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(5.0),
                                                            borderSide: const BorderSide(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                          errorBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(5.0),
                                                            borderSide: const BorderSide(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                          contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
                                                          alignLabelWithHint: true,
                                                          labelStyle: TextStyle(
                                                            //fontSize: focusNode.hasFocus ? 18 : 16.0,
                                                            //I believe the size difference here is 6.0 to account padding
                                                              color:
                                                              // focusNode.hasFocus
                                                              //?
                                                              Color(0xFF3F5521)
                                                            // : Colors.grey
                                                          ),
                                                          labelText: "Email",
                                                          hintStyle: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'BerlinSansFB'),
                                                          filled: true,
                                                          fillColor: Colors.white,
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(5.0),
                                                            borderSide: const BorderSide(
                                                              color: Colors.grey,
                                                            ),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(5.0),
                                                              borderSide: const BorderSide(
                                                                color: Color(0xFF3F5521),
                                                              ))),
                                                      //controller: authProvider.email,
                                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                                      keyboardType: TextInputType.emailAddress),
                                                  SizedBox(
                                                    height: screenHeight *
                                                        0.015,
                                                  ),
                                                  TextFormField(
                                                    style: const TextStyle(
                                                        color: Colors
                                                            .grey,
                                                        fontSize:
                                                        15,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        fontFamily: 'BerlinSansFB'),
                                                    decoration: InputDecoration(
                                                        prefixIcon: IconButton(
                                                          icon: Icon(
                                                            //passObscure
                                                            //?
                                                              Icons.lock_outlined
                                                            //: Icons.lock_open_outlined,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              //passObscure = !passObscure;
                                                            });
                                                          },
                                                        ),
                                                        focusedErrorBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(5.0),
                                                          borderSide: const BorderSide(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                        errorBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(5.0),
                                                          borderSide: const BorderSide(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                        contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
                                                        alignLabelWithHint: true,
                                                        labelStyle: TextStyle(
                                                          //fontSize: focusNode.hasFocus ? 18 : 16.0,
                                                          //I believe the size difference here is 6.0 to account padding
                                                            color: //focusNode.hasFocus
                                                            // ?
                                                            Color(0xFF3F5521)
                                                          //   : Colors.grey
                                                        ),
                                                        labelText: 'Password',
                                                        hintStyle: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'BerlinSansFB'),
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(5.0),
                                                          borderSide: const BorderSide(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(5.0),
                                                            borderSide: const BorderSide(
                                                              color: Color(0xFF3F5521),
                                                            ))),
                                                    //controller: authProvider.password,
                                                    // validator: validatePass,
                                                    autovalidateMode:
                                                    AutovalidateMode.onUserInteraction,

                                                    keyboardType:
                                                    TextInputType.visiblePassword,
                                                    //obscureText: passObscure,
                                                  ),
                                                ]),
                                          ),
                                          SizedBox(
                                            height:
                                            screenHeight *
                                                0.01,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .stretch,
                                            children: [
                                              InkWell(
                                                child:
                                                RichText(
                                                  textAlign:
                                                  TextAlign
                                                      .end,
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  text:
                                                  TextSpan(
                                                    text:
                                                    "Forgot Password",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3,
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => const ResetPasswordScreen()));
                                                },
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                            screenHeight *
                                                0.06,
                                          ),
                                          // !loading
                                          // ?
                                          ElevatedButton(
                                            onPressed:
                                                () async {
                                              setState(() {
                                                //loading = true;
                                              });
                                              // final SharedPreferences sharedPreferences =
                                              //     await SharedPreferences.getInstance();
                                              // sharedPreferences.setString(
                                              //     'email', emailController.text);

                                              if (false) {
                                                // ignore: avoid_print
                                                print(
                                                    'Not Validated');
                                                setState(
                                                        () {
                                                      //loading = false;
                                                    });
                                                // reset!=null?
                                              } else {
                                                if (true) {
                                                  print(
                                                      "logged");
                                                  setState(
                                                          () {
                                                        // loading = false;
                                                      });
                                                  SharedPreferences
                                                  sh =
                                                  await SharedPreferences
                                                      .getInstance();
                                                  sh.setBool(
                                                      "logged",
                                                      true);

                                                  Navigator.of(context).pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) => Navigationbar(
                                                              0)),
                                                          (Route<dynamic> route) =>
                                                      false);
                                                  //authProvider.status=Status.Authenticated;
                                                  setState(
                                                          () {});
                                                } else {
                                                  print(
                                                      "hello");
                                                  setState(
                                                          () {
                                                        //loading = false;
                                                      });
                                                  //_scaffoldKey.currentState.showSnackBar(
                                                  //SnackBar(
                                                  // content: Text(
                                                  //"${authProvider.messagelogin.toString()}"),
                                                  // ),
                                                  //);
                                                  //authProvider.messagelogin = "";
                                                }
                                              }
                                            },
                                            child: Text(
                                                'Log In',
                                                style: TextStyle(
                                                    color: Colors
                                                        .white,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    fontFamily:
                                                    'BerlinSansFB',
                                                    fontSize:
                                                    16)),
                                            style: ElevatedButton
                                                .styleFrom(
                                              padding: EdgeInsets.fromLTRB(
                                                  screenHeight *
                                                      0.14,
                                                  screenHeight *
                                                      0.02,
                                                  screenHeight *
                                                      0.14,
                                                  screenHeight *
                                                      0.02),
                                              onPrimary:
                                              const Color
                                                  .fromRGBO(
                                                  255,
                                                  255,
                                                  255,
                                                  1),
                                              primary: Theme.of(
                                                  context)
                                                  .primaryColor,
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    15.0),
                                              ),
                                            ),
                                          ),
                                          //: Center(child: CircularProgressIndicator()),
                                          SizedBox(
                                            height:
                                            screenHeight *
                                                0.03,
                                          ),
                                          Center(
                                            child: InkWell(
                                              child:
                                              FittedBox(
                                                child: Text(
                                                  "Create New Account",
                                                  style: Theme.of(
                                                      context)
                                                      .textTheme
                                                      .headline3,
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator
                                                    .push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                    const SignupScreen(),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  '${LanguageTr.lg[authProvider.language]["Log In"]}',
                ),
              )
            ],
          )
                  : RefreshIndicator(
            onRefresh: refreshdata,
                    child: Container(
                        color: LightColors.kLightYellow,
                        child: ListView.builder(
                            itemCount: allNotification.notificationlist.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if(  allNotification
                                      .notificationlist[index]
                                      .description.contains("Message"))

                                    {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (builder) => ChatPage(
                                            peerId: "admin",
                                            peerAvatar: "",
                                            peerNickname:
                                            "Customer Service",
                                          )
                                            ,
                                        ),
                                      );
                                    }


                                    else {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (builder) =>
                                            OrderId(
                                                allNotification
                                                    .notificationlist[index]
                                                    .orderId,
                                                1),
                                      ),
                                    );
                                  }
                                  allNotification.markAsRead(
                                      allNotification.notificationlist[index].id);
                                  if (!allNotification
                                      .notificationlist[index].seen) {
                                    var i = int.parse(package.nbnotification);
                                    i--;
                                    package.nbnotification = i.toString();
                                  }
                                },
                                child: Card(
                                  color: LightColors.kLightYellow2,
                                  // elevation: 5,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 10, 30, 30),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        allNotification
                                                .notificationlist[index].seen
                                            ? FaIcon(
                                                FontAwesomeIcons.checkDouble,
                                                color: colorCustom,
                                              )
                                            : Container(),
                                        Row(
                                          children: [
                                            // Padding(
                                            //   padding: const EdgeInsets.only(right: 20.0),
                                            //   child: CircleAvatar(
                                            //     minRadius: 16,
                                            //     maxRadius: screenHeight * 0.04,
                                            //     backgroundImage:
                                            //         AssetImage('images/food33.jpg'),
                                            //   ),
                                            // ),
                                            Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      allNotification
                                                          .notificationlist[index]
                                                          .title,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                                    Text(
                                                      allNotification
                                                          .notificationlist[index]
                                                          .description,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black87),
                                                    ),
                                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                                    Text(
                                                        '${DateFormat.yMd().add_jm().format(DateTime.parse(allNotification.notificationlist[index].date))}',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black26),
                                                    ),
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // child: ListTile(
                                    //   onTap: () {
                                    //     Navigator.of(context).push(
                                    //       MaterialPageRoute(
                                    //         builder: (builder) => OrderId(index, 1),
                                    //       ),
                                    //     );
                                    //   },
                                    //   leading: CircleAvatar(
                                    //     minRadius: 16,
                                    //     maxRadius: screenHeight * 0.1,
                                    //     backgroundImage: AssetImage('images/food33.jpg'),
                                    //   ),
                                    //
                                    //   title: Text(allNotification
                                    //       .notificationlist[index].title),
                                    //   subtitle: Text(allNotification
                                    //       .notificationlist[index].description),
                                    // ),
                                  ),
                                ),
                              );
                            }),
                      ),
                  )),
    );
  }
}
