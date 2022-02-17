import 'package:CaterMe/Services/credit_card_service.dart';
import 'package:CaterMe/model/RestCallAPi.dart';
import 'package:CaterMe/model/credit_card_model.dart';
import 'package:flutter/cupertino.dart';

class CreditCardsProvider extends ChangeNotifier{
  CreditCardsService _creditCardsService=CreditCardsService();
  List<CreditCardsModel> _list=[];
  CreditCardsModel _credit=CreditCardsModel();

  CreditCardsModel get credit => _credit;

  set credit(CreditCardsModel value) {
    _credit = value;
  }

  bool _loading=false;
  int _valueIndex=-1;
  bool _loadingDelete=false;
int _value=-1;


  CreditCardsService get creditCardsService => _creditCardsService;

  set creditCardsService(CreditCardsService value) {
    _creditCardsService = value;
  }

  bool get loadingDelete => _loadingDelete;

  set loadingDelete(bool value) {
    _loadingDelete = value;
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

 Future<String> deleteCard(int id)async{
   ErrorMessage em= await _creditCardsService.deleteCreditCard(id);
   if(em.message=="deleted"){
     list.removeAt(valueIndex);
   }
   notifyListeners();
   return em.message;
  }

  int get value => _value;

  set value(int value) {
    _value = value;
  }
}