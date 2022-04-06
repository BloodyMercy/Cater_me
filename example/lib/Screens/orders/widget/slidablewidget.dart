import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../Providers/order.dart';
import '../../../Providers/user.dart';


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

    UserProvider authProvider=Provider.of<UserProvider>(context,listen: true);
    return Slidable(

      actionPane: const SlidableDrawerActionPane(),
      child: child,
      secondaryActions: <Widget>[

        IconSlideAction(
          caption:'${authProvider.lg[authProvider.language]["Hide"]}'
          ,foregroundColor: Colors.black,
          color: Color(0xFFFFCDD2),

          iconWidget: const Icon(
            Icons.delete,
            color: Colors.black38,
            size: 20.0,
          ),
          onTap: () async {
    showDialog(
    context: context,
    barrierDismissible:
    false,
    builder: (BuildContext
    context) {
    return WillPopScope(
    onWillPop: () =>
    Future<bool>.value(
    false),
    child:
    AlertDialog(
    title: Text(
    '${authProvider.lg[authProvider.language]["Loading..."]}'),
    content: Column(
    mainAxisSize:
    MainAxisSize.min,
    children: <Widget>[
    const CircularProgressIndicator()
    ]),
    ));


             // changescreenuntill(context, HomeViewProfession(1));
          },
        );
   await orders.deleteorder(index);
       Navigator.pop(context);
          })
      ],
    );
  }
}
