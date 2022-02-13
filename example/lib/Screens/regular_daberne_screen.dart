import 'package:CaterMe/Providers/order.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'daberne_screen.dart';
import 'occasion/theme/colors/light_colors.dart';
import 'regular_screen.dart';

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
  }
bool loading = true;
  @override
  Widget build(BuildContext context) {
    final orderProvider =
        Provider.of<OrderCaterProvider>(context, listen: true);
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Container(
      color: LightColors.kLightYellow,
      height: screenHeight * 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              GestureDetector(
                onTap: () {
                  setState(() {
                    reg = !reg;
                    dab = false;
                  });
                  orderProvider.serviceId = 1;
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
                    Container(
                      // decoration:  BoxDecoration(
                      //     border: Border.all(
                      //       color: reg? Theme.of(context).primaryColor: Colors.white,
                      //     ),),
                      child: SvgPicture.asset('images/CaterMeStep2.svg',
                          height: screenHeight * 0.3),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    dab = !dab;
                    reg = false;
                  });
                  orderProvider.serviceId = 2;
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
                    Container(
                      // decoration:  BoxDecoration(
                      //   border: Border.all(
                      //     color: dab? Theme.of(context).primaryColor: Colors.white,
                      //   ),),
                      child:


                      SvgPicture.asset('images/daberni.svg',
                          height: screenHeight * 0.2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
