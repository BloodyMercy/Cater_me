class timeSpanHours{
  String _timespan="";
  bool _isDaberni= false ;
  timeSpanHours();
  String get timespan => _timespan;

  set timespan(String value) {
    _timespan = value;
  }

  bool get isDaberni => _isDaberni;

  set isDaberni(bool value) {
    _isDaberni = value;
  }
  timeSpanHours.fromJson(Map<String, dynamic> json) {

    _timespan = json['timeSpanHours'].toString()??"not found";
    _isDaberni = json['isDaberni']??false;

  }
}