import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/widgets/occasions/occasions_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NavigationBar/navigation_bar.dart';
import '../Providers/user.dart';
import '../language/language.dart';
import 'auth/reset_password_screen.dart';
import 'auth/signup_screen.dart';
import 'occasion/theme/colors/light_colors.dart';

class MyFavorites extends StatefulWidget {
  const MyFavorites({Key key}) : super(key: key);

  @override
  State<MyFavorites> createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  bool loading = true;


  getData() async {
    final package = Provider.of<PackagesProvider>(context, listen: false);
    await package.getAllFavorite();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    final package = Provider.of<PackagesProvider>(context, listen: true);

    final mediaQuery = MediaQuery.of(context);
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            iconSize: 30,
          ),
          elevation: 0,

          centerTitle: true,
          title: Text('${LanguageTr.lg[authProvider.language]["My Favorites"]}',
           
            style: Theme.of(context).textTheme.headline1,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          color: LightColors.kLightYellow,
          child: SafeArea(
            child: Center(
              child: !loading
                  ? package.listfavorite.length == 0 ?authProvider.status== Status.Authenticated
                ? Column(
                        children: [
                          Image.asset("images/nofavorites.png"),

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
                      : SingleChildScrollView(
                        child: GestureDetector(
                          onTap:() {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         AdsitemDetail(
                            //             ),
                            //   ),
                            // );
                          },
                          child: Column(
                              children: [...getFavorites(package.listfavorite)],
                            ),
                        ),
                      )
                  : Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF3F5521),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
