class Item {
  int id;
  String itemName;
  String category;
  String itemImage;

  Item({this.id, this.itemName, this.category});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    itemName = json['itemName']??"not found";
    category = json['category']??"not found";
    itemImage = json['itemImage']??"not found";
  }


}