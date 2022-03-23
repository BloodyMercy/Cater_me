import 'details.dart';

class AddOn {
  int id = 0;
  int tax = 0;
  String image = "";
  String title = "";
  String description = "";
  double price = 0.0;
  bool isfavorite = false;
  List<Details> itemDetails = [];

  AddOn();

  AddOn.fromJson(Map<String, dynamic> json, String a) {
    tax = json['tax'] ?? 0;
    id = json['id'] ?? 0;
    if (a == "ar") {
      title = json['titleAR'] ?? "غير معروف";
      image = json['imageAR'] ?? "غير معروف";
      description = json['descriptionAR'] ?? "غير معروف";
    } else {

      title = json['title'] ?? "not found";
      image = json['image'] ?? "not found";
      description = json['description'] ?? "not found";
    }

      price = double.parse(json['price'].toString()) ?? 0.0;
      isfavorite = json['isFavorite'] ?? false;
      if (json['itemDetails'] != null) {
        itemDetails = [];
        json['itemDetails'].forEach((v) {
          itemDetails.add(new Details.fromJson(v));
        });
      }
    }

}






