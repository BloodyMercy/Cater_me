

class Users {
  int id=0;
  String uid="";
  String name="";
  String phoneNumber="";
  String imageUrl="";
  String role="";
  String email="";
  int orderListId=0;
  bool isActive=false;
  String gender="";
  String birthDate="";
  String token="";
        Users();





  Users.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    uid = json['uid']??"not found";
    name = json['name']??"not found";
    phoneNumber = json['phoneNumber']??"not found";
    imageUrl = json['imageUrl']??"not found";
    role = json['role']??"not found";
    email = json['email']??"not found";
    orderListId = json['orderListId']??0;
    isActive = json['isActive']??false;
    gender = json['gender']??"not found";
    birthDate = json['birthDate']??"not found";
    token = json['token']??"not found";
  }

  Map<String, dynamic> toJson( ) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['imageUrl'] = this.imageUrl;
    data['role'] = this.role;
    data['email'] = this.email;
    data['orderListId'] = this.orderListId;
    data['isActive'] = this.isActive;
    data['gender'] = this.gender;
    data['birthDate'] = this.birthDate;
    data['token'] = this.token;
    return data;
  }
}