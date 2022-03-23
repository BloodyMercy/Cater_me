

import 'package:flutter/cupertino.dart';

import '../Services/surveyService.dart';
import '../model/Survey.dart';

class SurveyProvider with ChangeNotifier{
  SurveyService _service =SurveyService();
  List<surveyModel> _listsurvey=[];
  TextEditingController comment =TextEditingController();
  double _stars=0.0;
  List<int>_feedbackoptionid=[];
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

  List<int> get feedbackoptionid => _feedbackoptionid;

  set feedbackoptionid(List<int> value) {
    _feedbackoptionid = value;
    notifyListeners();
  }
  getsurvey() async {
_listsurvey = await  _service.getallsurvey();
_loading=true ;
notifyListeners();

  }
postsurvey() async {
return await  _service.postreview(complaint: comment.text, feedbackoptionid: _feedbackoptionid, rating:_stars );

}
}