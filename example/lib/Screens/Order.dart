import 'package:CaterMe/Payment/OrderSucc.dart';
import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/credit_card_provider.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/CustomAlert/alert.dart';
import 'package:CaterMe/Screens/addresses_screen.dart';
import 'package:CaterMe/Screens/donate/donatesteps.dart';
import 'package:CaterMe/Screens/order_summery_copy.dart';
import 'package:CaterMe/Screens/regular_daberne_screen.dart';
import 'package:CaterMe/Screens/regular_screen.dart';
import 'package:CaterMe/Screens/related_offers_screen.dart';
import 'package:CaterMe/widgets/Customer_stepper.dart';
import 'package:CaterMe/widgets/Payment/credit_cards_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Providers/orderById_provider.dart';
import '../Providers/user.dart';
import '../language/language.dart';
import '../webview/webview.dart';
import 'Addons/orderpages/steps.dart';
import 'CustomAlert3/CustomAlert3.dart';
import 'check out/SetupItems.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final _controller = ScrollController();
  ScrollController _verticatl = ScrollController();
  var _key = GlobalKey<ScaffoldState>();

  bool loadingnext = false;

  ///  DatabaseMethods databaseMethods = new DatabaseMethods();

  double barheight = 0.0;
  String url3ds = "";

  Future<bool> _onWillPop() async {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    return (await showDialog(
            context: context,
            builder: (context) => Dialog(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Stack(
                  overflow: Overflow.visible,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.30,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.09,
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: Column(
                          children: [
                            Text(
                              '${authProvider.lg[authProvider.language]["Are you sure you want to exit?"]}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.02),
                              child: Divider(
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.01),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    child: TextButton(
                                      child: Text(
                                        '${authProvider.lg[authProvider.language]["Yes"]}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        clearAlldata();

                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  TextButton(
                                    child: Text(
                                      '${authProvider.lg[authProvider.language]["No"]}',
                                      style: TextStyle(color: Colors.white),
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
                        top: -MediaQuery.of(context).size.height * 0.06,
                        child: Image.asset(
                          'images/Logoicon.png',
                          height: 100,
                        )),
                  ],
                ))
            //     CustomDialog(
            //   title: '${authProvider.lg[authProvider.language]["Are you sure you want to exit?"]}',
            //
            //   description: "",
            //   button1: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         primary: Colors.grey,
            //       ),
            //       onPressed: () {
            //         clearAlldata();
            //
            //         Navigator.of(context).pop();
            //         Navigator.of(context).pop();
            //       },
            //       child: Text('${authProvider.lg[authProvider.language]["Yes"]}')),
            //   oneOrtwo: true,
            //   button2: ElevatedButton(
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //     child: Text('${authProvider.lg[authProvider.language]["No"]}'),
            //   ),
            // ),
            )) ??
        false;
  }

  getucustomerdata() async {}

  getprofdata() async {}
  int steps;

  @override
  initState() {
    super.initState();
    steps = 1;
    getData();

    // getprofdata();
  }

  bool loading = false;
  int total = 0;

  bool ispressed = false;

  getData() async {
    final address = Provider.of<AdressProvider>(context, listen: false);
    address.typeofeventcontroller.text = "1";
    SharedPreferences sh = await SharedPreferences.getInstance();
    await address.getRegular(sh.getString("locale"));
  }

  clearAlldata() {
    final clearData = Provider.of<AdressProvider>(context, listen: false);
    clearData.clearAllData();

    return;
  }

  void _animateToIndex(int index) {
    setState(() {
      _verticatl.animateTo(
        (index * MediaQuery.of(context).size.width / 4).toDouble(),
        duration: Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    final _creditCardss =
        Provider.of<CreditCardsProvider>(context, listen: true);
    final addresses = Provider.of<AdressProvider>(context, listen: true);

    // final address = Provider.of<OrderCaterProvider>(context, listen: true);
    final details = Provider.of<OrderCaterProvider>(context, listen: true);
    final orderProvider =
        Provider.of<OrderCaterProvider>(context, listen: true);
    final packageProvider =
        Provider.of<PackagesProvider>(context, listen: true);

    var screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    final address = Provider.of<AdressProvider>(context, listen: true);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          key: _key,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              '${authProvider.lg[authProvider.language]["Order"]}',
              style: const TextStyle(
                  color: Color(0xFF3F5521),
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.close,
                color: const Color(0xFF3F5521),
              ),
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
                                            '${authProvider.lg[authProvider.language]["Are you sure you want to exit?"]}',
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
                                                      '${authProvider.lg[authProvider.language]["Yes"]}',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    onPressed: () {
                                                      orderProvider.spets = 1;

                                                      clearAlldata();

                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();
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
                              ))
                          //   CustomDialog(
                          //   title:
                          //       '${authProvider.lg[authProvider.language]["Are you sure you want to exit?"]}',
                          //   description: "",
                          //   button1: ElevatedButton(
                          //       style: ElevatedButton.styleFrom(
                          //         primary: Colors.grey,
                          //       ),
                          //       onPressed: () {
                          //         orderProvider.spets = 1;
                          //
                          //         clearAlldata();
                          //
                          //         Navigator.of(context).pop();
                          //         Navigator.of(context).pop();
                          //       },
                          //       child: Text(
                          //           '${authProvider.lg[authProvider.language]["Yes"]}')),
                          //   oneOrtwo: true,
                          //   button2: ElevatedButton(
                          //     onPressed: () {
                          //       Navigator.of(context).pop();
                          //     },
                          //     child: Text(
                          //         '${authProvider.lg[authProvider.language]["No"]}'),
                          //   ),
                          // )
                          ;
                    });
              },
            ),
          ),
          body: true
              ? SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: height * 0.88,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _verticatl,
                            child: Column(
                              children: [
                                CustomStepper(
                                  controller: _controller,
                                  onTap: (int value) {},
                                  text: [
                                    '${authProvider.lg[authProvider.language]["Location"]}',
                                    '${authProvider.lg[authProvider.language]["Event Details"]}',
                                    !orderProvider.setup
                                        ? '${authProvider.lg[authProvider.language]["Service"]}'
                                        : '${authProvider.lg[authProvider.language]["Setup"]}',
                                    '${authProvider.lg[authProvider.language]["Menus"]}',
                                    '${authProvider.lg[authProvider.language]["Add-Ons"]}',
                                    '${authProvider.lg[authProvider.language]["Checkout"]}',
                                    orderProvider.spets != 8
                                        ? '${authProvider.lg[authProvider.language]["Payment"]}'
                                        : '${authProvider.lg[authProvider.language]["OTP Verification"]}',
                                  ],
                                  selected: orderProvider.spets,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          height: 30,
                          thickness: 1,
                          indent: 1,
                          endIndent: 0,
                          color: Color(0xFF3F5521),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 1.65,
                          child: (orderProvider.spets == 1)
                              ? AddAddressScreen()
                              : (orderProvider.spets == 3)
                                  ? RegularDaberneScreen()
                                  : (orderProvider.spets == 2)
                                      ? ReguarScreen(addresses.Friends)
                                      : (orderProvider.spets == 4)
                                          ? RelatedOffersScreen()
                                          : (orderProvider.spets == 5)
                                              ? AddonsCardoffer(0)
                                              : (orderProvider.spets == 7)
                                                  ? CreditCardsPage()
                                                  : (orderProvider.spets == 8)
                                                      ? InAppWebViewPage(url3ds)
                                                      : (orderProvider.spets ==
                                                              6)
                                                          ? OrderSummeryCopy(
                                                              orderProvider
                                                                  .totale)
                                                          : Container(),
                        ),
                        Expanded(
                          child: Container(
                              // color: Colors.yellow,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    (orderProvider.spets > 1 &&
                                            !orderProvider.paymemtstep)
                                        ? !orderProvider.finaldonatesteps
                                            ? IconButton(
                                                onPressed: () {
                                                  if (details.setup) {
                                                    details.setup = false;
                                                  } else {
                                                    orderProvider.spets =
                                                        orderProvider.spets - 1;
                                                    _animateToIndex(
                                                        orderProvider.spets);
                                                  }
                                                },
                                                icon: Icon(Icons.arrow_back,
                                                    size: 35,
                                                    color: Color.fromRGBO(
                                                        63, 85, 33, 1)))
                                            : Container()
                                        : Container(),
                                    orderProvider.spets > 3
                                        ? !orderProvider.finaldonatesteps
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${authProvider.lg[authProvider.language]["Total"]} ${details.totale.toStringAsFixed(2)} ${authProvider.lg[authProvider.language]["SAR"]}",
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontFamily:
                                                            'BerlinSansFB',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.02,
                                                  ),
                                                  orderProvider.vatshisha > 0.0
                                                      ? Text(
                                                          '${authProvider.lg[authProvider.language]['*(Shisha VAT 100%)']}',
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        )
                                                      : Container(),
                                                  orderProvider.vatfood > 0.0
                                                      ? Text(
                                                          '${authProvider.lg[authProvider.language]["*(VAT included 15%)"]}',
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        )
                                                      : Container(),
                                                ],
                                              )
                                            : Container()
                                        : Container(),
                                    !loadingnext
                                        ? !orderProvider.finaldonatesteps
                                            ? details.issearch? ElevatedButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    loadingnext = true;
                                                  });

                                                  if (orderProvider.spets ==
                                                      1) {
                                                    if (orderProvider
                                                            .value.id ==
                                                        0) {
                                                      _key.currentState
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            '${authProvider.lg[authProvider.language]["Please choose an address"]}',
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      await orderProvider
                                                          .getdistance();

                                                      if (orderProvider
                                                          .coverageAddressModel
                                                          .isInCoverage) {
                                                        // if(true) {
                                                        orderProvider.spets++;
                                                        _animateToIndex(
                                                            orderProvider
                                                                .spets);
                                                      } else {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return CustomDialog3(
                                                                title:
                                                                    '${orderProvider.coverageAddressModel.message}',
                                                                description: "",
                                                                oneOrtwo: true,
                                                                button2:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                    '${authProvider.lg[authProvider.language]["Close"]}',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'BerlinSansFB'),
                                                                  ),
                                                                ),
                                                                // button1: ElevatedButton(
                                                                //   onPressed: () {
                                                                //     Navigator.of(context).pop();
                                                                //   },
                                                                //   child: Text(
                                                                //       '${authProvider.lg[authProvider.language]["Close"]}',
                                                                //       style: TextStyle(
                                                                //           fontFamily:
                                                                //           'BerlinSansFB')),
                                                                // ),
                                                              );
                                                            });
                                                      }
                                                      // _key.currentState
                                                      //     .showSnackBar(
                                                      //   SnackBar(
                                                      //     content: Text('${authProvider.lg[authProvider.language]["Sorry! We are fully booked."]}',
                                                      //     ),
                                                      //   ),
                                                      // );}
                                                    }
                                                  } else if (orderProvider
                                                          .spets ==
                                                      3) {
                                                    if (orderProvider
                                                            .serviceId ==
                                                        0) {
                                                      _key.currentState
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              '${authProvider.lg[authProvider.language]["Please choose one from the following offers "]}'),
                                                        ),
                                                      );
                                                    } else if (!details.setup) {
                                                      details.setup = true;
                                                    } else {
                                                      orderProvider.spets++;

                                                      _animateToIndex(
                                                          orderProvider.spets);
                                                    }
                                                  } else if (orderProvider
                                                          .spets ==
                                                      2) {
                                                    if (address.eventnamecontroller.text == "" ||
                                                        address.evendatecontroller
                                                                .text ==
                                                            "" ||
                                                        address.numberofguestcontroller
                                                                .text ==
                                                            "") {
                                                      _key.currentState
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              '${authProvider.lg[authProvider.language]["Please fill the empty fields"]}'),
                                                        ),
                                                      );
                                                    } else {
                                                      if (address.form) {
                                                        if (address.name.text ==
                                                                "" ||
                                                            address.phone
                                                                    .text ==
                                                                "") {
                                                          _key.currentState
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                '${authProvider.lg[authProvider.language]["Please fill the empty fields"]}',
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          await address
                                                              .checktime();
                                                          if (address
                                                              .hours.isDaberni)
                                                            orderProvider
                                                                .serviceId = 2;
                                                          orderProvider.spets++;

                                                          _animateToIndex(
                                                              orderProvider
                                                                  .spets);
                                                        }
                                                      } else {
                                                        await address
                                                            .checktime();
                                                        if (address
                                                            .hours.isDaberni)
                                                          orderProvider
                                                              .serviceId = 2;
                                                        orderProvider.spets++;

                                                        _animateToIndex(
                                                            orderProvider
                                                                .spets);
                                                      }
                                                    }
                                                  } else if (orderProvider
                                                          .spets ==
                                                      6) {
                                                    if (orderProvider
                                                            .totalpackage ==
                                                        0) {
                                                      _key.currentState
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              '${authProvider.lg[authProvider.language]["please choose a package to order"]}'),
                                                        ),
                                                      );
                                                    } else if (orderProvider
                                                                .totalssha <
                                                            5 &&
                                                        orderProvider
                                                                .vatshisha !=
                                                            0.0) {
                                                      _key.currentState
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              '${authProvider.lg[authProvider.language]["you can’t order less than 5 shishas"]}'),
                                                        ),
                                                      );
                                                    } else {
                                                      if (orderProvider
                                                              .itemOrders
                                                              .length >
                                                          0) {
                                                        bool a = false;
                                                        if (orderProvider
                                                                .choosebillFriend
                                                                .length >
                                                            0) {
                                                          for (int g = 0;
                                                              g <
                                                                  orderProvider
                                                                      .choosebillFriend
                                                                      .length;
                                                              g++) {
                                                            print(g);
                                                            if (orderProvider
                                                                        .choosebillFriend[
                                                                            g]
                                                                        .price ==
                                                                    0.0 &&
                                                                orderProvider
                                                                    .choosebillFriend[
                                                                g]
                                                                .id!=-69) {
                                                              _key.currentState
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                      '${authProvider.lg[authProvider.language]["Please choose someone to share your bill with"]}'),
                                                                ),
                                                              );
                                                              a = true;
                                                              break;
                                                            }
                                                          }
                                                        }

                                                        if (!a) {
                                                          showDialog(
                                                            context:
                                                                this.context,
                                                            barrierDismissible:
                                                                false,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return WillPopScope(
                                                                  onWillPop: () =>
                                                                      Future<bool>.value(
                                                                          false),
                                                                  child:
                                                                      AlertDialog(
                                                                    title: Text(
                                                                        '${authProvider.lg[authProvider.language]["Loading..."]}'),
                                                                    content: Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: <Widget>[
                                                                          const CircularProgressIndicator()
                                                                        ]),
                                                                  ));
                                                            },
                                                          );
                                                          final _creditCards =
                                                              Provider.of<
                                                                      CreditCardsProvider>(
                                                                  context,
                                                                  listen:
                                                                      false);
                                                          final order = Provider
                                                              .of<OrderByIdProvider>(
                                                                  context,
                                                                  listen:
                                                                      false);

                                                          final address = Provider
                                                              .of<AdressProvider>(
                                                                  context,
                                                                  listen:
                                                                      false);

                                                          int a =
                                                              await orderProvider
                                                                  .makeorder(
                                                            date: (address
                                                                    .evendatecontroller
                                                                    .text)
                                                                .replaceAll(
                                                              RegExp(
                                                                  '[^A-Za-z0-9]'),
                                                              '-',
                                                            ),

                                                            type: address
                                                                .typeofeventcontroller
                                                                .text,
                                                            nb: address
                                                                .numberofguestcontroller
                                                                .text,
                                                            //  idcard: _creditCards.credit.cardId,
                                                            contactname: address
                                                                .name.text,
                                                            contactphone:
                                                                address
                                                                    .phone.text,
                                                            eventname: address
                                                                .eventnamecontroller
                                                                .text,
                                                            eventtime: address
                                                                .DailyDatecontroller
                                                                .text,

                                                            // eventtime:address.
                                                            bool1: order.check1,
                                                            bool2: order.check2,
                                                            bool3: order.check4,
                                                          );
                                                          Navigator.of(context)
                                                              .pop();
                                                          if (a != 0) {
                                                            if (orderProvider
                                                                    .choosebillFriend
                                                                    .length >
                                                                0) {
                                                              if (orderProvider
                                                                      .choosebillFriend[0]
                                                                      .price ==
                                                                  0.0
 &&                                                            orderProvider
                                                                      .choosebillFriend[0].id==-69 ) {
                                                                Navigator.pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                AppointmentSuccess(0)));
                                                              } else {
                                                                orderProvider
                                                                        .paymemtstep =
                                                                    true;
                                                                orderProvider
                                                                    .orderid = a;
                                                                orderProvider
                                                                    .spets++;
                                                                _animateToIndex(
                                                                    orderProvider
                                                                        .spets);
                                                              }
                                                            } else {
                                                              orderProvider
                                                                      .paymemtstep =
                                                                  true;
                                                              orderProvider
                                                                  .orderid = a;
                                                              orderProvider
                                                                  .spets++;
                                                              _animateToIndex(
                                                                  orderProvider
                                                                      .spets);
                                                            }
                                                          }
                                                          else
                                                            {
                                                              _key.currentState
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                      '${authProvider.lg[authProvider.language]["error try again"]}'),
                                                                ),
                                                              );
                                                            }
                                                        }
                                                      } else {
                                                        _key.currentState
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                                '${authProvider.lg[authProvider.language]["no items to order"]}'),
                                                          ),
                                                        );
                                                      }
                                                    }
                                                  } else if (orderProvider
                                                          .spets ==
                                                      7) {
                                                    if (_creditCardss
                                                                .credit.id ==
                                                            0 &&
                                                        _creditCardss.value ==
                                                            -1) {
                                                      _key.currentState
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              '${authProvider.lg[authProvider.language]["no credit cards selected"]}'),
                                                        ),
                                                      );
                                                    } else if (true) {
                                                      //  await orderProvider.paymentverify
                                                      showDialog(
                                                        context: this.context,
                                                        barrierDismissible:
                                                            false,
                                                        builder: (BuildContext
                                                            context) {
                                                          return WillPopScope(
                                                              onWillPop: () =>
                                                                  Future<bool>.value(
                                                                      false),
                                                              child:
                                                                  AlertDialog(
                                                                title: Text(
                                                                    '${authProvider.lg[authProvider.language]["Loading..."]}'),
                                                                content: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize.min,
                                                                    children: <Widget>[
                                                                      const CircularProgressIndicator()
                                                                    ]),
                                                              ));
                                                        },
                                                      );
                                                      final _creditCards = Provider
                                                          .of<CreditCardsProvider>(
                                                              context,
                                                              listen: false);
                                                      final order = Provider.of<
                                                              OrderByIdProvider>(
                                                          context,
                                                          listen: false);

                                                      final address = Provider
                                                          .of<AdressProvider>(
                                                              context,
                                                              listen: false);

                                                      await orderProvider
                                                          .getPlaceOrderId(
                                                              orderProvider
                                                                  .orderid
                                                                  .toString(),
                                                              _creditCards
                                                                  .credit
                                                                  .cardId);

                                                      Navigator.of(context)
                                                          .pop();

                                                      //   else {

                                                      if (orderProvider
                                                          .paymentverify
                                                          .isNotEmpty) {
                                                        if (orderProvider
                                                                    .paymentverify[
                                                                "msg"] ==
                                                            "error") {
                                                          _key.currentState
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                  '${authProvider.lg[authProvider.language]["error to place order"]}'),
                                                            ),
                                                          );
                                                        } else {
                                                          setState(() {
                                                            url3ds = orderProvider
                                                                    .paymentverify[
                                                                "msg"];
                                                          });
                                                          orderProvider.spets++;
                                                          _animateToIndex(
                                                              orderProvider
                                                                  .spets);
                                                        }
                                                      } else {
                                                        _key.currentState
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                                '${authProvider.lg[authProvider.language]["error to place order"]}'),
                                                          ),
                                                        );
                                                      }
                                                    }

                                                    //    }
                                                    else {
                                                      orderProvider
                                                              .finaldonatesteps =
                                                          true;
                                                      orderProvider
                                                              .finaldonatestepsCancel =
                                                          true;
                                                      orderProvider.spets++;
                                                      _animateToIndex(
                                                          orderProvider.spets);
                                                    }
                                                  } else if (orderProvider
                                                          .spets ==
                                                      8) {
                                                    if (_creditCardss
                                                            .credit.id ==
                                                        0) {
                                                      _key.currentState
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              '${authProvider.lg[authProvider.language]["no credit cards selected"]}'),
                                                        ),
                                                      );
                                                    } else {
                                                      showDialog(
                                                        context: this.context,
                                                        barrierDismissible:
                                                            false,
                                                        builder: (BuildContext
                                                            context) {
                                                          return WillPopScope(
                                                              onWillPop: () =>
                                                                  Future<bool>.value(
                                                                      false),
                                                              child:
                                                                  AlertDialog(
                                                                title: Text(
                                                                    '${authProvider.lg[authProvider.language]["Loading..."]}'),
                                                                content: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize.min,
                                                                    children: <Widget>[
                                                                      const CircularProgressIndicator()
                                                                    ]),
                                                              ));
                                                        },
                                                      );
                                                      final _creditCards = Provider
                                                          .of<CreditCardsProvider>(
                                                              context,
                                                              listen: false);

                                                      final address = Provider
                                                          .of<AdressProvider>(
                                                              context,
                                                              listen: false);
                                                      final order = Provider.of<
                                                              OrderByIdProvider>(
                                                          context,
                                                          listen: false);
                                                      // await orderProvider.getotpverify(url3ds);
                                                      //   int a = await orderProvider.p

                                                      Navigator.of(context)
                                                          .pop();
                                                      if (orderProvider
                                                          .checkotp)
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    AppointmentSuccess(
                                                                        0)));
                                                      else if (orderProvider
                                                          .checkotp) {
                                                        showDialog(
                                                          context: this.context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  '${authProvider.lg[authProvider.language]["otp verification"]}'),
                                                              content: Text(
                                                                  '${authProvider.lg[authProvider.language]["otp not valid"]}'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                    child: Text(
                                                                        '${authProvider.lg[authProvider.language]["Close"]}'),
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            context))
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        orderProvider.spets--;

                                                        // showDialog(
                                                        //   context: this.context,
                                                        //   builder: (BuildContext
                                                        //       context) {
                                                        //     return AlertDialog(
                                                        //       title:  Text('${authProvider.lg[authProvider.language]["error"]}'
                                                        //           ),
                                                        //       content:  Text('${authProvider.lg[authProvider.language][ "try again"]}'
                                                        //          ),
                                                        //       actions: <Widget>[
                                                        //         TextButton(
                                                        //             child:
                                                        //                  Text('${authProvider.lg[authProvider.language]["Close"]}'
                                                        //                    ),
                                                        //             onPressed: () =>
                                                        //                 Navigator.pop(
                                                        //                     context))
                                                        //       ],
                                                        //     );
                                                        //
                                                        //
                                                        //   },
                                                        // );
                                                      }
                                                    }
                                                  } else if (orderProvider
                                                          .spets ==
                                                      4) {
                                                    if (
                                                    orderProvider
                                                            .itemOrders.length >
                                                        0
                                                    )
                                                    {
                                                      orderProvider.spets++;
                                                    } else {
                                                      _key.currentState
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              '${authProvider.lg[authProvider.language]["please add a package"]}'),
                                                        ),
                                                      );
                                                    }
                                                  } else if (orderProvider
                                                              .spets ==
                                                          5 &&
                                                      orderProvider.vatshisha !=
                                                          0.0) {
                                                    int itemcount = 0;
                                                    for (int i = 0;
                                                        i <
                                                            orderProvider
                                                                .itemOrders
                                                                .length;
                                                        i++) {
                                                      if (orderProvider
                                                          .itemOrders[i]
                                                          .isShisha) {
                                                        itemcount = itemcount +
                                                            orderProvider
                                                                .itemOrders[i]
                                                                .quantity;
                                                      }
                                                      if (itemcount == 5) break;
                                                    }

                                                    if (itemcount < 5) {
                                                      _key.currentState
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              '${authProvider.lg[authProvider.language]["minimun quantity for shisha is 5"]}'),
                                                        ),
                                                      );
                                                    } else {
                                                      orderProvider.spets++;

                                                      _animateToIndex(
                                                          orderProvider.spets);
                                                    }
                                                  } else {
                                                    orderProvider.spets++;

                                                    _animateToIndex(
                                                        orderProvider.spets);
                                                  }

                                                  setState(() {
                                                    loadingnext = false;
                                                  });
                                                },
                                                child: Text(
                                                  '${authProvider.lg[authProvider.language]['Next']}',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'BerlinSansFB',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )

                                                // style: ElevatedButton.styleFrom(
                                                //   padding: EdgeInsets.fromLTRB(
                                                //     width * 0.1,
                                                //     screenHeight * 0.03,
                                                //     width * 0.1,
                                                //     screenHeight * 0.03,
                                                //   ),
                                                //   onPrimary:
                                                //       const Color.fromRGBO(255, 255, 255, 1),
                                                //   primary: const Color.fromRGBO(63, 85, 33, 1),
                                                //
                                                // );
                                                ):Container()
                                            : Container()
                                        : CircularProgressIndicator(),
                                  ])),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }

  createChatRoomAndStartConversation(String userName) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (userName != sp.getString('email')) {
      List<String> users = [sp.getString('email').toString(), userName];
      String chatRoomId =
          getChatRoomId(sp.getString('email').toString(), userName);
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatRoomId": chatRoomId,
      };
      //   databaseMethods.createChatRoom(chatRoomId, chatRoomMap);

    } else {}
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
