import 'package:CaterMe/model/add_on.dart';
import 'package:CaterMe/model/packages.dart';
import 'package:CaterMe/widgets/Packages/test_package_add_details.dart';
import 'package:CaterMe/widgets/items_details.dart';
import 'package:flutter/material.dart';

class AddOnCards extends StatelessWidget {
  Package addOn;

  AddOnCards(this.addOn);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Center(
        child: InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => packageAdsDetailTest(addOn)));
      },
      child: Card(

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Container(
          height: mediaQuery.size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            children: [
              Card(

          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),),
                elevation: 4,
                child: Image.network(
                  this.addOn.image,
                  height: 100,
                  width: 200,

                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left:2.0),
                  child: Text(
                    '${this.addOn.title}',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                        fontWeight: FontWeight.normal,
                    //  fontFamily:
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [

                      Text(
                        'SAR ${this.addOn.price}',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
