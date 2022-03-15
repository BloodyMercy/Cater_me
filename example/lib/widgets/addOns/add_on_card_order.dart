import 'package:CaterMe/Screens/Cuisinis/offer/orderdetails.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/model/packages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/user.dart';
import '../../language/language.dart';

class AddOnCardOrder extends StatelessWidget {
  Package addOn;

  AddOnCardOrder(this.addOn);

  Widget setupAlertDialoadContainer(context, Package pack) {
    return OrderAdscuisDetail(
      addOn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    // final pack = Provider.of<PackagesProvider>(context, listen: true);
    var mediaQuery = MediaQuery.of(context);
    return Center(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: InkWell(
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
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                      ),
                      content: setupAlertDialoadContainer(context, addOn),
                    );
                  });
            },
            child: Container(
              // width: mediaQuery.size.width*0.8 ,
              height: mediaQuery.size.height * 0.35,

              child: Column(
                children: [
                  Image.network(
                    this.addOn.image,
                    height: 75,
                    width: 75,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: (mediaQuery.size.width * 0.035)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right:8.0),
                                child: Text(
                                  '${this.addOn.title}',
                                  maxLines: 2,
                                  style:  TextStyle(
                                      color: colorCustom,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'BerlinSansFB'),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right:8.0),
                                    child: Text("${LanguageTr.lg[authProvider.language]["SAR"]} ${this.addOn.price}",
                                      style: Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  //   IconButton(onPressed: (){}, icon: Icon(Icons.add_circle, color: Theme.of(context).primaryColor,))
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
