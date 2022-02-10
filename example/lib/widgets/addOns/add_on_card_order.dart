import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/Cuisinis/offer/orderdetails.dart';
import 'package:CaterMe/model/add_on.dart';
import 'package:CaterMe/widgets/Packages/order_add_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddOnCardOrder extends StatelessWidget {
  AddOn addOn;

  AddOnCardOrder(this.addOn);

  Widget setupAlertDialoadContainer(context, AddOn pack) {
    return OrderAdscuisDetail(
      addOn,
    );
  }

  @override
  Widget build(BuildContext context) {
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
              height: mediaQuery.size.height * 0.25,

              child: Column(
                children: [
                  Image.network(
                    this.addOn.image,
                    height: 100,
                    width: 100,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: (mediaQuery.size.width * 0.035)),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${this.addOn.title}',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Row(
                              children: [
                                Text(
                                  '\$${this.addOn.price}',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                //   IconButton(onPressed: (){}, icon: Icon(Icons.add_circle, color: Theme.of(context).primaryColor,))
                              ],
                            )
                          ],
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
