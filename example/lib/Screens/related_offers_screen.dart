import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/widgets/Packages/order_add_details.dart';
import 'package:CaterMe/widgets/fake_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'occasion/theme/colors/light_colors.dart';

class RelatedOffersScreen extends StatefulWidget {
  RelatedOffersScreen({Key key}) : super(key: key);

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
    SharedPreferences sh=await SharedPreferences.getInstance();
    await pack.getallpacakgesorder(orderprovider.serviceId,
        int.parse(address.typeofeventcontroller.text.toString()),
        int.parse(address.numberofguestcontroller.text.toString()
        ),sh.getString("locale"),);
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
    return OrderAdsDetail(
      pack.allpackagesorder[index],
    );
  }




  @override
  Widget build(BuildContext context) {
    final pack = Provider.of<PackagesProvider>(context, listen: true);
    var _width = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    return loading?
        !pack.allpackagesorder.isEmpty
            ? ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(
                      top: 5.0, left: 20.0, right: 20.0),
                  child: GestureDetector(
                    child: FittedBox(
                      child: Card(


                        // clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 12,

                        child: Stack(
                          children:[



                            Image.network(
                              pack.allpackagesorder[index].image,
                              fit: BoxFit.scaleDown,
                              // width: double.maxFinite,
                              height: screenHeight * 0.175,
                              width: _width * 0.8),
                        ]),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Container(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: Color.fromRGBO(63, 85, 33, 1),
                                  ),
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                ),
                              ),
                              content: setupAlertDialoadContainer(
                                  context, pack, index),
                            );
                          });
                    },
                  ),
                ),
                separatorBuilder: (_, index) => SizedBox(
                  height: screenHeight * 0.02,
                ),
                itemCount: pack.allpackagesorder.length,
              )
            : Center(
                child: Text('no packages available'),
              ):Center(child: CircularProgressIndicator(),);
  }
}
