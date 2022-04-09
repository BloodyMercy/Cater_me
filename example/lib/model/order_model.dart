

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
  int orderStatusid=0;
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

  OrderModel.fromJson(Map<String, dynamic> json,String a) {
    id = json['id']??0;
    profileId = json['profileId']??0;
    addressId = json['addressId']??0;
    addressTitle = json['addressTitle']??"not found";
    country = json['country']??"not found";
    street = json['street']??"not found";
    buildingName = json['buildingName']??"not found";
    floorNumber = json['floorNumber']??0;
    total = json['total'].toDouble()??0.0;
    orderStatusid=json["orderStatusId"]??0;
    if(a=="ar"){
      orderStatus = json['orderStatusAR']??"غير معروف";
    }else
    orderStatus = json['orderStatus']??"not found";
    eventType = json['eventType']??"not found";
    eventDate = json['eventDate']??"not found";
    eventName = json['eventName']??"not found";

    numberOfGuests = json['numberOfGuests']??"not found";

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