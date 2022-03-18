class setupItemsModel {
int id= 0;
String title="";
String titleAR= "";

setupItemsModel();
setupItemsModel.fromJson(Map<String, dynamic> json,String a) {
  id = json['id'] ?? 0;
  if (a=="ar"){titleAR = json['titleAR'] ?? 'غير معروف';}
  else{
  title = json['title'] ?? 'not found';}

}
}


