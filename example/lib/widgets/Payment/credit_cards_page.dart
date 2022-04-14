
import 'package:CaterMe/Providers/credit_card_provider.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
// import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Payment/Payment.dart';
import '../../Payment/applepay/flutter_pay.dart';
import '../../Providers/user.dart';
import '../../Screens/occasion/theme/colors/light_colors.dart';
import '../../language/language.dart';

class CreditCardsPage extends StatefulWidget {
  @override
  State<CreditCardsPage> createState() => _CreditCardsPageState();
}

class _CreditCardsPageState extends State<CreditCardsPage> {
  int _value = -1;
  int selectedIndex = -1;
  bool addcard = false;
  bool loading = true;
  String language;
  getAllData() async {
    var _creditCards = Provider.of<CreditCardsProvider>(context, listen: false);
    // _creditCards.loading=true;
    await _creditCards.getAllCards();
    SharedPreferences sh=await SharedPreferences.getInstance();
    (sh.getString("locale"));

  //  setState(() {
      language = sh.getString("locale");
  //  });
    // _creditCards.loading=false;
    setState(() {
      loading = false;

    });
  }

  @override
  void initState() {
    getAllData();
    super.initState();
  }

  FlutterPay flutterPay = FlutterPay();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final order = Provider.of<OrderCaterProvider>(context, listen: true);

    final _creditCards =
        Provider.of<CreditCardsProvider>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _creditCards.list.length != 0
                ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: _buildTitleSection(
                                title:
                                    '${authProvider.lg[authProvider.language]["Payment Details"]}',
                                subTitle:
                                    '${authProvider.lg[authProvider.language]["How would you like to pay ?"]}',
                              ),
                            ),





                            SliverToBoxAdapter(child:
                             Platform.isAndroid?
                              Container(

                                  height: 35.0,
                                  width: MediaQuery.of(context).size.width/3,

                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.all(Radius.circular(18.0)),
                                      color: Colors.white
                                  ),
                                  child: GestureDetector(
                                    onTap: () async{

                                      List<PaymentItem> items = [PaymentItem(name: "Caterme", price: 23)];

                                      flutterPay.setEnvironment(environment: PaymentEnvironment.Test);

                                   String a=await       flutterPay.requestPayment(
                                        googleParameters: GoogleParameters(
                                          gatewayName: "example",
                                          gatewayMerchantId: "01234567890123456789",
                                        ),
                                        appleParameters: AppleParameters(
                                          merchantIdentifier: "merchant.caterme.tiaragroup.com",
                                          merchantCapabilities: [
                                            MerchantCapability.threeDS,
                                            MerchantCapability.credit,
                                            MerchantCapability.debit
                                          ],
                                        ),
                                        currencyCode: "SAR",
                                        countryCode: "SA",
                                        paymentItems: items,
                                      );

                                   if(a==""){

                                   }
                                   else{
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

    await order
        .getPlaceOrderId(
    order
        .orderid
        .toString(),
    _creditCards
        .credit
        .cardId,true);

    Navigator.of(context)
        .pop();

    //   else {

    if (order
        .paymentverify
        .isNotEmpty) {
    if (order
        .paymentverify[
    "msg"] ==
    "error") {
    // _key.currentState
    //     .showSnackBar(
    // SnackBar(
    // content: Text(
    // '${authProvider.lg[authProvider.language]["error to place order"]}'),
    // ),
    // );
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


    }

                                      //ADD THE FUNCTIONS OF THIS BUTTON HERE
                                    },
                                    child: Row(

                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset("images/googlelogo.png",height: 25),
                                        SizedBox(width: 8.0,),
                                        Text('Pay with : Google Pay', style: TextStyle(color: Colors.black),)
                                      ],
                                    ),
                                  ))
                              :
                              Container(
                                  height: 35.0,
                                  width: MediaQuery.of(context).size.width/3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(18.0)),
                                      color: Colors.black
                                  ),
                                  child: GestureDetector(
                                    onTap: () async{


                                        List<PaymentItem> items = [PaymentItem(name: "Caterme", price: order.totale)];

                                        flutterPay.setEnvironment(environment: PaymentEnvironment.Test);

                                   String a=await     flutterPay.requestPayment(
                                          googleParameters: GoogleParameters(
                                            gatewayName: "example",
                                            gatewayMerchantId: "01234567890123456789",
                                          ),
                                          appleParameters: AppleParameters(
                                            merchantIdentifier: "merchant.caterme.tiaragroup.com",
                                            merchantCapabilities: [
                                              MerchantCapability.threeDS,
                                              MerchantCapability.credit,
                                              MerchantCapability.debit
                                            ],
                                          ),
                                          currencyCode: "SAR",
                                          countryCode: "SA",
                                          paymentItems: items,
                                        );


                                      //ADD THE FUNCTIONS OF THIS BUTTON HERE
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset("images/applelogo.png"
                                            ,height: 25),
                                        SizedBox(width: 8.0,),
                                        Text('Pay with  Apple Pay', style: TextStyle(color: Colors.white),)
                                      ],
                                    ),
                                  ))
                              ,),

                            SliverToBoxAdapter(child: Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Divider( color: Colors.black),
                            ),),
                            // SliverToBoxAdapter(
                            //   child:Column(
                            //     children: [
                            //
                            //       // ApplePayButton(
                            //       //   paymentConfigurationAsset: 'default_payment_profile_google_pay.json',
                            //       //   paymentItems:  [ PaymentItem(
                            //       //     label: 'Cater me',
                            //       //     amount: order.totale.toString(),
                            //       //     status: PaymentItemStatus.final_price,
                            //       //   )],
                            //       //   style: ApplePayButtonStyle.black,
                            //       //   type: ApplePayButtonType.buy,
                            //       //   margin: const EdgeInsets.only(top: 15.0),
                            //       //   onPaymentResult: onApplePayResult,
                            //       //   loadingIndicator: const Center(
                            //       //     child: CircularProgressIndicator(),
                            //       //   ),
                            //       // ),
                            //
                            //     ],
                            //
                            //   )
                            // ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int i) {
                                  return Container(
                                    child:
                                    InkWell(
                                      onTap: (){
                                        _creditCards.value = i;
                                        setState(() {
                                          _value = i;
                                        });
                                        _creditCards.credit =
                                        _creditCards.list[i];
                                      },
                                      child: Row(
                                        children: [
                                          Radio(
                                            fillColor: MaterialStateColor.resolveWith(
                                                (states) => colorCustom),
                                            toggleable: true,
                                            groupValue: _creditCards.value,
                                            value: i,
                                            onChanged: (value) {
                                              _creditCards.value = i;
                                              setState(() {
                                                _value = i;
                                              });
                                              _creditCards.credit =
                                                  _creditCards.list[i];
                                            },
                                          ),
                                          _buildCreditCard(
                                            color: Colors.black,
                                            cardExpiration:
                                                "${DateFormat("MM/yy").format(DateTime.parse(_creditCards.list[i].expiryDate))}",
                                            cardHolder: _creditCards.list[i].ownerName,
                                            cardNumber:
                                                "XXXX XXXX XXXX ${_creditCards.list[i].cardNumber}",
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                childCount: _creditCards.list.length,
                              ),
                            ),
                            // SliverToBoxAdapter(
                            //     child: IconButton(
                            //   onPressed: () {
                            //     Navigator.of(context).push(
                            //       MaterialPageRoute(
                            //         builder: (context) => HomeScreen(),
                            //       ),
                            //     );
                            //
                            //
                            //   },
                            //   icon: Icon(
                            //     Icons.add,
                            //     color: colorCustom,
                            //   ),
                            // ))
                          ],
                        ),
                    ],
                  ),
                )
                : Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => HomeScreen()));
                      },
                      child: Column(children:[
                        // if (Platform.isAndroid) {
                        //   // Android-specific code
                        // } else if (Platform.isIOS) {
                        //   // iOS-specific code
                        // }


                        Platform.isAndroid?

                        Container(

                            height: 35.0,
                            width: MediaQuery.of(context).size.width/3,

                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.all(Radius.circular(18.0)),
                                color: Colors.white
                            ),
                            child: GestureDetector(
                              onTap: (){
                                //ADD THE FUNCTIONS OF THIS BUTTON HERE
                              },
                              child: Row(

                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("images/googlelogo.png",height: 25),
                                  SizedBox(width: 8.0,),
                                  Text('Google Pay', style: TextStyle(color: Colors.black),)
                                ],
                              ),
                            ))
                        :
                        Container(
                            height: 35.0,
                            width: MediaQuery.of(context).size.width/3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(18.0)),
                                color: Colors.black
                            ),
                            child: GestureDetector(
                              onTap: (){
                                //ADD THE FUNCTIONS OF THIS BUTTON HERE
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("images/applelogo.png"
                                      ,height: 25),
                                  SizedBox(width: 8.0,),
                                  Text('Apple Pay', style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Divider(color: Colors.black,),
                        ),
                        Container(
                          color: Colors.transparent,
                          child: language=="en" ?Image.asset("images/CreditCardNewImage/no cards added yet in english.png"):Image.asset("images/CreditCardNewImage/no cards yet in arabic.png")),
                  ])  ),
                  ),
      ),
    floatingActionButton:  ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 8,
        primary: Colors.white,
        fixedSize: const Size(50, 50),
        shape: const CircleBorder(),
      ),
      child: Icon(
        Icons.add,
        size: 30,
        color: Theme.of(context).primaryColor,
      ),
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),));
      },
    ),

    );
  }

  // Build the title section
  Column _buildTitleSection({@required title, @required subTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 16.0),
          child: Text(
            '$title',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
          child: Text(
            '$subTitle',
            style: TextStyle(
                fontSize: 21,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        )
      ],
    );
  }

  // Build the credit card widget
  Card _buildCreditCard(
      {Color color,
      String cardNumber,
      String cardHolder,
      String cardExpiration}) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                '$cardNumber',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontFamily: 'CourrierPrime'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'CARDHOLDER',
                  value: cardHolder,
                ),
                _buildDetailsBlock(label: 'VALID THRU', value: cardExpiration),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Object _cardType(String type) {
    if (type == "MASTERCARD") return SvgPicture.asset('images/master_card.svg');
    if (type == "VISA") return SvgPicture.asset('images/visa_card.svg');
    return null;
  }

  // Build the top row containing logos
  Row _buildLogosBlock() {
    final cc = Provider.of<CreditCardsProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          // child: SvgPicture.asset(_cardType(cc.type)),
        ),
      ],
    );
  }

// Build Column containing the cardholder and expiration information
  Column _buildDetailsBlock({String label, String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
              color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          '$value',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

// Build the FloatingActionButton
  Container _buildAddCardButton({
    Icon icon,
    Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 24.0),
      alignment: Alignment.center,
      child: FloatingActionButton(
        elevation: 2.0,
        onPressed: () {
          print("Add a credit card");
        },
        backgroundColor: color,
        mini: false,
        child: icon,
      ),
    );
  }
}
