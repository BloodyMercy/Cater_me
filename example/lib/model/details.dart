class Details {
  int id;
  String title = '';
  String description = '';

  Details(this.id, this.title, this.description);

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    title = json['title']??"not found";
    description = json['description']??"not found";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
