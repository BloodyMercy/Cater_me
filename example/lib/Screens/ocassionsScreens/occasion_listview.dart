import 'package:CaterMe/Providers/occasion.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../NavigationBar/navigation_bar.dart';
import '../../Providers/user.dart';
import '../../language/language.dart';
import '../add_new_occasion.dart';
import '../auth/reset_password_screen.dart';
import '../auth/signup_screen.dart';
import '../edit_occasion.dart';

class OccasionListView extends StatefulWidget {
  @override
  State<OccasionListView> createState() => _OccasionListViewState();
}

class _OccasionListViewState extends State<OccasionListView> {
  bool loading = false;

  getData() async {
    // final occasion = Provider.of<PackagesProvider>(context, listen: false);
    //   await occasion.getalloccasions();

    final occa = Provider.of<OccasionProvider>(context, listen: false);
    await occa.getAllOccasionType();
    await occa.getallnewoccasion();
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  Future refreshocasionData() async {
    //   final occasion = Provider.of<PackagesProvider>(context, listen: false);
    final occa = Provider.of<OccasionProvider>(context, listen: false);

    occa.all.clear();
    occa.listoccasiontype.clear();
    await occa.getAllOccasionType();
    await occa.getallnewoccasion();

    return;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final occasion = Provider.of<PackagesProvider>(context, listen: true);
    final occa = Provider.of<OccasionProvider>(context, listen: true);
    var _mediaQuery = MediaQuery.of(context).size.height;
    final mediaQuery = MediaQuery.of(context);
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refreshocasionData,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              floating: false,
              expandedHeight: MediaQuery.of(context).size.height * 0.2,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: double.maxFinite,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(occa.listoccasiontype.length,
                          (int index) {
                        return GestureDetector(
                          onTap: () {
                            if (occa.listoccasiontype[index].id == -700) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AddNewOccasion(0),
                                ),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AddNewOccasion(index),
                                ),
                              );
                            }
                          },
                          child: Card(
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 3,
                              // width: ,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      occa.listoccasiontype[index].id == -700
                                          ? Icon(
                                              Icons.add,
                                              size: 40,
                                              color: colorCustom,
                                            )
                                          : Image.network(
                                              occa.listoccasiontype[index]
                                                  .image,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                            ),
                                      Text(
                                        occa.listoccasiontype[index].name,
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
            occa.all.length == 0
                ? SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Image.asset('images/NoOccassionsYet.png'),
                        ElevatedButton(onPressed: (){
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
                                        padding: EdgeInsets.only(top: 15.0),
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
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
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsets.only(left: 25.0),
                                              child: Center(
                                                child: Image(
                                                  image: AssetImage(
                                                      'images/logo.png'),
                                                  // width: 800,
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.4,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                height: screenHeight * 0.05),
                                            Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.only(
                                                  left: 37.0, right: 37.0),
                                              child: Column(
                                                children: [
                                                  Center(
                                                    child: Column(children: [
                                                      TextFormField(
                                                          style: const TextStyle(
                                                              color:
                                                              Colors.grey,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight
                                                                  .normal,
                                                              fontFamily:
                                                              'BerlinSansFB'),
                                                          decoration:
                                                          InputDecoration(
                                                              prefixIcon:
                                                              IconButton(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .mail_outline),
                                                                onPressed:
                                                                    () {},
                                                              ),
                                                              focusedErrorBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    5.0),
                                                                borderSide:
                                                                const BorderSide(
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                              errorBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    5.0),
                                                                borderSide:
                                                                const BorderSide(
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                              contentPadding:
                                                              EdgeInsets.only(
                                                                  left: MediaQuery.of(context).size.width *
                                                                      0.04),
                                                              alignLabelWithHint:
                                                              true,
                                                              labelStyle:
                                                              TextStyle(
                                                                //fontSize: focusNode.hasFocus ? 18 : 16.0,
                                                                //I believe the size difference here is 6.0 to account padding
                                                                  color:
                                                                  // focusNode.hasFocus
                                                                  //?
                                                                  Color(
                                                                      0xFF3F5521)
                                                                // : Colors.grey
                                                              ),
                                                              labelText:
                                                              '${LanguageTr.lg[authProvider.language]["Email"]}',
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize:
                                                                  15,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontFamily:
                                                                  'BerlinSansFB'),
                                                              filled: true,
                                                              fillColor:
                                                              Colors
                                                                  .white,
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    5.0),
                                                                borderSide:
                                                                const BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(
                                                                      5.0),
                                                                  borderSide:
                                                                  const BorderSide(
                                                                    color:
                                                                    Color(0xFF3F5521),
                                                                  ))),
                                                          //controller: authProvider.email,
                                                          autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                          keyboardType:
                                                          TextInputType
                                                              .emailAddress),
                                                      SizedBox(
                                                        height: screenHeight *
                                                            0.015,
                                                      ),
                                                      TextFormField(
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15,
                                                            fontWeight:
                                                            FontWeight
                                                                .normal,
                                                            fontFamily:
                                                            'BerlinSansFB'),
                                                        decoration:
                                                        InputDecoration(
                                                            prefixIcon:
                                                            IconButton(
                                                              icon: Icon(
                                                                //passObscure
                                                                //?
                                                                  Icons
                                                                      .lock_outlined
                                                                //: Icons.lock_open_outlined,
                                                              ),
                                                              onPressed:
                                                                  () {
                                                                setState(
                                                                        () {
                                                                      //passObscure = !passObscure;
                                                                    });
                                                              },
                                                            ),
                                                            focusedErrorBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              borderSide:
                                                              const BorderSide(
                                                                color: Colors
                                                                    .red,
                                                              ),
                                                            ),
                                                            errorBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              borderSide:
                                                              const BorderSide(
                                                                color: Colors
                                                                    .red,
                                                              ),
                                                            ),
                                                            contentPadding: EdgeInsets.only(
                                                                left: MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                    0.04),
                                                            alignLabelWithHint:
                                                            true,
                                                            labelStyle:
                                                            TextStyle(
                                                              //fontSize: focusNode.hasFocus ? 18 : 16.0,
                                                              //I believe the size difference here is 6.0 to account padding
                                                                color: //focusNode.hasFocus
                                                                // ?
                                                                Color(
                                                                    0xFF3F5521)
                                                              //   : Colors.grey
                                                            ),
                                                            labelText:
                                                            '${LanguageTr.lg[authProvider.language]["Password"]}',
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize:
                                                                15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontFamily:
                                                                'BerlinSansFB'),
                                                            filled: true,
                                                            fillColor:
                                                            Colors
                                                                .white,
                                                            enabledBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              borderSide:
                                                              const BorderSide(
                                                                color: Colors
                                                                    .grey,
                                                              ),
                                                            ),
                                                            focusedBorder:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    5.0),
                                                                borderSide:
                                                                const BorderSide(
                                                                  color:
                                                                  Color(0xFF3F5521),
                                                                ))),
                                                        //controller: authProvider.password,
                                                        // validator: validatePass,
                                                        autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,

                                                        keyboardType:
                                                        TextInputType
                                                            .visiblePassword,
                                                        //obscureText: passObscure,
                                                      ),
                                                    ]),
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight * 0.01,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .stretch,
                                                    children: [
                                                      InkWell(
                                                        child: RichText(
                                                          textAlign:
                                                          TextAlign.end,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          text: TextSpan(
                                                            text:
                                                            '${LanguageTr.lg[authProvider.language]["Forgot Password?"]}',
                                                            style: Theme.of(
                                                                context)
                                                                .textTheme
                                                                .headline3,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                  const ResetPasswordScreen()));
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight * 0.06,
                                                  ),
                                                  // !loading
                                                  // ?
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        //loading = true;
                                                      });
                                                      // final SharedPreferences sharedPreferences =
                                                      //     await SharedPreferences.getInstance();
                                                      // sharedPreferences.setString(
                                                      //     'email', emailController.text);

                                                      if (false) {
                                                        // ignore: avoid_print
                                                        print('Not Validated');
                                                        setState(() {
                                                          //loading = false;
                                                        });
                                                        // reset!=null?
                                                      } else {
                                                        if (true) {
                                                          print("logged");
                                                          setState(() {
                                                            // loading = false;
                                                          });
                                                          SharedPreferences sh =
                                                          await SharedPreferences
                                                              .getInstance();
                                                          sh.setBool(
                                                              "logged", true);

                                                          Navigator.of(context).pushAndRemoveUntil(
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      Navigationbar(
                                                                          0)),
                                                                  (Route<dynamic>
                                                              route) =>
                                                              false);
                                                          //authProvider.status=Status.Authenticated;
                                                          setState(() {});
                                                        }
                                                      }
                                                    },
                                                    child: Text('${LanguageTr.lg[authProvider.language]["Log In"]}',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontFamily:
                                                            'BerlinSansFB',
                                                            fontSize: 16)),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      padding:
                                                      EdgeInsets.fromLTRB(
                                                          screenHeight *
                                                              0.14,
                                                          screenHeight *
                                                              0.02,
                                                          screenHeight *
                                                              0.14,
                                                          screenHeight *
                                                              0.02),
                                                      onPrimary:
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      primary: Theme.of(context)
                                                          .primaryColor,
                                                      shape:
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(15.0),
                                                      ),
                                                    ),
                                                  ),
                                                  //: Center(child: CircularProgressIndicator()),
                                                  SizedBox(
                                                    height: screenHeight * 0.03,
                                                  ),
                                                  Center(
                                                    child: InkWell(
                                                      child: FittedBox(
                                                        child: Text(
                                                          '${LanguageTr.lg[authProvider.language]["Create New Account"]}',
                                                          style:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .headline3,
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
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
                        }, child: Text( '${LanguageTr.lg[authProvider.language]["Log In"]}',))
                      ],
                    ),

                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                    (context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditOccasion(occa.all[index]),
                            ),
                          );
                        },
                        child: Container(
                          child: Card(
                            elevation: 3,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromRGBO(63, 85, 33, 1),
                                  ),
                                  height: mediaQuery.size.height * 0.17,
                                  width: mediaQuery.size.width * 0.25,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${DateFormat.MMM().format(DateTime.parse(occa.all[index].date))}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                          '${DateFormat.d().format(DateTime.parse(occa.all[index].date))}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                                // SizedBox(
                                //   width: mediaQuery.size.width * 0.1,),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      children: [
                                        Text('${occa.all[index].name}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                        // SizedBox(
                                        //   height: 65,
                                        // ),
                                        Text('${occa.all[index].type}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                            '${LanguageTr.lg[authProvider.language]["edit"]}',
                                            //  locale: ,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 13,
                                                decoration:
                                                    TextDecoration.underline)

                                            // Theme.of(context)
                                            //     .textTheme
                                            //     .overline,
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width:
                                //       MediaQuery.of(context).size.width / 3,
                                // ),

                                Expanded(
                                  child: Image.network(
                                    occa.all[index].image,
                                    // width:
                                    //     MediaQuery.of(context).size.width / 5.5,
                                  ),
                                ),
                                //  ],
                                //  )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: occa.all.length,
                  ))
          ],
        ),
      ),
    );
  }
}
