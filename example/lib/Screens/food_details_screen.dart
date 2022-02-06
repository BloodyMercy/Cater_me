import 'package:CaterMe/Screens/cuisins_screen.dart';
import 'package:CaterMe/Screens/specific_menu.dart';
import 'package:CaterMe/model/cuisins.dart';
import 'package:CaterMe/model/food.dart';
import 'package:CaterMe/model/menu.dart';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FoodDetailScreen extends StatefulWidget {
  Food food;

  FoodDetailScreen({
    required this.food,
  });

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  final TextStyle st20Bold = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'BerlinSansFB');

  bool selected = false;

  @override
  Widget build(BuildContext context) {
    var qPortrait = MediaQuery.of(context).orientation;
    var screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
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
      body: LayoutBuilder(
        builder: (ctx, constraints) => qPortrait == Orientation.portrait
            ? Column(
                children: [
                  SizedBox(
                      height: constraints.maxHeight * 0.5,
                      width: double.maxFinite,
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.asset(widget.food.image))),
                  Container(
                    height: constraints.maxHeight * 0.5,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: constraints.maxHeight * 0.04,
                            child: FittedBox(
                                child: Text(
                              "Lorem Lorem:",
                              style: st20Bold,
                            ))),
                        SizedBox(
                          height: constraints.maxHeight * 0.05,
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.04,
                          child: FittedBox(
                            child: Text(
                              "Details:",
                              style: st20Bold,
                            ),
                          ),
                        ),
                        AutoSizeText(
                          widget.food.description,
                          style: const TextStyle(
                              fontSize: 20, fontFamily: 'BerlinSansFB'),
                          maxLines: 3,
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.135,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: mediaQuery.size.height * 0.05,
                                ),
                                Container(
                                    height: constraints.maxHeight * 0.03,
                                    child: const FittedBox(
                                        child: Text("PRICE",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: 'BerlinSansFB')))),
                                Text(
                                  '\$${widget.food.price.toString()}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'BerlinSansFB',
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
            : Row(
                children: [
                  FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset(
                        widget.food.image,
                        height: constraints.maxHeight * 1,
                        width: constraints.maxWidth * 0.5,
                      )),
                  Container(
                    // height: constraints.maxHeight * 0.5,
                    width: constraints.maxWidth * 0.5,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: mediaQuery.size.height * 0.05,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: constraints.maxHeight * 0.04,
                                  child: const FittedBox(
                                    child: Text(
                                      "price",
                                    ),
                                  ),
                                ),
                                Text(
                                  '\$${widget.food.price.toString()}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'BerlinSansFB',
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
