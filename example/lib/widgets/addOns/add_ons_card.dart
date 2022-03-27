import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/addOns.dart';
import 'package:CaterMe/widgets/addOns/add_on_cards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/user.dart';
import '../../language/language.dart';

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
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    final package = Provider.of<PackagesProvider>(context, listen: true);
    final mediaQuery = MediaQuery.of(context);
    Widget buildCards(AddOnCards card, int index) => Container(
          child: card,
        );
    return Container(
        height: mediaQuery.size.height * 0.35,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(padding:
                EdgeInsets.symmetric(
                  horizontal: 20,),
                child: Text(
                  '${package.addonsall[widget.i].name}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              // SizedBox(width: mediaQuery.size.width*0.6),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                    child:  Text('${authProvider.lg[authProvider.language]["See All"]}',

                        style: TextStyle( fontSize: 12)),
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
              height: mediaQuery.size.height * 0.27,
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
