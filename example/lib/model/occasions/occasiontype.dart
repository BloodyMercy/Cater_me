class OccassionType {
  int id;
  String name;

  OccassionType({this.id, this.name});

  OccassionType.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['title']??"not found";
  }

}