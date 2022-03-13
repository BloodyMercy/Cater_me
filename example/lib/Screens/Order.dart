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
import 'Addons/orderpages/steps.dart';


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


  Future<bool> _onWillPop() async {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    return (await showDialog(
          context: context,
          builder: (context) => CustomDialog(
            title: '${LanguageTr.lg[authProvider.language]["Are you sure you want to exit?"]}',

            description: "",
            button1: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                onPressed: () {
                  clearAlldata();

                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('${LanguageTr.lg[authProvider.language]["yes"]}')),
            oneOrtwo: true,
            button2: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('${LanguageTr.lg[authProvider.language]["No"]}'),
            ),
          ),
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
    SharedPreferences sh=await SharedPreferences.getInstance();
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.white,
            title:  Text('${LanguageTr.lg[authProvider.language]["Order"]}'
              ,
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
                      return CustomDialog(
                        title:'${LanguageTr.lg[authProvider.language]["Are you sure you want to exit?"]}' ,
                        description: "",
                        button1: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                            ),
                            onPressed: () {
                              orderProvider.spets = 1;

                              clearAlldata();

                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Text('${LanguageTr.lg[authProvider.language]["Yes"]}'
                                )),
                        oneOrtwo: true,
                        button2: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('${LanguageTr.lg[authProvider.language]["No"]}'),
                        ),
                      );
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
                                  onTap: (int value) {
                                    if (orderProvider.spets == 1) {
                                      if (orderProvider.value.id == 0) {
                                        _key.currentState.showSnackBar(
                                           SnackBar(
                                            content:
                                                Text('${LanguageTr.lg[authProvider.language]["Please choose an address"]}'),
                                                   ),

                                        );
                                      } else {
                                        orderProvider.spets = value;
                                      }
                                    }
                                    if (orderProvider.spets == 3) {
                                      if (orderProvider.value.id == 0) {
                                        _key.currentState.showSnackBar(
                                           SnackBar(
                                            content:  Text('${LanguageTr.lg[authProvider.language]["please choose one from the following offers "]}'
                                                ),
                                          ),
                                        );
                                        // orderProvider.spets=0;
                                      } else {
                                        orderProvider.spets = value;
                                      }
                                    }
                                    if (orderProvider.spets == 2) {
                                      if (address.eventnamecontroller.text == "" ||
                                          address.evendatecontroller.text == "" ||
                                          address.numberofguestcontroller.text ==
                                              "" ||
                                          address.typeofeventcontroller.text == "") {
                                         SnackBar(
                                          content:
                                              Text('${LanguageTr.lg[authProvider.language][ "Please fill the empty fields"]}'
                                                  ),
                                        );
                                        // );
                                      } else {
                                        // else{
                                        orderProvider.spets = value;
                                        setState(() {
                                          //  orderProvider.spets=value;

                                          _controller.animateTo(
                                            0,
                                            duration:
                                                const Duration(milliseconds: 500),
                                            curve: Curves.linear,
                                          );
                                        });
                                        //  }
                                      }
                                    }

                                    if (orderProvider.spets == 5) {
                                      setState(() {
                                        _controller.animateTo(
                                          0,
                                          duration: const Duration(milliseconds: 500),
                                          curve: Curves.linear,
                                        );
                                      });
                                    } else {
                                      orderProvider.spets = value;
                                    }
                                    if (orderProvider.spets == 6) {
                                      setState(() {
                                        _controller.animateTo(
                                          0,
                                          duration: const Duration(milliseconds: 500),
                                          curve: Curves.linear,
                                        );
                                      });
                                    } else {
                                      orderProvider.spets = value;
                                    }
                                    if (orderProvider.spets == 6) {
                                      bool a = false;
                                      for (int i = 0;
                                          i < orderProvider.choosebillFriend.length;
                                          i++) {
                                        if (orderProvider.choosebillFriend[i].price ==
                                            0) {
                                          a = true;
                                        }
                                      }
                                      if (a)
                                         SnackBar(
                                          content:
                                              Text('${LanguageTr.lg[authProvider.language][ "Please fill the empty fields"]}'
                                                  ),
                                        );
                                      else
                                        orderProvider.spets = value;
                                    }

                                    if (orderProvider.spets == 7) {
                                      setState(() {
                                        _controller.animateTo(
                                          0,
                                          duration: const Duration(milliseconds: 500),
                                          curve: Curves.linear,
                                        );
                                      });
                                    } else {
                                      orderProvider.spets = value;
                                    }
                                  },
                                  text:  [
                                    '${LanguageTr.lg[authProvider.language]["Location"]}',
                                    '${LanguageTr.lg[authProvider.language]["Event Details"]}',
                                    '${LanguageTr.lg[authProvider.language]["Service"]}',
                                    '${LanguageTr.lg[authProvider.language]["Packages"]}',
                                    '${LanguageTr.lg[authProvider.language]["Add-Ons"]}',
                                    '${LanguageTr.lg[authProvider.language]["Checkout"]}',
                                    '${LanguageTr.lg[authProvider.language]["Payment"]}',


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
                              ? DonateStepsScreen(0)



                                                  : (orderProvider.spets == 6)
                                                      ? OrderSummeryCopy(
                                                          orderProvider.totale)
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
                                    orderProvider.spets > 1
                                        ? !orderProvider.finaldonatesteps?IconButton(
                                            onPressed: () {
                                              orderProvider.spets =
                                                  orderProvider.spets - 1;
                                              _animateToIndex(
                                                  orderProvider.spets);
                                            },
                                            icon: Icon(Icons.arrow_back,
                                                size: 35,
                                                color: Color.fromRGBO(
                                                    63, 85, 33, 1))):Container()
                                        : Container(),
                                    orderProvider.spets > 3
                                        ? !orderProvider.finaldonatesteps?Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${LanguageTr.lg[authProvider.language]["Total"]}${details.totale.toStringAsFixed(2)} ${LanguageTr.lg[authProvider.language]["SAR"]}",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'BerlinSansFB',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                              ),
                                              orderProvider.vatshisha > 0.0
                                                  ? Text('${LanguageTr.lg[authProvider.language]['*(Shisha VAT 100%)']}'
                                                      ,
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    )
                                                  : Container(),
                                              orderProvider.vatfood > 0.0
                                                  ? Text('${LanguageTr.lg[authProvider.language]['*(VAT 15%)']}'
                                                      ,
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ):Container()
                                        : Container(),
                                    !loadingnext
                                        ? !orderProvider.finaldonatesteps?ElevatedButton(
                                            onPressed: () async {
                                              setState(() {
                                                loadingnext = true;
                                              });

                                              if (orderProvider.spets == 1) {
                                                if (orderProvider.value.id ==
                                                    0) {
                                                  _key.currentState
                                                      .showSnackBar(
                                                     SnackBar(
                                                      content: Text('${LanguageTr.lg[authProvider.language]["Please choose an address"]}',
                                                          ),
                                                    ),
                                                  );
                                                } else {


                                                  if(await orderProvider.getdistance()) {
                                                    orderProvider.spets++;
                                                    _animateToIndex(
                                                        orderProvider.spets);
                                                  }
                                                  else{
                                                    _key.currentState
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text('${LanguageTr.lg[authProvider.language]["Please choose an address"]}',
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                }
                                              } else if (orderProvider.spets ==
                                                  3) {
                                                if (orderProvider.serviceId ==
                                                    0) {
                                                  _key.currentState
                                                      .showSnackBar(
                                                     SnackBar(
                                                      content:  Text('${LanguageTr.lg[authProvider.language]["Please choose one from the following offers "]}'
                                                          ),
                                                    ),
                                                  );
                                                } else {
                                                  orderProvider.spets++;

                                                  _animateToIndex(
                                                      orderProvider.spets);
                                                }
                                              } else if (orderProvider.spets ==
                                                  2) {
                                                if (address.eventnamecontroller
                                                            .text ==
                                                        "" ||
                                                    address.evendatecontroller
                                                            .text ==
                                                        "" ||
                                                    address.numberofguestcontroller
                                                            .text ==
                                                        "" ||
                                                    address.typeofeventcontroller
                                                            .text ==
                                                        "") {
                                                  _key.currentState
                                                      .showSnackBar(
                                                     SnackBar(
                                                      content: Text('${LanguageTr.lg[authProvider.language]["Please fill the empty fields"]}'
                                                          ),
                                                    ),
                                                  );
                                                } else {
                                                  if (address.form) {
                                                    if (address.name.text ==
                                                            "" ||
                                                        address.phone.text ==
                                                            "") {
                                                      _key.currentState
                                                          .showSnackBar(
                                                         SnackBar(
                                                          content: Text(
                                                            '${LanguageTr.lg[authProvider.language][  "Please fill the empty fields"]}',),
                                                        ),
                                                      );
                                                    } else {
                                                      await address.checktime();
                                                      if (address
                                                          .hours.isDaberni)
                                                        orderProvider
                                                            .serviceId = 2;
                                                      orderProvider.spets++;

                                                      _animateToIndex(
                                                          orderProvider.spets);
                                                    }
                                                  } else {
                                                    await address.checktime();
                                                    if (address.hours.isDaberni)
                                                      orderProvider.serviceId =
                                                          2;
                                                    orderProvider.spets++;

                                                    _animateToIndex(
                                                        orderProvider.spets);
                                                  }
                                                }
                                              } else if (orderProvider.spets ==
                                                  6) {
                                                if (orderProvider
                                                        .totalpackage ==
                                                    0) {
                                                  _key.currentState
                                                      .showSnackBar(
                                                     SnackBar(
                                                      content: Text('${LanguageTr.lg[authProvider.language][ "please choose a package to order"]}'
                                                         ),
                                                    ),
                                                  );
                                                } else if (orderProvider
                                                            .totalssha <
                                                        5 &&
                                                    orderProvider.vatshisha !=
                                                        0.0) {
                                                  _key.currentState
                                                      .showSnackBar(
                                                     SnackBar(
                                                      content: Text('${LanguageTr.lg[authProvider.language]["you can’t order less than 5 shishas"]}'
                                                          ),
                                                    ),
                                                  );
                                                } else {
                                                  if (orderProvider
                                                          .itemOrders.length >
                                                      0) {
                                                    bool a = false;
                                                    if (orderProvider
                                                            .choosebillFriend
                                                            .length >
                                                        0) {
                                                      for (int i = 0;
                                                          i <
                                                              orderProvider
                                                                  .choosebillFriend
                                                                  .length;
                                                          i++) {
                                                        print(i);
                                                        if (orderProvider
                                                                .choosebillFriend[
                                                                    i]
                                                                .price ==
                                                            0) {
                                                          _key.currentState
                                                              .showSnackBar(
                                                             SnackBar(
                                                              content: Text('${LanguageTr.lg[authProvider.language]["Please choose someone to share your bill with"]}'
                                                                  ),
                                                            ),
                                                          );
                                                          a = true;
                                                          break;
                                                        }
                                                      }
                                                    }

                                                    if (!a) {
                                                      orderProvider.spets++;
                                                      _animateToIndex(
                                                          orderProvider.spets);
                                                    }
                                                  } else {
                                                    _key.currentState
                                                        .showSnackBar(
                                                       SnackBar(
                                                        content: Text('${LanguageTr.lg[authProvider.language]["no items to order"]}'
                                                        ),
                                                          ),

                                                    );
                                                  }
                                                }
                                              }
                                              else if(orderProvider.spets ==
                                                  7){
                                                if (_creditCardss.credit.id ==
                                                    0) {
                                                  _key.currentState
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text('${LanguageTr.lg[authProvider.language][ "no credit cards selected"]}'
                                                      ),
                                                    ),
                                                  );
                                                }
                                                else
                                                  {
                                                    orderProvider.finaldonatesteps=true;
                                                    orderProvider.spets++;
                                                    _animateToIndex(
                                                        orderProvider.spets);
                                                  }
                                              }

                                              else if (orderProvider.spets ==
                                                  8) {
                                                if (_creditCardss.credit.id ==
                                                    0) {
                                                  _key.currentState
                                                      .showSnackBar(
                                                     SnackBar(
                                                      content: Text('${LanguageTr.lg[authProvider.language][ "no credit cards selected"]}'
                                                         ),
                                                    ),
                                                  );
                                                } else {
                                                  showDialog(
                                                    context: this.context,
                                                    barrierDismissible: false,
                                                    builder:
                                                        (BuildContext context) {
                                                      return WillPopScope(
                                                          onWillPop: () =>
                                                              Future<bool>.value(
                                                                  false),
                                                          child: AlertDialog(
                                                            title:  Text('${LanguageTr.lg[authProvider.language]["Loading..."]}'
                                                                ),
                                                            content: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: <
                                                                    Widget>[
                                                                  const CircularProgressIndicator()
                                                                ]),
                                                          ));
                                                    },
                                                  );
                                                  final _creditCards = Provider
                                                      .of<CreditCardsProvider>(
                                                          context,
                                                          listen: false);

                                                  final address = Provider.of<
                                                          AdressProvider>(
                                                      context,
                                                      listen: false);
                                                  final order = Provider.of<OrderByIdProvider>(context, listen: false);
                                                  int a = await orderProvider
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
                                                          idcard: _creditCards
                                                              .credit.cardId,
                                                          contactname:
                                                              address.name.text,
                                                          contactphone: address
                                                              .phone.text,
                                                          eventname: address
                                                              .eventnamecontroller
                                                              .text,order.check1,order.check2,order.check4);

                                                  Navigator.of(context).pop();
                                                  if (a != 0)
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AppointmentSuccess(
                                                                    a)));
                                                  else {
                                                    showDialog(
                                                      context: this.context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title:  Text('${LanguageTr.lg[authProvider.language]["error "]}'
                                                              ),
                                                          content:  Text('${LanguageTr.lg[authProvider.language][ "try again"]}'
                                                             ),
                                                          actions: <Widget>[
                                                            TextButton(
                                                                child:
                                                                     Text('${LanguageTr.lg[authProvider.language]["Close"]}'
                                                                       ),
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context))
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }
                                                }
                                              } else if (orderProvider.spets ==
                                                  4) {
                                                if (orderProvider
                                                        .itemOrders.length >
                                                    0) {
                                                  orderProvider.spets++;
                                                } else {
                                                  _key.currentState
                                                      .showSnackBar(
                                                     SnackBar(
                                                      content: Text('${LanguageTr.lg[authProvider.language][ "please add a package"]}'
                                                         ),
                                                    ),
                                                  );
                                                }
                                              } else if (orderProvider.spets ==
                                                      5 &&
                                                  orderProvider.vatshisha !=
                                                      0.0) {
                                                int itemcount = 0;
                                                for (int i = 0;
                                                    i <
                                                        orderProvider
                                                            .itemOrders.length;
                                                    i++) {
                                                  if (orderProvider
                                                      .itemOrders[i].isShisha) {
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
                                                      content: Text('${LanguageTr.lg[authProvider.language]["minimun quantity for shisha is 5"]}'
                                                          ),
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
                                            child:  Text('${LanguageTr.lg[authProvider.language]['Next']}',

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
