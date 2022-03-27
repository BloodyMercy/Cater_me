import 'package:CaterMe/Payment/Payment.dart';
import 'package:CaterMe/Providers/credit_card_provider.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    final _creditCards =
        Provider.of<CreditCardsProvider>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _creditCards.list.length != 0
                ? Stack(
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
                    Positioned(
                      top:  MediaQuery.of(context).size.height * 0.52,
                      left: MediaQuery.of(context).size.width*0.79,
                      child:  ElevatedButton(
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
                    )
                  ],
                )
                : Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => HomeScreen()));
                      },
                      child: Container(
                          color: Colors.transparent,
                          child: language=="en" ?Image.asset("images/CreditCardNewImage/no cards added yet in english.png"):Image.asset("images/CreditCardNewImage/no cards yet in arabic.png")),
                    ),
                  ),
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
