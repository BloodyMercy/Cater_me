class surveyModel {
  int id;
  String title="catch";
  String titleAr="catch";
  bool isChecked=false;

  surveyModel({id, title,titleAr});

  surveyModel.fromJson(Map<String, dynamic> json ,String lang) {
    id = json['id'];
    title = lang=="ar"?json['titleAr']:json['title'];
    isChecked=json['isChecked'];

  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['title'] = this.title;
  //   data['titleAr'] = this.titleAr;
  //   return data;
  // }
}
