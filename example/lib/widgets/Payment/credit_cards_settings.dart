import 'package:CaterMe/Payment/Payment.dart';
import 'package:CaterMe/Providers/credit_card_provider.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class CreditCardsSettings extends StatefulWidget {
  @override
  State<CreditCardsSettings> createState() => _CreditCardsSettingsState();
}

class _CreditCardsSettingsState extends State<CreditCardsSettings> {
  int _value = -1;
  getAllData() async{
    var _creditCards = Provider.of<CreditCardsProvider>(context,listen: false);
    _creditCards.loading=true;
    await _creditCards.getAllCards();
    _creditCards.loading=false;
  }
@override
  void initState() {
    getAllData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _creditCards=Provider.of<CreditCardsProvider>(context,listen: true);
    return Scaffold(
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        centerTitle: true,
        title: Text(
          'My Credit Cards',
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

      body: SafeArea(
        child: Column(

          children: <Widget>[

            Expanded(
                child:_creditCards.loading?Center(child: CircularProgressIndicator(),): CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _buildTitleSection(
                          title: "Payment Details",
                          subTitle: "How would you like to pay ?"),
                    ),
                  SliverList(
                      delegate:
                      SliverChildBuilderDelegate((BuildContext context, int i) {
                        return  Container(
                          child: Row(
                            children: [
                              Radio(
                                toggleable: true,
                                groupValue:_creditCards.valueIndex,
                                value: i,
                                onChanged: (value) {
                                  setState(() {
                                    _creditCards.valueIndex = i;
                                    // orderprovider.valueIndex = index;
                                  });
                                  // orderprovider.value = widget.address[index];
                                },
                              ),
                              _buildCreditCard(
                                  color: LightColors.kLightYellow2,
                                  cardExpiration: _creditCards.list[i].expiryDate,
                                  cardHolder: _creditCards.list[i].ownerName,
                                  cardNumber: "XXXX XXXX XXXX ${_creditCards.list[i].cardNumber}"),
                            ],
                          ),

                        );
                      },
                          childCount:  _creditCards.list.length
                      ),
                    ),
                    // SliverToBoxAdapter(
                    //   child:
                    //   _buildAddCardButton(
                    //       icon: Icon(Icons.add),
                    //       color: LightColors.kLightYellow2),
                    // )
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
              color: Color(0xff3F5521),
              fontSize: 9,
              fontWeight: FontWeight.bold),
        ),
        Text(

    "$value",
          style: TextStyle(
              color: Color(0xff3F5521),
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
          print("Add a credit card");
        },
        backgroundColor: color,
        mini: false,
        child: icon,
      ),
    );
  }
}
