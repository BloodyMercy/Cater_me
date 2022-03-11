class OccassionType {
  int id;
  String name;
String image ;
  OccassionType({this.id, this.name, this.image});

  OccassionType.fromJson(Map<String, dynamic> json,String a) {
    id = json['id']??0;
    if(a=="ar") {
      name = json['titleAR'] ?? "غير معروف";
      image = json['imageAR'] ?? "غير معروف";
    }
    else {
      name = json['title'] ?? "not found";

      image = json['image'] ?? "not found";
    }
  }

}