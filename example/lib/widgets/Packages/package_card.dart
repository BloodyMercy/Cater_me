import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/model/packages.dart';
import 'package:CaterMe/widgets/Packages/test_package_add_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class PackageCard extends StatefulWidget {
  Package packages;

  PackageCard(this.packages);

  @override
  State<PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  bool loading = false;

  getData() async {
    final pack = Provider.of<PackagesProvider>(context, listen: false);
    await pack.getpacakgesby(pack.packages.id);
    //   setState(() {
    //     loading=false;
    //   });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pack = Provider.of<PackagesProvider>(context, listen: true);
    final mediaQuery = MediaQuery.of(context);
    return InkWell(
      onTap: () {
        //
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => packageAdsDetailTest(widget.packages),
        ));
      },
      child: Container(
        // width: mediaQuery.size.width * 0.97,
        //
        // decoration: BoxDecoration(
        //   border: Border.all(style: BorderStyle.none),
        //   borderRadius: BorderRadius.all(Radius.circular(15)),
        //
        //   image: DecorationImage(
        //       image: NetworkImage(
        //         widget.packages.image,
        //       ),
        //       fit: BoxFit.fill),
        // ),
        child:
        CachedNetworkImage(
          width: mediaQuery.size.width * 0.97,
          //width: 200,
          placeholder: (context, url) =>
              SkeletonGridLoader(

                builder: Container(

                  height: 100,
                  width: 200,
                  child: Card(

                    color: Color(0xFF3F5521),
                    child: GridTile(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Color(0xFF3F5521)),
                          )
                        ],
                       ),
                    ),
                  ),
                ),
                items: 1,
                itemsPerRow: 1,
                period: Duration(seconds: 1),
                highlightColor: Color(0xFF3F5521),
                baseColor: Color(0xffffffff),
                direction: SkeletonDirection.ltr,
                childAspectRatio: 1.6,
              ),
          imageUrl:                 widget.packages.image,



        ),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Container(
        //
        //       decoration: BoxDecoration(
        //         border: Border.all(style: BorderStyle.none),
        //         // color: Color.fromRGBO(63, 85, 33, 0.5),
        //         borderRadius: BorderRadius.only(
        //             bottomLeft: Radius.circular(20),
        //             bottomRight: Radius.circular(20)),
        //       ),
        //       height: mediaQuery.size.height * 0.07,
        //       width: mediaQuery.size.width * 0.97,
        //       child: Padding(
        //         padding: EdgeInsets.symmetric(
        //             horizontal: mediaQuery.size.width * 0.035,
        //             vertical: mediaQuery.size.height * 0.015),
        //         child:  CachedNetworkImage(
        //             height: 100,
        //             width: 200,
        //             placeholder: (context, url) =>
        //                 Expanded(
        //                   child: SkeletonGridLoader(
        //
        //                     builder: Container(
        //
        //                       height: 100,
        //                       width: 200,
        //                       child: Card(
        //
        //                         color: Color(0xFF3F5521),
        //                         child: GridTile(
        //                           child: Column(
        //                             mainAxisAlignment: MainAxisAlignment.center,
        //                             children: <Widget>[
        //                               Container(
        //                                 decoration: BoxDecoration(
        //
        //                                     borderRadius: BorderRadius.all(Radius.circular(15)),
        //                                     color: Color(0xFF3F5521)),
        //                               )
        //                             ],
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                     items: 1,
        //                     itemsPerRow: 1,
        //                     period: Duration(seconds: 1),
        //                     highlightColor: Color(0xFF3F5521),
        //                     baseColor: Color(0xffffffff),
        //                     direction: SkeletonDirection.ltr,
        //                     childAspectRatio: 1.35,
        //                   ),
        //                 ),
        //             imageUrl:                 widget.packages.image,
        //
        //
        //
        //         ),
        //
        //       ),
        //
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
