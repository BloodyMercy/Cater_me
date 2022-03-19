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
  Intro intro=Intro(
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    startinto();
 //   playaudio();
    inAppMessaging(context,SplashScreen());

  }



  startinto() async{



    SharedPreferences sh=await SharedPreferences.getInstance();
    //bool a=sh.getBool("startintro")==null;

    intro.setStepConfig(
      0,
      borderRadius: BorderRadius.circular(64),
    );
    if(sh.getBool("startintro")??true) {
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
    sh.setBool("startintro", false);
  }
  Future<bool> _onWillPop() async {
    final authProvider = Provider.of<UserProvider>(context, listen: false);
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

              Navigator.pop(context,true);


            },
            child: Text('${LanguageTr.lg[authProvider.language]["Yes"]}')),
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
  @override
  Widget build(BuildContext context){
    final packageprovider=Provider.of<PackagesProvider>(context,listen: true);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Stack(
        children: <Widget>[


          AnimatedOpacity(
            opacity: (packageprovider.loading )? 1.0 : 0.2,
            duration: Duration(milliseconds: 500),
            child: buildbody(context),
          ),
          AnimatedOpacity(
            opacity: (packageprovider.loading ) ? 0.0 : 1.0,
            duration: Duration(milliseconds: 500),
            child: buildLoading(context),
          ),
        ],
      ),
    );
  }
  Widget buildLoading(BuildContext context){
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
    final orderCaterprovider=Provider.of<OrderCaterProvider>(context,listen: true);
    final address=Provider.of<AdressProvider>(context,listen: true);
    final credit=Provider.of<CreditCardsProvider>(context,listen: true);
    final order = Provider.of<OrderByIdProvider>(context, listen: true);
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return
      Scaffold(


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
                if(authProvider.status == Status.Authenticated) {
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
                  orderCaterprovider.finaldonatesteps=false;
                  orderCaterprovider.finaldonatestepsCancel=false;
                  credit.value = -1;
                  orderCaterprovider.setup=false;
                  orderCaterprovider.paymemtstep=false;
                  orderCaterprovider.serviceId = 1;
                  address.form = false;
                  address.valueIndex = -1;
                  // orderCaterprovider.
                  address.phone.text = "";
                  address.name.text = "";
                  order.check1 = false;
                  order.check2 = false;
                  orderCaterprovider.finaldonatesteps=false;
                  order.check3 = false;
                  order.check4 = false;
                  orderCaterprovider.checkotp=false;
                  // orderCaterprovider.listFriend=[];
                  address.value2Index = -1;
                  //address.value1Index = -1;
                  orderCaterprovider.valueIndex = -1;
                  orderCaterprovider.value.id= 0;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Order(),
                    ),
                  );
                }
                else{
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                }
              },
              child: Container(
                  height:40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).primaryColor),
                  child: const Icon(Icons.add_rounded,
                      color:Color.fromRGBO(253, 202, 29, 1), size: 35)),
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
            backgroundColor:  LightColors.kLightYellow,
            type: BottomNavigationBarType.fixed,
            iconSize: 30,
            selectedItemColor:yellowColor,
            unselectedItemColor:  Theme.of(context).primaryColor,
            items: [
               BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.home,
                  size: 25, //Icon Size//Color Of Icon
                ),
                label:   '${LanguageTr.lg[authProvider.language]["Home"]}',
              ),
               BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.calendarCheck,
                  size: 25, //Icon Size
                ),
                label: '${LanguageTr.lg[authProvider.language]["Occasions"]}',
              ),
            package.nbnotification!="0"  ? BottomNavigationBarItem(

                icon:  Badge(
                    badgeColor: Color.fromRGBO(253, 202, 29, 1),
                   // badgeContent:Text("3"),
                    child: Icon(
                      Icons.backpack,size: 25,
                    //  color: Theme.of(context).primaryColor,
                    ),
                ),
                label: '${LanguageTr.lg[authProvider.language]["Order"]}',
              ):BottomNavigationBarItem(
          icon:  Icon(

                Icons.backpack,
                size: 25,

              ),
          label: '${LanguageTr.lg[authProvider.language]["Order"]}',
        ),
               BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidUser,
                  size: 25, //Icon Size

                ),
                label: '${LanguageTr.lg[authProvider.language]["Settings"]}',
              ),
            ],
            currentIndex: widget._selectedIndex,
            onTap: _onItemTap,
          ),
        ));
  }
}
