import 'package:CaterMe/model/packages.dart';
import 'package:CaterMe/widgets/Packages/test_package_add_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/user.dart';
import '../../language/language.dart';

class AddOnCards extends StatelessWidget {
  Package addOn;

  AddOnCards(this.addOn);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    var mediaQuery = MediaQuery.of(context);
    return Center(
        child: InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => packageAdsDetailTest(addOn)));
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
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: CachedNetworkImage(
                    height: 100,
                    width: 200,
                  placeholder: (context, url) =>
                   CircularProgressIndicator(),
                    imageUrl: this.addOn.image


                ),
                // child: Image.network(
                //   this.addOn.image,
                //   height: 100,
                //   width: 200,
                //   loadingBuilder: ((context, child, loadingProgress) {
                //     if (loadingProgress == null) return child;
                //     return Center(
                //       child: CircularProgressIndicator(
                //         strokeWidth: 1,
                //         value: loadingProgress.expectedTotalBytes != null
                //             ? loadingProgress.cumulativeBytesLoaded /
                //                 loadingProgress.expectedTotalBytes
                //             : null,
                //       ),
                //     );
                //   }),
                //
                // ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Text(
                    '${this.addOn.title}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
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
                        "${LanguageTr.lg[authProvider.language]["SAR"]} ${this.addOn.price}",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
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
