import 'package:CaterMe/Services/credit_card_service.dart';
import 'package:CaterMe/model/credit_card_model.dart';
import 'package:flutter/cupertino.dart';

class CreditCardsProvider extends ChangeNotifier{
  CreditCardsService _creditCardsService=CreditCardsService();
  List<CreditCardsModel> _list=[];
  bool _loading=false;
  int _valueIndex=-1;
  String _type = '';

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  int get valueIndex => _valueIndex;

  set valueIndex(int value) {
    _valueIndex = value;
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
  }

  List<CreditCardsModel> get list => _list;

  set list(List<CreditCardsModel> value) {
    _list = value;
  }

  getAllCards()async{
    _list = await _creditCardsService.getAllCreditCards();
    notifyListeners();
  }
}