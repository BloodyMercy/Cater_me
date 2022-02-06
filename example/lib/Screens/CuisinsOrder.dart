import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/model/add_on.dart';

import 'package:CaterMe/widgets/addOns/add_on_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CuisinOrderScreen extends StatefulWidget {

  CuisinOrderScreen();

  @override
  State<CuisinOrderScreen> createState() => _CuisinOrderScreenState();
}

class _CuisinOrderScreenState extends State<CuisinOrderScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  getdata(){
   // final package = Provider.of<PackagesProvider>(context, listen: false);
  //  final order = Provider.of<OrderCaterProvider>(context, listen: false);
    //package.getonidorder(package.addonsall[0].id, order.serviceId);
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final package = Provider.of<PackagesProvider>(context, listen: true);


    return  ColoredBox(
      color: Colors.white,
      child:package.cuisins.categories.length>0?  SizedBox(
        height: mediaQuery.size.height * 0.71,
        child: GridView(
          padding: const EdgeInsets.all(25),
          children: getCuisinsCards(package.cuisins.categories),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 5,
          ),
        ),
      ):Center(child: Text("no cuisins to display"),),

    );
  }
}
