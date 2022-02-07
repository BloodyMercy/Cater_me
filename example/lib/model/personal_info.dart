class PersonalInfoModel {
  String name="";
  String phoneNumber="";
  String email="";
  String birthDate="";

  PersonalInfoModel({name, phoneNumber, email, birthDate});

  PersonalInfoModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    birthDate = json['birthDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['birthDate'] = this.birthDate;
    return data;
  }
}