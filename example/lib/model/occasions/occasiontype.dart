class OccassionType {
  int id;
  String name;
String image ;
  OccassionType({this.id, this.name, this.image});

  OccassionType.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['title']??"not found";
    image= json['image']??"notfound";
  }

}