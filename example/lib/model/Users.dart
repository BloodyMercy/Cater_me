import 'package:flutter/material.dart';

class Users {
  int id=0;
  String uid="";
  String name="";
  String phoneNumber="";
  String imageUrl="";
  String role="";
  String email="";
  int orderListId=0;
  bool isActive=false;
  String gender="";
  String birthDate="";
  String token="";
        Users();





  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    imageUrl = json['imageUrl'];
    role = json['role'];
    email = json['email'];
    orderListId = json['orderListId'];
    isActive = json['isActive'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    token = json['token'];
  }

  Map<String, dynamic> toJson( ) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['imageUrl'] = this.imageUrl;
    data['role'] = this.role;
    data['email'] = this.email;
    data['orderListId'] = this.orderListId;
    data['isActive'] = this.isActive;
    data['gender'] = this.gender;
    data['birthDate'] = this.birthDate;
    data['token'] = this.token;
    return data;
  }
}