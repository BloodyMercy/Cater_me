import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:CaterMe/model/occasion.dart';
import 'package:CaterMe/widgets/occasions/occasion_card.dart';
import 'package:CaterMe/widgets/occasions/occasions_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Ocasions extends StatefulWidget {
  const Ocasions({Key? key}) : super(key: key);

  @override
  State<Ocasions> createState() => _OcasionsState();
}

class _OcasionsState extends State<Ocasions> {
  @override
  bool loading=false;
  Widget build(BuildContext context) {
   // List<Occasion> occasion = occasionSS;
    final mediaQuery = MediaQuery.of(context);


    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Occasions',
            style: Theme.of(context).textTheme.headline1,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: !loading?Container(
            color: Colors.white,
            child: Column(
              children: [
                OccasionCard(
                  Axis.vertical,
                )
              ],
            )):Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
