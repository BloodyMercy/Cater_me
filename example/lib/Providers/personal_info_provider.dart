import 'package:CaterMe/Services/personal_info_service.dart';
import 'package:CaterMe/model/personal_info.dart';
import 'package:flutter/cupertino.dart';

class PersonalInfoProvider extends ChangeNotifier{
  PersonalInfoService _personalInfoService=PersonalInfoService();
  PersonalInfoModel _personalInfo=PersonalInfoModel();

  PersonalInfoModel get personalInfo => _personalInfo;

  set personalInfo(PersonalInfoModel value) {
    _personalInfo = value;
  }

  getPersonalInfo() async{
    _personalInfo = await _personalInfoService.getAllInfo();

    notifyListeners();
  }
}