class ContactUsModel {
  int id=0;
  String email='';
  String phoneNumber='';


  ContactUsModel();

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    email = json['email']??'not found';
    phoneNumber = json['phoneNumber']??'not found';

  }
}



