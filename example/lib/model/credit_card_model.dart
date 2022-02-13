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
    id = json['id']??0;
    cardId = json['cardId']??"not found";
    expiryDate = json['expiryDate']??"not found";
    ownerName = json['ownerName']??"not found";
    cardNumber = json['cardNumber']??"not found";
    type = json['type']??"not found";
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