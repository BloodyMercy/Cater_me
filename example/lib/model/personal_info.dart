class PersonalInfoModel {
  String name="";
  String phoneNumber="";
  String email="";
  String birthDate="";
  String imageUrl="";

  PersonalInfoModel({name, phoneNumber, email, birthDate,imageUrl});

  PersonalInfoModel.fromJson(Map<String, dynamic> json) {
    name = json['name']??"not found";
    phoneNumber = json['phoneNumber']??"not found";
    email = json['email']??"not found";
    birthDate = json['birthDate']??"not found";
    imageUrl=json['imageUrl']??"not found";
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