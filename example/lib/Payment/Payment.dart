
import 'dart:async';

import 'package:CaterMe/Providers/credit_card_provider.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/model/credit_card_model.dart';
import 'package:credit_card/credit_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_checkout_payment/flutter_checkout_payment.dart';
import 'package:provider/provider.dart';

import '../Providers/user.dart';
import 'ahmad/Creditform.dart';
import 'ahmad/creditwidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _isInit = "false";

  String cardNumber = '';
  String expiryDate = '';
  String cardNameHolder = '';
  String cvv = '';
  bool cvvFocused = false;

  @override
  void initState() {
    super.initState();
    initPaymentSDK();
  }

 Future<void> initPaymentSDK() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool isSuccess = await FlutterCheckoutPayment.init(key: "pk_3a939f67-bce1-4e9a-b83f-3b4d1e8b77f6");
   // bool isSuccess = await FlutterCheckoutPayment.init(key: "pk_test_3d1705b5-c273-44c2-a8f3-ed737498c04e");
      //bool isSuccess =  await FlutterCheckoutPayment.init(key: "${Keys.TEST_KEY}", environment: Environment.LIVE);
      print(isSuccess);
      if (mounted) setState(() => _isInit = "true");
    } on PlatformException {
      if (mounted) setState(() => _isInit = "error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    return   GestureDetector( behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('${authProvider.lg[authProvider.language]["Add Card"]}'
          ,style: Theme.of(context).textTheme.headline1,),centerTitle: true,
 actions: [
                 IconButton(icon: Icon(Icons.done),onPressed: _cardValidation)

 ]),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                //SizedBox(height: 10),
               // Text("Checkout Init: $_isInit", style: TextStyle(fontSize: 18)),
                CreditCardWidget(

                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardNameHolder,
                  cvvCode: cvv,
                  textStyle:TextStyle(color: Colors.white,fontSize: 17,),
                  showBackView: cvvFocused,
                  height: 200,
                  width: 270,
                  animationDuration: Duration(milliseconds: 1000),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: CreditCardForm(onCreditCardModelChange: _onModelChange),
                  ),
                ),
                // Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                //   Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                //     ElevatedButton(
                //
                //       child: Text(
                //         "Add Card",
                //         style: TextStyle(fontSize: 14,fontFamily: "BerlinSansFB",fontWeight: FontWeight.bold),
                //       ),
                //       onPressed: _generateToken,
                //       style: ElevatedButton.styleFrom(
                //         // padding: EdgeInsets.symmetric(
                //         //   horizontal: (MediaQuery.of(context).size.width * 0.2),
                //         //   vertical: (MediaQuery.of(context).size.height * 0.01),
                //         // ),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         primary: Theme.of(context).primaryColor,
                //       ),
                //     ),
                //
                //
                //
                //
                //   ]),
                //
                //   ]),
                SizedBox(height: 10)
              ],
            ),
          )),
    );
  }

  void _onModelChange(CreditCardModel model) {
    setState(() {
      cardNumber = model.cardNumber;
      expiryDate = model.expiryDate;
      cardNameHolder = model.cardHolderName;
      cvv = model.cvvCode;
      cvvFocused = model.isCvvFocused;
    });
  }

  Future<void> _generateToken() async {

    try {
      // Show loading dialog
      showDialog(
        context: this.context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final authProvider = Provider.of<UserProvider>(context, listen: true);
          return WillPopScope(
              onWillPop: () => Future<bool>.value(false),
              child: AlertDialog(
                title: Text( '${authProvider.lg[authProvider.language]["Loading..."]}',),
                content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[CircularProgressIndicator()]),
              ));
        },
      );

      String number = cardNumber.replaceAll(" ", "");
      String expiryMonth = expiryDate.substring(0, 2);
      String expiryYear = expiryDate.substring(3);
      number=ToEnglishNumbers(number);
      cvv=ToEnglishNumbers(cvv);
      expiryYear=ToEnglishNumbers(expiryYear);
      expiryMonth=ToEnglishNumbers(expiryMonth);
      print("$cardNumber, $cardNameHolder, $expiryMonth, $expiryYear, $cvv");
//FlutterCheckoutPayment.
      CardTokenisationResponse response = await FlutterCheckoutPayment.generateToken(
          number: number, name: cardNameHolder, expiryMonth: expiryMonth, expiryYear: expiryYear, cvv: cvv);
print(response.token);
      // Hide loading dialog
   //   Navigator.pop(context);
      final address = Provider.of<OrderCaterProvider>(context, listen: false);

CreditCardsModel  card=  await address.sendtokeknpayemnt(response.token,cardNameHolder,cvv);
if(card.id==0){
  Navigator.of(context).pop();

  showDialog(
    context: this.context,
    builder: (BuildContext context) {
      final authProvider = Provider.of<UserProvider>(context, listen: true);
      return AlertDialog(
        title: Text( '${authProvider.lg[authProvider.language]["error"]}',),
        content: Text("try again"),
        actions: <Widget>[TextButton(child: Text( '${authProvider.lg[authProvider.language]["Close"]}',), onPressed: () => Navigator.pop(context))],
      );
    },
  );


}

else {
   final _creditCards=Provider.of<CreditCardsProvider>(context,listen: false);
   await _creditCards.getAllCards();
   print("ssssssssss");
   Navigator.of(context).pop();
  Navigator.pop(context);
}


      // Show result dialog
      // showDialog(
      //   context: this.context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: Text("Token"),
      //       content: Text("${response?.token}"),
      //       actions: <Widget>[TextButton(child: Text("Close"), onPressed: () => Navigator.pop(context))],
      //     );
      //   },
      // );
    } catch (ex) {
      // Hide loading dialog
      Navigator.pop(context);

      // Show error dialog
      showDialog(
        context: this.context,
        builder: (BuildContext context) {
          final authProvider = Provider.of<UserProvider>(context, listen: true);

          return AlertDialog(
            title: Text( '${authProvider.lg[authProvider.language]["error"]}',),
            content: Text("${ex.toString()}"),
            actions: <Widget>[TextButton(child: Text( '${authProvider.lg[authProvider.language]["Close"]}',), onPressed: () => Navigator.pop(context))],
          );
        },
      );
    }
  }

  Future<void> _generateTokenWithAddress() async {
    try {
      // Show loading dialog
      showDialog(
        context: this.context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final authProvider = Provider.of<UserProvider>(context, listen: true);
          return WillPopScope(
              onWillPop: () => Future<bool>.value(false),
              child: AlertDialog(
                title: Text( '${authProvider.lg[authProvider.language]["Loading..."]}',),
                content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[CircularProgressIndicator()]),
              ));
        },
      );

      String number = cardNumber.replaceAll(" ", "");
      String expiryMonth = expiryDate.substring(0, 2);
      String expiryYear = expiryDate.substring(3);

      print("$cardNumber, $cardNameHolder, $expiryMonth, $expiryYear, $cvv");

      CardTokenisationResponse response = await FlutterCheckoutPayment.generateToken(
          number: number,
          name: cardNameHolder,
          expiryMonth: expiryMonth,
          expiryYear: expiryYear,
          cvv: cvv,
          billingModel: BillingModel(
              addressLine1: "address line 1",
              addressLine2: "address line 2",
              postcode: "postcode",
              country: "UK",
              city: "city",
              state: "state",
              phoneModel: PhoneModel(countryCode: "+44", number: "07123456789")));

      // Hide loading dialog
      Navigator.pop(context);

      // Show result dialog
      showDialog(
        context: this.context,
        builder: (BuildContext context) {
          final authProvider = Provider.of<UserProvider>(context, listen: true);
          return AlertDialog(
            title: Text("Token"),
            content: Text("${response?.token}"),
            actions: <Widget>[TextButton(child: Text( '${authProvider.lg[authProvider.language]["Close"]}',), onPressed: () => Navigator.pop(context))],
          );
        },
      );
    } catch (ex) {
      // Hide loading dialog
      Navigator.pop(context);

      // Show error dialog
      showDialog(
        context: this.context,
        builder: (BuildContext context) {
          final authProvider = Provider.of<UserProvider>(context, listen: true);
          return AlertDialog(
            title: Text( '${authProvider.lg[authProvider.language]["error"]}',),
            content: Text("${ex.toString()}"),
            actions: <Widget>[TextButton(child: Text( '${authProvider.lg[authProvider.language]["Close"]}',), onPressed: () => Navigator.pop(context))],
          );
        },
      );
    }
  }
  String ToEnglishNumbers(String s)
  {
    return
      s.replaceAll(RegExp(r"٠"),"0").
      replaceAll(RegExp(r"۱"), "1").
      replaceAll(RegExp(r"۲"), "2").
      replaceAll(RegExp(r"۳"), "3").
      replaceAll(RegExp(r"٤"), "4").
      replaceAll(RegExp(r"٥"), "5").
      replaceAll(RegExp(r"٦"), "6").
      replaceAll(RegExp(r"٧"), "7").
      replaceAll(RegExp(r"٨"), "8").
      replaceAll(RegExp(r"٩"), "9");
  }

  Future<void> _cardValidation() async {
    try {
      // Show loading dialog
      showDialog(
        context: this.context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final authProvider = Provider.of<UserProvider>(context, listen: true);
          return WillPopScope(
              onWillPop: () => Future<bool>.value(false),
              child: AlertDialog(
                title: Text( '${authProvider.lg[authProvider.language]["Loading..."]}',),
                content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[CircularProgressIndicator()]),
              ));
        },
      );

      String number = cardNumber.replaceAll(" ", "");
      number= ToEnglishNumbers(number);
      print("$cardNumber");

      bool isValid = await FlutterCheckoutPayment.isCardValid(number: number);
      Navigator.pop(context);
      // Hide loading dialog
      if(isValid) {

        _generateToken();
      }
      else {
        // Navigator.pop(context);

        // Show result dialog
        showDialog(
          context: this.context,
          builder: (BuildContext context) {
            final authProvider = Provider.of<UserProvider>(context, listen: true);
            return AlertDialog(
              title: Text( '${authProvider.lg[authProvider.language]["Card not Valid"]}',),
              // content: Text("$isValid"),
              actions: <Widget>[
                TextButton(child: Text( '${authProvider.lg[authProvider.language]["Close"]}',),
                    onPressed: () => Navigator.pop(context))
              ],
            );
          },
        );
      }
    } catch (ex) {
      // Hide loading dialog
      Navigator.pop(context);

      // Show error dialog
      showDialog(
        context: this.context,
        builder: (BuildContext context) {
          final authProvider = Provider.of<UserProvider>(context, listen: true);
          return AlertDialog(
            title: Text( '${authProvider.lg[authProvider.language]["error"]}',),
            content: Text("${ex.toString()}"),
            actions: <Widget>[TextButton(child: Text( '${authProvider.lg[authProvider.language]["Close"]}',), onPressed: () => Navigator.pop(context))],
          );
        },
      );
    }
  }}