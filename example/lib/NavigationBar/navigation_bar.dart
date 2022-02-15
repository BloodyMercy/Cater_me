import 'dart:async';

import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/Order.dart';
import 'package:CaterMe/Screens/ocassionsScreens/occasion_listview.dart';


import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/Screens/orders/yourOrders.dart';
import 'package:CaterMe/Screens/settings_screen.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/intro/flutter_intro.dart';
import 'package:CaterMe/widgets/homepage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:badges/badges.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Navigationbar extends StatefulWidget {
  int _selectedIndex;

  Navigationbar(this._selectedIndex);
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<Navigationbar> {



   AudioCache _audioCache;
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
        'View all packages,add your occassions,Traking your orders',
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
          milliseconds: 500,
        ),
            () {
          /// start the intro
          intro.start(context);
        },
      );
    }
    sh.setBool("startintro", false);
  }
  @override
  Widget build(BuildContext context){
    final packageprovider=Provider.of<PackagesProvider>(context,listen: true);

    return Stack(
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
    final package = Provider.of<PackagesProvider>(context, listen: true);
    final orderCaterprovider=Provider.of<OrderCaterProvider>(context,listen: true);
    final address=Provider.of<AdressProvider>(context,listen: true);

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
                address.clearAddressController();
                orderCaterprovider.spets=1;
                orderCaterprovider.totale=0.0;
                orderCaterprovider.choosebillFriend=[];
                orderCaterprovider.choosebillFriend=[];
               // orderCaterprovider.listFriend=[];
                address.value2Index=-1;
                orderCaterprovider.valueIndex=-1;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Order(),
                  ),
                );
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
              const BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.home,
                  size: 25, //Icon Size//Color Of Icon
                ),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.calendarCheck,
                  size: 25, //Icon Size
                ),
                label: 'Ocasions',
              ),
        package.nbnotification!="0"  ? BottomNavigationBarItem(

                icon:  Badge(
                    badgeColor: Color.fromRGBO(253, 202, 29, 1),
                   // badgeContent:Text("3"),
                    child: Icon(
                      Icons.backpack,size: 25,
                      color: Theme.of(context).primaryColor,
                    ),
                ),
                label: 'Orders',
              ):BottomNavigationBarItem(
          icon:  Icon(

                Icons.backpack,
                size: 25,

              ),
          label: 'Orders',
        ),
              const BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidUser,
                  size: 25, //Icon Size

                ),
                label: 'Settings',
              ),
            ],
            currentIndex: widget._selectedIndex,
            onTap: _onItemTap,
          ),
        ));
  }
}
