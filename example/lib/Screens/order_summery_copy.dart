
import 'package:CaterMe/Providers/friend.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/model/friend_model.dart';
import 'package:CaterMe/widgets/Frriends/friends_textField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Providers/user.dart';
import '../language/language.dart';
import 'cartpage/CartCard.dart';
import 'occasion/theme/colors/light_colors.dart';
import 'orders/checkout/carditem.dart';

class OrderSummeryCopy extends StatefulWidget {
  double alpha = 0.0;

  OrderSummeryCopy(this.alpha);

  @override
  _OrderSummeryCopyState createState() => _OrderSummeryCopyState();
}

class _OrderSummeryCopyState extends State<OrderSummeryCopy> {
  ScrollController _scrollController = ScrollController();

  @override
  bool loading = false;
  bool adonce=false ;
  @override
  void initState() {
    super.initState();
    getData();

  }
  String imageurl="";
  List<String> listFriendssearch = [];

  getData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    imageurl=_prefs.getString("imageUrl");
    final occasion = Provider.of<FriendsProvider>(context, listen: false);
    if (occasion.listFriends.length == 0) await occasion.getAllFriends();
    List<String> l = [];
    for (int i = 0; i < occasion.listFriends.length; i++) {
      l.add(occasion.listFriends[i].name);
    }

    setState(() {
      listFriendssearch = l;
    });
    setState(() {
      loading = false;
    });
  }

  Future<bool> _onWillPop() async {
    final frnd = Provider.of<FriendsProvider>(context, listen: true);

    return (await showDialog(
        context: context,
        builder: (context) =>
            setupAlertDialoadContainer(context, frnd.listFriends))) ??
        false;
  }

  bool isSearch = false;
  List<FriendModel> _friend = [];

  void _addNewFriend(
      // String id,
      String fullName,
      String email,
      String phoneNumber,
      ) async {
    final newFriend = FriendModel();
    await getData();
    setState(() {
      _friend.add(newFriend);
    });
  }

  void _startAddNewFriend(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: FreindsTextField(_addNewFriend),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  Widget setupAlertDialoadContainer(context, List<FriendModel> l) {
    final frnd = Provider.of<FriendsProvider>(context, listen: true);
    final details = Provider.of<OrderCaterProvider>(context, listen: true);
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return
      GestureDetector( behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },


      child: SingleChildScrollView(
        child: Container(
          color: LightColors.kLightYellow2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Container(
                // color: Colors.white,
                height: 400.0, // Change as per your requirement
                width: 400.0, // Change as per your requirement
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: frnd.listFriends.length,
                  itemBuilder: (BuildContext context, int index) {
                    return listFriendssearch[index]
                        .contains(controllersearch.text.toLowerCase())
                        ? CheckboxListTile(
                      activeColor: Theme.of(context).primaryColor,
                      value: details.choosebillFriend
                          .contains(frnd.listFriends[index]),
                      onChanged: (val) {
                        if (val == true)
                          details.addfriend(frnd.listFriends[index]);
                        else
                          details.removefriend(frnd.listFriends[index]);
                      },
                      title: Card(
                        color: LightColors.kLightYellow2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                // radius: 25.0,
                                backgroundImage: NetworkImage(l[index].image),
                                backgroundColor: Colors.transparent,
                                radius: screenHeight * 1,
                              ),
                              Text(l[index].name),
                            ],
                          ),
                        ),
                      ),
                    )
                        : Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool issearch = true;
  String searchText = "";
  TextEditingController controllersearch = TextEditingController();

  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    final mediaQuery = MediaQuery.of(context);
    final details = Provider.of<OrderCaterProvider>(context, listen: true);
    final frnd = Provider.of<FriendsProvider>(context, listen: true);
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(slivers: <Widget>[
            SliverToBoxAdapter(
                child: Center(
                    child: Text('${authProvider.lg[authProvider.language]["VAT Number"]}  311085799400003',

                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black)))),
            details.itemOrders.length == 0
                ? SliverToBoxAdapter(
                child: Center(
                    child: Text('${authProvider.lg[authProvider.language]["no items added"]}'
                        ,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black))))
                : SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int i) {
                  final item = details.itemOrders[i];
                  if (i > details.itemOrders.length) return null;

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child:
                        // widget.data[index].status=="Package"?Container( child: CartItemCard(widget.data[index] , index),):
                        Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(232, 232, 232, 1.0),
                            ),
                            child: Row(
                              children: [
                                Spacer(),
                                SvgPicture.asset(
                                    'images/iconphase2/Trash.svg'),
                                //  (image: Icons.delete);
                              ],
                            ),
                          ),
                          onDismissed: (direction) {

                            details.removeItems(details.itemOrders[i]);

                          },
                          child: CartCard(
                              card: details.itemOrders[i], index:i),
                        ),
                      ),
                    ],
                  ); // you can add your available item here
                },
                childCount: details.itemOrders.length,
              ),
            ),
            issearch
                ? SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        issearch = !issearch;
                   details.issearch=issearch;

                      });
                    },
                    child:  Text('${authProvider.lg[authProvider.language]["Share Bill"]}'
                      ,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BerlinSansFB'),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  )
                ],
              ),
            )
                : SliverToBoxAdapter(child: Container()),

            SliverToBoxAdapter(
                child: !issearch
                    ? Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              details.controllers.clear();

                              for(int c=0; c<details.choosebillFriend.length; c++){
                                TextEditingController alpha = TextEditingController();
                                alpha.text=(details.totale/details.choosebillFriend.length).floor().toString();
                                details.addcontroller(alpha);
                                details.updateprocefreind((details.totale/details.choosebillFriend.length).floor().toDouble(), c);

                              }

    if(details.choosebillFriend.isNotEmpty) {
      double beta = (details.totale / details.choosebillFriend.length) -
          (details.totale / details.choosebillFriend.length).floor();
      double teta = double.parse(details.controllers[0].text);
      details.controllers[0].text =
          (teta + (beta * details.choosebillFriend.length)).toString();
    }
                              // Navigator.pop(context);
                              setState(() {
                                issearch = true;
                              });
                              details.issearch=issearch;
                            },
                            icon: Icon(
                              Icons.close,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                details.controllers.clear();

                                for(int c=0; c<details.choosebillFriend.length; c++){
                                  TextEditingController alpha = TextEditingController();
                                  alpha.text=(details.totale/details.choosebillFriend.length).floor().toString();
                                  details.addcontroller(alpha);
                                  details.updateprocefreind((details.totale/details.choosebillFriend.length).floor().toDouble(), c);

                                }
if(details.choosebillFriend.isNotEmpty) {
  double beta = (details.totale / details.choosebillFriend.length) -
      (details.totale / details.choosebillFriend.length).floor();
  double teta = double.parse(details.controllers[0].text);
  details.controllers[0].text =
      (teta + (beta * details.choosebillFriend.length)).toString();
}
setState(() {
                                  issearch = true;
                                });
                                details.issearch=issearch;
                                //  Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.check,
                                color: Theme.of(context).primaryColor,
                              ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          frnd.listFriends.length > 0
                              ? '${authProvider.lg[authProvider.language]["Choose the friends you want to share the order with."]}'

                              :'${authProvider.lg[authProvider.language]["No freind to share"]}'
                          ,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontFamily: 'BerlinSansFB'),
                        ),
                      ),
                      SizedBox(
                        height: mediaQuery.size.height * 0.02,
                      ),
                      TextButton(
                        onPressed: () {
                          details.controllers.clear();
                          details.choosebillFriend.clear();
                          adonce=false;
                          _startAddNewFriend(context);
                        },
                        child: Text('${authProvider.lg[authProvider.language]["Add Friend"]}'
                          ,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: 'BerlinSansFB',
                          ),
                        ),
                      )
                    ],
                  ),
                )
                    : Container()),
            !issearch
                ? SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return frnd.listFriends[index].name
                        .contains(controllersearch.text.toLowerCase())
                        ? CheckboxListTile(
                      activeColor: Theme.of(context).primaryColor,
                      value: details.choosebillFriend
                          .contains(frnd.listFriends[index]),
                      onChanged: (val) {

                        if (val == true){
                          if(!adonce){
                            FriendModel you = FriendModel();

                            you.name=authProvider.lg[authProvider.language]["Me"];
                            you.id=-69;
                            you.image=imageurl;
                            details.addfriend(you);
                            adonce=true;
                          }
                          details.addfriend(frnd.listFriends[index]);}
                        else {
                          details
                              .removefriend(frnd.listFriends[index]);
                          if(details.choosebillFriend.length==1){
                            details.choosebillFriend.clear();
                            adonce=false;
                          }
                        }    },
                      title: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                // radius: screenHeight * 0.04,
                                radius: 25.0,
                                child: ClipRRect(

                                  child: Image.network(

                                      frnd.listFriends[index].image),
                                  borderRadius:
                                  BorderRadius.circular(50.0),
                                ),
                              ),
                              Container(
                                  width:mediaQuery.size.width *0.5,
                                  child: Text(frnd.listFriends[index].name)),
                            ],
                          ),
                        ),
                      ),
                    )
                        : Container();
                  },
                  childCount: frnd.listFriends.length,
                ))
                : SliverToBoxAdapter(child: Container()),

            issearch
                ? SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: screenHeight * 0.04,
                          backgroundImage:NetworkImage(
                              details.choosebillFriend[index].image),
                        ),
                        title: Text(details.choosebillFriend[index].name),
                        trailing: SizedBox(
                            height: mediaQuery.size.height / 20,
                            width: mediaQuery.size.width / 3,
                            child: TextFormField(
                              enabled: index!=0,
                              onChanged: (value) {
print(value);
details.controllers[0].text="1";

                                double sum = 0.0;
                                for (int i = 0;
                                i < details.controllers.length;
                                i++) {
                                  if (details
                                      .controllers[i].text.isEmpty ||
                                      details.controllers[i].text ==
                                          null) {
                                    details.updateprocefreind(0, index);
                                    details.controllers[i].clear();
                                  } else {

                                    sum += double.parse(
                                        details.controllers[i].text==""?"0.0":details.controllers[i].text);
                                  }
                                }
                                double lastinput = double.parse(
                                    details.controllers[index].text==""?"0.0":details.controllers[index].text);
                                if (sum > details.totale) {
                                  details.controllers[index].text =
                                      (details.totale - (sum - lastinput))
                                          .toString()=="0.0"?"":(details.totale - (sum - lastinput))
                                          .toString();
                                  details.updateprocefreind(details.totale - (sum - lastinput), index);
                                }
                                else{

                                  details.controllers[0].text =(details.totale-sum).toString()=="0.0"?"1":(details.totale-sum+1).toString();
                                  details.updateprocefreind( details.totale-sum, 1);
                                  details.updateprocefreind( lastinput, index);

                                }
                              },
                              decoration: InputDecoration(
                                hintText: '${authProvider.lg[authProvider.language]['Price']}',
                                fillColor: Colors.black,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.0),
                                  borderRadius:
                                  BorderRadius.circular(25.0),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              controller: details.controllers[index],
                            ))),
                  ); // you can add your unavailable item here
                },
                childCount: details.choosebillFriend.length,
              ),
            )
                : SliverToBoxAdapter(child: Container()),
//              SliverToBoxAdapter(child:  Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: [
// Padding(
//   padding: const EdgeInsets.only(left: 15.0),
//   child:   Column(
//
//     crossAxisAlignment: CrossAxisAlignment.start,
//
//     children: [
//
//       Text(
//
//           "You cant't cancel or edit your order once submitted!"),
//
//       Text(
//
//         'Subtotal: ${details.subTotal.toStringAsFixed(3)}',
//
//         style: TextStyle(
//
//           fontWeight: FontWeight.bold,
//
//         ),
//
//       ),
//
//       Text(
//
//         'Totale: ${details.totale.toStringAsFixed(3)}',
//
//         style: TextStyle(
//
//           color: Color(0xFF3F5521),
//
//           fontWeight: FontWeight.bold,
//
//         ),
//
//       ),
//
//       Text(
//
//         '*(VAT included ${details.tax} %:)',
//
//         style: TextStyle(
//
//           fontWeight: FontWeight.bold,
//
//         ),
//
//       ),
//
//
//
//       Row(
//
//
//
//         children: [
//
//           Text(
//
//             '*(VAT included ${details.tax} %:  SAR)',
//
//             style: TextStyle(
//
//               fontWeight: FontWeight.bold,
//
//             ),
//
//           ),
//
//         ],
//
//       ),
//
//     ],
//
//   ),
// )
//
//
//                ],
//              ))
          ])),
    );
  }
}
