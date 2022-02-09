class OrderByIdModel {
  String item="";
  int quantity;
  int itemPrice=0;
  String date ="";
  int totalItemPrice=0;
  int finalPrice=0;
  int total=0;
  bool isDaberni=false;

  OrderByIdModel(
  {item,
      this.quantity,
      itemPrice,
      date,
      totalItemPrice,
      finalPrice,
      total,
      isDaberni});

  OrderByIdModel.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    quantity = json['quantity'];
    itemPrice = json['itemPrice'];
    date = json['date'];
    totalItemPrice = json['totalItemPrice'];
    finalPrice = json['finalPrice'];
    total = json['total'];
    isDaberni = json['isDaberni'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['item'] = this.item;
  //   data['quantity'] = this.quantity;
  //   data['itemPrice'] = this.itemPrice;
  //   data['date'] = this.date;
  //   data['totalItemPrice'] = this.totalItemPrice;
  //   data['finalPrice'] = this.finalPrice;
  //   data['total'] = this.total;
  //   data['isDaberni'] = this.isDaberni;
  //   return data;
  // }
}