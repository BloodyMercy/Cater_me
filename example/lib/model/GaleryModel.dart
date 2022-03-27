class GalleryModel{
  String _link = "";

  String get link => _link;

  set link(String value) {
    _link = value;
  }

  GalleryModel.fromJson(Map<String, dynamic> json){
    _link= json["image"]??"";
  }
}