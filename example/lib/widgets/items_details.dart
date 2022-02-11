import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/Services/HomePage/PackageService.dart';
import 'package:CaterMe/model/add_on.dart';
import 'package:CaterMe/model/food.dart';
import 'package:CaterMe/model/item.dart';
import 'package:CaterMe/model/packages.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';



class AdsitemDetail extends StatefulWidget {
  AddOn food;

  AdsitemDetail(this.food);

  @override
  State<AdsitemDetail> createState() => _AdsitemDetailState();
}

class _AdsitemDetailState extends State<AdsitemDetail> {
  final TextStyle st20Bold = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'BerlinSansFB');

  bool selected = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final packages=Provider.of<PackagesProvider>(context,listen: false);
    var qPortrait = MediaQuery.of(context).orientation;
    var screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: Text(
                'Related Offers',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            !loading
                ? IconButton(
                icon: Icon(
                  widget.food.isfavorite
                      ? Icons.star_purple500_outlined
                      : Icons.star_border_outlined,
                  color: Colors.yellow,
                ),
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  await PackageService.favoriteitem(widget.food.id)
                      .then((value) {
                    if (value) {
                      widget.food.isfavorite = !widget.food.isfavorite;
                    }
                    setState(() {
                      loading = false;
                    });
                  });
                })
                : CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 4.0,
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(63, 85, 33, 1),
      ),
      body: LayoutBuilder(
        builder: (ctx, constraints) => qPortrait == Orientation.portrait
            ? Container(
          color: LightColors.kLightYellow,
              child: Column(
          children: [
              SizedBox(
                  height: constraints.maxHeight * 0.5,
                  width: double.maxFinite,
                  child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.network(widget.food.image))),
              Container(
                height: constraints.maxHeight * 0.5,
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Html(


                    ),
                    SizedBox(
                        height: constraints.maxHeight * 0.04,
                        child: FittedBox(
                            child: Text(
                              widget.food.title,
                              style: st20Bold,
                            ))),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
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
                    Container(height:30,child:ListView.builder(
                      itemCount: widget.food.itemDetails.length,
                      itemBuilder: (ctx, i) {
                        return ListTile(
                          leading: Icon(Icons.circle),
                          title: Text(widget.food.itemDetails[i].description),
                          subtitle: Text(widget.food.itemDetails[i].title),



                        );
                      },
                    )),
                    SizedBox(
                      height: constraints.maxHeight * 0.135,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                                height: constraints.maxHeight * 0.03,
                                child: const FittedBox(
                                    child: Text("PRICE",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: 'BerlinSansFB')))),
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
                          height: constraints.maxHeight * 0.04,
                        ),
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

                      SizedBox(
                        height: constraints.maxHeight * 0.04,
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
    );
  }
}
