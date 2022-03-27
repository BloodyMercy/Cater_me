class LanguageModel {
  Map<String,Map<String,String>> lg={};

  Map<String,String> en={};
  Map<String,String> ar={};

  LanguageModel();

  LanguageModel.fromJson(Map<String, dynamic> json) {

    if (json['en'] != null) {
      json['en'].forEach((v) {
        en[v['key']]=v['title'];
      });
    }
    if (json['ar'] != null) {



     json['ar'].forEach((v) {
       ar[v['key']]=v['title'];
      });

    }
    lg["en"] = en;
    lg["ar"]= ar;
  }
}

