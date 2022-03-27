import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/widgets/Cuisins/cuisins_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../language/language.dart';
import 'cuisins_list.dart';

class CuisinCard extends StatefulWidget {
  @override
  State<CuisinCard> createState() => _CuisinCardState();
}

class _CuisinCardState extends State<CuisinCard> {
   int activeIndex;

  // getData()async{
  //   Packages _cuisin=Provider.of<Packages>(context,listen: false);
  //
  // }
  @override
  void initState() {
    activeIndex = 0;
    super.initState();
    //  getData();
  }

  // final List<PageViewModel> pages = [
  @override
  Widget build(BuildContext context) {
    final _cuisin = Provider.of<PackagesProvider>(context, listen: true);
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final mediaQuery = MediaQuery.of(context);
    Widget buildCards(CuisinsCard card, int index) => Container(
    //  height: 100,
          child: card,
        );
    List card = getCuisins(_cuisin.cuisins.categories);
    return card.length != 0
        ? ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: card.length,
            itemBuilder: (context, i) {
              final cards = card[i];
              return buildCards(cards, i);
            },
          )
        // listview.builder(

        //   itemCount: card.length,
        //   itemBuilder: (context, index, reaIndex) {
        //     final cards = card[index];
        //     return buildCards(cards, index);
        //   },
        //   options: CarouselOptions(

        //     height: mediaQuery.size.height * 0.20,
        //     autoPlay: false,
        //     enableInfiniteScroll: false,
        //     autoPlayCurve: Curves.fastOutSlowIn,

        //     viewportFraction: 0.3,
        //   ),
        // )
        : Center(child: Text('${authProvider.lg[authProvider.language]["No Shisha To Display"]}'));
  }
}
