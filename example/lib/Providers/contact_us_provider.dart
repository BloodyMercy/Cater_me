import 'package:flutter/cupertino.dart';
import '../model/contact_us_model.dart';
import '../Services/Contact_us_services.dart';




class ContactUsProvider extends ChangeNotifier{
  ContactUsService _ContactUs=ContactUsService();
  ContactUsModel _UsContact=ContactUsModel();





  ContactUsModel get UsContact => _UsContact;


  set UsContact(ContactUsModel value) {
    _UsContact = value;
  }

  getPersonalInfo() async{
    _UsContact = await _ContactUs.getallcontactus();

    notifyListeners();
  }
}