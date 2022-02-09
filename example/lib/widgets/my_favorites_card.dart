import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/model/food.dart';
import 'package:CaterMe/model/packages.dart';
import 'package:flutter/material.dart';

class MyFavoritesCard extends StatelessWidget {
  final Package food;
  const MyFavoritesCard({ this.food});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      color: LightColors.kLightYellow,
      child: Column(
        children: [
          SizedBox(height: mediaQuery.size.height*0.05),
          SizedBox(
            height: mediaQuery.size.height * 0.35,
            width: mediaQuery.size.width * 0.95,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
          child: Container(
            width: mediaQuery.size.width * 0.97,
            decoration: BoxDecoration(
                border: Border.all(style: BorderStyle.none),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                    image: NetworkImage(
                      food.image,
                    ),
                    fit: BoxFit.fill)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.none),
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    height: mediaQuery.size.height * 0.07,
                    width: mediaQuery.size.width * 0.97,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: mediaQuery.size.width * 0.035),
                      child: Text(
                        food.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'BerlinSansFB'),
                      ),
                    )),
              ],
            ),))
          ),

        ],
      ),
    );
  }
}
