import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/addOns.dart';
import 'package:CaterMe/model/packages.dart';
import 'package:CaterMe/widgets/addOns/add_on_cards.dart';

import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class AddOnsCard extends StatefulWidget {
  final List<AddOnCards> card;
  final int i;
  AddOnsCard({ this.card, this.i});
  @override
  State<AddOnsCard> createState() => _AddOnsCardState();
}

class _AddOnsCardState extends State<AddOnsCard> {
  int activeIndex;
  @override
  void initState() {
    activeIndex = 0;
    super.initState();
  }

  // final List<PageViewModel> pages = [
  @override
  Widget build(BuildContext context) {
    final package = Provider.of<PackagesProvider>(context, listen: true);
    final mediaQuery = MediaQuery.of(context);
    Widget buildCards(AddOnCards card, int index) => Container(
          child: card,
        );
    return Container(
        height: mediaQuery.size.height * 0.4,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: (mediaQuery.size.width * 0.04)),
                child: Text(
                  '${package.addonsall[widget.i].name}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              // SizedBox(width: mediaQuery.size.width*0.6),
              Padding(
                padding: EdgeInsets.only(right: (mediaQuery.size.width * 0.04)),
                child: GestureDetector(
                    child:  Text("See All", style: Theme.of(context).textTheme.bodyText1),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddOns(package.addonsall[widget.i].id,package.addonsall[widget.i].name)),

                      );
                    }),
              ),
            ],
          ),
          widget.card.length==0? Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Text('you don\t have any addons'),
          ): SizedBox(
              height: mediaQuery.size.height * 0.25,
              width: mediaQuery.size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.card.length,
                itemBuilder: (context, i) {
                  final cards = widget.card[i];
                  return buildCards(cards, i);
                },
              )),
        ]
        ));
  }
}
