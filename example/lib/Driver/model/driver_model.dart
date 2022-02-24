class DriverOrderModel {
  List<TodayOrders> todayOrders;
  List<UpcomingOrders> upcomingOrders;

  DriverOrderModel();

  DriverOrderModel.fromJson(Map<String, dynamic> json) {
    if (json['todayOrders'] != null) {
      todayOrders = <TodayOrders>[];
      json['todayOrders'].forEach((v) {
        todayOrders.add(new TodayOrders.fromJson(v));
      });
    }
    if (json['upcomingOrders'] != null) {
      upcomingOrders = <UpcomingOrders>[];
      json['upcomingOrders'].forEach((v) {
        upcomingOrders.add(new UpcomingOrders.fromJson(v));
      });
    }
  }
}

class TodayOrders {
  int id=0;
  int profileId=0;
  int addressId=0;
  String addressTitle="";
  String country="";
  String street="";
  String buildingName="";
  int floorNumber=0;
  double total=0.0;
  String orderStatus="";
  String eventType="";
  String eventDate="";
  String eventName="";
  String numberOfGuests="";

  TodayOrders();

  TodayOrders.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    profileId = json['profileId']??0;
    addressId = json['addressId']??0;
    addressTitle = json['addressTitle']??"not found";
    country = json['country']??"not found";
    street = json['street']??"not found";
    buildingName = json['buildingName']??"not found";
    floorNumber = json['floorNumber']??0;
    total = json['total'].toDouble()??0.0;
    orderStatus = json['orderStatus']??"not found";
    eventType = json['eventType']??"not found";
    eventDate = json['eventDate']??"not found";
    eventName = json['eventName']??"not found";
    numberOfGuests = json['numberOfGuests']??"not found";
  }

}

class UpcomingOrders {
  int id=0;
  int profileId=0;
  int addressId=0;
  String addressTitle="";
  String country="";
  String street="";
  String buildingName="";
  int floorNumber=0;
  double total=0.0;
  String orderStatus="";
  String eventType="";
  String eventDate="";
  String eventName="";
  String numberOfGuests="";

  UpcomingOrders();

  UpcomingOrders.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    profileId = json['profileId']??0;
    addressId = json['addressId']??0;
    addressTitle = json['addressTitle']??"not found";
    country = json['country']??"not found";
    street = json['street']??"not found";
    buildingName = json['buildingName']??"not found";
    floorNumber = json['floorNumber']??0;
    total = json['total'].toDouble()??0.0;
    orderStatus = json['orderStatus']??"not found";
    eventType = json['eventType']??"not found";
    eventDate = json['eventDate']??"not found";
    eventName = json['eventName']??"not found";
    numberOfGuests = json['numberOfGuests']??"not found";
  }


}