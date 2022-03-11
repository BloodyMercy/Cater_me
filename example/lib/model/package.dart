import 'package:CaterMe/model/packages.dart';

class Packages {
  int id=0;
  String name='';
  List<Package> items=[];


Packages();
  Packages.fromJson(Map<dynamic, dynamic> json,String a) {
    id = json['id']??0;
    name = json['name']??"not found";
    if (json['items'] != null) {
      items = <Package>[];
      json['items'].forEach((v) {
        items.add(new Package.fromJson(v,a));
      });
    }
  }
}