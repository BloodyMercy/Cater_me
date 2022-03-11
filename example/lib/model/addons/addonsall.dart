import 'package:CaterMe/model/packages.dart';

class Addonall {
  int id=0;
  String name="";
  List<Package> items=[];

  Addonall();

  Addonall.fromJson(Map<String, dynamic> json,String a) {

    id = json['id']??0;
    if(a=="ar"){
      name = json['nameAR']??"غير معروف";
    }else
    name = json['name']??"not found";

    if (json['items'] != null) {
      items = <Package>[];
      json['items'].forEach((v) {
        items.add(new Package.fromJson(v,"ar"));
      });
    }
  }


}