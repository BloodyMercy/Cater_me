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

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    addressId = json['addressId'];
    serviceId = json['serviceId'];
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems.add(new OrderItems.fromJson(v));
      });
    }
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
    if (json['paymentFriend'] != null) {
      paymentFriend = <PaymentFriend>[];
      json['paymentFriend'].forEach((v) {
        paymentFriend.add(new PaymentFriend.fromJson(v));
      });
    }
    subTotal = json['subTotal'].toDouble();
    total = json['total'].toDouble();
    tax = json['tax'].toDouble();
    isDonated = json['isDonated'];
  }
}

class OrderItems {
  String item;
  int quantity;
  double price;
  double total;
  double tax;

  OrderItems({this.item, this.quantity, this.price, this.total, this.tax});

  OrderItems.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    quantity = json['quantity'];
    price = json['price'].toDouble();
    total = json['total'].toDouble();
    tax = json['tax'].toDouble();
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
    eventType = json['eventType'];
    eventName = json['eventName'];
    eventDate = json['eventDate'];
    eventTypeId = json['eventTypeId'];
    numberOfGuests = json['numberOfGuests'];
    contactPhoneNumber = json['contactPhoneNumber'];
    contactName = json['contactName'];
  }
}

class PaymentFriend {
  int friendId;
  String name;
  double amount;
  String image;
  String email;
  String phoneNumber;

  PaymentFriend(
      {this.friendId,
        this.name,
        this.amount,
        this.image,
        this.email,
        this.phoneNumber});

  PaymentFriend.fromJson(Map<String, dynamic> json) {
    friendId = json['friendId'];
    name = json['name'];
    amount = json['amount'].toDouble();
    image = json['image'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }
}