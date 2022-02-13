import 'package:CaterMe/Providers/cuisines.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/widgets/Cuisins/cuisins_card.dart';
import 'package:CaterMe/widgets/Cuisins/cuisins_list.dart';
import 'package:CaterMe/widgets/addOns/add_on_list.dart';

import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../../addOns.dart';

class AddonsCardoffer extends StatefulWidget {
  int id;

  AddonsCardoffer(this.id);

  @override
  State<AddonsCardoffer> createState() => _AddonsCuisinCardofferState();
}

class _AddonsCuisinCardofferState extends State<AddonsCardoffer> {
  int activeIndex;
int selected=0;
  // getData()async{
  //   Packages _cuisin=Provider.of<Packages>(context,listen: false);
  //
  // }
  @override
  void initState() {
    activeIndex = 0;
    super.initState();
    getalldata();
    //  getData();
  }
  getalldata() async{
    final package=Provider.of<CuisineProvider>(context,listen: false);
    final _cuisin = Provider.of<PackagesProvider>(context, listen: false);
    final orderprov = Provider.of<OrderCaterProvider>(context, listen: false);
   // await package.getcuisinsbyid(widget.id);
    if(_cuisin.addonsall.length>0) {

      await _cuisin.getonidorder(_cuisin.addonsall[0].id,orderprov.serviceId,false);
    }
    setState(() {
      loadingitems=false;
    });
  }


  bool loadingitems=true;
  // bool loading = true;
  // final List<PageViewModel> pages = [
  @override
  Widget build(BuildContext context) {
    final _cuisin = Provider.of<PackagesProvider>(context, listen: true);
    final _cuisinprovider = Provider.of<CuisineProvider>(context, listen: true);

    final mediaQuery = MediaQuery.of(context);
    Widget buildCards(CuisinsCard card, int index) => Container(
      //  width: 20,
      // height: 20,

      child: card,
    );
    // List card = getCuisins(_cuisinprovider.cuisinsbyid);
    return



      SingleChildScrollView(

          child:Container(
            color: LightColors.kLightYellow,
            child: Column(children:[
              _cuisin.addonsall.length != 0
                  ? Container(
                color: LightColors.kLightYellow,
                  height:50,
                  width: 400,
                  child:
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _cuisin.addonsall.length,
                    itemBuilder: (context, index) {
                      //  final cards = card[i];
                      return Container(
                        child:
                        GestureDetector(

                          onTap: () async{
                            setState(() {
                              loadingitems=true;
                              selected=index;
                            });
                            await _cuisin.getonid(_cuisin.addonsall[index].id);
                            setState(() {
                              loadingitems=false;
                            });
                            //
                            // Navigator.of(context).pushReplacement(
                            //   MaterialPageRoute(
                            //     builder: (context) => AddOns(cuisin.id),
                            //   ),
                            // );


                          },
                          child: Card(
                            color: LightColors.kLightYellow2,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Container(

                                decoration: BoxDecoration(
                                    color: (index   == selected)
                                        ? Color.fromRGBO(253, 202, 29, 0.8)
                                        :  Color(0xFF3F5521),
                                    border: Border.all(style: BorderStyle.none),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                   ),
                                width: mediaQuery.size.height * 0.15,
                                height: mediaQuery.size.height /8,
                                child: Center(
                                  child: Expanded(
                                    child: Text(
                                      '${_cuisin.addonsall[index].name}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'BerlinSansFB'),
                                    ),
                                  ),
                                ),
                              )),
                        ),







                      );



                    },
                  )): Center(child: Text("No Cuisines To Dispaly")),


              !loadingitems?  Container(
                  height: 500,
                  //ß  width:300,

                  child:  GridView(
                    padding: const EdgeInsets.all(25),
                    children: getAddOnOrder(_cuisin.allons),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 2.9 / 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 5,
                    ),
                  )):Center(child: CircularProgressIndicator(
                color: Color(0xFF3F5521),
              ),)



            ]),
          ));


    // listview.builder(

    //   itemCount: card.length,
    //   itemBuilder: (context, index, reaIndex) {
    //     final cards = card[index];
    //     return buildCards(cards, index);
    //   },
    //   options: CarouselOptions(

    //     height: mediaQuery.size.height * 0.20,
    //     autoPlay: false,
    //     enableInfiniteScroll: false,
    //     autoPlayCurve: Curves.fastOutSlowIn,

    //     viewportFraction: 0.3,
    //   ),
    // )

  }
}
