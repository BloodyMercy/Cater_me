import 'package:CaterMe/model/menu.dart';
import 'package:CaterMe/widgets/Cuisins/cuisins_card.dart';
import 'package:CaterMe/widgets/Cuisins/cuisins_list.dart';

import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

class MenuCard extends StatefulWidget {
  Menu menu;
  MenuCard({ this.menu});
  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  int activeIndex;
  @override
  void initState() {
    activeIndex = 0;
    super.initState();
  }

  // final List<PageViewModel> pages = [
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    Widget buildCards(CuisinsCard card, int index) => Container(
          child: card,
        );
    List card = getFood(widget.menu.allFood);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider.builder(
            itemCount: card.length,
            itemBuilder: (context, index, reaIndex) {
              final cards = card[index];
              return buildCards(cards, index);
            },
            options: CarouselOptions(
              disableCenter: true,
              pageSnapping: false,
              height: mediaQuery.size.height * 0.20,
              autoPlay: false,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              viewportFraction: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
