import 'package:CaterMe/Screens/cuisins_screen.dart';
import 'package:CaterMe/model/menu.dart';
import 'package:CaterMe/widgets/Cuisins/cuisins_list.dart';
import 'package:flutter/material.dart';

class SpecificMenu extends StatelessWidget {
  Menu menu;
   SpecificMenu({ this.menu});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    PreferredSize appBar = PreferredSize(
      preferredSize: Size.fromHeight(
        MediaQuery.of(context).size.height * 0.12,
      ),
      child: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(top: (mediaQuery.size.width * 0.04)),
          child: IconButton(
            onPressed: () {
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => CuisinsScreen(),
              //   ),
              // );
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
            iconSize: 30,
          ),
        ),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(top: (mediaQuery.size.height * 0.03)),
          child: Text(
            'Menu',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: //Padding(
          //padding:  EdgeInsets.only(top:mediaQuery.size.height*0.15),
          //child:
          Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            height: mediaQuery.size.height * 0.1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: mediaQuery.size.width*0.05),
                  child: Text(this.menu.name, style: Theme.of(context).textTheme.headline2,),
                ),
              ],
            ),
          ),
          SizedBox(
            height: mediaQuery.size.height * 0.71,
            child:GridView(
        padding: const EdgeInsets.all(25),
        children: getMenusCards(this.menu.allFood),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          childAspectRatio: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 5,
        ),
      ),
      // ),
          )])
    );
  }
}