import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/model/add_on.dart';

import 'package:CaterMe/widgets/addOns/add_on_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddOnOrderScreen extends StatefulWidget {
int idons;
  AddOnOrderScreen(this.idons);

  @override
  State<AddOnOrderScreen> createState() => _AddOnOrderScreenState();
}

class _AddOnOrderScreenState extends State<AddOnOrderScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
getdata();

  }
  getdata(){
    final package = Provider.of<PackagesProvider>(context, listen: false);
    final order = Provider.of<OrderCaterProvider>(context, listen: false);
    package.getonidorder(widget.idons, order.serviceId,false);
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final package = Provider.of<PackagesProvider>(context, listen: true);


    return  ColoredBox(
        color: Colors.white,
        child:package.allonsorder.length>0? GridView(
          padding: const EdgeInsets.all(25),
          children: getAddOnOrder(package.allonsorder),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2.9 / 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 5,
          ),
        ):Center(child: Text("no Addons to display"),),

    );
  }
}
