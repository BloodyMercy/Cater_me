import 'package:CaterMe/model/add_on.dart';
import 'package:CaterMe/widgets/items_details.dart';
import 'package:flutter/material.dart';

class AddOnCards extends StatelessWidget {
  AddOn addOn;
  AddOnCards(this.addOn);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Center(
      
      
      
      
      child:InkWell(
        onTap: (){
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AdsitemDetail(addOn)
              ));
        },
        
        child:
      
      
      Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
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
                padding: EdgeInsets.only(left: (mediaQuery.size.width * 0.035)),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${this.addOn.title}',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Text(
                          '\$${this.addOn.price}',
                          style: Theme.of(context).textTheme.headline3,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
