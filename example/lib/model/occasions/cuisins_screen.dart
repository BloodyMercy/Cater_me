import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:CaterMe/Providers/cuisines.dart';

import 'package:CaterMe/model/cuisins.dart';

import 'package:CaterMe/widgets/addOns/add_on_list.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';






class CuisinsScreen extends StatefulWidget {
  int id;


  CuisinsScreen(this.id);

  @override
  State<CuisinsScreen> createState() => _CuisinsScreenState();
}

class _CuisinsScreenState extends State<CuisinsScreen> {

@override
  void initState() {
    // TODO: implement initState
getalldata();
  }
bool loading=true;
  getalldata() async{
    final package=Provider.of<CuisineProvider>(context,listen: false);

    await package.getcuisinsbyid(widget.id);
    setState(() {
      loading=false;
    });
  }
  Future refreshdata() async{
    final package=Provider.of<CuisineProvider>(context,listen: false);
package.clearData();
    await package.getcuisinsbyid(widget.id);
  return;
  }
  @override
  Widget build(BuildContext context) {

      final package=Provider.of<CuisineProvider>(context,listen: true);
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(
              );
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
            iconSize: 30,
          ),
          elevation: 0,

          centerTitle: true,
          title: Text(
            'Shishas',
            style: Theme.of(context).textTheme.headline1,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: //Padding(
            //padding:  EdgeInsets.only(top:mediaQuery.size.height*0.15),
            RefreshIndicator(
              onRefresh: refreshdata,

              child:Center(
                child:loading?Center(child: CircularProgressIndicator(),): package.cuisinsbyid.length>0?
                GridView(
                  padding: const EdgeInsets.all(25),
                  children: getCuisinsCards(package.cuisinsbyid),

                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    childAspectRatio:1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                ):
                Center(child:Text("No Shisha")),
              ),
    )));
  }
}
