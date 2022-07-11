import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/Cuisinis/offer/orderdetails.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/model/packages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/user.dart';
import '../../Screens/ahmad/My Orders/widgets/test_package_add_details.dart';

class AddOnCardOrder extends StatelessWidget {
  Package addOn;

  AddOnCardOrder(this.addOn);

  Widget setupAlertDialoadContainer(context, Package pack) {
    return OrderAdscuisDetail(
      addOn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final pack = Provider.of<PackagesProvider>(context, listen: true);

    // final pack = Provider.of<PackagesProvider>(context, listen: true);
    var mediaQuery = MediaQuery.of(context);
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        child: Stack(
          children: [
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          packageAdsDetailTestorder(addOn, false),
                    ),
                  );
                  // showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return AlertDialog(
                  //         title: Container(
                  //           alignment: Alignment.topLeft,
                  //           child: IconButton(
                  //             icon: Icon(
                  //               Icons.close,
                  //               color: Color.fromRGBO(63, 85, 33, 1),
                  //             ),
                  //             onPressed: () => Navigator.of(context).pop(false),
                  //           ),
                  //         ),
                  //         content: setupAlertDialoadContainer(context, addOn),
                  //       );
                  //     });
                },
                child: Container(
                  // width: mediaQuery.size.width*0.8 ,
                  height: mediaQuery.size.height * 0.35,

                  child: Column(
                    children: [
                      CachedNetworkImage(
                        height: 95,
                        width: 95,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        imageUrl: this.addOn.image,
                      ),
                      // Image.network(
                      //   this.addOn.image,
                      //   height: 75,
                      //   width: 75,
                      // ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: (mediaQuery.size.width * 0.035)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      '${this.addOn.title}',
                                      maxLines: 2,
                                      style: TextStyle(

                                          color: colorCustom,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'BerlinSansFB'),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          "${authProvider.lg[authProvider.language]["SAR"]} ${this.addOn.price}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                      ),

                                      //   IconButton(onPressed: (){}, icon: Icon(Icons.add_circle, color: Theme.of(context).primaryColor,))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // addOn.isfavorite? Positioned(
            //   top: mediaQuery.size.height * 0.15,
            //   left: mediaQuery.size.width * 0.3,
            //   child: Icon(
            //     FontAwesomeIcons.solidHeart,
            //     color: yellowColor,
            //     size: 20,
            //   ),
            // ):Container(),
          ],
        ),
      ),
    );
  }
}
