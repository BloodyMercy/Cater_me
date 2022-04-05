import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentBottomSheet extends StatefulWidget {
  @override
  _PaymentBottomSheetState createState() => _PaymentBottomSheetState();
}

enum CardType { Paypal, PaybyCard }

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  CardType _character = CardType.Paypal;
  TextEditingController CNumberController = new TextEditingController();
  TextEditingController CHolderController = new TextEditingController();
  TextEditingController EDateController = new TextEditingController();
  TextEditingController CCVCodeController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // UserProvider _user =Provider.of<UserProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 0.8,
                decoration: new BoxDecoration(
                  color: Color(0xff313444),
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(25.0),
                    topRight: const Radius.circular(25.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 15),
                child: Text(
                  'Add your card',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 1.08,
                  top: MediaQuery.of(context).size.height / 60,
                  right: 10
                ),
                /*child: InkWell(
                  onTap: () {
                    changeScreenReplacement(context, Payments());
                  },*/
                  child: 
     GestureDetector( behavior: HitTestBehavior.translucent,
                      child: Image.asset(
                        'assets/icons/icon-x.png',
                        width: 40,
                      ),
                    onTap: (){
                      // changeScreenReplacement(context, Payments());
                    },
                    ),

              ),
              Container(
                height: height,
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, left: 12,right: 12),
                    child: Container(
                      height: height / 5,
                      width: width / 0.09,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(59, 63, 82, 1),
                          border: Border.all(
                            color: Color.fromRGBO(59, 63, 82, 1),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60, left: 12),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Text('PayPal',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Ubuntu',
                          )),
                      leading: Radio<CardType>(
                        activeColor: Color(0xff00A9A5),
                        value: CardType.Paypal,
                        groupValue: _character,
                        onChanged: (CardType value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 6,
                    ),
                    child: Divider(
                      thickness: 0.5,
                      indent: 12,
                      endIndent: 16,
                      color: Color(0xff8792a4),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 130,
                      left: 12,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Text('Pay by Card',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Ubuntu',
                          )),
                      leading: Radio<CardType>(
                        activeColor: Color(0xff00A9A5),
                        value: CardType.PaybyCard,
                        groupValue: _character,
                        onChanged: (CardType value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,vertical: 180
                    ),
                    child: Container(
                      height: height / 2.3,
                      width: width / 0.09,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(59, 63, 82, 1),
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(5))),
                    ),
                  ),
                  Padding(
                    padding:
                   EdgeInsets.symmetric(vertical: 190,horizontal: 20),
                    child: _customfield(CNumberController, "Card Number",
                        Icons.credit_card_outlined),
                  ),
                 Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 255, horizontal: 20),
                    child: _customfield(CHolderController, "Card Holder",
                        Icons.person_outline_outlined),
                  ),
                 Padding(
                    padding: const EdgeInsets.symmetric(vertical: 320,horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          child: _customfield(EDateController, "Exp. Date",
                              Icons.calendar_today_outlined),
                          height: height / 13,
                          width: width / 2.5,
                        ),
                        SizedBox(
                          child: _customfield(
                              CCVCodeController, "CCV Code", Icons.lock_outline),
                          height: height / 13,
                          width: width / 2.5,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 1.5,
                      left: 17,
                      right: 10,
                    ),
                    child: Image.asset('assets/icons/Lock.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 1.5,
                        left: 35,
                        right: 10),
                    child: Text(
                      "Your payment information is safe with us. We use secure transmission and encrypted storage.",
                      style: TextStyle(
                        color: Color(0xff8792a4),
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 1.2,
                  left: MediaQuery.of(context).size.width / 30,
                ),
                child: Container(
                  width: width / 1.09,
                  height: height / 13,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xff00A9A5),
                        ),
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 20))),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

TextFormField _customfield(
    TextEditingController controller, String hint, IconData icon) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color(0xff00A9A5),
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 5.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(),
        ),
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 12.0, color: Colors.black),
        suffixIcon: Icon(
          icon,
          color: const Color(0xff8792A4),
          size: 20,
        )),
    style: const TextStyle(
      fontSize: 15,
      color: Colors.black,
    ),
    validator: (value) {
      if (value == null) {
        return 'Please Enter $hint';
      }
      return null;
    },
  );
}
