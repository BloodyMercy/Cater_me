import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Screens/CustomAlert/alert.dart';
import 'package:CaterMe/Screens/chooseadress/confirm_location_view.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/model/address/address.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Providers/user.dart';
import '../../language/language.dart';

class AddressesListSettings extends StatefulWidget {
  final List<Address> address;


  AddressesListSettings(this.address);

  @override
  State<AddressesListSettings> createState() => _AddressesListSettingsState();
}

class _AddressesListSettingsState extends State<AddressesListSettings> {
  int _value = -1;

String language;

getdata()async{
  SharedPreferences sh = await SharedPreferences.getInstance();
  setState(() {
    language = sh.getString('locale');
  });

}

@override
  void initState() {
getdata();
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true);
    final orderprovider =
    Provider.of<OrderCaterProvider>(context, listen: true);
    final address=Provider.of<AdressProvider>(context,listen: true);
    var _mediaQueryWidth = MediaQuery.of(context).size.width;
    var _mediaQuery = MediaQuery.of(context).size.height;

    return Container(

      height: _mediaQuery * 0.87,
      child: widget.address.isEmpty
          ? Center(
          child: Container(
            child: language=="en"?Image.asset('images/NoAdresses.png'):Image.asset('images/no address yetعربي/no addresses yetبالعربي-04.png')
          ))
          : ListView.builder(
          itemCount: widget.address.length,
          itemBuilder: (ctx, index) {
            return Container(
              child: Card(
                color:LightColors.kLightYellow2,
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: _mediaQuery * 0.03,
                      horizontal: _mediaQuery * 0.01),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on ,color: Color(0xFF3F5521),),
                      Column(children: [

                      ],),
                      SizedBox(

                        width: _mediaQueryWidth*0.01,

                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                     widget.address[index].title.toString(),
                                    style: const TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.normal,
                                    
                                    ),
                                  ),

                                  Text(
                                    widget.address[index].city.toString(),
                                    style: const TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.normal
                                    ),
                                  ),

                                  Text(
                                    "${widget.address[index].street.toString()}",
                                    style: const TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.normal),
                                  ),


                                  Text(
                                    "${widget.address[index].buildingName.toString()}",
                                    style: const TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.normal),
                                  ),


                                  Text(
                                     "${widget.address[index].floorNumber.toString()}",
                                     style: const TextStyle(
                                         fontSize: 15, fontWeight: FontWeight.normal),
                                   ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(onPressed: (){
                                  address.valueIndex=index;
                                  address.isUpdate=true;

                                  // address.createOrUpdate=1;
                                  address.id=widget.address[index].id;
                                  address.addresstitlecontroller.text=widget.address[index].title;
                                  address.citycontrollerstring.text=widget.address[index].city;
                                  // address.countrycontrollerstring.text=;
                                  address.streetcontroller.text=widget.address[index].street;
                                  address.buildingcontroller.text=widget.address[index].buildingName;
                                  address.floornumbercontroller.text=widget.address[index].floorNumber.toString();
                                  address.latitudenumbercontroller.text=widget.address[index].latitude;
                                  address.longtituenumbercontroller.text=widget.address[index].longitude;
                                  // widget.address[index].

                                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ConfirmLocation() ));


                                }, icon: Icon(FontAwesomeIcons.solidEdit,color: Color(0xFF3F5521),size: 20)),
                                IconButton(
                                    onPressed: () {
                                     showDialog(context: context, builder: (BuildContext context)=>
                                         Dialog(
                                             backgroundColor: Colors.black,
                                             shape: RoundedRectangleBorder(
                                                 borderRadius: BorderRadius.circular(20.0)),
                                             child: Stack(
                                               overflow: Overflow.visible,
                                               alignment: Alignment.topCenter,
                                               children: [
                                                 Container(
                                                   height: MediaQuery.of(context).size.height *
                                                       0.30,
                                                   child: Padding(
                                                     padding: EdgeInsets.only(
                                                         top: MediaQuery.of(context)
                                                             .size
                                                             .height *
                                                             0.09,
                                                         left: MediaQuery.of(context)
                                                             .size
                                                             .width *
                                                             0.05,
                                                         right: MediaQuery.of(context)
                                                             .size
                                                             .width *
                                                             0.05),
                                                     child: Column(
                                                       children: [
                                                         Text(
                                                           '${user.lg[user.language]["Do you want to delete this address"]}',
                                                           style: TextStyle(
                                                               fontWeight: FontWeight.bold,
                                                               fontSize: 20,
                                                               color: Colors.white),
                                                           textAlign: TextAlign.center,
                                                         ),
                                                         Padding(
                                                           padding: EdgeInsets.only(
                                                               top: MediaQuery.of(context)
                                                                   .size
                                                                   .height *
                                                                   0.02),
                                                           child: Divider(
                                                             color: Colors.white,
                                                           ),
                                                         ),
                                                         Padding(
                                                           padding: EdgeInsets.only(
                                                               top: MediaQuery.of(context)
                                                                   .size
                                                                   .height *
                                                                   0.01),
                                                           child: Row(
                                                             mainAxisAlignment:
                                                             MainAxisAlignment
                                                                 .spaceBetween,
                                                             children: [
                                                               Padding(
                                                                 padding: EdgeInsets.symmetric(
                                                                     horizontal:
                                                                     MediaQuery.of(context)
                                                                         .size
                                                                         .width *
                                                                         0.05),
                                                                 child: TextButton(
                                                                   child: Text(
                                                                     '${user.lg[user.language]["Yes"]}',
                                                                     style: TextStyle(
                                                                         color: Colors.white),
                                                                   ),
                                                                   onPressed:()async{
                                      showDialog(
                                      context: this.context,
                                      barrierDismissible: false,
                                      builder: (BuildContext contexts) {

                                      return WillPopScope(
                                      // onWillPop: () => Future<bool>.value(false),
                                      child: AlertDialog(
                                      title: Text("${user.lg[user.language]["Loading"]}",style: TextStyle(color: colorCustom),),
                                      content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[CircularProgressIndicator(color: colorCustom,)]),
                                      ));
                                      },
                                      );
                                      var delete= await  address.deleteAddress(widget.address[index].id);
                                      if(delete=="deleted"){
                                      widget.address.remove(widget.address[index]);
                                      Navigator.pop(context);
                                      Navigator.of(context).pop();
                                      // Timer(
                                      //   Duration(
                                      //     seconds: 3,
                                      //   ),
                                      //  () {
                                      /// start the intro
                                      MotionToast.success(
                                      title:  "Cater me",
                                      titleStyle:  TextStyle(fontWeight:  FontWeight.bold),
                                      description:  "${user.lg[user.language]["Address Deleted"]}"
                                      //  animationType: ANIMATION.FROM_LEFT,
                                      ).show(context);
                                      //  },
                                      // );
                                      }else{
                                      Navigator.pop(context);
                                      Navigator.of(context).pop();
                                      MotionToast.error(
                                      title:  "Cater me",
                                      titleStyle:  TextStyle(fontWeight:  FontWeight.bold),
                                      description:  "${user.lg[user.language]["Address cannot be Deleted"]}"
                                      //  animationType: ANIMATION.FROM_LEFT,
                                      ).show(context);

                                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      //   content: Text("${authProvider.lg[user.language]["Address cannot be Deleted"]}"
                                      //       ),
                                      // ));
                                      }

                                                                   },
                                                                 ),
                                                               ),
                                                               Divider(
                                                                 color: Colors.white,
                                                               ),
                                                               TextButton(
                                                                 child: Text(
                                                                   '${user.lg[user.language]["No"]}',
                                                                   style: TextStyle(
                                                                       color: Colors.white),
                                                                 ),
                                                                 onPressed: () {
                                                                   Navigator.of(context).pop();
                                                                 },
                                                               ),
                                                             ],
                                                           ),
                                                         )
                                                       ],
                                                     ),
                                                   ),
                                                 ),
                                                 Positioned(
                                                     top: -MediaQuery.of(context).size.height *
                                                         0.06,
                                                     child: Image.asset(
                                                       'images/Logoicon.png',
                                                       height: 100,
                                                     )),
                                               ],
                                             )),

                                     )  ;
                                    }, icon:Icon(FontAwesomeIcons.trash,color: redColor,size: 20,) ),

                              ],
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
