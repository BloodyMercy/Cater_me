import 'package:CaterMe/Screens/specific_menu.dart';
import 'package:CaterMe/model/add_on.dart';
import 'package:CaterMe/model/addons/addonsall.dart';
import 'package:CaterMe/model/cuisins.dart';

import 'package:flutter/material.dart';

import 'add_on_order_screen.dart';

class AddonsCard extends StatelessWidget {
  Addonall cuisin;
  int index;
  AddonsCard({required this.cuisin, required this.index});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Center(
        child: GestureDetector(

          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => AddOnOrderScreen(cuisin.id),
              ),
            );
          },
          child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: ((this.index % 2) == 0)
                        ? Color.fromRGBO(253, 202, 29, 0.8)
                        : Color.fromRGBO(135, 217, 12, 0.8),
                    border: Border.all(style: BorderStyle.none),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    // image: DecorationImage(
                    //     opacity: 0.5,
                    //     image: NetworkImage(
                    //       this.cuisin.image,
                    //     ),
                    //     fit: BoxFit.fill)
                ),
                width: mediaQuery.size.height * 0.15,
                height: mediaQuery.size.height * 0.20,
                child: Center(
                  child: Text(
                    '${this.cuisin.name}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BerlinSansFB'),
                  ),
                ),
              )),
        ));
  }
}
