import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/add_new_occasion.dart';
import 'package:CaterMe/Screens/edit_occasion.dart';
import 'package:CaterMe/model/occasion.dart';
import 'package:CaterMe/widgets/occasions/occasions_card.dart';
import 'package:CaterMe/widgets/occasions/occasions_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OccasionCard extends StatefulWidget {
  Axis ax;
  OccasionCard(this.ax);
  @override
  State<OccasionCard> createState() => _OccasionCardState();
}

class _OccasionCardState extends State<OccasionCard> {
  int activeIndex;
  // list
  @override
  void initState() {
    activeIndex = 0;
    // getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final occasion=Provider.of<OccasionProvider>(context,listen:true);
    final package=Provider.of<PackagesProvider>(context,listen:true);
    // List<Occasion> occc=getOccasionsToday(occasion.today);
    List<Occasion> occa=getOccasionsToday(package.occasions);
    final mediaQuery = MediaQuery.of(context);
    Widget buildCards(OccasionsCard card, int index) =>
        Container(

          child: Column(
            children: [
              card,
              widget.ax == Axis.vertical
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: (mediaQuery.size.width * 0.1)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditOccasion(occa[index]),
                                ),
                              );
                            },
                            child: ImageIcon(
                              AssetImage(
                                'images/edit.png',
                              ),
                              color: Theme.of(context).primaryColor,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        );
    List<OccasionsCard> card = getOccasions(package.occasions);
    var content = card.length >0?Container(
      height: mediaQuery.size.height*0.2,
        child: ListView.builder(
          scrollDirection: widget.ax,
        itemCount: card.length+1, itemBuilder: (BuildContext context, int index) {
      final cards = card[index];
      return index==card.length?    Container(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: mediaQuery
                      .size.width *
                      0.02),
              child: Text(
                'You don\'t have any upcoming occasions ',
                style: TextStyle(
                    color: Theme.of(
                        context)
                        .primaryColor,
                    fontSize: 11,
                    fontFamily:
                    'BerlinSansFB'),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(
                        context)
                        .push(
                      MaterialPageRoute(
                        builder:
                            (context) =>
                            AddNewOccasion(
                                0),
                      ),
                    );
                  },
                  icon: const Icon(Icons
                      .add_circle_outline_rounded),
                  color:
                  Theme.of(context)
                      .primaryColor,
                ),
                Text(
                  'Add an occasion ',
                  style: TextStyle(
                      fontWeight:
                      FontWeight
                          .bold,
                      color: Theme.of(
                          context)
                          .primaryColor,
                      fontSize: 15,
                      fontFamily:
                      'BerlinSansFB'),
                ),
              ],
            )
          ],
        ),
      ):buildCards(cards, index);
    },

        // options: widget.ax == Axis.vertical
        //     ? CarouselOptions(
        //         scrollDirection: widget.ax,
        //         height: mediaQuery.size.height * 0.45,
        //         pageSnapping: false,
        //         autoPlay: false,
        //         enableInfiniteScroll: false,
        //         viewportFraction: 0.4,
        //       )
        //     : CarouselOptions(
        //         scrollDirection: widget.ax,
        //         pageSnapping: false,
        //         height: mediaQuery.size.height * 0.2,
        //         autoPlay: false,
        //         autoPlayCurve: Curves.fastOutSlowIn,
        //         enableInfiniteScroll: false,
        //         viewportFraction: 1,
        //       )
    ) ):Container();
    return Container(
      // height: mediaQuery.size.height*0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          widget.ax == Axis.vertical
              ? SizedBox(
                  height: mediaQuery.size.height * 0.65,
                  child: content,
                )
              : content,
          widget.ax == Axis.vertical
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: mediaQuery.size.height * 0.01,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>  AddNewOccasion(0),
                            ),
                          );
                        },
                        child: const Text(
                          "Add new occasion",
                          style: TextStyle(
                              color: Color.fromRGBO(63, 85, 33, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BerlinSansFB'),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          padding: EdgeInsets.symmetric(
                            horizontal: (mediaQuery.size.width * 0.05),
                            vertical: (mediaQuery.size.height * 0.01),
                          ),
                          primary:  Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
