import 'package:CaterMe/Providers/order.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/Screens/orders/mainOrderId.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../NavigationBar/navigation_bar.dart';
import '../../Providers/user.dart';
import '../../language/language.dart';
import '../auth/reset_password_screen.dart';
import '../auth/signup_screen.dart';

class YourOrders extends StatefulWidget {
  const YourOrders({Key key}) : super(key: key);

  @override
  _YourOrdersState createState() => _YourOrdersState();
}

class _YourOrdersState extends State<YourOrders> {
  bool loading = true;

  Future getData() async {
    final orders = Provider.of<OrderProvider>(context, listen: false);
    await orders.getAllOrders();

    setState(() {
      loading = false;
    });
    return;
  }

  Future refreshOrderData() async {
    final orders = Provider.of<OrderProvider>(context, listen: false);

    await orders.clearData();
    await orders.getAllOrders();
    return;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Color _getColorByEvent(String orderStatus) {
    if (orderStatus == "Accetped") return  Color(0xFF3F5521);
    if (orderStatus == "Received") return  Color(0xFF3F5521);
    if (orderStatus == "Rejected") return Color(0xFFEA4D47);
    if (orderStatus == "Pending ") return  Color(0xFFEAB316);
    if (orderStatus == "Delivered") return Color(0xFF272833);

    return Colors.blue;
  }

  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final orders = Provider.of<OrderProvider>(context, listen: true);
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('${LanguageTr.lg[authProvider.language][  "My Orders"]}',style: Theme.of(context).textTheme.headline1,),
        centerTitle: true,),
        body: RefreshIndicator(
          onRefresh: refreshOrderData,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    :orders.listOrder.length==0?Column(
                  children: [
                    Center(child: Image.asset('images/noorderyet.png')),
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
                                                          "Email",
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
                                                        'Password',
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
                                                        "Forgot Password",
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
                                                    } else {
                                                      print("hello");
                                                      setState(() {
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
                                                child: Text('Log In',
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
                                                      "Create New Account",
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
                    }, child: Text('Sign in'))
                  ],
                ):Container(
                  color: LightColors.kLightYellow,
                        child: ListView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (builder) =>
                                      OrderId(orders.listOrder[index].id, 0),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 5,
                              color: LightColors.kLightYellow2,
                                child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(orders.listOrder[index].eventName,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        orders.listOrder[index].orderStatus,
                                        style: TextStyle(
                                          color: _getColorByEvent(orders
                                              .listOrder[index]
                                              .orderStatus.toString()),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${DateFormat("dd-MM-yyyy").format(DateTime.parse(orders.listOrder[index].eventDate))}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(

                                    "${LanguageTr.lg[authProvider.language][ "Address"]}, ${orders.listOrder[index].addressTitle}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                            )),
                          );
                        },
                        itemCount: orders.listOrder.length,
                      ))),
          ),
        ),
      ),
    );
  }
}
