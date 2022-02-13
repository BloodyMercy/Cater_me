import 'package:CaterMe/Providers/order.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/Services/HomePage/PackageService.dart';
import 'package:CaterMe/model/ItemsOrder.dart';
import 'package:CaterMe/model/food.dart';
import 'package:CaterMe/model/packages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';


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




class packageAdsDetailTest extends StatefulWidget {
  Package food;

  packageAdsDetailTest(this.food);

  @override
  State<packageAdsDetailTest> createState() => _OrderAdsDetailState();
}

class _OrderAdsDetailState extends State<packageAdsDetailTest> {
  final TextStyle st20Bold = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'BerlinSansFB');

  bool selected = false;
  bool loading = false;

  getData() async {
    final pack = Provider.of<PackagesProvider>(context, listen: false);
    await pack.getpacakgesby(pack.packages.id);
    setState(() {
      loading = false;
    });
  }

  ItemOrders a = ItemOrders();

  @override
  void initState() {
    getData();
    super.initState();
  }

  int count = 0;

  @override
  Widget build(BuildContext context) {
    final orderprovider =
    Provider.of<OrderCaterProvider>(context, listen: true);
    final pack = Provider.of<PackagesProvider>(context, listen: true);
    var qPortrait = MediaQuery.of(context).orientation;
    var screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text('Details', style: Theme.of(context).textTheme.headline1),
      //   actions: [
      //     IconButton(
      //         icon: Icon(
      //           widget.food.isfavorite
      //               ? Icons
      //               .star_purple500_outlined
      //               : Icons
      //               .star_border_outlined,
      //           color: Colors.yellow,
      //           size: 30,
      //         ),
      //         onPressed: () async {
      //           setState(() {
      //             loading = true;
      //           });
      //           await PackageService
      //               .favoriteitem(
      //               widget.food.id)
      //               .then((value) {
      //             if (value) {
      //               widget.food.isfavorite =
      //               !widget.food
      //                   .isfavorite;
      //             }
      //             setState(() {
      //               loading = false;
      //             });
      //           });
      //         })
      //   ],
      //   // title: Row(
      //   //
      //   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   //   children: [
      //   //     const Padding(
      //   //       padding: EdgeInsets.only(left: 40.0),
      //   //
      //   //         child: Text(
      //   //           'Details',
      //   //           style: TextStyle(fontWeight: FontWeight.bold),
      //   //         ),
      //   //
      //   //
      //   //     ),
      //   //
      //   //
      //   //   ],
      //   // ),
      //   backgroundColor: const Color.fromRGBO(63, 85, 33, 1),
      // ),
      body:
          CustomScrollView(
            slivers: [
              SliverAppBar(
                shadowColor: Colors.transparent,
                leading: IconButton(onPressed: (){
                  Navigator.of(context).pop();
                },icon: Icon(Icons.backup,color: Colors.green,size: 35,),),

                pinned: true,
                floating: true,
                expandedHeight: MediaQuery.of(context).size.height * 0.4,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background:SizedBox(
                    height:MediaQuery.of(context).size.height * 0.4,
                    width: double.maxFinite,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Image.network(widget.food.image),
                    ),
                  ) ,
                ),

              ),
              SliverList(
                delegate:
              SliverChildListDelegate(
                [
                  Container(
                    // height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        )),
                    child: Column(
                      children: <Widget>[
                        Html(
                          data: widget.food.description,
                          style: {
                            "body":Style( fontSize: FontSize(18.0), )
                          },
                        ),
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

  _SliverAppBarDelegate({ this.child });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
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
