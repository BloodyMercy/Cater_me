import 'package:CaterMe/Payment/Payment.dart';
import 'package:CaterMe/Providers/credit_card_provider.dart';
import 'package:CaterMe/Screens/CustomAlert/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Providers/user.dart';
import '../../language/language.dart';


class CreditCardsSettings extends StatefulWidget {
  @override
  State<CreditCardsSettings> createState() => _CreditCardsSettingsState();
}

class _CreditCardsSettingsState extends State<CreditCardsSettings> {
  int _value = -1;
  String language;
  getAllData() async{
    var _creditCards = Provider.of<CreditCardsProvider>(context,listen: false);
    _creditCards.loading=true;
    await _creditCards.getAllCards();
    _creditCards.loading=false;

    SharedPreferences sh = await SharedPreferences.getInstance();
    setState(() {
      language = sh.getString('locale');
    });

  }
@override
  void initState() {
    getAllData();
    super.initState();
  }final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    final _creditCards=Provider.of<CreditCardsProvider>(context,listen: true);
    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          iconSize: 30,
        ),
        elevation: 0,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     bottom: Radius.circular(15),
        //   ),
        // ),
        centerTitle: true,
        title: Text('${LanguageTr.lg[authProvider.language]['My Credit Cards']}',

          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(onPressed: (){

            Navigator.of(context).push(
              MaterialPageRoute(builder: (_)=>HomeScreen())
            );
          }, icon: Icon(Icons.add))
        ],
      ),

      body: _creditCards.list.length==0?Center(child: language=="en"?Image.asset('images/nocardsyet.png'):Image.asset('images/no address yetعربي/no addresses yetبالعربي-10.png')):_creditCards.loading?Center(child: CircularProgressIndicator(),):
      SafeArea(
        child:  Column(

          children: <Widget>[

            Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _buildTitleSection(
                          title: '${LanguageTr.lg[authProvider.language]["Payment Details"]}',

                          subTitle:'${LanguageTr.lg[authProvider.language]["How would you like to pay ?"]}' ),
                    ),
                  SliverList(
                      delegate:
                      SliverChildBuilderDelegate((BuildContext context, int i) {
                        return  Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Card(
                            elevation: 4.0,
                            color: Colors.black,
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
                                  Row(mainAxisAlignment: MainAxisAlignment.end,
                                  children: [IconButton(
                                      onPressed: () {
                                        _creditCards.valueIndex = i;
                                        showDialog(context: context, builder: (BuildContext context){
                                          return CustomDialog(title:'${LanguageTr.lg[authProvider.language][ "Delete Credit Card"]}', description: '${LanguageTr.lg[authProvider.language]["Are you sure do you want to delete this card?"]}', button1: ElevatedButton(onPressed:  () async{
                                            _creditCards.loading=true;
                                            _creditCards.notifyListeners();
                                            Navigator.pop(context);
                                            var delete = await  _creditCards.deleteCard(_creditCards.list[i].id);
                                            if(delete=="deleted"){
                                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                                  content: Text('${LanguageTr.lg[authProvider.language]["Credit card Deleted"]}'),

                                                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                //   content: Text('Address Deleted'),
                                              ));
                                            }else{
                                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                                  content: Text('${LanguageTr.lg[authProvider.language]['Credit card cannot be deleted']}'),
    )
                                                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                //   content: Text('Address Deleted'),
                                              );
                                            }


                                            await _creditCards.getAllCards();
                                            _creditCards.loading=false;
                                            _creditCards.notifyListeners();
                                          },child: Text('${LanguageTr.lg[authProvider.language]["Yes"]}'),), oneOrtwo: true,button2:  ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);

                                              },
                                              child: Text('${LanguageTr.lg[authProvider.language]["No"]}'
                                                  )),);
                                        });







                                      }, icon:Icon(Icons.delete,color: Colors.red) ),],),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Text(
                                      "XXXX XXXX XXXX ${_creditCards.list[i].cardNumber}",
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
                                        label: '${LanguageTr.lg[authProvider.language]["CARDHOLDER"]}',
                                        value: _creditCards.list[i].ownerName,
                                      ),
                                      _buildDetailsBlock(label:  '${LanguageTr.lg[authProvider.language]["VALID THRU"]}',
                                       value: "${DateFormat("MM/yy").format(DateTime.parse(_creditCards.list[i].expiryDate))}"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                              // _buildCreditCard(
                              //     color: LightColors.kLightYellow2,
                              //     cardExpiration: _creditCards.list[i].expiryDate,
                              //     cardHolder: _creditCards.list[i].ownerName,
                              //     cardNumber: "XXXX XXXX XXXX ${_creditCards.list[i].cardNumber}"),


                          // Slidable(
                          //   key: UniqueKey(),
                          //   endActionPane: ActionPane(
                          //     motion:  BehindMotion(),
                          //     children:  [
                          //       Spacer(),
                          //
                          //
                          //     ],
                          //   ),
                          //   child: Row(
                          //     children: [
                          //
                          //     ],
                          //   ),
                          //
                          // )
                            ],
                          ),

                        );
                      },
                          childCount:  _creditCards.list.length
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: 15,),
                    ),
                  ],
                )

            )
          ],
        ),
      ),
    );
  }

  // Build the title section
  Column _buildTitleSection({@required title, @required subTitle}) {
    final authProvider = Provider.of<UserProvider>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 16.0),
          child: Text(
            '$title',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
          child: Text(
            '$subTitle',
            style: TextStyle(fontSize: 21, color: Color(0xff3F5521)),
          ),
        )
      ],
    );
  }

  // Build the credit card widget
  Card _buildCreditCard(
      { Color color,
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
                    color: Color(0xff3F5521),
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
                _buildDetailsBlock(label: 'VALID THRU', value: "${DateFormat("MM/yy").format(DateTime.parse(cardExpiration))}"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build the top row containing logos
  Row _buildLogosBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SvgPicture.asset(
            "images/caterme.svg",
            height: 40,
            width: 18,
          ),
        ),
        // Image.asset(
        //   "assets/images/mastercard.png",
        //   height: 50,
        //   width: 50,
        // ),
      ],
    );
  }

// Build Column containing the cardholder and expiration information
  Column _buildDetailsBlock({ String label,  String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.bold),
        ),
        Text(

    "$value",
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold),
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
          print(
              "Add a credit card");
        },
        backgroundColor: color,
        mini: false,
        child: icon,
      ),
    );
  }
}
