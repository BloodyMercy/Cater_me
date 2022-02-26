
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
  deleteFreind(int id)async{
  // return  await  _friendsService.deleteFriends(id);
  var em= await _friendsService.deleteFriends(id);
  notifyListeners();
  return em.message;
  }



FriendModel _FriendCreated = FriendModel();


  FriendServices get friendsService => _friendsService;

  set friendsService(FriendServices value) {
    _friendsService = value;
  }

  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();




 Future<bool> createNewFriend() async {

    _FriendCreated=await  FriendServices.CreateFriend(
  namecontroller.text.toString(),
     int.parse(phonecontroller.text.toString()),
      emailcontroller.text.toString(),
    );
    if(_FriendCreated.id!=0) {
      _listFriends.insert(0, _FriendCreated);
      return true;
    }
    else{
      return false;
    }


    namecontroller.text="";
    phonecontroller.text="";
    emailcontroller.text="";
    notifyListeners();
  }
  UpdateFriend(int id) async {
bool done=
     await  _friendsService.updatefriends(
        name: namecontroller.text.toString(),
     phonenumber:
phonecontroller.text,
    email:   emailcontroller.text,
      id: id,
    );


    namecontroller.text="";
    phonecontroller.text="";
    emailcontroller.text="";
 await getAllFriends();
notifyListeners();
    return done ;

  }



}


