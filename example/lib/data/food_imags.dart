class Ads {
  String imgUrl;
  String price;
  String description;
  String id;

  Ads(this.imgUrl, this.description, this.price, this.id);
  static List<Ads> generateAds() {
    return [
      Ads(
          'images/food4.png',
          "This event will occur at the castle black are sure are!!!",
          '\$1500',
          'N1'),
      Ads(
          'images/food3.png',
          "This Time Everything  castle black are you r night we sure are!!!",
          '\$1500',
          'N2'),
      Ads(
          'images/food2.png',
          "This Time Everything will  a spectacular night we sure are!!!",
          '\$1500',
          'N3'),
      Ads(
          'images/food1.png',
          "This Time Everything will change for a spectacular night we sure are!!!",
          '\$1500',
          'N4'),
    ];
  }
}
