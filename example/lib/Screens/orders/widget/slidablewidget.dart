import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../Providers/order.dart';


class SlidableWidget extends StatelessWidget {
   Widget child;
   // CustomerType clientdata;
   int index;
  SlidableWidget({

     this.child,
    // required this.clientdata,
    this.index,
  }) ;

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context, listen: true);

    // UserProvider _user=Provider.of<UserProvider>(context,listen: true);
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      child: child,
      secondaryActions: <Widget>[

        IconSlideAction(
          caption: "Delete",
          color: const Color.fromRGBO(159, 172, 189, 1),
          iconWidget: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 20.0,
          ),
          onTap: () {
            orders.deleteorder(index);
             // changescreenuntill(context, HomeViewProfession(1));
          },
        )
      ],
    );
  }
}
