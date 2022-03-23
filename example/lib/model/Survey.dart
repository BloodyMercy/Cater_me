class surveyModel {
  int id;
  String title;
  String titleAr;

  surveyModel({id, title,titleAr});

  surveyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];

  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['title'] = this.title;
  //   data['titleAr'] = this.titleAr;
  //   return data;
  // }
}
