class PersonalInfoModel {
  String name="";
  String phoneNumber="";
  String email="";
  String birthDate="";
  String imageUrl="";

  PersonalInfoModel({name, phoneNumber, email, birthDate,imageUrl});

  PersonalInfoModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    birthDate = json['birthDate'];
    imageUrl=json['imageUrl'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   data['phoneNumber'] = this.phoneNumber;
  //   data['email'] = this.email;
  //   data['birthDate'] = this.birthDate;
  //   data['imageUrl'] = this.imageUrl;
  //   return data;
  // }
}