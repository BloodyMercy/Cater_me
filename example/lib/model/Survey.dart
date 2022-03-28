class surveyModel {
  int id;
  String title = "catch";
  String titleAr = "catch";
  bool isChecked = false;
double _stars= 0.0 ;

  double get stars => _stars;

  set stars(double value) {
    _stars = value;
  }

  surveyModel({id, title, titleAr, isChecked});

  surveyModel.fromJson(Map<String, dynamic> json, String lang) {
    id = json['id'];
    title = lang == "ar" ? json['titleAr'] : json['title'];

    isChecked = json['isChecked'];
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['id'] = this.id;
//   data['title'] = this.title;
//   data['titleAr'] = this.titleAr;
//   return data;
// }
}
