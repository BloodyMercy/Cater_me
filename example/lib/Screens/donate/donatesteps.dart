import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../Providers/user.dart';
import '../../language/language.dart';
import '../CustomAlert/const.dart';



class DonateStepsScreen extends StatefulWidget {
  int step;
DonateStepsScreen(this.step);
  @override
  _RegularDaberneScreenState createState() => _RegularDaberneScreenState();
}

class _RegularDaberneScreenState extends State<DonateStepsScreen> {
  bool reg;
  bool dab;

  @override
  void initState() {
    super.initState();
    reg = false;
    dab = false;
    //  data();
  }
data(){
  final authProvider = Provider.of<UserProvider>(context, listen: false);

  title=[];
   desc=[];
}

  bool loading = true;
  List<String> title=[];
  List<String> desc=[];

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<UserProvider>(context, listen: true);

    final orderProvider =
        Provider.of<OrderCaterProvider>(context, listen: true);
    final addresProvider = Provider.of<AdressProvider>(context, listen: true);
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 10.0,
                offset: const Offset(0.0, 0.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
               " title",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              Text(
                "description",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child:ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                        ),
                        onPressed: () {

                         // Navigator.pop(context,true);


                        },
                        child: Text("Yes")),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                        ),
                        onPressed: () {

                       //   Navigator.pop(context,true);


                        },
                        child: Text("No")),
                  ),
                ],
              )
            ],
          ),
        ),
        // Positioned(
        //   left: Consts.padding,
        //   right: Consts.padding,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.green,
        //     radius: Consts.avatarRadius,
        //     child: Text(
        //       "FAISAL",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
