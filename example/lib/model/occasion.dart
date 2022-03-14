class Occasion {
  int id=0;
  String type="";
  String date="";
  String name="";
  String image="";

 bool yearly;

  Occasion();

Occasion.fromJson(Map<String, dynamic> json,String a) {
  id = json['id']??0;

  date = json['date']??"not found";
  name = json['title']??"not found";
  if(a=="ar"){
    type = json['typeAR'].toString()??"غير معروف";
  }else
  type = json['type']??"not found";
  image = json['image']??"not found";
}
  Occasion.fromJsonadd(Map<String, dynamic> json,String a) {
    id = json['id']??0;
    date = json['date']??"not found";
    name = json['title']??"not found";
    if(a=="ar"){
      type = json['typeAR'].toString()??"غير معروف";
    }else
    type = json['type'].toString()??"not found";
    image = json['image']??"not found";
  }
}
