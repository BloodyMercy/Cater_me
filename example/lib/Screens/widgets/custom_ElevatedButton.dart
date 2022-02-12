
import 'dart:io';

import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/model/address_model.dart';
import 'package:CaterMe/widgets/Addresses/addresses_textField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CustomElevatedButton extends StatefulWidget {
   String hinttext;

  CustomElevatedButton(this.hinttext, );

  @override
  _CustomElevatedButtonState createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  String chosenhinttext="";
  String chosenlocation="";

  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chosenhinttext = widget.hinttext;


  }
  List<Addresses> _address = [];
  void _addNewAddress(
      String contactName,
      String email,
      String phoneNumber,
      String country,
      String city,
      String addressTitle,
      // String id,
      ) {
    final newAddress = Addresses(
      // image: image,
      contactName: contactName,
      email: email,
      phoneNumber: phoneNumber,
      country: country,
      city: city,
      addressTitle: addressTitle,
      id: DateTime.now().toString(),
    );

    setState(() {
      _address.add(newAddress);
    });
  }
  void _startAddNewAddress(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return AddressesTextField(_addNewAddress, ctx);
        });
  }

  @override
  Widget build(BuildContext context) {

    final adress = Provider.of<AdressProvider>(context, listen: true);
    return ElevatedButton(

      onPressed: ()async{
        adress.createOrUpdate=0;
        adress.clearAddressController();
        _startAddNewAddress(context);
      },
      child: Text(
        chosenhinttext,
        style: const TextStyle(
          fontFamily: 'Ubuntu',
          fontWeight: FontWeight.w500,
          color: Color(0xFF3F5521)
        ),
      ),
      style: ButtonStyle(

        backgroundColor:
        MaterialStateProperty.all(
          Color.fromRGBO(255, 255, 255, 1.0),
        ),

        minimumSize: MaterialStateProperty.all(Size(200, 50)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            )
        ),),
    );
  }
}
