class OrderByIdStatusModel {
  int statusId;


  OrderByIdStatusModel({this.statusId});

  OrderByIdStatusModel.fromJson(Map<String, dynamic> json) {
    statusId = json['statusId']??0;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['statusId'] = this.statusId;
  //   data['status'] = this.status;
  //   return data;
  // }
}