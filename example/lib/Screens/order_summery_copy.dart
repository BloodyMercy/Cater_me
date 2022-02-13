import 'package:CaterMe/Providers/friend.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/model/friend_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'occasion/theme/colors/light_colors.dart';
import 'orders/checkout/carditem.dart';

class OrderSummeryCopy extends StatefulWidget {
  double alpha =0.0;
   OrderSummeryCopy(this.alpha);

  @override
  _OrderSummeryCopyState createState() => _OrderSummeryCopyState();
}

class _OrderSummeryCopyState extends State<OrderSummeryCopy> {
  ScrollController _scrollController = ScrollController();

  @override
 // List<bool> _isChecked = List<bool>.filled(15, false);
bool loading=false;
  @override
  void initState() {
    super.initState();
    getData();

  //  _isChecked = List<bool>.filled(15, false);
  }
  List<String> listFriendssearch = [];


  getData()async{
    final occasion=Provider.of<FriendsProvider >(context,listen: false);
    if(occasion.listFriends.length==0)
    await occasion.getAllFriends();
    List<String> l = [];
    for(int i=0;i<occasion.listFriends.length;i++)
      {
        l.add(occasion.listFriends[i].name);


      }
    setState(() {
      listFriendssearch=l;
    });
   // controllersearch.text="p";
    setState(() {
      loading=false;
    });
  }
  Future<bool> _onWillPop() async {

    final frnd=Provider.of<FriendsProvider >(context,listen:true);

    return (await showDialog(
            context: context,
            builder: (context) => setupAlertDialoadContainer(context,frnd.listFriends))) ??
        false;
  }


  bool isSearch = false;


  Widget setupAlertDialoadContainer(context,List<FriendModel> l) {
    final frnd=Provider.of<FriendsProvider >(context,listen:true);
    final details = Provider.of<OrderCaterProvider>(context, listen: true);
    return SingleChildScrollView(
      child:  Container(
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
                itemCount:frnd.listFriends.length,
                itemBuilder: (BuildContext context, int index) {
                  return
                    listFriendssearch[index].contains(controllersearch.text.toLowerCase())?
                    CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    value: details.choosebillFriend.contains(frnd.listFriends[index]),
                    onChanged: (val) {
                      if(val==true)
                    details.addfriend(frnd.listFriends[index]);
                      else
                        details.removefriend(frnd.listFriends[index]);
                    },
                    title: Card(
                      color: LightColors.kLightYellow2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              child: ClipRRect(
                                child: Image.network(
                                    l[index].image),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            Text(l[index].name),
                          ],
                        ),
                      ),
                    ),
                  ):Container();

                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool issearch = true;
  String searchText="";
  TextEditingController controllersearch = TextEditingController();
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final details = Provider.of<OrderCaterProvider>(context, listen: true);
    final frnd=Provider.of<FriendsProvider >(context,listen:true);
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: LightColors.kLightYellow,
          child: Column(children:[


       Expanded(
           child: CustomScrollView(slivers: <Widget>[

           details.itemOrders.length==0? SliverToBoxAdapter(child:Center(child:Text("no items added")))  : SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int i) {
                    final item = details.itemOrders[i];
                    if (i> details.itemOrders.length) return null;

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
                              padding: EdgeInsets.symmetric(horizontal: 20),
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
                            child: CartItemCard(details.itemOrders[i], i),
                          ),
                        ),
                      ],
                    ); // you can add your available item here
                  },
                  childCount: details.itemOrders.length,
                ),
              ),
             issearch?SliverToBoxAdapter(child:     Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 TextButton(
                   onPressed: () {

                  setState(() {
                    issearch=!issearch;
                  });
                   },
                   child: const Text(
                     "Share Bill",
                     style: TextStyle(
                         decoration: TextDecoration.underline,
                         color: Color(0xFF3F5521),
                         fontSize: 20,
                         fontWeight: FontWeight.bold,
                         fontFamily: 'BerlinSansFB'),
                   ),
                 ),
               ],
             ) ,):SliverToBoxAdapter(child:Container()),


           SliverToBoxAdapter(child: !issearch? Container(
               child: Column(
                 children: [
                   Row(
                     mainAxisAlignment:
                     MainAxisAlignment
                         .spaceBetween,
                     children: [
                       IconButton(
                         onPressed: () {
                          // Navigator.pop(context);
                           setState(() {
                             issearch=true;
                           });
                         },
                         icon: Icon(
                           Icons.close,
                           color: Theme.of(context)
                               .primaryColor,
                         ),
                       ),
                       IconButton(
                           onPressed: () {
                           setState(() {
                             issearch=true;
                           });
                           //  Navigator.pop(context);

                           },
                           icon: Icon(
                             Icons.check,
                             color: Theme.of(context)
                                 .primaryColor,
                           ))
                     ],
                   ),
                   Padding(
                     padding:const EdgeInsets.only(left: 15.0),
                     child: Text(
                       'Choose the friends you want to share the order with.',
                       style: TextStyle(
                           color: Theme.of(context)
                               .primaryColor,
                           fontFamily: 'BerlinSansFB'),
                     ),
                   ),
                   SizedBox(
                     height: mediaQuery.size.height *
                         0.02,
                   ),

                 ],
               ),
             ):Container()),
           !issearch?  SliverList(
             delegate: SliverChildBuilderDelegate(

    (BuildContext context, int index) {
                 return
                   listFriendssearch[index].contains(controllersearch.text.toLowerCase())?
                   CheckboxListTile(
                     activeColor: Theme.of(context).primaryColor,
                     value: details.choosebillFriend.contains(frnd.listFriends[index]),
                     onChanged: (val) {
                       if(val==true)
                         details.addfriend(frnd.listFriends[index]);
                       else
                         details.removefriend(frnd.listFriends[index]);
                     },
                     title: Card(
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             CircleAvatar(
                               radius: 25.0,
                               child: ClipRRect(
                                 child: Image.network(
                                     frnd.listFriends[index].image),
                                 borderRadius: BorderRadius.circular(50.0),
                               ),
                             ),
                             Text(   frnd.listFriends[index].name),
                           ],
                         ),
                       ),
                     ),
                   ):Container();

               },
               childCount:  frnd.listFriends.length,
             )


             ):SliverToBoxAdapter(child:Container()),



             issearch? SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        details.addcontroller(new TextEditingController());
                    //  final item = ;

                    return    ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(details.choosebillFriend[index].image),
                        ),
                        title: Text(details.choosebillFriend[index].name),
                        trailing: SizedBox(
                            height: mediaQuery.size.height/20,
                            width: mediaQuery.size.width/3,
                            child: TextFormField(
onChanged: (value){
  double sum=0.0;
  for(int i=0; i<details.controllers.length;i++){
    if(details.controllers[i].text.isEmpty||details.controllers[i].text==null){
    }else{
    sum+=double.parse(details.controllers[i].text);
    }
  }
  double lastinput= double.parse( details.controllers[index].text);
  if(sum>details.totale) {
    details.controllers[index].text = (details.totale- (sum-lastinput) ).toString();
  }
setState(() {

});
},
                              decoration: InputDecoration(
                                hintText:'Price' ,
                                fillColor: Color(0xFF3F5521),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFF3F5521), width: 1.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              keyboardType: TextInputType.number,
controller:details.controllers[index],
                            ))); // you can add your unavailable item here
                  },
                  childCount:details.choosebillFriend.length ,
                ),
              ):SliverToBoxAdapter(child:Container()),
             SliverToBoxAdapter(child:  Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
Padding(
  padding: const EdgeInsets.only(left: 15.0),
  child:   Column(

    crossAxisAlignment: CrossAxisAlignment.start,

    children: [

      Text(

          "You cant't cancel or edit your order once submitted!"),

      Text(

        'Subtotal: ${details.subTotal.toStringAsFixed(3)}',

        style: TextStyle(

          fontWeight: FontWeight.bold,

        ),

      ),

      Text(

        'Totale: ${details.totale.toStringAsFixed(3)}',

        style: TextStyle(

          color: Color(0xFF3F5521),

          fontWeight: FontWeight.bold,

        ),

      ),

      Text(

        '*(VAT included ${details.tax} %:)',

        style: TextStyle(

          fontWeight: FontWeight.bold,

        ),

      ),



      Row(



        children: [

          Text(

            '*(VAT included ${details.tax} %:  SAR)',

            style: TextStyle(

              fontWeight: FontWeight.bold,

            ),

          ),

        ],

      ),

    ],

  ),
)


               ],
             ))

            ]),
       ),



          ]),
        )),
    );
  }
}
