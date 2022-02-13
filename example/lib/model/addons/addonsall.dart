import 'package:CaterMe/model/add_on.dart';
import 'package:CaterMe/model/packages.dart';

class Addonall {
  int id=0;
  String name="";
  List<Package> items=[];

  Addonall();

  Addonall.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['name']??"not found";
    if (json['items'] != null) {
      items = <Package>[];
      json['items'].forEach((v) {
        items.add(new Package.fromJson(v));
      });
    }
  }


}