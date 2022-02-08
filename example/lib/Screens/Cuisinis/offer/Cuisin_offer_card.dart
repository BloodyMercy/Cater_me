import 'package:CaterMe/Providers/cuisines.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/widgets/Cuisins/cuisins_card.dart';
import 'package:CaterMe/widgets/Cuisins/cuisins_list.dart';
import 'package:CaterMe/widgets/addOns/add_on_list.dart';

import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../../addOns.dart';

class CuisinCardoffer extends StatefulWidget {
  int id;

  CuisinCardoffer(this.id);

  @override
  State<CuisinCardoffer> createState() => _CuisinCardofferState();
}

class _CuisinCardofferState extends State<CuisinCardoffer> {
  late int activeIndex;

  int selected = 0;

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

  getalldata() async {
    final package = Provider.of<CuisineProvider>(context, listen: false);
    final _cuisin = Provider.of<PackagesProvider>(context, listen: false);
    final orderprov = Provider.of<OrderCaterProvider>(context, listen: false);
    await package.getcuisinsbyid(widget.id);
    if (package.cuisinsbyid.length > 0) {
      await _cuisin.getonidorder(
          package.cuisinsbyid[0].id, orderprov.serviceId, true);
    }
    setState(() {
      loadingitems = false;
    });
  }

  bool loadingitems = true;
  bool loading = true;


  // final List<PageViewModel> pages = [
  @override
  Widget build(BuildContext context) {
    final _cuisin = Provider.of<PackagesProvider>(context, listen: true);
    final _cuisinprovider = Provider.of<CuisineProvider>(context, listen: true);
    final orderprov = Provider.of<OrderCaterProvider>(context, listen: true);

    final mediaQuery = MediaQuery.of(context);
    Widget buildCards(CuisinsCard card, int index) => Container(
          //  width: 20,
          // height: 20,

          child: card,
        );
    // List card = getCuisins(_cuisinprovider.cuisinsbyid);
    return SingleChildScrollView(
        child: Column(children: [
      _cuisinprovider.cuisinsbyid.length != 0
          ? Container(
              height: 50,
              width: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _cuisinprovider.cuisinsbyid.length,
                itemBuilder: (context, index) {
                  //  final cards = card[i];
                  return Container(
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          loadingitems = true;
                          selected = index;
                        });
                        await _cuisin.getonidorder(
                            _cuisinprovider.cuisinsbyid[index].id,
                            orderprov.serviceId,
                            true);
                        setState(() {
                          loadingitems = false;
                        });
                        //
                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(
                        //     builder: (context) => AddOns(cuisin.id),
                        //   ),
                        // );
                      },
                      child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: (index == selected)
                                    ? Color.fromRGBO(253, 202, 29, 0.8)
                                    : Color(0xFF3F5521),
                                border: Border.all(style: BorderStyle.none),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                    opacity: 0.5,
                                    image: NetworkImage(
                                      _cuisinprovider.cuisinsbyid[index].image,
                                    ),
                                    fit: BoxFit.fill)),
                            width: mediaQuery.size.height * 0.15,
                            height: mediaQuery.size.height / 8,
                            child: Center(
                              child: Text(
                                '${_cuisinprovider.cuisinsbyid[index].name}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'BerlinSansFB'),
                              ),
                            ),
                          )),
                    ),
                  );
                },
              ))
          : Center(child: Text("No Cuisines To Dispaly")),
      !loadingitems
          ? Container(
              height: 500,
              //ß  width:300,

              child: GridView(
                padding: const EdgeInsets.all(25),
                children: getAddOnOrder(_cuisin.allonsorder),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2.9 / 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 5,
                ),
              ))
          : Center(
              child: CircularProgressIndicator(),
            )
    ]));

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
