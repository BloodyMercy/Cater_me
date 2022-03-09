import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../Providers/user.dart';
import '../language/language.dart';

class RegularDaberneScreen extends StatefulWidget {
  @override
  _RegularDaberneScreenState createState() => _RegularDaberneScreenState();
}

class _RegularDaberneScreenState extends State<RegularDaberneScreen> {
  bool reg;
  bool dab;

  @override
  void initState() {
    super.initState();
    reg = false;
    dab = false;
    //  data();
  }

  data() {
    final orderProvider =
        Provider.of<OrderCaterProvider>(context, listen: true);
    final addresProvider = Provider.of<AdressProvider>(context, listen: true);
    if (addresProvider.hours.isDaberni) {
      orderProvider.serviceId = 2;
    }
    setState(() {});
  }

  bool loading = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    final orderProvider =
        Provider.of<OrderCaterProvider>(context, listen: true);
    final addresProvider = Provider.of<AdressProvider>(context, listen: true);
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                if (!addresProvider.hours.isDaberni) {
                  setState(() {
                    reg = !reg;
                    dab = false;
                  });
                  orderProvider.serviceId = 1;
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: orderProvider.serviceId == 1
                        ? Theme.of(context).primaryColor
                        : Colors.black12,
                    size: 30,
                  ),
                  Column(
                    children: [
                      Image.asset('images/CaterMe.png',
                          height: screenHeight * 0.3),
                      Text('${LanguageTr.lg[authProvider.language]["after"]}${addresProvider.hours.timespan}',
                          style:TextStyle(fontWeight: FontWeight.normal,color:Colors.black),)
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (!addresProvider.hours.isDaberni) {
                  setState(() {
                    dab = !dab;
                    reg = false;
                  });
                  orderProvider.serviceId = 2;
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: orderProvider.serviceId == 2
                        ? Theme.of(context).primaryColor
                        : Colors.black12,
                    size: 30,
                  ),
                  Column(
                    children: [
                      Container(
                        // decoration:  BoxDecoration(
                        //   border: Border.all(
                        //     color: dab? Theme.of(context).primaryColor: Colors.white,
                        //   ),),
                        child: SvgPicture.asset('images/daberni.svg',
                            height: screenHeight * 0.2),
                      ),
                      Text(" ${LanguageTr.lg[authProvider.language][ "before"]}, ${addresProvider.hours.timespan} ",style: TextStyle(fontWeight: FontWeight.normal,color:Colors.black)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
