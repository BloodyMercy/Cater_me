
  import 'details.dart';

class AddOn {
 int id=0;
 int tax = 0;
  String image="";
  String title="";
  String description="";
  double price=0.0;
 bool isfavorite = false;
 List<Details> itemDetails = [];

 AddOn(

  );

 AddOn.fromJson(Map<String, dynamic> json) {
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


  }