import 'package:CaterMe/Driver/provider/driverOrder_provider.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDriverDetails extends StatefulWidget {
  final int id;
  OrderDriverDetails(this.id);

  @override
  _OrderDriverDetailsState createState() => _OrderDriverDetailsState();
}

class _OrderDriverDetailsState extends State<OrderDriverDetails> {
  getData()async{
    final orderDriver=Provider.of<DriverOrderProvider>(context,listen: false);
    await orderDriver.getOrderByid(widget.id);
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final orderDriver=Provider.of<DriverOrderProvider>(context,listen: true);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Order Details",style: Theme.of(context).textTheme.headline1,),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            AnimatedOpacity(
              opacity: (orderDriver.loading )? 0 : 1.0,
              duration: Duration(milliseconds: 500),
              child: buildbody(context),
            ),
            AnimatedOpacity(
              opacity: (orderDriver.loading ) ? 1.0 : 0,
              duration: Duration(milliseconds: 500),
              child: buildLoading(context),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildLoading(BuildContext context){
    return Align(
      child: Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
      alignment: Alignment.center,
    );
  }
  Widget buildbody(BuildContext context){
    final screenHeight=MediaQuery.of(context).size.height;
    final orderDriver=Provider.of<DriverOrderProvider>(context,listen: true);
    return SafeArea(child:

      CustomScrollView(slivers: [

        SliverToBoxAdapter(child:
        Padding(padding: const EdgeInsets.all(8),
          child: Container(
            height: screenHeight*0.3,
            child: Card(child: Center(child: Text("Map")),elevation: 5,),
          ),)
          ,),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: Container(
                child: ListView.separated(
                  itemCount: orderDriver.orderItems.length,
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
                              Expanded(
                                child: Text(
                                  "${orderDriver.orderItems[i].item} x ${orderDriver.orderItems[i].quantity}",
                                  style: TextStyle(
                                      color: blackColor,
                                      fontWeight:
                                      FontWeight.normal),
                                ),
                              ),
                              Text(
                                "SAR ${orderDriver.orderItems[i].price}",
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
    );
  }

}
