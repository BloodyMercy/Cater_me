
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CustomElevatedButton extends StatefulWidget {
   String hinttext;
   String location;
   VoidCallback  pressed;
  CustomElevatedButton(this.hinttext,this.location,this.pressed);

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
    chosenlocation = widget.location;

  }

  @override
  Widget build(BuildContext context) {


    return ElevatedButton(
      onPressed: ()async{

      },
      child: Text(
        chosenhinttext,
        style: TextStyle(
          fontFamily: 'Ubuntu',
          fontWeight: FontWeight.w500,
        ),
      ),
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.all(
          Color.fromRGBO(0, 169, 165, 1.0),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            )
        ),),
    );
  }
}
