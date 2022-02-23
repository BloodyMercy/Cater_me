import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';

class OrderDriverDetails extends StatefulWidget {
  const OrderDriverDetails({Key key}) : super(key: key);

  @override
  _OrderDriverDetailsState createState() => _OrderDriverDetailsState();
}

class _OrderDriverDetailsState extends State<OrderDriverDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Order Details",style: Theme.of(context).textTheme.headline1,),
        centerTitle: true,
      ),
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: Container(
                child: ListView.separated(
                  itemCount: 20,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Text(
                                "Launch  ",
                                style: TextStyle(
                                    color: blackColor,
                                    fontWeight:
                                    FontWeight.normal),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.03,
                              ),
                              Text(
                                "SAR 1000",
                                style: TextStyle(
                                    color: blackColor,
                                    fontWeight:
                                    FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) { return Divider(thickness: 2,); },
                ),
              ),
            ),
          ),
        )
      ],),
    ));
  }
}
