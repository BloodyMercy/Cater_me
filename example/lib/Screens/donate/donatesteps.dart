import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../Payment/OrderSucc.dart';
import '../../Providers/credit_card_provider.dart';
import '../../Providers/orderById_provider.dart';
import '../../Providers/user.dart';
import '../../language/language.dart';
import '../CustomAlert/const.dart';



class DonateStepsScreen extends StatefulWidget {
  int step;
DonateStepsScreen(this.step);
  @override
  _RegularDaberneScreenState createState() => _RegularDaberneScreenState();
}

class _RegularDaberneScreenState extends State<DonateStepsScreen> {
  bool reg;
  bool dab;
int st=0;
  @override
  void initState() {
    super.initState();
    reg = false;
    dab = false;

     data();
  }
  String desc="";
  String desc1="";
  String desc2="";
data(){
  final authProvider = Provider.of<UserProvider>(context, listen: false);

  title=['${LanguageTr.lg[authProvider.language]["extra services"]}'];
  setState(() {


   desc='${LanguageTr.lg[authProvider.language]["Do you want catering equipment?"]}';
   desc1='${LanguageTr.lg[authProvider.language]["Do you want a service team?"]}';
   desc2='${LanguageTr.lg[authProvider.language]["Do you want to donate the rest of your food?"]}';
}); // desc=["Do you want catering equipment?","Do you want a service team?","Do you want to donate the rest of your food?"];
}

  bool loading = true;
  List<String> title=[];


  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderByIdProvider>(context, listen: true);

    final authProvider = Provider.of<UserProvider>(context, listen: true);

    final orderProvider =
        Provider.of<OrderCaterProvider>(context, listen: true);
    final addresProvider = Provider.of<AdressProvider>(context, listen: true);
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Stack(
      children: <Widget>[
      loading?  Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 10.0,
                offset: const Offset(0.0, 0.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
              title[0],
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
                 Text(
                desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                loading==true?  Align(
                    alignment: Alignment.bottomRight,
                    child:ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                        ),
                        onPressed: () async{
                          setState(() {
                            loading=false;
                          });
                          Future.delayed(const Duration(milliseconds: 500), () {

// Here you can write your code

                            setState(() {
                              loading=true;
                              // Here you can write your code for open new view
                            });

                          });
                          setState(() {
                            st=st+1;
                          });
setState(() {
  if(st==1)
  desc=desc1;
  if(st==2)
    desc=desc2;
});
              if(st==1)
                order.check1=true;
              else if(st==2)
                order.check2=true;
              else if(st==3)
                order.check4=true;
if(st==3){
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
          .text,
    bool1: order.check1,
    bool2: order.check2,
    bool3: order.check4,



  );

  Navigator.of(context).pop();
  if (a != 0)
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AppointmentSuccess(
                    a)));
  else {
    orderProvider.spets--;
    orderProvider.finaldonatesteps=false;
   // orderProvider.spets--;
    // _animateToIndex(
    //     orderProvider.spets);

  }


}

                        },
                        child: Text('${LanguageTr.lg[authProvider.language]["Yes"]}')),
                  ):Center(child:CircularProgressIndicator()),
               loading==true?   Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                        ),
                        onPressed: () async {
                          setState(() {
                            loading=false;
                          });
                          Future.delayed(const Duration(milliseconds: 500), () {

// Here you can write your code

                            setState(() {
                              loading=true;
                              // Here you can write your code for open new view
                            });

                          });
st=st+1;
                       //   Navigator.pop(context,true);
                          setState(() {
                            widget.step=widget.step++;
                          });

                          // if(st==1)
                          //   order.check1=true;
                          // if(st==2)
                          //   order.check2=true;
                          // if(st==3)
                          //   order.check4=true;



if(st==3){
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
          .text,  bool1: order.check1,
    bool2: order.check2,
    bool3: order.check4,);

  Navigator.of(context).pop();
  if (a != 0)
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AppointmentSuccess(
                    a)));
  else {
    orderProvider.spets--;
    orderProvider.finaldonatesteps=false;
  //  orderProvider.spets--;
  }
}
                        },
                        child: Text('${LanguageTr.lg[authProvider.language]["No"]}')),
                  ):Container(),
                ],
              )
            ],
          ),
        ):Center(child:CircularProgressIndicator()),
        // Positioned(
        //   left: Consts.padding,
        //   right: Consts.padding,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.green,
        //     radius: Consts.avatarRadius,
        //     child: Text(
        //       "FAISAL",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
