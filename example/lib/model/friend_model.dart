class FriendModel {
  int id=0;
  String name = '';
  String phoneNumber = '';
  String email = '';
  String image = '';
  double price=0.0;

  FriendModel();

  FriendModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['name']??"";
    phoneNumber = json['phoneNumber']??"";
    email = json['email']??"";
    image = json['image']??"";

  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['phoneNumber'] = this.phoneNumber;
  //   data['email'] = this.email;
  //   data['image'] = this.image;
  //   return data;
  // }
}
