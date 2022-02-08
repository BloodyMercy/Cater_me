
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/model/ItemsOrder.dart';
import 'package:CaterMe/model/add_on.dart';

import 'package:provider/provider.dart';

import 'package:flutter/material.dart';





class CartItemCard extends StatefulWidget {
  CartItemCard(
      this.cart,
      this.index
      );
ItemOrders cart;
  int index;
  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {


  int _itemCount =0;
  @override
  void initState() {
    _itemCount =widget.cart.quantity;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
final _cartP=Provider.of<OrderCaterProvider>(context,listen: false);


    return Container(
      color:  Color.fromRGBO(232, 232, 232, 1.0),
      height: 160,
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.all(20.0),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: AspectRatio(
                    aspectRatio: 0.88,
                    child: Container(
                      decoration: BoxDecoration(
                        color:  Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.network(
                        widget.cart.image,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Icon(Icons.do_not_disturb,color:Colors.red);
                        },
                        loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null ?
                                loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        fit: BoxFit.fill,

                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cart.title,
                      style:  TextStyle(
                          fontSize: 14,
                          color: Color(0xFF3F5521),
                          fontFamily: 'Ubuntu'),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                   Text(
                     widget.cart.description,
                     style:  TextStyle(
                       fontSize: 10,
                       color: Color(0xFF3F5521),
                       fontFamily: 'Ubuntu',
                     ),),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        _itemCount != 0
                            ? Container(
                            decoration: BoxDecoration(
                              color:  Color.fromRGBO(253, 202, 29, 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 30,
                            width: 30,
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                icon:  Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                onPressed: () async{
                                  setState(() {
                                   // if(widget.cart.status!="Package"){
                                      if(_itemCount>0){

                                        setState(() {
                                          _itemCount--;
                                          widget.cart.quantity=_itemCount;
                                          //_cartP.modifyquantity(_itemCount, widget.index);
                                        } );
                                        _cartP.itemOrders[widget.index]=widget.cart;
                                        _cartP.modifyItemsmoins(_itemCount, widget.index);

                                      }



                                  });}
                            ))
                            : Container(
                            decoration: BoxDecoration(
                              color:  Color.fromRGBO(253, 202, 29, 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 30,
                            width: 30,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon:  Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 18,
                              ),
                              onPressed: () {

                              },
                            )),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          _itemCount.toString() ,
                          style:  TextStyle(
                            color: Color(0xFF3F5521),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 202, 29, 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 30,
                          width: 30,
                          child: IconButton(
                              padding: EdgeInsets.zero,
                              icon:  Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 18,
                              ),
                              onPressed: (){
                               // setState(() {
                                 // if(widget.cart.status!="Package") {
                                   // if(_itemCount <int.parse(widget.cart.)){

                                 setState(() {
    _itemCount++;
    widget.cart.quantity=_itemCount;
    //_cartP.modifyquantity(_itemCount, widget.index);
    } );

    _cartP.modifyItems(_itemCount, widget.index);
                                      //_cartP.modifyquantity(_itemCount, widget.index);
                                   // }
                                }

                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      "Ras ${widget.cart.totalprice}",
                      style:  TextStyle(
                        color: Color(0xFF3F5521),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//////////////