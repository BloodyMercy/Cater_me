import 'package:CaterMe/Services/notification_service.dart';
import 'package:CaterMe/model/notification_model.dart';
import 'package:flutter/cupertino.dart';

class NotificationProvider  extends ChangeNotifier{
  NotificationService _notificationService =NotificationService();
  List<notificationModel> _notificationlist = [];
  notificationModel _createnotification=notificationModel();
  List<notificationModel> get notificationlist => _notificationlist;

  set notificationlist(List<notificationModel> value) {
    _notificationlist = value;
  }
  String _title='';
  String _body='';

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  createAllNotifications()async{
    _createnotification =await _notificationService.//radetle l model li zedto
    createNotification(Title: _title, Body: _body);
    _notificationlist.add(_createnotification);//zedra 3l list la tsir updated
    notifyListeners();
  }
  getAllNotifications()async{
    _notificationlist=await _notificationService.getAllNotifications();
    notifyListeners();
  }

  String get body => _body;

  set body(String value) {
    _body = value;
  }
  markAsRead(int id) async{
    await _notificationService.markAsRead(id);
    notifyListeners();
  }
}