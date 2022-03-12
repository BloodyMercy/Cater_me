import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/widgets/addOns/add_on_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Providers/address.dart';
import '../Providers/user.dart';
import '../language/language.dart';

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
  getdata() async {
    final package = Provider.of<PackagesProvider>(context, listen: false);
    final order = Provider.of<OrderCaterProvider>(context, listen: false);
    final address = Provider.of<AdressProvider>(context, listen: false);
    SharedPreferences sh=await SharedPreferences.getInstance();
    package.getonidorder(widget.idons, order.serviceId, int.parse(address.numberofguestcontroller.text.toString()
    ),false,sh.getString("locale"));
  }
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

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
        ):Center(child: Text('${LanguageTr.lg[authProvider.language]["no Addons to display"]}'
            ),),

    );
  }
}
