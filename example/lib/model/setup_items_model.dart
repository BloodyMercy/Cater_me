class setupItemsModel {
int id= 0;
String title="";

setupItemsModel();
setupItemsModel.fromJson(Map<String, dynamic> json,String a) {
  id = json['id'] ?? 0;
  if (a=="ar"){
    title = json['titleAR'] ?? 'غير معروف';}
  else{
  title = json['title'] ?? 'not found';}

}
}


