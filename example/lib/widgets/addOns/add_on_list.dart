import 'package:CaterMe/Screens/AddonsCard.dart';
import 'package:CaterMe/model/add_on.dart';
import 'package:CaterMe/model/addons/addonsall.dart';
import 'package:CaterMe/model/cuisins.dart';
import 'package:CaterMe/widgets/Menu/menus_cards.dart';
import 'package:CaterMe/widgets/addOns/add_on_card_order.dart';

import 'package:CaterMe/widgets/addOns/add_on_cards.dart';

import 'package:CaterMe/widgets/Cuisins/cuisins_card.dart';


import 'add_ons_card.dart';

List<AddOnCards> getAddOns(List<AddOn> on) {
  var list = on;
  var result = list.map((e) => AddOnCards(e)).toList();
  return result;
}

List<AddOnCardOrder> getAddOnOrder(List<AddOn> on) {
  var list = on;
  var result = list.map((e) => AddOnCardOrder(e)).toList();
  return result;
}

List<AddOnsCard> getAddOnsCard(List<Addonall> t) {
  List<AddOnCards> l = [];
  List<AddOnsCard> ll = [];
  AddOnsCard add;

  for (int i = 0; i < t.length; i++) {
    l = getAddOns(t[i].items);
    add = AddOnsCard(
      card: l,
      i: i,
    );
    ll.add(add);
  }
  return ll;
}

List<CuisinsCard> getCuisinsCards(List<dynamic> l)  {
  var list = l;
  int index=0;
  var result = list.map((e) => new CuisinsCard(cuisin:e, index: index++)).toList();
  return result;
}

List<AddonsCard> getAddonsCards(List<dynamic> l)  {
  var list = l;
  int index=0;
  var result = list.map((e) => new AddonsCard(cuisin:e, index: index++)).toList();
  return result;
}



// List<AddOnCards> getSingleAddOns(Add) {
//   var list = addOnss;
//   var result = list.map((e) => AddOnCards(e)).toList();
//   return result;
// }