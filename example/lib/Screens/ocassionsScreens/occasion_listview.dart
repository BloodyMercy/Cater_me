import 'package:CaterMe/Providers/occasion.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/model/occasions/occasiontype.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../add_new_occasion.dart';
import '../edit_occasion.dart';

class OccasionListView extends StatefulWidget {
  @override
  State<OccasionListView> createState() => _OccasionListViewState();
}

class _OccasionListViewState extends State<OccasionListView> {
  bool loading = false;

  getData() async {
    final occasion = Provider.of<PackagesProvider>(context, listen: false);
    await occasion.getalloccasions();
    final occa = Provider.of<OccasionProvider>(context, listen: false);
    await occa.getAllOccasionType();

    occa.listoccasiontype.insert(0,OccassionType(id: -700,name: "Add occation",image: ''));

  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  Future refreshocasionData() async {
    final occasion = Provider.of<PackagesProvider>(context, listen: false);
    final occa = Provider.of<OccasionProvider>(context, listen: false);

    occa.all.clear();
    occa.listoccasiontype.clear();

    await occa.getallnewoccasion();
    occa.listoccasiontype.insert(0,OccassionType(id: -700,name: "Add occation",image: ''));
    return;
  }

  @override
  Widget build(BuildContext context) {
    final occasion = Provider.of<PackagesProvider>(context, listen: true);
    final occa = Provider.of<OccasionProvider>(context, listen: true);
    var _mediaQuery = MediaQuery
        .of(context)
        .size
        .height;
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child:  RefreshIndicator(
    onRefresh: refreshocasionData,
    child: CustomScrollView(
    slivers: [
    SliverAppBar(
    pinned: false,
    floating: false,
    expandedHeight: MediaQuery.of(context).size.height * 0.2,
    backgroundColor: Colors.transparent,
    flexibleSpace: FlexibleSpaceBar(
    background: SizedBox(
    height: MediaQuery.of(context).size.height * 0.01,
    width: double.maxFinite,
    child: Container(
    height: MediaQuery.of(context).size.height * 0.1,
    child: ListView(
    scrollDirection: Axis.horizontal,
    children:
      List.generate(occa.listoccasiontype.length, (int index) {

        return    GestureDetector(
          onTap: (){

            if(occa.listoccasiontype[index].id==-700) {
              Navigator.of(context).push(

                MaterialPageRoute(
                  builder: (context) =>
                   AddNewOccasion(0),
                ),
              );
            }else{
              Navigator.of(context).push(

                MaterialPageRoute(
                  builder: (context) =>
                      AddNewOccasion(index),
                ),
              );
            }
            },
          child: Card(
            child: Container(
             // width: ,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      occa.listoccasiontype[index].id==-700?
                      Icon(Icons.add,size: 40,color: colorCustom,):Image.network(occa.listoccasiontype[index].image,width: MediaQuery.of(context).size.width*0.3,),
                      Text(occa.listoccasiontype[index].name)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ); } ),
    ),
    ),
  ),
  ),
  ),

         SliverList(

             delegate: SliverChildBuilderDelegate(

                 (context ,int index ){
                   return GestureDetector(
                     onTap: (){

                       Navigator.of(context).push(
                         MaterialPageRoute(
                           builder: (context) =>
                            EditOccasion(occa.all[index]),
                         ),
                       );


                     },
                     child: Container(
                       child: Card(
                         elevation: 3,
                         shape: const RoundedRectangleBorder(
                           borderRadius: BorderRadius.all(
                             Radius.circular(20),
                           ),
                         ),
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             SizedBox(
                               height: mediaQuery.size.height * 0.17,
                               width: mediaQuery.size.width * 0.25,
                               child: Container(

                                 height: mediaQuery.size.height * 0.17,
                                 width: mediaQuery.size.width * 0.25,
                                 color:Color.fromRGBO(63, 85, 33, 1),


                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Text(
                                       '${DateFormat.MMM().format(DateTime.parse(occa.all[index].date))}',
                                       style: const TextStyle(
                                           color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                                     ),
                                     Text(
                                         '${DateFormat.d().format(DateTime.parse(occa.all[index].date))}',
                                         style: const TextStyle(
                                             color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold))
                                   ],
                                 ),
                               ),
                             ),
                             // SizedBox(
                             //   width: mediaQuery.size.width * 0.1,),
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text(
                                     '${occa.all[index].name}',
                                     style: Theme.of(context).textTheme.headline2,
                                   ),
                                   SizedBox(height: 65,),
                                   Text(
                                     '${occa.all[index].type}',
                                     style: Theme.of(context).textTheme.headline2,
                                   ),
                                   SizedBox(height: 20,),
                                   Text(
                                     'edit',
                                   //  locale: ,
                                     style: Theme.of(context).textTheme.overline,
                                   ),
                                 ],
                               ),
                             ),
                             SizedBox(width:MediaQuery.of(context).size.width/5.8 ,),

                                 Expanded(child: Image.network(occa.all[index].image, width: MediaQuery.of(context).size.width/5.5,)),
                             //  ],
                           //  )
                           ],
                         ),
                       ),
                     ),
                   );
                 },


               childCount: occa.all.length ,))



  ],
  ),
  ),

  );
}}
