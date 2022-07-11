import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Providers/address.dart';
import '../../Providers/occasion.dart';
import '../../Providers/order_provider.dart';
import '../../Providers/user.dart';
import '../Order.dart';

class OccasionAdded extends StatefulWidget {
  String text1;
  String text2;
   OccasionAdded(this.text1,this.text2) ;

  @override
  State<OccasionAdded> createState() => _OccasionAddedState();
}

class _OccasionAddedState extends State<OccasionAdded> {
String language;
  getData() async {


    SharedPreferences sh=await SharedPreferences.getInstance();

    setState(() {
      language = sh.getString("locale");
    });

  }

  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      body:

       Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 27,left: 15),
            child: Align(alignment: Alignment.topLeft,
                child: IconButton(onPressed:(){
                  final occasion = Provider.of<OccasionProvider>(context, listen: false);

                  occasion.nameofoccasioncontroller.text="";
                  occasion.typeofoccasioncontroller.text="";
                  occasion.datechosencontroller.text="";

                  Navigator.of(context).pop();
                  }
                 , icon: Icon(Icons.close),color:colorCustom,)),
          ),
          // SizedBox(
          //   height: mediaQuery.size.height * 0.02,
          // ),
          Column(
            children: [

              Center(
                  child: language=="en"?Image.asset('images/occasionadded.png',fit:BoxFit.contain):Image.asset("images/no address yetعربي/no addresses yetبالعربي-03.png",fit:BoxFit.contain),
                      )
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
    // orderCaterprovider.serviceId=0;z
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



              address.value2Index=-1;
              orderCaterprovider.spets=1;
              orderCaterprovider.issearch=true;
              orderCaterprovider.adonce=false;
              orderCaterprovider.vatshisha=0.0;
              orderCaterprovider.vatfood=0.0;

              orderCaterprovider.totale=0.0;
              orderCaterprovider.choosebillFriend=[];
              orderCaterprovider.choosebillFriend=[];
              orderCaterprovider.itemOrders=[];
            //  credit.value=-1;
              orderCaterprovider.serviceId=0;
              address
                  .eventnamecontroller
                  .text=widget.text1;
              address
                  .evendatecontroller
                  .text=widget.text2;
              address.evendatelancontroller.text=widget.text2;
              setState(() {

              });
            //  orderCaterprovider.valueIndex=-1;
                  Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Order(),
                ),
              );
            },
            child: Text(
              '${authProvider.lg[authProvider.language]["Order"]}',
              style: Theme.of(context).textTheme.headline1,
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.fromLTRB(
                  mediaQuery.size.height  * 0.14,
                  mediaQuery.size.height * 0.02,
                  mediaQuery.size.height * 0.14,
                  mediaQuery.size.height * 0.02),
              onPrimary: const Color.fromRGBO(255, 255, 255, 1),
              primary: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          // ElevatedButton(
          //
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          //   child: Text(
          //     "CLOSE",
          //     style: Theme.of(context).textTheme.headline1,
          //   ),
          //   style: ElevatedButton.styleFrom(
          //
          //     elevation: 5,
          //     padding: EdgeInsets.symmetric(
          //       horizontal: (mediaQuery.size.width * 0.3),
          //       vertical: (mediaQuery.size.height * 0.02),
          //     ),
          //     primary: Colors.black12,
          //     shape: new RoundedRectangleBorder(
          //       borderRadius: const BorderRadius.all(Radius.circular(10)),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
