class LanguageModel {
  Map<String,Map<String,String>> lg={};

  Map<String,String> en;
  Map<String,String> ar;

  LanguageModel();

  LanguageModel.fromJson(Map<String, dynamic> json) {

    if (json['en'] != null) {
      lg['en'] = json['en'].forEach((v) {
        en.putIfAbsent(v['key'],v['title']);

      });
    }
    if (json['ar'] != null) {
      lg['ar']  = json['ar'].forEach((v) {
        ar.putIfAbsent(v['key'],v['title']);
      });
    }
  }
}

