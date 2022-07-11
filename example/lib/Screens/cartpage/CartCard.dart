
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/order_provider.dart';
import '../../Providers/user.dart';
import '../../model/ItemsOrder.dart';



class CartCard extends StatefulWidget {
  const CartCard({
  this.card,
  this.index,
  }) ;
  final ItemOrders card;
  final int index;

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {

  int _itemCount = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _itemCount=widget.card.quantity;
    });
  }
  @override
  Widget build(BuildContext context) {

    final details = Provider.of<OrderCaterProvider>(context, listen: true);
    final _cartP=Provider.of<OrderCaterProvider>(context,listen: false);
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    return ListTile(
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      leading: SizedBox(
        width: 70,
        child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child:  Image.network(
                widget.card.image,
                errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                  return Icon(Icons.do_not_disturb,color:Colors.red);
                },
                loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null ?
                        loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    ),
                  );
                },
                fit: BoxFit.fill,
                width: 100,
                height: 100,
              ),
            )),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  child: Text(
                    widget.card.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Geomanist'),
                  ),
                ),
              ),

              Text(

                "${widget.card.price} ${authProvider.lg[authProvider.language]["SAR"]}",

                style: TextStyle(
                  fontFamily: 'Geomanist',
                  color: Color.fromRGBO(180, 187, 197, 1),
                ),
                maxLines: 1,
              )
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            '${authProvider.lg[authProvider.language]["Total: "]}'+ widget.card.totalprice.toString(),//widget.card.product.size[0],
            style:
            TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          // SizedBox(
          //   height: 3,
          // ),
          // Text(
          //   "Color: " + widget.card.,
          //   style:
          //   TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          // ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text('${authProvider.lg[authProvider.language]["Quantity: "]}'
                ,
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 5,
              ),
             Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 7), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(360),
                  ),
                  height: 25,
                  width: 25,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.black,
                      size: 18,
                    ),
                    onPressed: () {
                      // if(widget.cart.status!="Package"){
                      if(_itemCount>widget.card.min){

                        setState(() {
                          _itemCount=_itemCount-widget.card.increment;
                          widget.card.quantity=_itemCount;
                          //_cartP.modifyquantity(_itemCount, widget.index);
                        } );
                        _cartP.totalssha=_cartP.totalssha-widget.card.increment;
                        _cartP.itemOrders[widget.index]=widget.card;
                        _cartP.modifyItemsmoins(_itemCount, widget.index);

                      }
                    //  _cart.editquantity(_itemCount,widget.index);
                      details.controllers.clear();

                      for(int c=0; c<details.choosebillFriend.length; c++){
                        TextEditingController alpha = TextEditingController();
                        alpha.text=(details.totale/details.choosebillFriend.length).floor().toString();
                        details.addcontroller(alpha);
                        details.updateprocefreind((details.totale/details.choosebillFriend.length).floor().toDouble(), c);

                      }
                    },
                  )),

              const SizedBox(
                width: 15,
              ),
              Text(
                _itemCount.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 7), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(360),
                ),
                height: 25,
                width: 25,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      if(_itemCount<widget.card.max){
                        setState(() {
                          _itemCount=_itemCount+widget.card.increment;
                          widget.card.quantity=_itemCount;

                          //_cartP.modifyquantity(_itemCount, widget.index);
                        } );

                        _cartP.totalssha=_cartP.totalssha+widget.card.increment;

                        _cartP.modifyItems(_itemCount, widget.index);
                      }
                      details.controllers.clear();

                      for(int c=0; c<details.choosebillFriend.length; c++){
                        TextEditingController alpha = TextEditingController();
                        alpha.text=(details.totale/details.choosebillFriend.length).floor().toString();
                        details.addcontroller(alpha);
                        details.updateprocefreind((details.totale/details.choosebillFriend.length).floor().toDouble(), c);

                      }

                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}
