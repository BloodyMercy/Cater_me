class Address {
  int id = 0;
  String city = '';
  int cityId = 0;
  String street = '';
  String buildingName = '';
  int floorNumber = 0;
  String title ='';

  List<Occations>? occations;

  Address();

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    cityId = json['cityId'];
    street = json['street'];
    buildingName = json['buildingName'];
    floorNumber = json['floorNumber'];
    title = json['title'];
    if (json['occations'] != null) {
      occations = <Occations>[];
      json['occations'].forEach((v) {
        occations!.add(new Occations.fromJson(v));
      });
    }
  }
}

class Occations {
  int? occationId;
  String? occationName;

  Occations({this.occationId, this.occationName});

  Occations.fromJson(Map<String, dynamic> json) {
    occationId = json['occationId'];
    occationName = json['occationName'];
  }
}
