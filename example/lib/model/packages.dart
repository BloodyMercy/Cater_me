import 'package:CaterMe/model/ItemsOrder.dart';
import 'package:CaterMe/model/details.dart';

class Package {

int id;
  String image = "";
  int tax = 0;
  String title = "";
  String description = "";
  double price = 0;
  bool isfavorite = false;
  List<Details> itemDetails = [];

  Package(this.id, this.image, this.title, this.description, this.price,
      this.isfavorite, this.itemDetails);

  Package.fromJson(Map<String, dynamic> json) {
    tax = json['tax']==null?0:json['tax'];
    id = json['id'];
    image = json['image'];
    title = json['title'];
    description = json['description'];
    price = double.parse(json['price'].toString());
    isfavorite = json['isFavorite'];
    if (json['itemDetails'] != null) {
      itemDetails = [];
      json['itemDetails'].forEach((v) {
        itemDetails.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tax'] =tax;
    data['id'] =id;
    data['image'] = image;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    if (itemDetails != null) {
      data['itemDetails'] = itemDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
