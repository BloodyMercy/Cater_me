class Occasion {
  int id=0;
  String type="";
  String date="";
  String name="";
 bool yearly;

  Occasion();

Occasion.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  date = json['date'];
  name = json['title'];
  type = json['type'];
}
  Occasion.fromJsonadd(Map<String, dynamic> json) {
    id = json['profileId'];
    date = json['date'];
    name = json['title'];
    type = json['typeId'].toString();

  }
}
