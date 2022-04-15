import 'package:credit_card/credit_card_model.dart';
import 'package:credit_card/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../Providers/user.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({
    Key key,
    this.cardNumber,
    this.expiryDate,
    this.cardHolderName,
    this.cvvCode,
    @required this.onCreditCardModelChange,
    this.themeColor,
    this.textColor = Colors.black,
    this.cursorColor,
  }) : super(key: key);

  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final void Function(CreditCardModel) onCreditCardModelChange;
  final Color themeColor;
  final Color textColor;
  final Color cursorColor;

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;
  bool isCvvFocused = false;
  Color themeColor;

  void Function(CreditCardModel) onCreditCardModelChange;
  CreditCardModel creditCardModel;

  final MaskedTextController _cardNumberController =
  MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
  MaskedTextController(mask: '00/00');
  final TextEditingController _cardHolderNameController =
  TextEditingController();
  final TextEditingController _cvvCodeController =
  MaskedTextController(mask: '0000');

  FocusNode cvvFocusNode = FocusNode();

  void textFieldFocusDidChange() {
    creditCardModel.isCvvFocused = cvvFocusNode.hasFocus;
    onCreditCardModelChange(creditCardModel);
  }

  void createCreditCardModel() {
    cardNumber = widget.cardNumber ?? '';
    expiryDate = widget.expiryDate ?? '';
    cardHolderName = widget.cardHolderName ?? '';
    cvvCode = widget.cvvCode ?? '';

    creditCardModel = CreditCardModel(
        cardNumber, expiryDate, cardHolderName, cvvCode, isCvvFocused);
  }

  @override
  void initState() {
    super.initState();

    createCreditCardModel();

    onCreditCardModelChange = widget.onCreditCardModelChange;

    cvvFocusNode.addListener(textFieldFocusDidChange);

    _cardNumberController.addListener(() {
      setState(() {
        cardNumber = _cardNumberController.text;
        creditCardModel.cardNumber = cardNumber;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _expiryDateController.addListener(() {
      setState(() {
        expiryDate = _expiryDateController.text;
        creditCardModel.expiryDate = expiryDate;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cardHolderNameController.addListener(() {
      setState(() {
        cardHolderName = _cardHolderNameController.text;
        creditCardModel.cardHolderName = cardHolderName;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cvvCodeController.addListener(() {
      setState(() {
        cvvCode = _cvvCodeController.text;
        creditCardModel.cvvCode = cvvCode;
        onCreditCardModelChange(creditCardModel);
      });
    });
  }

  @override
  void didChangeDependencies() {
    themeColor = widget.themeColor ?? Theme.of(context).primaryColor;
    super.didChangeDependencies();
  }
  TextFormField _customfieldnumberotp(
      TextEditingController controller, String hint, IconData icon) {
    return TextFormField(
      controller: controller,
      focusNode: cvvFocusNode,
      textDirection: TextDirection.ltr,
      keyboardType: TextInputType.number,

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
  TextFormField _customfieldnumber(
      TextEditingController controller, String hint, IconData icon) {
    return TextFormField(
      controller: controller,

      textDirection: TextDirection.ltr,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,

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
  TextFormField _customfield(
      TextEditingController controller, String hint, IconData icon) {
    return TextFormField(
      controller: controller,
      textDirection: TextDirection.ltr,
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
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final user = Provider.of<UserProvider>(context, listen: true);
    return   GestureDetector( behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Theme(
        data: ThemeData(
          primaryColor: themeColor.withOpacity(0.8),
          primaryColorDark: themeColor,
        ),
        child: Form(
          child: Column(
            children: <Widget>[
          Padding(
          padding:
          EdgeInsets.symmetric(vertical: 19,horizontal: 20),
          child:   _customfieldnumber(_cardNumberController, '${user.lg[user.language]['Card number']}',
                  Icons.credit_card_outlined)),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: _customfield(_cardHolderNameController, '${user.lg[user.language]['Card Holder']}',
                    Icons.person_outline_outlined),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      child: _customfieldnumber(_expiryDateController, '${user.lg[user.language]['Expired Date']}',
                          Icons.calendar_today_outlined),
                      height: height / 13,
                      width: width / 2.5,
                    ),
                    SizedBox(
                      child: _customfieldnumberotp(
                         _cvvCodeController, "CCV", Icons.lock_outline),
                      height: height / 13,
                      width: width / 2.5,
                    ),
                  ],
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 8.0),
              //   margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
              //   child: TextFormField(
              //     textDirection: TextDirection.ltr,
              //     controller: _cardNumberController,
              //     cursorColor: widget.cursorColor ?? themeColor,
              //     style: TextStyle(
              //       color: widget.textColor,
              //     ),
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: '${user.lg[user.language]['Card number']}',
              //       hintText: 'xxxx xxxx xxxx xxxx',
              //
              //     ),
              //     keyboardType: TextInputType.number,
              //     textInputAction: TextInputAction.next,
              //   ),
              // ),
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 8.0),
              //   margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
              //   child: TextFormField(
              //     controller: _expiryDateController,
              //     cursorColor: widget.cursorColor ?? themeColor,
              //     style: TextStyle(
              //       color: widget.textColor,
              //     ),
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(),
              //         labelText:'${user.lg[user.language]['Expired Date']}',
              //         hintText:user.language=="ar"?'YY/MM': 'MM/YY'),
              //     keyboardType: TextInputType.number,
              //     textInputAction: TextInputAction.next,
              //   ),
              // ),
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 8.0),
              //   margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
              //   child: TextField(
              //     focusNode: cvvFocusNode,
              //     controller: _cvvCodeController,
              //     cursorColor: widget.cursorColor ?? themeColor,
              //     style: TextStyle(
              //       color: widget.textColor,
              //     ),
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'CVV',
              //       hintText: 'XXX',
              //     ),
              //     keyboardType: TextInputType.number,
              //     textInputAction: TextInputAction.done,
              //     onChanged: (String text) {
              //       setState(() {
              //         cvvCode = text;
              //       });
              //     },
              //   ),
              // ),
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 8.0),
              //   margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
              //   child: TextFormField(
              //     controller: _cardHolderNameController,
              //     cursorColor: widget.cursorColor ?? themeColor,
              //     style: TextStyle(
              //       color: widget.textColor,
              //     ),
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: '${user.lg[user.language]['Card Holder']}',
              //     ),
              //     keyboardType: TextInputType.text,
              //     textInputAction: TextInputAction.next,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
