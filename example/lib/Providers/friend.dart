
import 'package:CaterMe/Services/friend.dart';

import 'package:CaterMe/model/friend_model.dart';


import 'package:flutter/cupertino.dart';

class FriendsProvider extends ChangeNotifier {
  FriendServices _friendsService = FriendServices();
  List<FriendModel> _listFriends = [];


  List<FriendModel> get listFriends => _listFriends;

  set listFriends(List<FriendModel> value) {
    _listFriends = value;
  }

  getAllFriends() async {

    _listFriends = await _friendsService.getAllFriends();

    notifyListeners();
  }


FriendModel _FriendCreated = FriendModel();


  FriendServices get friendsService => _friendsService;

  set friendsService(FriendServices value) {
    _friendsService = value;
  }

  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();




  createNewFriend() async {

    _FriendCreated=await  FriendServices.CreateFriend(
  namecontroller.text.toString(),
     int.parse(phonecontroller.text.toString()),
      emailcontroller.text.toString(),
    );
    _listFriends.insert(0,_FriendCreated);
    notifyListeners();
  }



}


