

import 'package:flutter/cupertino.dart';

import '../Services/surveyService.dart';
import '../model/Survey.dart';

class SurveyProvider with ChangeNotifier{
  SurveyProvider.nodata(){}
  SurveyService _service =SurveyService();
  List<surveyModel> _listsurvey=[];
  TextEditingController comment =TextEditingController();
  double _stars=0.0;
  List<Map<String, String >>_feedbackoptionid=[];
bool _loading=false;

  bool get loading => _loading;

  List<surveyModel> get listsurvey => _listsurvey;

  set listsurvey(List<surveyModel> value) {
    _listsurvey = value;
    notifyListeners();
  }

  double get stars => _stars;

  set stars(double value) {
    _stars = value;
    notifyListeners();
  }
List<int>listid=[];
  List<Map<String, String >> get feedbackoptionid => _feedbackoptionid;

  set feedbackoptionid(List<Map<String, String >> value) {
    _feedbackoptionid = value;
    notifyListeners();
  }
  getsurvey() async {
_listsurvey = await  _service.getallsurvey();
_loading=true ;
notifyListeners();

  }
postsurvey() async {
 await  _service.postreview(complaint: comment.text, feedbackoptionid: _feedbackoptionid, rating:_stars );
comment.text="";
 _feedbackoptionid.clear();
 _stars=0;

}
}