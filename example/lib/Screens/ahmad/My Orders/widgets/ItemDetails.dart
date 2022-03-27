class ItemsOrderedDetails {
  final int id, quantity;
  final String name,size,color;
  final List<String> images;
  final double price;

  ItemsOrderedDetails({
    this.id,
    this.images,
    this.name,
    this.price,
    this.size,
    this.color,
    this.quantity
  });
}

List<ItemsOrderedDetails> Items = [
  ItemsOrderedDetails(
    id: 1,
    images: [
      "assets/images/image-shirt.png",
    ],
    name: "Butiqueta Sweater - Limited Edition SS22 COLLECTION",
    price: 1250.00,
    size: "US 10",
    color: "Dark Teal",
    quantity: 1
  ),
  ItemsOrderedDetails(
    id: 2,
    images: [
      "assets/images/whiteShirt.png",
    ],
    name: "Butiqueta Sweater - Limited Edition SS22 COLLECTION",
    price: 1250.00,
    size: "US 10",
    color: "Dark Teal",
    quantity: 1
  ),
  ItemsOrderedDetails(
      id: 3,
      images: [
        "assets/images/handbag.png",
      ],
      name: "Butiqueta Sweater - Limited Edition SS22 COLLECTION",
      price: 1250.00,
      size: "US 10",
      color: "Dark Teal",
      quantity: 2
  ),
  ItemsOrderedDetails(
      id: 4,
      images: [
        "assets/images/image_watch.png",
      ],
      name: "Butiqueta Sweater - Limited Edition SS22 COLLECTION",
      price: 1250.00,
      size: "US 10",
      color: "Dark Teal",
      quantity: 2
  ),

];


