import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/model/packages.dart';
import 'package:CaterMe/widgets/Packages/test_package_add_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

          decoration: BoxDecoration(

            border: Border.all(style: BorderStyle.none),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(

                image: NetworkImage(
                  widget.packages.image,
                ),
                fit: BoxFit.fill),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(style: BorderStyle.none),
                    // color: Color.fromRGBO(63, 85, 33, 0.5),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  height: mediaQuery.size.height * 0.07,
                  width: mediaQuery.size.width * 0.97,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mediaQuery.size.width * 0.035,
                        vertical: mediaQuery.size.height * 0.015),

                  )),
            ],
          ),
        ));
  }
}
