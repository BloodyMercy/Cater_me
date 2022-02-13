import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customTextFieldPhone extends StatefulWidget {

  Icon icon ;
  String label;
  TextEditingController controller;
  customTextFieldPhone({ this.controller,  this.label, this.icon});
  @override
  _costumTextFieldPhone createState() => _costumTextFieldPhone();
}

class _costumTextFieldPhone extends State<customTextFieldPhone> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    FocusNode focusNode = FocusNode();
    return  Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        keyboardType: TextInputType.number,

        // controller: adress.floornumbercontroller,
        controller: widget.controller,
        focusNode: focusNode,

        decoration: InputDecoration(

prefixIcon: widget.icon,

            contentPadding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),

            alignLabelWithHint: true,
            labelStyle: TextStyle(
                fontSize: focusNode.hasFocus ? 18 : 16.0,//I believe the size difference here is 6.0 to account padding
                color:
                focusNode.hasFocus ? Color(0xFF3F5521) : Colors.grey),
            labelText: widget.label,
            hintStyle:const TextStyle(
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
        style: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: 'BerlinSansFB'),
      ),
    );
  }
}
