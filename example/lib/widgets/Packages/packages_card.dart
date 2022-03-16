import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/widgets/occasions/occasions_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Providers/user.dart';
import '../../Screens/seeallpackages.dart';
import '../../language/language.dart';
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

  bool loading = false;

  // final List<PageViewModel> pages = [
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    final mediaQuery = MediaQuery.of(context);
    final packageprovider =
        Provider.of<PackagesProvider>(context, listen: true);
    // Widget buildCards(PackageCard card, int index) => Container(
    //       child: card,
    //     );
    Widget buildIndicator() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedSmoothIndicator(
              activeIndex: this.activeIndex,
              count: packageprovider.packages.items.length,
              effect: ScrollingDotsEffect(
                activeDotColor: Theme.of(context).primaryColor,
                dotHeight: 10,
                dotWidth: 10,
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => seeAllPackages("ttillee"),
                ));
              },
              child: Text('${LanguageTr.lg[authProvider.language]["See All"]}'
                  ),
            ),
          ],
        );
    List<PackageCard> card = getPackages();
    return Container(
      color:Colors.white,
      // width: mediaQuery.size.width * 90,
      child: !loading
          ? Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  packageprovider.packages.items.length > 0
                      ? CarouselSlider.builder(
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
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            viewportFraction: 1,
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: mediaQuery.size.height * 0.03,
                        horizontal: mediaQuery.size.width * 0.05),
                    child: buildIndicator(),
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
