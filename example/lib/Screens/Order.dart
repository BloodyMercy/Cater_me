
import 'package:CaterMe/Payment/OrderSucc.dart';
import 'package:CaterMe/Payment/Payment.dart';
import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/add_on_order_screen.dart';
import 'package:CaterMe/Screens/addresses_screen.dart';
import 'package:CaterMe/Screens/order_summery_1.dart';
import 'package:CaterMe/Screens/order_summery_copy.dart';
import 'package:CaterMe/Screens/regular_daberne_screen.dart';
import 'package:CaterMe/Screens/regular_screen.dart';
import 'package:CaterMe/Screens/related_offers_screen.dart';
import 'package:CaterMe/model/address/address.dart';
import 'package:CaterMe/widgets/Customer_stepper.dart';
import 'package:CaterMe/widgets/Payment/credit_cards_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Addons/orderpages/steps.dart';
import 'AddonsOrder.dart';
import 'Cuisinis/offer/Cuisin_offer_card.dart';
import 'CuisinsOrder.dart';

class Order extends StatefulWidget {

  // int selectedStep;
  // int id;
  //
  // String location ;
  // bool loadin =true;
  // bool offeron ;

 // Order();

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final _controller = new ScrollController();
  var _key = GlobalKey<ScaffoldState>();
///  DatabaseMethods databaseMethods = new DatabaseMethods();

  double barheight=0.0;


  Future<bool> _onWillPop() async {
    //UserProvider _user=Provider.of<UserProvider>(context,listen:true);
final _orderCaterprovider=Provider.of<OrderCaterProvider>(context,listen: true);
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        backgroundColor:Colors.white ,
        title: new Text("Are you sure you want to exit?"),
        content: new Text(
          "",style: const TextStyle(color:Colors.white),),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text("No"),
          ),
          TextButton(
              onPressed: () {
                // ServicePreservationProvider _serpres = Provider.of<ServicePreservationProvider>(context, listen: false);
                // _serpres.cleardata();

                Navigator.of(context).pop();
              } ,
              child: new Text("yes")),

        ],
      ),
    )) ?? false;
  }



  getucustomerdata() async {

  }
  getprofdata()async{

  }
   int steps;
  @override
  initState(){
    super.initState();
    steps = 1;
    getData();
    // getprofdata();
  }
  bool loading=false;
  int total=0;



  bool ispressed = false;
  getData()async{
    final address=Provider.of<AdressProvider>(context,listen: false);
    await address.getRegular();
  }

  clearAlldata() {
    final clearData = Provider.of<AdressProvider>(context, listen: false);
    clearData.clearAllData();

    return;
  }


  @override
  Widget build(BuildContext context) {
    final addresses = Provider.of<AdressProvider>(context, listen: true);
  // final address = Provider.of<OrderCaterProvider>(context, listen: true);
    final details = Provider.of<OrderCaterProvider>(context, listen: true);
    final orderProvider = Provider.of<OrderCaterProvider>(context, listen: true);
    final packageProvider = Provider.of<PackagesProvider>(context, listen: true);

    var screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    final address=Provider.of<AdressProvider>(context,listen: true);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child:WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          key: _key,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.white,
            title: const Text("Order",
              style: const TextStyle(
                  color: Color(0xFF3F5521),
                  fontWeight: FontWeight.bold,
                  fontSize: 25),),
            leading: IconButton(
              icon: const Icon(Icons.close, color: const Color(0xFF3F5521),),
              onPressed: () async {
                return  await showDialog(
                  context: context,
                  builder: (context) => new AlertDialog(
                    backgroundColor:Colors.white ,
                    title: new Text("Are you sure you want to exit?"),
                    content: new Text(
                      "",style: const TextStyle(color:Colors.white),),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: new Text("No"),
                      ),
                      TextButton(
                        onPressed: () {
                          orderProvider.spets = 1;

                          clearAlldata();
                          // ServicePreservationProvider _serpres = Provider.of<ServicePreservationProvider>(context, listen: false);
                          // _serpres.cleardata();
                           Navigator.of(context).pop();
                           Navigator.of(context).pop();
                        } ,
                        child: new Text("yes")),

                    ],
                  ),
                );

              },
            ),
          ),
          body: true?SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              height: height*0.88,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          CustomStepper(
                            controller: _controller,
                            onTap: (int value){




                              if(orderProvider.spets==1) {

                                  if (orderProvider.value.id==0
                                  ) {
                                    _key.currentState
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "please choose an address "),
                                      ),
                                    );

                                  }


                                else{
                                  orderProvider.spets=value;
                                }
                              }
                              if(orderProvider.spets==3) {
                                if (orderProvider.value.id==0) {
                                  _key.currentState
                                      .showSnackBar(
                                    const SnackBar(
                                      content: const Text(
                                          "please choose one from the following offers "),
                                    ),
                                  );
                                  // orderProvider.spets=0;
                                }
                                else{
                                  orderProvider.spets=value;
                                }
                              }
                              if(orderProvider.spets==2){
                                if (address
                                    .eventnamecontroller
                                    .text ==
                                    "" ||
                                    address.evendatecontroller
                                        .text ==
                                        "" ||
                                    address
                                        .numberofguestcontroller
                                        .text ==
                                        "" ||
                                    address
                                        .typeofeventcontroller
                                        .text == "")
                                      {
                                      // orderProvider.spets=0;
                                      // if( orderProvider.serviceId==0){
                                      // _key.currentState
                                      //     .showSnackBar(
                                      const SnackBar(
                                      content: Text(
                                      "please fill the empty fields "),
                                      );
                                      // );
                                      }
                                      else{
                                        orderProvider.spets=value;
                                        setState(() {
                                          //  orderProvider.spets=value;

                                          _controller.animateTo(
                                            0,
                                            duration: const Duration(milliseconds: 500),
                                            curve: Curves.linear,
                                          );
                                        });
                                      }
                                      }




                              if(orderProvider.spets==5){


                                setState(() {

                                  _controller.animateTo(
                                    0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.linear,
                                  );
                                });
                              }else{
                                orderProvider.spets=value;
                              }
                              if(orderProvider.spets==6){


                                setState(() {

                                  _controller.animateTo(
                                    0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.linear,
                                  );
                                });
                              }else{
                                orderProvider.spets=value;
                              }
                              if(orderProvider.spets==7){


                                setState(() {

                                  //orderProvider.spets=value;
                                  _controller.animateTo(
                                    0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.linear,
                                  );
                                });
                              }else{
                                orderProvider.spets=value;
                              }




                            },
                            text: const [
                              "Location",
                              "Event Details",
                              "Service",

                              "Packages",

                              "Add-Ons",
                              "Checkout",
                              "Payment"
                            ],
                            selected:orderProvider.spets,
                          )
                        ],
                      ),
                    ),

                  ),

                  const Divider(
                    height: 20,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                    color: Color(0xFF3F5521),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height/1.55,
                    child:
                    (orderProvider.spets==1)?  AddAddressScreen():
                    (orderProvider.spets==3)? RegularDaberneScreen():
                    (orderProvider.spets==2)? ReguarScreen(addresses.Friends):
                    (orderProvider.spets==4)? RelatedOffersScreen():

                    (orderProvider.spets==5)? AddonsCardoffer(0):
                    (orderProvider.spets==7)?CreditCardsPage():
                    (orderProvider.spets==6)? const OrderSummeryCopy():


                    Container(),
                  ),


                Expanded(

                    child: Container(
                      height: MediaQuery.of(context).size.height/9,
                     // color: Colors.yellow,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total: ${details.totale.toStringAsFixed(3)} SAR", style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'BerlinSansFB',
                              fontWeight: FontWeight.bold),),
                        ElevatedButton(
                            onPressed: () async{
                              if(orderProvider.spets==1) {
                                if (orderProvider.value.id==0
                                   ) {
                                  _key.currentState
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "please choose an address "),
                                    ),
                                  );
                                }
                                else{
                               orderProvider.spets++;
                                }
                              }
                          else    if(orderProvider.spets==3) {
                                if (orderProvider.serviceId==0
                                ) {
                                  _key.currentState
                                      .showSnackBar(
                                    const SnackBar(
                                      content: const Text(
                                          "please choose one from the following offers "),
                                    ),
                                  );
                                }
                                else{
                                 orderProvider.spets++;
                                }
                              }





                     else         if(orderProvider.spets==2) {
                                if (address
                                    .eventnamecontroller
                                    .text ==
                                    "" ||
                                    address.evendatecontroller
                                        .text ==
                                        "" ||
                                    address
                                        .numberofguestcontroller
                                        .text ==
                                        "" ||
                                    address
                                        .typeofeventcontroller
                                        .text == "") {
                                  _key.currentState
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "please fill the empty fields "),
                                    ),
                                  );
                                }
                                else{
                                 await  address.checktime();
                                 if(address.hours.isDaberni)
                                   orderProvider.serviceId=2;
                                  orderProvider.spets++;
                                }
                              }

                     else if(orderProvider.spets==7){
                                showDialog(
                                  context: this.context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return WillPopScope(
                                        onWillPop: () => Future<bool>.value(false),
                                        child: AlertDialog(
                                          title: const Text("Loading..."),
                                          content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[const CircularProgressIndicator()]),
                                        ));
                                  },
                                );


                                final address = Provider.of<AdressProvider>(context, listen: false);

               bool a=     await   orderProvider.makeorder(address.evendatecontroller.text, address.typeofeventcontroller.text, address.numberofguestcontroller.text,  "src_nxrej2zfr4uedj5p5xxuljrl5i");

                    Navigator.of(context).pop();
if(a)
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppointmentSuccess()));
else{
  showDialog(
    context: this.context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("error "),
        content: const Text("try again"),
        actions: <Widget>[TextButton(child: const Text("Close"), onPressed: () => Navigator.pop(context))],
      );
    },
  );
}


                     }

                              else
                                orderProvider.spets++;
                          //    }




                            },
                            child:   orderProvider.spets!=8? const Text(
                           'Next',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'BerlinSansFB',
                                  fontWeight: FontWeight.bold),
                            ):const Text(
                              'Done',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'BerlinSansFB',
                                  fontWeight: FontWeight.bold),
                            ),
                            // style: ElevatedButton.styleFrom(
                            //   padding: EdgeInsets.fromLTRB(
                            //     width * 0.1,
                            //     screenHeight * 0.03,
                            //     width * 0.1,
                            //     screenHeight * 0.03,
                            //   ),
                            //   onPrimary:
                            //       const Color.fromRGBO(255, 255, 255, 1),
                            //   primary: const Color.fromRGBO(63, 85, 33, 1),
                            //
                            // ),
                          ),
                    ])),
                  ),
                ],
              ),
            ),
          ):  const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
  createChatRoomAndStartConversation(String userName) async {
    SharedPreferences sp=await SharedPreferences.getInstance();
    if (userName != sp.getString('email')) {
      List<String> users = [sp.getString('email').toString(), userName];
      String chatRoomId = getChatRoomId(sp.getString('email').toString(), userName);
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatRoomId": chatRoomId,
      };
   //   databaseMethods.createChatRoom(chatRoomId, chatRoomMap);

    } else {
    }
  }
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

}