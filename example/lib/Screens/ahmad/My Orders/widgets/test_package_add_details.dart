import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/Services/HomePage/PackageService.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/model/ItemsOrder.dart';
import 'package:CaterMe/model/packages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeleton_loader/skeleton_loader.dart';



//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: SafeArea(
//       child: DecoratedBox(
//         child: CustomScrollView(
//           slivers: <Widget>[
//             SliverAppBar(
//               expandedHeight: 300,
//               flexibleSpace: FlexibleSpaceBar(
//                 collapseMode: CollapseMode.pin,
//                 background: Container(
//                   decoration: BoxDecoration(image: DecorationImage(image: AssetImage("your_image_here"), fit: BoxFit.cover)),
//                   padding: EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 20),
//
//                 ),
//               ),
//             ),
//             SliverList(
//               delegate:
//               SliverChildListDelegate(
//                 [
//                   Container(
//                     decoration: BoxDecoration(
//                         color: Colors.orange,
//                         borderRadius: BorderRadius.horizontal(
//                           left: Radius.circular(30),
//                           right: Radius.circular(30),
//                         )),
//                     child: Column(
//                       children: <Widget>[
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

class packageAdsDetailTestorder extends StatefulWidget {
  Package food;

  packageAdsDetailTestorder(this.food);

  @override
  State<packageAdsDetailTestorder> createState() => _OrderAdsDetailState();
}

class _OrderAdsDetailState extends State<packageAdsDetailTestorder> {
  final TextStyle st20Bold = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'BerlinSansFB');

  bool selected = false;
  bool loading = false;
  getData() async {
    SharedPreferences rifai=await SharedPreferences.getInstance();
    setState(() {
      count=widget.food.min;
    });
    setState(() {
      loading = false;
      lg=rifai.getString("locale");
    });
    final pack = Provider.of<PackagesProvider>(context, listen: false);
    await pack.getpacakgesby(pack.packages.id);




  }

  ItemOrders a = ItemOrders();

  @override
  void initState() {
    getData();
    super.initState();
  }

  int count = 1;


  String lg="";
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    final orderprovider =
        Provider.of<OrderCaterProvider>(context, listen: true);
    final pack = Provider.of<UserProvider>(context, listen: true);
    var qPortrait = MediaQuery.of(context).orientation;
    var width = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            shadowColor: Colors.transparent,
            actions: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(150)),
                // child: IconButton(
                //   onPressed: () async {
                //     if (pack.status == Status.Unauthenticated) {
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (context) => LoginScreen()));
                //     } else {
                //       setState(() {
                //         loading = true;
                //       });
                //
                //       showDialog(
                //         context: this.context,
                //         barrierDismissible: false,
                //         builder: (BuildContext contexts) {
                //           return WillPopScope(
                //               // onWillPop: () => Future<bool>.value(false),
                //               child: AlertDialog(
                //             title: Text(
                //               "Loading...",
                //               style: TextStyle(color: yellowColor),
                //             ),
                //             content: Column(
                //                 mainAxisSize: MainAxisSize.min,
                //                 children: <Widget>[
                //                   CircularProgressIndicator(
                //                     color: yellowColor,
                //                   )
                //                 ]),
                //           ));
                //         },
                //       );
                //       print("${widget.food.isfavorite}");
                //       await PackageService.favoriteitem(widget.food.id)
                //           .then((value) {
                //         if (value) {
                //           Navigator.pop(context);
                //           widget.food.isfavorite = !widget.food.isfavorite;
                //         } else {
                //           Navigator.pop(context);
                //         }
                //         setState(() {
                //           loading = false;
                //         });
                //       });
                //
                //       print("${widget.food.isfavorite}");
                //     }
                //   },
                //   icon: Icon(
                //     widget.food.isfavorite
                //         ? FontAwesomeIcons.solidHeart
                //         : FontAwesomeIcons.heart,
                //     color: yellowColor,
                //     size: 20,
                //   ),
                // ),
              )
            ],
            leading: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(150)),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: yellowColor,
                    size: 30,
                  ),
                ),
              ),
            ),
            pinned: false,
            floating: false,
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.maxFinite,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child:
                  CachedNetworkImage(
                      height: screenHeight * 0.175,
                      width: width * 0.8,
                      placeholder: (context, url) =>
                          // SkeletonGridLoader(
                          //
                          //   builder: Container(
                          //     height: screenHeight * 0.175,
                          //     width: width   * 0.8,
                          //     child: Card(
                          //
                          //       color: Color(0xFF3F5521),
                          //       child: GridTile(
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: <Widget>[
                          //             Container(
                          //               decoration: BoxDecoration(
                          //
                          //                   borderRadius: BorderRadius.all(Radius.circular(15)),
                          //                   color: Color(0xFF3F5521)),
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          //   items: 1,
                          //   itemsPerRow: 1,
                          //   period: Duration(seconds: 1),
                          //   highlightColor: Color(0xFF3F5521),
                          //   baseColor: Color(0xffffffff),
                          //   direction: SkeletonDirection.ltr,
                          //   childAspectRatio: 2.8,
                          // ),
CircularProgressIndicator(color: Color.fromRGBO(63, 85, 33, 1)),
                      imageUrl:widget.food.image


                  ),

                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  // height: MediaQuery.of(context).size.height ,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      )),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          widget.food.title,
                          style: const TextStyle(
                              fontSize: 28,
                              fontFamily: 'BerlinSansFB',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Text(
                              "${authProvider.lg[authProvider.language]["Price"]}:",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'BerlinSansFB',
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${authProvider.lg[authProvider.language]["SAR"]} ${widget.food.price.toString()}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'BerlinSansFB',
                                  fontWeight: FontWeight.bold),
                            ),





                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (count != 0) {
                                        if(count>widget.food.min) {
                                          // orderprovider.totalpackage=orderprovider.totalpackage-1;
                                          setState(() {
                                            count= count - widget.food.increment;
                                          });

                                        }
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Color.fromRGBO(63, 85, 33, 1),
                                  )),
                              Text(
                                "${count}",
                                style: TextStyle(
                                  color: Color.fromRGBO(63, 85, 33, 1),
                                  fontSize: 30,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    if(count<widget.food.max) {
                                      //  orderprovider.totalpackage=orderprovider.totalpackage+1;
                                      setState(() {
                                        count= count + widget.food.increment;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Color.fromRGBO(63, 85, 33, 1),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Expanded(
                            child: FloatingActionButton(
                              onPressed: () {
                                if (count == 0) {
                                } else {
                                  orderprovider.totalpackage=orderprovider.totalpackage+1;
                                  a.ispack=true;
                                  a.id = widget.food.id;
                                  a.image = widget.food.image;
                                  a.description = widget.food.description;
                                  a.isfavorite = widget.food.isfavorite;
                                  a.itemDetails = widget.food.itemDetails;
                                  a.title = widget.food.title;
                                  a.quantity = count;

                                  a.price=widget.food.price;
                                  a.totalprice = count * widget.food.price;
                                  a.tax=widget.food.tax;
                                  a.min=widget.food.min;
                                  a.max=widget.food.max;

                                  orderprovider.addItems(a,widget.food.isShisha);
                                  Navigator.of(context).pop(false);
                                }

                              },
                              child:  Text(lg=="en"?
                              'ADD':"اضف"
                                ,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'BerlinSansFB'),
                              ),
                              backgroundColor: Color.fromRGBO(63, 85, 33, 1),
                            ),
                          )
                          // ElevatedButton(
                          //   onPressed: () {
                          //     // validate();
                          //   },
                          //   child: const Text(
                          //     'ADD',
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.bold,
                          //         fontFamily: 'BerlinSansFB'),
                          //   ),
                          //   style: ElevatedButton.styleFrom(
                          //     padding: EdgeInsets.fromLTRB(
                          //       screenHeight * 0.06,
                          //       screenHeight * 0.02,
                          //       screenHeight * 0.06,
                          //       screenHeight * 0.02,
                          //     ),
                          //     onPrimary:
                          //         const Color.fromRGBO(255, 255, 255, 1),
                          //     primary: const Color.fromRGBO(63, 85, 33, 1),
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(100.0),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      //   Container(height: 100,),
                      Html(
                        data: widget.food.description,
                        style: {
                          "body": Style(
                            fontFamily: 'BerlinSansFB',
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          )
                        },
                      ),
                      //  Container(height: 100,),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  _SliverAppBarDelegate({this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return child;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => child.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
