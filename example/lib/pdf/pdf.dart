import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:provider/provider.dart';

import '../Providers/orderById_provider.dart';

void main() {
  runApp(
      MaterialApp(
          home: MyPdf()
      )
  );
}

class MyPdf extends StatefulWidget{
  @override
  State<MyPdf> createState() => _MyPdfState();
}

class _MyPdfState extends State<MyPdf> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderByIdProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
            title:Text("PDF Invoice"), //appbar title
            actions:[ IconButton(icon: Icon(Icons.share,color: Colors.white,),
            onPressed: (){},),],
            backgroundColor: colorCustom //appbar background color
        ),
        body: Container(
            child: PDF().cachedFromUrl(

             orders.pdfLink,
               // maxAgeCacheObject:Duration(days: 30), //duration of cache
              placeholder: (progress) => Center(child: Text('$progress %')),
               errorWidget: (error) => Center(child: Text("hello")),
             )
        )
    );

  }

}