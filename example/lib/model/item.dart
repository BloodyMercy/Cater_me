class Item {
  int? id;
  String? itemName;
  String? category;
  String? itemImage;

  Item({this.id, this.itemName, this.category});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['itemName'];
    category = json['category'];
    itemImage = json['itemImage'];
  }


}