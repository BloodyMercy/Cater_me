import 'package:CaterMe/Providers/order.dart';

import 'package:CaterMe/Screens/orders/mainOrderId.dart';


import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class YourOrders extends StatefulWidget {
  const YourOrders({Key? key}) : super(key: key);

  @override
  _YourOrdersState createState() => _YourOrdersState();
}

class _YourOrdersState extends State<YourOrders>  {
  bool loading = true;
 Future  getData() async{
    final orders = Provider.of<OrderProvider>(context, listen: false);
    await orders.getAllOrders();


    setState(() {
      loading=false;
    });
return;
  }

  Future refreshOrderData() async {
    final orders = Provider.of<OrderProvider>(context, listen: false);

    await orders.clearData();
    await orders.getAllOrders();
    return;
  }

  @override
  void initState() {

    super.initState();    getData();
  }


  @override
  Widget build(BuildContext context) {
    final orders=Provider.of<OrderProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(

        body: RefreshIndicator(
          onRefresh: refreshOrderData,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:Container(
              child:  loading?Center(child: CircularProgressIndicator(),):
               Container(
                  child:
                  orders.listOrder.length==0?Center(child: Text("No orders yet",style: TextStyle(fontWeight: FontWeight.bold),)) :
                    ListView.builder(itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>OrderId(orders.listOrder[index].id!,0)));
                      },
                      child: Card(child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(orders.listOrder[index].eventName,style: TextStyle(color: Colors.black)),
                                Text(orders.listOrder[index].orderStatus)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text("${orders.listOrder[index].eventDate}"),
                            SizedBox(height: 10,),
                            Text("Address: ${orders.listOrder[index].addressTitle}")
                          ],
                        ),
                      )),
                    );

                  },itemCount: orders.listOrder.length,
                  ))
            ),
          ),
        ),
      ),
    );
  }
}
