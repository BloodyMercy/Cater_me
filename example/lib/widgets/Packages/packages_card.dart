import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/widgets/occasions/occasions_list.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package_card.dart';


class PackagesCard extends StatefulWidget {
  @override
  State<PackagesCard> createState() => _PackagesCardState();
}

class _PackagesCardState extends State<PackagesCard> {
 int activeIndex;
  @override
  void initState() {
    activeIndex = 0;
    super.initState();
  }
bool loading=false;
  // final List<PageViewModel> pages = [
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final packageprovider=Provider.of<PackagesProvider>(context,listen: true);
    // Widget buildCards(PackageCard card, int index) => Container(
    //       child: card,
    //     );
    Widget buildIndicator() => AnimatedSmoothIndicator(
          activeIndex: this.activeIndex,
          count: packageprovider.packages.items.length,
          effect: ScrollingDotsEffect(
            activeDotColor: Theme.of(context).primaryColor,
            dotHeight: 10,
            dotWidth: 10,
          ),
        );
    List<PackageCard> card = getPackages();
    return SizedBox(
      // width: mediaQuery.size.width * 90,
      child:!loading? Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Container(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              packageprovider.packages.items.length>0? CarouselSlider.builder(
                itemCount: packageprovider.packages.items.length,

                itemBuilder: (context, index, reaIndex) {
                  final cards = packageprovider.packages.items[index];
                  return PackageCard(cards);
                },
                options: CarouselOptions(
                  onPageChanged: (index, reason) => setState(() {
                    this.activeIndex = index;
                  }),

                  autoPlay: true,

                  height: mediaQuery.size.height * 0.3,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 1,
                ),
              ):Center(child:Text("no Packages",style: TextStyle(color: Colors.black),)),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: mediaQuery.size.height * 0.03,
                    horizontal: mediaQuery.size.width * 0.05),
                child: buildIndicator(),
              )
            ],
          ),
        ),
      ):Center(child: CircularProgressIndicator()),
    );
  }
}
