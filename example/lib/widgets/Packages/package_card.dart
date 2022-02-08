import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/data/food_details.dart';
import 'package:CaterMe/model/occasion.dart';
import 'package:CaterMe/model/package.dart';
import 'package:CaterMe/model/packages.dart';
import 'package:CaterMe/widgets/Packages/package_add_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'order_add_details.dart';

class PackageCard extends StatefulWidget {
  Package packages;
  PackageCard(this.packages);

  @override
  State<PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  bool loading= false;
  getData()async{
    final pack=Provider.of<PackagesProvider>(context,listen: false);
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
    final pack=Provider.of<PackagesProvider>(context,listen: true);
    final mediaQuery = MediaQuery.of(context);
    return InkWell(
        onTap: (){
          //
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => packageAdsDetail(
                 widget.packages
                ),
              ));

        },

        child:Container(
      width: mediaQuery.size.width * 0.97,

      decoration: BoxDecoration(
          border: Border.all(style: BorderStyle.none),
          borderRadius: BorderRadius.all(Radius.circular(15)),
          image: DecorationImage(
              image: NetworkImage(
                widget.packages.image,
              ),
              fit: BoxFit.fill)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                border: Border.all(style: BorderStyle.none),
                color: Color(0xFF3F5521),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              height: mediaQuery.size.height * 0.07,
              width: mediaQuery.size.width * 0.97,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: mediaQuery.size.width * 0.035, vertical: mediaQuery.size.height*0.015),
                child: Text(
                  widget.packages.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BerlinSansFB'),
                ),
              )),
        ],
      ),
    ));
  }
}
