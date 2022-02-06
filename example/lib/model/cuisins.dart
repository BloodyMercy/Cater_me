import 'menu.dart';

class Cuisins {
   String name="";

   String image="";
int id=0;
  Cuisins(
      {required this.name,
      required this.id,
      required this.image});
  // AddOn.fromJson(Map<String, dynamic> json) {
  //   category = json['type'];
  //   name = json['name'];
  //   price=json['price'];
  //   image=json['image'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['type'] = this.category;
  //   data['name'] = this.name;
  //   data['price'] = this.price;
  //   data['image'] = this.image;
  //   return data;
  // }

  Cuisins.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image=json['image'];
  }
}
