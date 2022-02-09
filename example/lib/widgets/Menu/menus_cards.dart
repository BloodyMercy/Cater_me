import 'package:CaterMe/Screens/food_details_screen.dart';
import 'package:CaterMe/Screens/specific_menu.dart';
import 'package:CaterMe/data/food_details.dart';
import 'package:CaterMe/model/cuisins.dart';
import 'package:CaterMe/model/food.dart';

import 'package:flutter/material.dart';

class MenusCard extends StatelessWidget {
  Food food;
  int index;
  MenusCard({ this.food,  this.index});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Center(
        child: GestureDetector(
           onTap: (){
                Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FoodDetailScreen(food:this.food),
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
                                    color: ((this.index%2)==0)?  Color.fromRGBO(253, 202, 29, 0.8): Color.fromRGBO(135, 217, 12, 0.8),

          border: Border.all(style: BorderStyle.none),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
            opacity: 0.5,
              image: AssetImage(
                this.food.image,
              ),
              fit: BoxFit.fill)),
                width: mediaQuery.size.height * 0.25,
                height: mediaQuery.size.height * 0.6,
                  child: 
                  
                      Center(
                        child: Text(
                          '${this.food.name}',
                          style: TextStyle(color: Colors.white,fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BerlinSansFB'),
                        ),
                      ),
                    
                  
                
              )),
        ));
  }
}
