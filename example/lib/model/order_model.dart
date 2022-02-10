

class OrderModel {
  int id;
  int profileId=0;
  int addressId=0;
  String addressTitle='';
  String country='';
  String street='';
  String buildingName='';
  int floorNumber=0;
  double total=0.0;
  String orderStatus='';
  String eventType='';
  String eventDate="";
  String eventName='';
  String numberOfGuests='';
  // double percentageOfDaberni=0.0;
  // double hoursOfDaberni=0.0;
  // double tax=0.0;

  OrderModel(
  {
    this.id,
        profileId,
        addressId,
        addressTitle,
        country,
        street,
        buildingName,
        floorNumber,
        total,
        orderStatus,
        eventType,
        eventDate,
        eventName,
        numberOfGuests,
        // percentageOfDaberni,
        // hoursOfDaberni,
        // tax
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileId = json['profileId'];
    addressId = json['addressId'];
    addressTitle = json['addressTitle'];
    country = json['country'];
    street = json['street'];
    buildingName = json['buildingName'];
    floorNumber = json['floorNumber'];
    total = json['total'].toDouble();
    orderStatus = json['orderStatus'];
    eventType = json['eventType'];
    eventDate = json['eventDate'];
    eventName = json['eventName'];
    numberOfGuests = json['numberOfGuests'];
    // percentageOfDaberni = json['percentageOfDaberni'];
    // hoursOfDaberni = json['hoursOfDaberni'];
    // tax = json['tax']==null?0.0:json['tax'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['profileId'] = this.profileId;
  //   data['addressId'] = this.addressId;
  //   data['addressTitle'] = this.addressTitle;
  //   data['country'] = this.country;
  //   data['street'] = this.street;
  //   data['buildingName'] = this.buildingName;
  //   data['floorNumber'] = this.floorNumber;
  //   data['total'] = this.total;
  //   data['orderStatus'] = this.orderStatus;
  //   data['eventType'] = this.eventType;
  //   data['isDaberni'] = this.isDaberni;
  //   data['eventDate'] = this.eventDate;
  //   data['eventName'] = this.eventName;
  //   data['numberOfGuests'] = this.numberOfGuests;
  //   data['percentageOfDaberni'] = this.percentageOfDaberni;
  //   data['hoursOfDaberni'] = this.hoursOfDaberni;
  //   data['tax'] = this.tax;
  //   return data;
  // }
}