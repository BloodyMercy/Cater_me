import 'package:CaterMe/Providers/occasion.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/model/friend_model.dart';
import 'package:CaterMe/model/occasion.dart';
import 'package:CaterMe/model/occasions/occasiontype.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../add_new_occasion.dart';

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
      child: Scaffold(
      appBar: AppBar(
      centerTitle: true,
      title: Text(
        'My Occasions',
      ),
      backgroundColor: Theme
          .of(context)
          .primaryColor,

    ),
    body: RefreshIndicator(
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
          onTap: (){ Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
              const AddNewOccasion(),
            ),
          );},
          child: Card(
            child: Container(
             // width: ,
              child: Row(
                children: [
                  Column(
                    children: [
                      occa.listoccasiontype[index].id==-700?
                      IconButton(

                        onPressed: () {

                        },
                        icon: const Icon(Icons.add),
                      ):Image.network(occa.listoccasiontype[index].image,width: MediaQuery.of(context).size.width*0.3,),
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
  ],
  ),
  ),
),
  );
}}
