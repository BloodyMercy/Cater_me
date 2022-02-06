class Food {
  late String category;
  late String name;
  late double price;
  late String image;
  late String description;
  late bool favorite;

  Food(
      {required this.category,
      required this.name,
      required this.price,
      required this.image,
      required this.description,
      required this.favorite,
      required String cuisine});
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
