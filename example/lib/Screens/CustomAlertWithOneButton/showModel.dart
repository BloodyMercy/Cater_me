import 'package:CaterMe/Screens/CustomAlert/alert.dart';
import 'package:flutter/material.dart';

import 'alert.dart';


class ShowModel extends StatefulWidget {


  @override
  _ShowModelState createState() => _ShowModelState();
}

class _ShowModelState extends State<ShowModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: (){
          return Container(
            child: ElevatedButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) => CustomDialog(
                    title: "Success",
                    description:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    buttonText: "Okay",
                  ),
                );
              },

            ),
          );

        },
        child: Text(''),
      ),
    );
  }
}




