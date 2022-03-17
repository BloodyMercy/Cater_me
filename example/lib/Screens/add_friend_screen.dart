import 'package:CaterMe/Providers/friend.dart';
import 'package:CaterMe/model/friend_model.dart';
import 'package:CaterMe/widgets/Frriends/friends_list.dart';
import 'package:CaterMe/widgets/Frriends/friends_textField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/user.dart';
import '../language/language.dart';
import 'occasion/theme/colors/light_colors.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({Key key}) : super(key: key);

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  @override
  List<FriendModel> _friend = [];

  void _addNewFriend(
    // String id,
    String fullName,
    // String email,
    String phoneNumber,
  ) {
    final newFriend = FriendModel();

    setState(() {
      _friend.add(newFriend);
    });
  }

  void _startAddNewFriend(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled:true,
        context: ctx,
        builder: (_) {
          return GestureDetector(

            child: FreindsTextField(_addNewFriend),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void deleteFreind(String id) {
    setState(() {
      _friend.removeWhere(
        (element) => element.id == id,
      );
    });
  }

  bool loading = true;

  getData() async {
    final friends = Provider.of<FriendsProvider>(context, listen: false);
    await friends.getAllFriends();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future frndData() async {
    final setting = Provider.of<FriendsProvider>(context, listen: false);
    await getData();

    return;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    final friends = Provider.of<FriendsProvider>(context, listen: true);
    var _mediaQuery = MediaQuery.of(context).size.height;
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            iconSize: 30,
          ),
          elevation: 0,

          centerTitle: true,
          title: Text('${LanguageTr.lg[authProvider.language]['Add New Friend']}'
            ,
            style: Theme.of(context).textTheme.headline1,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(onPressed:() {
              friends.namecontroller.text="";
              friends.emailcontroller.text="";
              friends.phonecontroller.text="";

              _startAddNewFriend(context);},

                icon: Icon(Icons.add))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: frndData,
          child: loading
              ? Container(
                  color: LightColors.kLightYellow,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF3F5521),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    color: LightColors.kLightYellow,
                    child: Column(
                      children: [FriendsList(friends.listFriends)],
                    ),
                  ),
                ),
        ),

        // floatingActionButton: FloatingActionButton(
        //
        //   child: const Icon(Icons.add),
        //   backgroundColor: Theme.of(context).primaryColor,
        //   onPressed: () => _startAddNewFriend(context),
        // ),
      ),
    );
  }
}
