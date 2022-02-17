class notificationModel {
 int id;
  int orderId = 0;
  String title = '';
  String description = '';
  bool seen=false;
  String date = '';

  notificationModel();

  notificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    orderId = json['orderId']??0;
    title = json['title']??"not found";
    description = json['description']??"not found";
    seen=json['seen']??false;
    date = json['date']?? false;
  }

  

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['orderId'] = this.orderId;
  //   data['title'] = this.title;
  //   data['description'] = this.description;
  //   return data;
  // }
}
