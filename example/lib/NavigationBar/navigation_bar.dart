import 'dart:async';

import 'package:CaterMe/Helpers/inappnotification.dart';
import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/credit_card_provider.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/Screens/CustomAlert/alert.dart';
import 'package:CaterMe/Screens/Order.dart';
import 'package:CaterMe/Screens/auth/login_screen.dart';
import 'package:CaterMe/Screens/ocassionsScreens/occasion_listview.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/Screens/orders/yourOrders.dart';
import 'package:CaterMe/Screens/review/review.dart';
import 'package:CaterMe/Screens/settings_screen.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/intro/flutter_intro.dart';
import 'package:CaterMe/notificaition/services/notification_service.dart';

import 'package:CaterMe/widgets/homepage.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Providers/orderById_provider.dart';
import '../Providers/user.dart';
import '../Screens/auth/reset_password_screen.dart';
import '../Screens/auth/signup_screen.dart';
import '../SplachScreen.dart';
import '../language/language.dart';

class Navigationbar extends StatefulWidget {
  int _selectedIndex;

  Navigationbar(this._selectedIndex);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<Navigationbar> {
  NotificationServices notificationService = NotificationServices();

  //AudioCache _audioCache;
  final List<Widget> _widgetOptions = [
    HomePage(),
    OccasionListView(),
    YourOrders(),
    TABBar()
  ];

  Widget customThemeWidgetBuilder(StepWidgetParams stepWidgetParams) {
    List<String> texts = [
      'Make your order now ',
      'check your order and see traking order',
      'My usage is also very simple, you can quickly learn and use it through example and api documentation.',
      'In order to quickly implement the guidance, I also provide a set of out-of-the-box themes, I wish you all a happy use, goodbye!',
    ];
    return Padding(
      padding: EdgeInsets.all(
        32,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            '${texts[stepWidgetParams.currentStepIndex]}【${stepWidgetParams.currentStepIndex + 1} / ${stepWidgetParams.stepCount}】',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: stepWidgetParams.onPrev,
                child: Text(
                  'Prev',
                ),
              ),
              SizedBox(
                width: 16,
              ),
              ElevatedButton(
                onPressed: stepWidgetParams.onNext,
                child: Text(
                  'Next',
                ),
              ),
              SizedBox(
                width: 16,
              ),
              ElevatedButton(
                onPressed: stepWidgetParams.onFinish,
                child: Text(
                  'Finish',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onItemTap(int index) {
    setState(() {
      widget._selectedIndex = index;
    });
  }

  Intro intro = Intro(
    stepCount: 2,
    maskClosable: true,
    onHighlightWidgetTap: (introStatus) {
      print(introStatus);
    },

    /// use defaultTheme
    widgetBuilder: StepWidgetBuilder.useDefaultTheme(
      texts: [
        'Click here,and make your order',
        'View all packages,add your occassions,track your orders',
      ],
      buttonTextBuilder: (currPage, totalPage) {
        return currPage < totalPage - 1 ? 'Next' : 'Finish';
      },
    ),
  );

  getLanguage() async {
    final user = Provider.of<UserProvider>(context, listen: false);
    await user.getLanguage();
    // print(user.lg[user.language]["Home"]);
    //  user.status=Status.Authenticated;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLanguage();
    startinto();
    //   playaudio();
    inAppMessaging(context, SplashScreen());
  }

  startinto() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final authProvider = Provider.of<UserProvider>(context, listen: false);
    intro = Intro(
      stepCount: 2,
      maskClosable: true,
      onHighlightWidgetTap: (introStatus) {
        print(introStatus);
      },

      /// use defaultTheme
      widgetBuilder: StepWidgetBuilder.useDefaultTheme(
        texts: [
          '${authProvider.lg[_prefs.getString("locale")]["Click here,and make your order"]}',
          '${authProvider.lg[_prefs.getString("locale")]["View all packages,add your occassions,track your orders"]}'
        ],
        buttonTextBuilder: (currPage, totalPage) {
          return currPage < totalPage - 1
              ? '${authProvider.lg[_prefs.getString("locale")]["Next"]}'
              : '${authProvider.lg[_prefs.getString("locale")]["Finish"]}';
        },
      ),
    );
    //bool a=sh.getBool("startintro")==null;

    intro.setStepConfig(
      0,
      borderRadius: BorderRadius.circular(64),
    );
    if (_prefs.getBool("startintro") ?? true) {
      Timer(
        Duration(
          seconds: 3,
        ),
        () {
          /// start the intro
          intro.start(context);
        },
      );
    }
    // Timer(
    //   Duration(
    //     seconds: 3,
    //   ),
    //  () {
    /// start the intro
    // MotionToast.success(
    //   title:  "Cater me",
    //   titleStyle:  TextStyle(fontWeight:  FontWeight.bold),
    //   description:  "You are not logged in,log in now",
    // //  animationType: ANIMATION.FROM_LEFT,
    // ).show(context);
    //  },
    // );
    _prefs.setBool("startintro", false);
  }

  Future<bool> _onWillPop() async {
    final authProvider = Provider.of<UserProvider>(context, listen: false);
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
                      height: MediaQuery.of(context).size.height * 0.25,
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
                                  top: MediaQuery.of(context).size.height * 0.02),
                              child: Divider(
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.01),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                        MediaQuery.of(context).size.width * 0.05),
                                    child: TextButton(
                                      child: Text(
                                        '${authProvider.lg[authProvider.language]["Yes"]}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context,true);
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
            //   description: "",
            //   button1: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         primary: Colors.grey,
            //       ),
            //       onPressed: () {
            //
            //         Navigator.pop(context,true);
            //
            //
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

  @override
  Widget build(BuildContext context) {
    final packageprovider =
        Provider.of<PackagesProvider>(context, listen: true);
    final mediaQuery = MediaQuery.of(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Stack(
        children: <Widget>[
          AnimatedOpacity(
            opacity: (packageprovider.loading) ? 1.0 : 0.2,
            duration: Duration(milliseconds: 500),
            child: buildbody(context),
          ),
          AnimatedOpacity(
            opacity: (packageprovider.loading) ? 0.0 : 1.0,
            duration: Duration(milliseconds: 500),
            child: buildLoading(context),
          ),
          AnimatedOpacity(
              opacity: packageprovider.getReviewPending ? 1 : 0,
              duration: Duration(milliseconds: 500),
              child:
                  // showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return
                  Dialog(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Stack(
                        overflow: Overflow.visible,
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            height: mediaQuery.size.height * 0.25,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: mediaQuery.size.height * 0.07,
                                  left: mediaQuery.size.width * 0.05,
                                  right: mediaQuery.size.width * 0.05),
                              child: Column(
                                children: [
                                  Text(
                                    'We hope our service met your expectations!',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: mediaQuery.size.height * 0.02),
                                    child: Divider(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: mediaQuery.size.height * 0.01),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  mediaQuery.size.width * 0.05),
                                          child: TextButton(
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                packageprovider
                                                    .setReviewPending = false;
                                              });
                                            },
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.white,
                                        ),
                                        TextButton(
                                          child: Text(
                                            'Rate your order',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Review()));
                                            setState(() {
                                              packageprovider.setReviewPending =
                                                  false;
                                            });
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
                              top: -mediaQuery.size.height * 0.06,
                              child: Image.asset(
                                'images/Logoicon.png',
                                height: 100,
                              )),
                        ],
                      )))
        ],
      ),
    );
  }

  Widget buildLoading(BuildContext context) {
    return Align(
      child: Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
      alignment: Alignment.center,
    );
  }

  Widget buildbody(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    final package = Provider.of<PackagesProvider>(context, listen: true);
    final orderCaterprovider =
        Provider.of<OrderCaterProvider>(context, listen: true);
    final address = Provider.of<AdressProvider>(context, listen: true);
    final credit = Provider.of<CreditCardsProvider>(context, listen: true);
    final order = Provider.of<OrderByIdProvider>(context, listen: true);
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: widget._selectedIndex,
          children: _widgetOptions,
        ),
        floatingActionButton: SizedBox(
          key: intro.keys[0],
          height: 55,
          width: 55,
          child: FittedBox(
            child: FloatingActionButton(
              elevation: 0,
              foregroundColor: Colors.transparent,
              shape: CircleBorder(
                side: BorderSide(
                    color: Theme.of(context).primaryColor, width: 0.5),
              ),
              backgroundColor: Colors.transparent,
              onPressed: () {
                if (authProvider.status == Status.Authenticated) {
                  address.clearAddressController();
                  orderCaterprovider.spets = 1;
                  orderCaterprovider.vatshisha = 0.0;
                  orderCaterprovider.vatfood = 0.0;

                  orderCaterprovider.totale = 0.0;
                  orderCaterprovider.orderid = 0;
                  orderCaterprovider.choosebillFriend = [];
                  orderCaterprovider.choosebillFriend = [];
                  orderCaterprovider.itemOrders = [];
                  orderCaterprovider.totalssha = 0;
                  orderCaterprovider.totalpackage = 0;
                  orderCaterprovider.finaldonatesteps = false;
                  orderCaterprovider.finaldonatestepsCancel = false;
                  credit.value = -1;
                  orderCaterprovider.setup = false;
                  orderCaterprovider.paymemtstep = false;
                  orderCaterprovider.serviceId = 1;
                  address.form = false;
                  address.valueIndex = -1;
                  address.numberofguestcontrollerstring.text = "";
                  address.numberofguestcontroller.text = "";
                  // orderCaterprovider.
                  address.phone.text = "";
                  address.name.text = "";
                  order.check1 = false;
                  order.check2 = false;
                  orderCaterprovider.finaldonatesteps = false;
                  order.check3 = false;
                  order.check4 = false;
                  orderCaterprovider.checkotp = false;
                  // orderCaterprovider.listFriend=[];
                  address.value2Index = -1;
                  //address.value1Index = -1;
                  orderCaterprovider.valueIndex = -1;
                  orderCaterprovider.value.id = 0;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Order(),
                    ),
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                }
              },
              child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).primaryColor),
                  child: const Icon(Icons.add_rounded,
                      color: Color.fromRGBO(253, 202, 29, 1), size: 35)),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: LightColors.kLightYellow,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            key: intro.keys[1],
            backgroundColor: LightColors.kLightYellow,
            type: BottomNavigationBarType.fixed,
            iconSize: 30,
            selectedItemColor: yellowColor,
            unselectedItemColor: Theme.of(context).primaryColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.home,
                  size: 25, //Icon Size//Color Of Icon
                ),
                label: '${authProvider.lg[authProvider.language]["Home"]}',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.calendarCheck,
                  size: 25, //Icon Size
                ),
                label: '${authProvider.lg[authProvider.language]["Occasions"]}',
              ),
              package.nbnotification != "0"
                  ? BottomNavigationBarItem(
                      icon: Badge(
                        badgeColor: Color.fromRGBO(253, 202, 29, 1),
                        // badgeContent:Text("3"),
                        child: Icon(
                          Icons.backpack, size: 25,
                          //  color: Theme.of(context).primaryColor,
                        ),
                      ),
                      label:
                          '${authProvider.lg[authProvider.language]["Order"]}',
                    )
                  : BottomNavigationBarItem(
                      icon: Icon(
                        Icons.backpack,
                        size: 25,
                      ),
                      label:
                          '${authProvider.lg[authProvider.language]["Order"]}',
                    ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.solidUser,
                  size: 25, //Icon Size
                ),
                label: '${authProvider.lg[authProvider.language]["Settings"]}',
              ),
            ],
            currentIndex: widget._selectedIndex,
            onTap: _onItemTap,
          ),
        ));
  }
}
