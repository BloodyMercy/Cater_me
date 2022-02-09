import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/model/add_on.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class FoodTile extends StatelessWidget {
  final AddOn foodItem;

 FoodTile(this.foodItem) ;

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          shadowColor: const Color(0xffF7CBAB),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  foodItem.title,
                  style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.w600, fontSize: 18),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '\$${foodItem.price}',
                  style: GoogleFonts.varelaRound(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: LightColors.kDarkYellow,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: -10,
          top: -30,
          child: Image.network(
            foodItem.image,
            height: 120,
            width: 120,
          ),
        ),
      ],
    );
  }
}
