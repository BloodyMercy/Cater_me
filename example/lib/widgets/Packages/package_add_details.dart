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
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class packageAdsDetail extends StatefulWidget {
  Package food;

  packageAdsDetail(this.food);

  @override
  State<packageAdsDetail> createState() => _OrderAdsDetailState();
}

class _OrderAdsDetailState extends State<packageAdsDetail> {
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
      appBar: AppBar(
        centerTitle: true,
        title: Text('Details', style: Theme.of(context).textTheme.headline1),
        actions: [
          IconButton(
              icon: Icon(
                widget.food.isfavorite
                    ? Icons
                    .star_purple500_outlined
                    : Icons
                    .star_border_outlined,
                color: Colors.yellow,
                size: 30,
              ),
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                await PackageService
                    .favoriteitem(
                    widget.food.id)
                    .then((value) {
                  if (value) {
                    widget.food.isfavorite =
                    !widget.food
                        .isfavorite;
                  }
                  setState(() {
                    loading = false;
                  });
                });
              })
        ],
        // title: Row(
        //
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     const Padding(
        //       padding: EdgeInsets.only(left: 40.0),
        //
        //         child: Text(
        //           'Details',
        //           style: TextStyle(fontWeight: FontWeight.bold),
        //         ),
        //
        //
        //     ),
        //
        //
        //   ],
        // ),
        backgroundColor: const Color.fromRGBO(63, 85, 33, 1),
      ),
      body: SingleChildScrollView(
        child: !loading
            ? Column(
                      children: [
                        SizedBox(
                          height:MediaQuery.of(context).size.height * 0.4,
                          width: double.maxFinite,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Image.network(widget.food.image),
                          ),
                        ),


                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                                child: Text(
                              widget.food.title,
                              style: st20Bold,
                            )),
                            // !loading
                            //     ?
                            //     : CircularProgressIndicator(
                            //         color:
                            //             LightColors.kLightYellow,
                            //         strokeWidth: 4.0,
                            //       )
                          ],
                        ),
                        SizedBox(
                          height:MediaQuery.of(context).size.height * 0.025,
                        ),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.start,
                          children: [
                            Container(
                                height: MediaQuery.of(context).size.height * 0.03,
                                child: const FittedBox(
                                    child: Text(
                                  "PRICE",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'BerlinSansFB',
                                      fontWeight: FontWeight.bold),
                                ))),
                            SizedBox(width: 20,),
                            Text(
                              widget.food.price.toString(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'BerlinSansFB',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                      Html(
                            data: widget.food.description,
                          ),

                      ],
                    )

            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
