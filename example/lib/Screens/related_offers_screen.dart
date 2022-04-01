import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/model/packages.dart';
import 'package:CaterMe/widgets/Packages/order_add_details.dart';
import 'package:CaterMe/widgets/fake_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';


import '../Providers/user.dart';
import '../colors/colors.dart';
import '../language/language.dart';
import 'ahmad/My Orders/widgets/test_package_add_details.dart';

class RelatedOffersScreen extends StatefulWidget {
  RelatedOffersScreen({Key key}) : super(key: key);
  Package fav;

  @override
  State<RelatedOffersScreen> createState() => _RelatedOffersScreenState();
}

class _RelatedOffersScreenState extends State<RelatedOffersScreen> {

  final foods = Fake_Data;

  bool loading = false;

  getData() async {
    final pack = Provider.of<PackagesProvider>(context, listen: false);
    final orderprovider =
        Provider.of<OrderCaterProvider>(context, listen: false);
    final address = Provider.of<AdressProvider>(context, listen: false);
    SharedPreferences sh = await SharedPreferences.getInstance();
    address.typeofeventcontroller.text="1";
    await pack.getallpacakgesorder(
      orderprovider.serviceId,
      int.parse(address.typeofeventcontroller.text.toString()),

      int.parse(address.numberofguestcontroller.text.toString()),
      sh.getString("locale"),  address.evendatelancontroller.text.toString()
    );
    setState(() {
      loading = true;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget setupAlertDialoadContainer(context, PackagesProvider pack, int index) {



    return packageAdsDetailTestorder(
      pack.allpackagesorder[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    final pack = Provider.of<PackagesProvider>(context, listen: true);
    final fav = Provider.of<OrderCaterProvider>(context, listen: true);
    var _width = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    return loading
        ? !pack.allpackagesorder.isEmpty
            ? ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                  child: GestureDetector(
                    child: FittedBox(
                      child: Container(


                          // clipBehavior: Clip.antiAlias,
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(15),
                          // ),
                          // elevation: 12,
                          child: Stack(children: [

                            Card(elevation: 10,
                              child: Container(
                                    height: screenHeight * 0.250,
                                    width: _width * 0.8,
                                  // child: CachedNetworkImage(
                                  //   placeholder: (context, url) =>
                                  //    CircularProgressIndicator(),
                                  //     imageUrl: pack.allpackagesorder[index].image
                                  // ),
                                child: Column(children:[
                                   Image.network(

                                      pack.allpackagesorder[index].image,
                                      // loadingBuilder: ((context, child, loadingProgress) {
                                      //   if (loadingProgress == null) return child;
                                      //   return Center(
                                      //     child: CircularProgressIndicator(
                                      //       strokeWidth: 1,
                                      //       value: loadingProgress.expectedTotalBytes != null
                                      //           ? loadingProgress.cumulativeBytesLoaded /
                                      //           loadingProgress.expectedTotalBytes
                                      //           : null,
                                      //     ),
                                      //   );
                                      // }),
                                      fit: BoxFit.scaleDown,
                                      // width: double.maxFinite,
                                      height: screenHeight * 0.175,
                                      width: _width * 0.8),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text("${authProvider.lg[authProvider.language]["SAR"]} ${pack.allpackagesorder[index].price}",),
                                ]),
                              ),
                            ),

                            // pack.allpackagesorder[index].isfavorite
                            //     ? Positioned(
                            //   top:screenHeight * 0.13,
                            //         left: _width * 0.7,
                            //         child: Icon(
                            //           FontAwesomeIcons.solidHeart,
                            //           color: yellowColor,
                            //           size: 20,
                            //         ),
                            //       )
                            //     : Container(),
                          ])),
                    ),
                    onTap: () {

                      Navigator.of(context)
                          .push(
                          MaterialPageRoute(
                            builder: (context) =>
                            packageAdsDetailTestorder(pack.allpackagesorder[index]),
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
                      //             onPressed: () =>
                      //                 Navigator.of(context).pop(false),
                      //           ),
                      //         ),
                      //         content: setupAlertDialoadContainer(
                      //             context, pack, index),
                      //       );
                      //     });
                    },
                  ),
                ),
                separatorBuilder: (_, index) => SizedBox(
                  height: screenHeight * 0.02,
                ),
                itemCount: pack.allpackagesorder.length,
              )
            : Center(
                child: Text("${authProvider.lg[authProvider.language]["No packages available"]}"),
              )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
