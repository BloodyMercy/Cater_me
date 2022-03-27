import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/widgets/Cuisins/cuisins_card.dart';
import 'package:CaterMe/widgets/addOns/add_on_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Providers/user.dart';
import '../../../language/language.dart';

class AddonsCardoffer extends StatefulWidget {
  int id;

  AddonsCardoffer(this.id);

  @override
  State<AddonsCardoffer> createState() => _AddonsCuisinCardofferState();
}

class _AddonsCuisinCardofferState extends State<AddonsCardoffer> {
  int activeIndex;
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

    final _cuisin = Provider.of<PackagesProvider>(context, listen: false);
    final orderprov = Provider.of<OrderCaterProvider>(context, listen: false);
    final address = Provider.of<AdressProvider>(context, listen: false);
    SharedPreferences sh=await SharedPreferences.getInstance();
    // await package.getcuisinsbyid(widget.id);
    if (_cuisin.addonsallorder.length > 0) {
      await _cuisin.getonidorder(
          _cuisin.addonsallorder[0].id, orderprov.serviceId,int.parse(address.numberofguestcontroller.text.toString()), false,sh.getString("locale"));
    }
    setState(() {
      loadingitems = false;
    });

  }

  bool loadingitems = true;

  // bool loading = true;
  // final List<PageViewModel> pages = [
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final _cuisin = Provider.of<PackagesProvider>(context, listen: true);

    final orderprov = Provider.of<OrderCaterProvider>(context, listen: false);

    final mediaQuery = MediaQuery.of(context);
    Widget buildCards(CuisinsCard card, int index) => Container(
          width: mediaQuery.size.width*0.1,
          height: mediaQuery.size.height*0.1,
          child: card,
        );
    // List card = getCuisins(_cuisinprovider.cuisinsbyid);
    return SingleChildScrollView(
        child: Column(children: [
      _cuisin.addonsallorder.length != 0
          ? Container(
              color: LightColors.kLightYellow,
              height: 50,
              width: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _cuisin.addonsallorder.length,
                itemBuilder: (context, index) {
                  //  final cards = card[i];
                  return Container(
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          loadingitems = true;
                          selected = index;
                        });
                        SharedPreferences sh=await SharedPreferences.getInstance();
                        await _cuisin.getonidorder(_cuisin.addonsallorder[index].id,
                            orderprov.serviceId, 0,false,sh.getString("locale"));
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
                          color: LightColors.kLightYellow2,
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            width: mediaQuery.size.height * 0.30,
                            height: mediaQuery.size.height / 8,
                            child: FittedBox(
                              child: Text(
                                '${_cuisin.addonsallorder[index].name}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BerlinSansFB',
                                ),
                              ),
                              fit: BoxFit.scaleDown,
                            ),
                          )),
                    ),
                  );
                },
              ))
          : Center(child: Text('${authProvider.lg[authProvider.language]["No Cuisines To Dispaly"]}'
         )),
      !loadingitems
          ? Container(
              height: mediaQuery.size.height * 0.6,
              //ß  width:300,

              child: GridView(
                padding: const EdgeInsets.all(25),
                children: getAddOnOrder(_cuisin.allonsorder),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2.5 / 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 5,
                ),
              ))
          : Center(
              child: CircularProgressIndicator(
                color: Color(0xFF3F5521),
              ),
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
