import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/model/ItemsOrder.dart';
import 'package:CaterMe/model/packages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  int count = 1;
  String lg="";
  getData() async {
    setState(() {
      count=widget.food.min;
    });
    final pack = Provider.of<PackagesProvider>(context, listen: false);
    await pack.getpacakgesby(pack.packages.id);
    SharedPreferences rifai=await SharedPreferences.getInstance();
    setState(() {
      loading = false;
      lg=rifai.getString("locale");
    });


  }

  ItemOrders a = ItemOrders();

  @override
  void initState() {
    getData(

    );
    super.initState();
  }



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


                                  // !loading
                                  //     ? IconButton(
                                  //         icon: Icon(
                                  //           widget.food.isfavorite
                                  //               ? Icons.star_purple500_outlined
                                  //               : Icons.star_border_outlined,
                                  //           color: Colors.yellow,
                                  //         ),
                                  //         onPressed: () async {
                                  //           // setState(() {
                                  //           //   loading = true;
                                  //           // });
                                  //           await PackageService.favoriteitem(
                                  //                   widget.food.id)
                                  //               .then((value) {
                                  //             // if (value) {
                                  //             //   widget.food.isfavorite = !widget.food.isfavorite;
                                  //             // }
                                  //             // setState(() {
                                  //             //   loading = false;
                                  //             // });
                                  //           });
                                  //         })
                                  //     : CircularProgressIndicator(
                                  //         color: Colors.white,
                                  //         strokeWidth: 4.0,
                                  //       )
                                ],
                              )),
                          SizedBox(
                            height: constraints.maxHeight * 0.025,
                          ),
                          // Html(
                          //   data: widget.food.description,
                          //   style: {
                          //     "body": Style(
                          //       fontFamily: 'BerlinSansFB',
                          //       color: Colors.black87,
                          //       fontWeight: FontWeight.normal,
                          //     )
                          //   },
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: constraints.maxHeight * 0.03,
                                  child:  FittedBox(
                                      child: Text(lg=="en"?
                                    "PRICE":"السعر"
                                        ,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'BerlinSansFB',
                                        fontWeight: FontWeight.normal),
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
                          // SizedBox(
                          //   height: constraints.maxHeight * 0.04,
                          //   child: FittedBox(
                          //     child: Text(
                          //       "Details:",
                          //       style: st20Bold,
                          //     ),
                          //   ),
                          // ),

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
                                height: constraints.maxHeight * 0.04,
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
