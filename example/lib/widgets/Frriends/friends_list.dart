import 'package:CaterMe/Providers/friend.dart';
import 'package:CaterMe/Screens/CustomAlert/alert.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/model/friend_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Providers/user.dart';
import '../../language/language.dart';
import 'editfriend.dart';

class FriendsList extends StatefulWidget {
  final List<FriendModel> friend;

  FriendsList(this.friend);

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
bool loading = true ;
String language;
void _EditFriend(BuildContext ctx,FriendModel a ) {
  showModalBottomSheet(
      isScrollControlled:true,
      context: ctx,
      builder: (_) {
        return GestureDetector(

          child: editfriend(a),
          behavior: HitTestBehavior.opaque,
        );
      });
}
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
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    final friend = Provider.of<FriendsProvider>(context, listen: true);
    var _mediaQuery = MediaQuery.of(context).size.height;
    var _mediaQueryWidth = MediaQuery.of(context).size.width;
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: SizedBox(
        height: _mediaQuery * 0.9,
        child: widget.friend.isEmpty
            ? Center(
             child: Container(
               child: language=="en"?Image.asset('images/NoFriendsYet.png'):Image.asset('images/no address yetعربي/no addresses yetبالعربي-05.png')
             ),
              )
            : loading?ListView.builder(
                itemCount: widget.friend.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    color: LightColors.kLightYellow2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: _mediaQuery * 0.02,
                              horizontal: _mediaQuery * 0.01),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(

                                  widget.friend[index].image,
                                  // height: screenHeight * 0.25,
                                  // width: 40,
                                ),
                                backgroundColor: Colors.transparent,
                                radius: screenHeight * 0.04,
                                // minRadius: 16,
                                // maxRadius: screenHeight * 0.04,

                                // radius: 25.0,
                                // child: ClipRRect(
                                //
                                //   child: Image.network(
                                //
                                //      widget.friend[index].image,
                                //     // height: screenHeight * 0.25,
                                //     // width: 40,
                                //     fit:BoxFit.cover,
                                //   ),
                                //   borderRadius: BorderRadius.circular(screenHeight * 0.04),
                                // ),
                              ),
                              SizedBox(width:_mediaQueryWidth * 0.025 ,),
                              Container(
                                width: _mediaQueryWidth*0.6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.friend[index].name,

                                      style: const TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.friend[index].email,
                                      style: const TextStyle(
                                          fontSize: 15, fontWeight: FontWeight.normal),
                                    ),
                                    // SizedBox(height: _mediaQuery * 0.01),
                                    Text(
                                      widget.friend[index].phoneNumber,
                                      style: const TextStyle(
                                          fontSize: 13, fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          IconButton(onPressed: (){
                            //edit
                            _EditFriend(context,widget.friend[index]);
                          }, icon: Icon(FontAwesomeIcons.solidEdit,color: Color(0xFF3F5521),size: 20)
                          ),
                            IconButton(onPressed: ()async{
                              loading=false;
                              setState(() {

                              });
                              bool state=(await  friend.deleteFreind(widget.friend[index].id)) ;
                              if(state){
                                loading=true;

                                friend.listFriends.remove(widget.friend[index]);

                              }else{
                                loading=true;

                              }

setState(() {

});

                            }, icon: GestureDetector(
                              child: Icon(FontAwesomeIcons.trash,color: redColor
                                ,size: 20,),
                              onTap: (){
                                showDialog(context: context, builder: (BuildContext context)=>
                                    CustomDialog( title: '${LanguageTr.lg[authProvider.language]["Do you want to delete this friend"]}',


                                      description: "",
                                      button1:ElevatedButton(
                                        style: ElevatedButton.styleFrom(primary: Colors.grey),
                                        child: Text('${LanguageTr.lg[authProvider.language]["Yes"]}'
                                            ),
                                        onPressed: ()async{
                                          showDialog(
                                            context: this.context,
                                            barrierDismissible: false,
                                            builder: (BuildContext contexts) {

                                              return WillPopScope(
                                                // onWillPop: () => Future<bool>.value(false),
                                                  child: AlertDialog(
                                                    title: Text('${LanguageTr.lg[authProvider.language]["Loading..."]}',style: TextStyle(color: colorCustom),),
                                                    content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[CircularProgressIndicator(color: colorCustom,)]),
                                                  ));
                                            },
                                          );
                                          var delete= await  friend.deleteFreind(widget.friend[index].id);
                                          if(delete=="deleted"){
                                            widget.friend.remove(widget.friend[index]);
                                            Navigator.pop(context);
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                content: Text('${LanguageTr.lg[authProvider.language]['Friend Deleted']}'
                                                    )));
                                          }else{
                                            Navigator.pop(context);
                                            Navigator.of(context).pop();


                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text('${LanguageTr.lg[authProvider.language]['Friend cannot be Deleted']}'
                                                  ),
                                            ));
                                          }
                                        },
                                      ),
                                      button2: ElevatedButton(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },child: Text('${LanguageTr.lg[authProvider.language]["No"]}'
                                          ),
                                      ),
                                      oneOrtwo: true,
                                    )
                                )  ;
                              },
                            )
                            ),

                          ],)
                      ],
                    ),
                  );
                }):Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}
