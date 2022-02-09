class Food {
  String category;
  String name;
   double price;
   String image;
  String description;
   bool favorite;

  Food(
      { this.category,
       this.name,
       this.price,
     this.image,
       this.description,
      this.favorite,
     String cuisine});
  // Food.fromJson(Map<String, dynamic> json) {
  //   category = json['type'];
  //   name = json['name'];
  //   price = json['price'];
  //   image = json['image'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['type'] = category;
  //   data['name'] = name;
  //   data['price'] = price;
  //   data['image'] = image;
  //   return data;
  // }
}
