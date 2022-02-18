import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customTextFieldicon extends StatefulWidget {
  Icon icon ;

  String label;
  TextEditingController controller;
  customTextFieldicon({ this.controller,  this.label, this.icon});
  @override
  _costumTextFieldState createState() => _costumTextFieldState();
}

class _costumTextFieldState extends State<customTextFieldicon> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    FocusNode focusNode = FocusNode();
    return  Container(
        padding: const EdgeInsets.all(1.0),
        child: TextFormField(

          controller: widget.controller,
          focusNode: focusNode,
          decoration: InputDecoration(
              prefixIcon: widget.icon,


              contentPadding:
              EdgeInsets.only(left: mediaQuery.size.width * 0.04),

              alignLabelWithHint: true,
              labelStyle: TextStyle(
                  fontSize: focusNode.hasFocus ? 18 : 16.0,//I believe the size difference here is 6.0 to account padding
                  color:
                  focusNode.hasFocus ? Color(0xFF3F5521) : Colors.grey),
              labelText: widget.label,
              hintStyle:TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BerlinSansFB'),

              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Color(0xFF3F5521),
                  ))),
          style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'BerlinSansFB'),
        ));
  }
}
