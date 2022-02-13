import 'package:CaterMe/Providers/order.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Services/HomePage/PackageService.dart';
import 'package:CaterMe/model/ItemsOrder.dart';
import 'package:CaterMe/model/food.dart';
import 'package:CaterMe/model/packages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

class OrderAdsDetail extends StatefulWidget {
  Package food;

  OrderAdsDetail(this.food);

  @override
  State<OrderAdsDetail> createState() => _OrderAdsDetailState();
}

class _OrderAdsDetailState extends State<OrderAdsDetail> {
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
    return SingleChildScrollView(
      child: Container(
        height: screenHeight * 0.95,
        width: MediaQuery.of(context).size.width * 0.9,
        child: LayoutBuilder(
          builder: (ctx, constraints) => qPortrait == Orientation.portrait
              ? Column(
                  children: [
                    SizedBox(

                        height: constraints.maxHeight * 0.25,
                        width: double.maxFinite,
                        child: Card(
                          elevation: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),),
                            child: Image.network(widget.food.image))),
                    Container(
                      height: constraints.maxHeight * 0.5,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: constraints.maxHeight * 0.04,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FittedBox(
                                      child: Text(
                                    widget.food.title,
                                    style: st20Bold,
                                  )),
                                  !loading
                                      ? IconButton(
                                          icon: Icon(
                                            widget.food.isfavorite
                                                ? Icons.star_purple500_outlined
                                                : Icons.star_border_outlined,
                                            color: Colors.yellow,
                                          ),
                                          onPressed: () async {
                                            // setState(() {
                                            //   loading = true;
                                            // });
                                            await PackageService.favoriteitem(
                                                    widget.food.id)
                                                .then((value) {
                                              // if (value) {
                                              //   widget.food.isfavorite = !widget.food.isfavorite;
                                              // }
                                              // setState(() {
                                              //   loading = false;
                                              // });
                                            });
                                          })
                                      : CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 4.0,
                                        )
                                ],
                              )),
                          SizedBox(
                            height: constraints.maxHeight * 0.025,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: constraints.maxHeight * 0.03,
                                  child: const FittedBox(
                                      child: Text(
                                    "PRICE",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'BerlinSansFB',
                                        fontWeight: FontWeight.bold),
                                  ))),
                              Text(
                                widget.food.price.toString(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'BerlinSansFB',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.025,
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.04,
                            child: FittedBox(
                              child: Text(
                                "Details:",
                                style: st20Bold,
                              ),
                            ),
                          ),
                          Container(
                              height: 85,
                              child: ListView.builder(
                                itemCount: widget.food.itemDetails.length,
                                itemBuilder: (ctx, i) {
                                  return ListTile(
                                    leading: Icon(Icons.circle),
                                    title: Text(
                                        widget.food.itemDetails[i].description),
                                    subtitle:
                                        Text(widget.food.itemDetails[i].title),
                                  );
                                },
                              )),
                          SizedBox(
                            height: constraints.maxHeight * 0.073,
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
                                            count--;
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        Icons.remove_circle,
                                        color: Color.fromRGBO(63, 85, 33, 1),
                                      )),
                                  Text(
                                    "$count",
                                    style: TextStyle(
                                      color: Color.fromRGBO(63, 85, 33, 1),
                                      fontSize: 30,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          count++;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.add_circle,
                                        color: Color.fromRGBO(63, 85, 33, 1),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.04,
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  if (count == 0) {
                                  } else {
                                    a.id = widget.food.id;
                                    a.image = widget.food.image;
                                    a.description = widget.food.description;
                                    a.isfavorite = widget.food.isfavorite;
                                    a.itemDetails = widget.food.itemDetails;
                                    a.title = widget.food.title;
                                    a.quantity = count;
                                    a.price=widget.food.price;
                                    a.totalprice = count * widget.food.price;
                                    orderprovider.addItems(a);
                                    Navigator.of(context).pop(false);
                                  }

                                },
                                child: const Text(
                                  'ADD',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'BerlinSansFB'),
                                ),
                                backgroundColor: Color.fromRGBO(63, 85, 33, 1),
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
                        ],
                      ),
                    )
                  ],
                )
              : Row(
                  children: [
                    FittedBox(
                        fit: BoxFit.fill,
                        child: Image.asset(
                          widget.food.image,
                          height: constraints.maxHeight * 1,
                          width: constraints.maxWidth * 0.5,
                        )),
                    Container(
                      // height: constraints.maxHeight * 0.5,
                      width: constraints.maxWidth * 0.5,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: constraints.maxHeight * 0.04,
                                    child: const FittedBox(
                                      child: Text(
                                        "price",
                                      ),
                                    ),
                                  ),
                                  Text(
                                    widget.food.price.toString(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'BerlinSansFB',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              // ElevatedButton(
                              //   onPressed: () {
                              //     // validate();
                              //   },
                              //   child: const Text('Add'),
                              //   style: ElevatedButton.styleFrom(
                              //     padding: EdgeInsets.fromLTRB(
                              //         screenHeight * 0.06,
                              //         screenHeight * 0.02,
                              //         screenHeight * 0.06,
                              //         screenHeight * 0.02),
                              //     onPrimary:
                              //         const Color.fromRGBO(255, 255, 255, 1),
                              //     primary: const Color.fromRGBO(63, 85, 33, 1),
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(5.0),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
