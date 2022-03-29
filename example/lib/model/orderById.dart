class OrderDetailsModel {
  int addressId;
  int serviceId;
  List<OrderItems> orderItems;
  Event event;
  List<PaymentFriend> paymentFriend;
  double subTotal;
  double total;
  double tax;
  bool isDonated;

  OrderDetailsModel(
      {this.addressId,
      this.serviceId,
      this.orderItems,
      this.event,
      this.paymentFriend,
      this.subTotal,
      this.total,
      this.tax,
      this.isDonated});

  OrderDetailsModel.fromJson(Map<String, dynamic> json, String a) {
    addressId = json['addressId'] ?? 0;
    serviceId = json['serviceId'] ?? 0;
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems.add(new OrderItems.fromJson(v, a));
      });
    }
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
    if (json['paymentFriend'] != null) {
      paymentFriend = <PaymentFriend>[];
      json['paymentFriend'].forEach((v) {
        paymentFriend.add(new PaymentFriend.fromJson(v,a));
      });
    }
    subTotal = json['subTotal'].toDouble() ?? 0.0;
    total = json['total'].toDouble() ?? 0.0;
    tax = json['tax'].toDouble() ?? 0.0;
    isDonated = json['isDonated'] ?? false;
  }
}

class OrderItems {
  String item;
  int quantity;
  double price;
  double total;
  double tax;
  String image;

  OrderItems({this.item, this.quantity, this.price, this.total, this.tax});

  OrderItems.fromJson(Map<String, dynamic> json, String a) {
    if (a == "ar") {
      item = json['itemAR'] ?? "غير معروف";
      image = json["imageAR"] ?? "";
    } else {
      item = json['item'] ?? "not found";
      image = json["image"] ?? "";
    }
    quantity = json['quantity'] ?? 0;
    price = json['price'].toDouble() ?? 0.0;
    total = json['total'].toDouble() ?? 0.0;
    tax = json['tax'].toDouble() ?? 0.0;
  }
}

class Event {
  String eventType;
  String eventName;
  String eventDate;
  int eventTypeId;
  String numberOfGuests;
  String contactPhoneNumber;
  String contactName;

  Event(
      {this.eventType,
      this.eventName,
      this.eventDate,
      this.eventTypeId,
      this.numberOfGuests,
      this.contactPhoneNumber,
      this.contactName});

  Event.fromJson(Map<String, dynamic> json) {
    eventType = json['eventType'] ?? "not found";
    eventName = json['eventName'] ?? "not found";
    eventDate = json['eventDate'] ?? "not found";
    eventTypeId = json['eventTypeId'] ?? 0;
    numberOfGuests = json['numberOfGuests'] ?? "not found";
    contactPhoneNumber = json['contactPhoneNumber'] ?? "not found";
    contactName = json['contactName'] ?? "not found";
  }
}

class PaymentFriend {
  int friendId;
  String name;
  double amount;
  String image;
  String email;
  String phoneNumber;
  String paymentStatus;
  String paymentStatusAr;
  int paymentStatusId;


  PaymentFriend(
      {this.friendId,
      this.name,
      this.amount,
      this.image,
      this.email,
      this.phoneNumber,
      this.paymentStatus,
      this.paymentStatusId,
      this.paymentStatusAr});

  PaymentFriend.fromJson(Map<String, dynamic> json ,String a) {
    friendId = json['friendId'] ?? 0;
    name = json['name'] ?? "not found";
    amount = json['amount'].toDouble() ?? 0.0;
    image = json['image'] ?? "not found";
    email = json['email'] ?? "not found";
    phoneNumber = json['phoneNumber'] ?? "not found";
    if(a=="ar"){
      paymentStatus=json['paymentStatusAr']??"غير معروف";
    }else
    paymentStatus = json['paymentStatus'] ?? "not found";
    paymentStatusId = json['paymentStatusId']??0;
  }
}
