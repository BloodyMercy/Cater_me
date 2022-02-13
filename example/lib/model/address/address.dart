class Address {
  int id = 0;
  String city = '';
  int cityId = 0;
  String street = '';
  String buildingName = '';
  int floorNumber = 0;
  String title ='';
  String longitude="";
  String latitude="";

  List<Occations> occations;

  Address();

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    city = json['city']??"not found";
    cityId = json['cityId']??0;
    street = json['street']??'not found';
    buildingName = json['buildingName']??"not found";
    floorNumber = json['floorNumber']??0;
    title = json['title']??"not found";
    longitude=json['longitude']??"not found";
    latitude=json['latitude']??"not found";
    if (json['occations'] != null) {
      occations = <Occations>[];
      json['occations'].forEach((v) {
        occations.add(new Occations.fromJson(v));
      });
    }
  }
}

class Occations {
  int occationId;
  String occationName;

  Occations({this.occationId, this.occationName});

  Occations.fromJson(Map<String, dynamic> json) {
    occationId = json['occationId'];
    occationName = json['occationName'];
  }
}
