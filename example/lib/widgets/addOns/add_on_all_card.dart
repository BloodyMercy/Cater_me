// import 'package:CaterMe/Providers/cuisines.dart';
// import 'package:CaterMe/Providers/packages.dart';
// import 'package:CaterMe/widgets/Cuisins/cuisins_card.dart';
// import 'package:CaterMe/widgets/Cuisins/cuisins_list.dart';
// import 'package:CaterMe/widgets/addOns/add_on_card_order.dart';
// import 'package:CaterMe/widgets/addOns/add_on_list.dart';
//
// import 'package:flutter/material.dart';
//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:provider/provider.dart';
//
// class AddOnAllCard extends StatefulWidget {
//   @override
//   State<AddOnAllCard> createState() => _AddOnAllCardState();
// }
//
// class _AddOnAllCardState extends State<AddOnAllCard> {
//   late int activeIndex;
//
//   // getData()async{
//   //   Packages _cuisin=Provider.of<Packages>(context,listen: false);
//   //
//   // }
//   @override
//   void initState() {
//     activeIndex = 0;
//     super.initState();
//     //  getData();
//   }
//
//   // final List<PageViewModel> pages = [
//   @override
//   Widget build(BuildContext context) {
//     final _cuisin = Provider.of<PackagesProvider>(context, listen: true);
//
//     final mediaQuery = MediaQuery.of(context);
//     Widget buildCards(AddOnCardOrder card, int index) => Container(
//       child: card,
//     );
//     List card = getAddOnOrder(_cuisin.cuisins.categories);
//     return card.length != 0
//         ? ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: card.length,
//       itemBuilder: (context, i) {
//         final cards = card[i];
//         return buildCards(cards, i);
//       },
//     )
//     // listview.builder(
//
//     //   itemCount: card.length,
//     //   itemBuilder: (context, index, reaIndex) {
//     //     final cards = card[index];
//     //     return buildCards(cards, index);
//     //   },
//     //   options: CarouselOptions(
//
//     //     height: mediaQuery.size.height * 0.20,
//     //     autoPlay: false,
//     //     enableInfiniteScroll: false,
//     //     autoPlayCurve: Curves.fastOutSlowIn,
//
//     //     viewportFraction: 0.3,
//     //   ),
//     // )
//         : Center(child: Text("No Add On's To Dispaly"));
//   }
// }
