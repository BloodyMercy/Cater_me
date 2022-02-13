class City {
  int id;
  String name;

  City();

  City.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['name']??"not found";
  }
}