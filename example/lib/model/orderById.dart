// class OrderByIdModel {
//   String item="";
//   int quantity;
//   int itemPrice=0;
//   String date ="";
//   int totalItemPrice=0;
//   int finalPrice=0;
//   int total=0;
//   bool isDaberni=false;
//
//   OrderByIdModel(
//   {item,
//       this.quantity,
//       itemPrice,
//       date,
//       totalItemPrice,
//       finalPrice,
//       total,
//       isDaberni});
//
//   OrderByIdModel.fromJson(Map<String, dynamic> json) {
//     item = json['item'];
//     quantity = json['quantity'];
//     itemPrice = json['itemPrice'];
//     date = json['date'];
//     totalItemPrice = json['totalItemPrice'];
//     finalPrice = json['finalPrice'];
//     total = json['total'];
//     isDaberni = json['isDaberni'];
//   }
// }

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

  OrderItems({this.item, this.quantity, this.price, this.total});

  OrderItems.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    quantity = json['quantity'];
    price = json['price'].toDouble();
    total = json['total'].toDouble();
  }
}

class Event {
  String eventName;
  String eventDate;
  int eventTypeId;
  String numberOfGuests;

  Event(
      {this.eventName,
        this.eventDate,
        this.eventTypeId,
        this.numberOfGuests});

  Event.fromJson(Map<String, dynamic> json) {
    eventName = json['eventName'];
    eventDate = json['eventDate'];
    eventTypeId = json['eventTypeId'];
    numberOfGuests = json['numberOfGuests'];
  }
}

class PaymentFriend {
  int friendId;
  double amount;
  String image;
  String email;
  String phoneNumber;

  PaymentFriend(
      {this.friendId, this.amount, this.image, this.email, this.phoneNumber});

  PaymentFriend.fromJson(Map<String, dynamic> json) {
    friendId = json['friendId'];
    amount = json['amount'].toDouble();
    image = json['image'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }
}