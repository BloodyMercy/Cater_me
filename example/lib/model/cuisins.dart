

class Cuisins {
   String name="";

   String image="";
int id=0;
  Cuisins(
      { this.name,
       this.id,
      this.image});
  // AddOn.fromJson(Map<String, dynamic> json) {
  //   category = json['type'];
  //   name = json['name'];
  //   price=json['price'];
  //   image=json['image'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['type'] = this.category;
  //   data['name'] = this.name;
  //   data['price'] = this.price;
  //   data['image'] = this.image;
  //   return data;
  // }

  Cuisins.fromJson(Map<String, dynamic> json,a) {
    id = json['id']??0;
    if(a=="ar") {
      name = json['nameAR'] ?? 'not found';
      image = json['imageAR'] ?? 'not found';
    }else
      {
        name = json['name'] ?? 'not found';
        image = json['image'] ?? 'not found';
      }
  }
}
