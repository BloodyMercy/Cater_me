class CreditCardsModel {
  int id=0;
  String cardId="";
  String expiryDate="";
  String ownerName="";
  String cardNumber="";
  String type="";

  CreditCardsModel(
   );

  CreditCardsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardId = json['cardId'];
    expiryDate = json['expiryDate'];
    ownerName = json['ownerName'];
    cardNumber = json['cardNumber'];
    type = json['type'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['cardId'] = this.cardId;
  //   data['expiryDate'] = this.expiryDate;
  //   data['ownerName'] = this.ownerName;
  //   data['cardNumber'] = this.cardNumber;
  //   data['type'] = this.type;
  //   return data;
  // }
}