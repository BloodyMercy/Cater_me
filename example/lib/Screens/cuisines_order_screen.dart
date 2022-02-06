import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:CaterMe/Providers/cuisines.dart';

import 'package:CaterMe/model/cuisins.dart';
import 'package:CaterMe/widgets/Cuisins/cuisin_fake.dart';

import 'package:CaterMe/widgets/addOns/add_on_list.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';






class CuisinesOrderScreen extends StatefulWidget {
  int id;


  CuisinesOrderScreen(this.id);

  @override
  State<CuisinesOrderScreen> createState() => _CuisinesOrderScreenState();
}

class _CuisinesOrderScreenState extends State<CuisinesOrderScreen> {

  @override
  void initState() {
    // TODO: implement initState
    getalldata();
  }

  getalldata() async{
    final package=Provider.of<CuisineProvider>(context,listen: false);

    await package.getcuisinsbyid(widget.id);
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
    return
        RefreshIndicator(
          onRefresh: refreshdata,

          child:SingleChildScrollView(

            physics: AlwaysScrollableScrollPhysics(),
            child: Column(

              children: [
               
                package.cuisinsbyid.length>0?     SizedBox(
                  height: mediaQuery.size.height * 0.71,
                  child: GridView(
                    padding: const EdgeInsets.all(25),
                    children: getCuisinsCards(package.cuisinsbyid),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 5,
                    ),
                  ),
                ):Center(child:Text("no cuisins")),
              ],
            ),
            // ),

        ));
  }
}
