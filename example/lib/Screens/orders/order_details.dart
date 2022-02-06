
import 'package:CaterMe/Providers/orderById_provider.dart';
import 'package:CaterMe/Providers/orderStatus_provider.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsOrder extends StatefulWidget {
  int id;

  DetailsOrder(this.id);


  @override
  _DetailsOrderState createState() => _DetailsOrderState();
}

class _DetailsOrderState extends State<DetailsOrder> {
  double Price=0.0;
  double finaltax=0.0;
  double finalPrice=0.0;

  bool loading = true;
  getData() async{
    final orders = Provider.of<OrderByIdProvider>(context, listen: false);
    await orders.getOrderById(widget.id);

    setState(() {
      loading = false;
    });
    orders.orderList.forEach((element) {
      Price+=element.finalPrice;
    });

  }
  Future refreshOrderData() async {
    final orders = Provider.of<OrderByIdProvider>(context, listen: false);

    await orders.clearData();
    await orders.getOrderById(widget.id);
    orders.orderList.forEach((element) {
      Price+=element.finalPrice;
    });
    return;
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
@override
  void dispose() {
   Price=0.0;
   finaltax=0.0;
   finalPrice=0.0;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final order=Provider.of<OrderByIdProvider>(context, listen: true);


    finalPrice=Price+finaltax;
    return Scaffold(

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refreshOrderData,
          child: Column(
            children: [
              loading?Center(child: CircularProgressIndicator()):Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("This id is:${widget.id}"),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),

                      child: Column(

                        children: [
                          ListView.builder(

                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context,index){
                            return  Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${order.orderList[index].item} x ${order.orderList[index].quantity}"),
                                    Text("\$ ${order.orderList[index].finalPrice}"),

                                  ],
                                ),
                                const SizedBox(height: 10,)
                              ],
                            );
                          },
                          itemCount: order.orderList.length,
                          ),
                          const SizedBox(height: 10,),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Final Price"),
                              Text("\$ ${finalPrice}"),
                            ],
                          ),

                        ],
                      ),
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
