class GalleryModel{
  String _link = "";

  String get link => _link;

  set link(String value) {
    _link = value;
  }

  GalleryModel.fromJson(Map<String, dynamic> json){
    _link= json[""]??"";
  }
}
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