class Country {
  int id;
  String name;

  Country({this.id, this.name});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['name']??'not found';
  }

}