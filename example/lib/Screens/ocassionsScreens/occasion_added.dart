import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/address.dart';
import '../../Providers/order_provider.dart';
import '../Order.dart';

class OccasionAdded extends StatelessWidget {
  String text1;
  String text2;
   OccasionAdded(this.text1,this.text2) ;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      color:LightColors.kLightYellow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: mediaQuery.size.height * 0.02,
          ),
          Column(
            children: [
              Center(
                  child: Image.asset('images/occasionadded.png',
                      height: 350, width: 250)),
              // SizedBox(
              //   height: mediaQuery.size.height * 0.08,
              // ),
              // Text(
              //   "Occasion Added",
              //   style: Theme.of(context).textTheme.headline5,
              // ),
            ],
          ),

    //
    //     address.clearAddressController();
    //     orderCaterprovider.spets=1;
    //     orderCaterprovider.vatshisha=0.0;
    // orderCaterprovider.vatfood=0.0;
    //
    // orderCaterprovider.totale=0.0;
    // orderCaterprovider.choosebillFriend=[];
    // orderCaterprovider.choosebillFriend=[];
    // orderCaterprovider.itemOrders=[];
    // credit.value=-1;
    // orderCaterprovider.serviceId=0;
    //
    // // orderCaterprovider.listFriend=[];
    // address.value2Index=-1;
    // orderCaterprovider.valueIndex=-1;
    //     Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => Order(),
    //   ),
    // );
          ElevatedButton(
            onPressed: () {
              final address=Provider.of<AdressProvider>(context,listen: false);
              final orderCaterprovider=Provider.of<OrderCaterProvider>(context,listen: false);
                  address.clearAddressController();
              address
                  .eventnamecontroller
                  .text=text1;
              address
                  .evendatecontroller
                  .text=text2;


              address.value2Index=-1;
              orderCaterprovider.spets=1;
              orderCaterprovider.vatshisha=0.0;
              orderCaterprovider.vatfood=0.0;

              orderCaterprovider.totale=0.0;
              orderCaterprovider.choosebillFriend=[];
              orderCaterprovider.choosebillFriend=[];
              orderCaterprovider.itemOrders=[];
            //  credit.value=-1;
              orderCaterprovider.serviceId=0;
            //  orderCaterprovider.valueIndex=-1;
                  Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Order(),
                ),
              );
            },
            child: Text(
              "place order",
              style: Theme.of(context).textTheme.headline1,
            ),
            style: ElevatedButton.styleFrom(
              elevation: 5,
              padding: EdgeInsets.symmetric(
                horizontal: (mediaQuery.size.width * 0.3),
                vertical: (mediaQuery.size.height * 0.02),
              ),
              primary: Theme.of(context).primaryColor,
              shape: new RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "CLOSE",
              style: Theme.of(context).textTheme.headline1,
            ),
            style: ElevatedButton.styleFrom(
              elevation: 5,
              padding: EdgeInsets.symmetric(
                horizontal: (mediaQuery.size.width * 0.3),
                vertical: (mediaQuery.size.height * 0.02),
              ),
              primary: Theme.of(context).primaryColor,
              shape: new RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
