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
  List<bool> _isChecked = List<bool>.filled(15, false);

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(15, false);
  }
  Future<bool> _onWillPop() async {
    //UserProvider _user=Provider.of<UserProvider>(context,listen:true);

    return (await showDialog(
        context: context,
        builder: (context) => setupAlertDialoadContainer(context))) ??
        false;
  }
  Widget setupAlertDialoadContainer(context) {
    // final details=Provider.of<OrderCaterProvider>(context,listen: true);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.white,
            height: 400.0, // Change as per your requirement
            width: 400.0, // Change as per your requirement
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  activeColor: Theme.of(context).primaryColor,
                  value: _isChecked[index],
                  onChanged: (val) {
                    setState(() {
                      setState(() {
                        _isChecked[index] = val!;
                      });
                    });
                  },
                  title: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              child: ClipRRect(
                                child: Image.network(
                                    'https://static.wikia.nocookie.net/youtube/images/9/9c/Hecker.jpg/revision/latest/top-crop/width/360/height/360?cb=20211024200708'),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            Text('List Item $index'),
                          ],
                        ),
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  bool isSearch = false;
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
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
                  Padding(
                    padding: const EdgeInsets.only(right: 23.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('*(VAT included 15.0%: ${details.tax} SAR)',style: TextStyle(fontWeight: FontWeight.bold,),),
                        ElevatedButton(
                          onPressed: () {
                            // return  await showDialog(
                            //   context: context,
                            //   builder: (context) =>
                            //       setupAlertDialoadContainer()
                            // );
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: SingleChildScrollView(
                                      child: Container(
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: Theme.of(context).primaryColor,
                                                    ),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(
                                                        Icons.check,
                                                        color: Theme.of(context).primaryColor,
                                                      ))
                                                ],
                                              ),
                                              Text(
                                                'Choose the friends you want to share the order with.',
                                                style: TextStyle(
                                                    color: Theme.of(context).primaryColor,
                                                    fontFamily: 'BerlinSansFB'),
                                              ),
                                              SizedBox(
                                                height: mediaQuery.size.height * 0.02,
                                              ),
                                              SizedBox(
                                                height: mediaQuery.size.height * 0.06,
                                                child: TextField(
                                                  autofocus: false,
                                                  onTap: () {
                                                    setState(() {
                                                      isSearch = true;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                            color: Color.fromRGBO(
                                                                232, 232, 232, 1)),
                                                        borderRadius:
                                                        BorderRadius.circular(10)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Theme.of(context)
                                                                .primaryColor)),
                                                    filled: true,
                                                    fillColor: const Color.fromRGBO(
                                                        232, 232, 232, 1),
                                                    hintText: 'Search',
                                                    prefixIcon: const Icon(Icons.search),
                                                    prefixIconColor: Colors.black,
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey[850],
                                                        fontSize: 16,
                                                        fontFamily: 'BerlinSansFB'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                    content: setupAlertDialoadContainer(context),
                                  );
                                });
                          },
                          child: const Text(
                            "Share Bill",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'BerlinSansFB'),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: (mediaQuery.size.width * 0.030),
                              vertical: (mediaQuery.size.height * 0.01),
                            ),
                            primary: Theme.of(context).primaryColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
