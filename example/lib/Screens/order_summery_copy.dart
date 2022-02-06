import 'package:CaterMe/Providers/order_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'orders/checkout/carditem.dart';

class OrderSummeryCopy extends StatefulWidget {
  const OrderSummeryCopy({Key? key}) : super(key: key);

  @override
  _OrderSummeryCopyState createState() => _OrderSummeryCopyState();
}

class _OrderSummeryCopyState extends State<OrderSummeryCopy> {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final details = Provider.of<OrderCaterProvider>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Receipt',
                style: TextStyle(color: Colors.red),
              ),
              Text('All prices include VAT'),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 330,
                width: 400,
                child: ListView.builder(
                    itemCount: details.itemOrders.length,
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemBuilder: (ctx, i) {

                      return Column(
                        children: [
                          Padding(
                            padding:   EdgeInsets.symmetric(vertical: 10.0),
                            child:
                           // widget.data[index].status=="Package"?Container( child: CartItemCard(widget.data[index] , index),):
                            Dismissible(
                              key:  UniqueKey(),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                padding:  EdgeInsets.symmetric(horizontal: 20),
                                decoration:  BoxDecoration(
                                  color: Color.fromRGBO(232, 232, 232, 1.0),
                                ),
                                child: Row(
                                  children:  [
                                    Spacer(),
                                    SvgPicture.asset('images/iconphase2/Trash.svg'),
                                //  (image: Icons.delete);
                                  ],
                                ),
                              ),
                              onDismissed: (direction){
                                //setState(() {
                                // _cartP.listcart.removeAt(index);
                               // _cartP.RemoveFromCart(widget.data[index]);

                                //   });
                              },
                              child: CartItemCard(details.itemOrders[i] , i),
                            ),
                          ),
                        ],
                      );



                    }),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("You cant't cancel or edit your order once submitted!"),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Subtotal: ${details.subTotal}',style: TextStyle(fontWeight: FontWeight.bold,),),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Totale: ${details.totale}',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,),),
                  SizedBox(
                    height: 10,
                  ),
                  Text('*(VAT included 15.0%: ${details.tax} SAR)',style: TextStyle(fontWeight: FontWeight.bold,),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
