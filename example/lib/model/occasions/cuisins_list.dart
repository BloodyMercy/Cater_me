import 'package:CaterMe/model/cuisins.dart';
import 'package:CaterMe/model/food.dart';
import 'package:CaterMe/widgets/Cuisins/cuisins_card.dart';

import 'menus_cards.dart';

List<CuisinsCard> getCuisins(List<Cuisins> cuisins) {

  var list = cuisins;
  int index=0;
  var result = list.map((e) => CuisinsCard(cuisin:e, index: index++,)).toList();
  return result;
}

List<MenusCard> getFood(List<Food> food) {
  var list = food;
  int i=0;
  var result = list.map((e) => MenusCard(food:e,index:(i++))).toList();
  return result;
}

List<MenusCard> getMenusCards(List<Food> food) {
  var list = food;
  int i=0;
  var result = list.map((e) => MenusCard(food:e,index:(i++))).toList();
  return result;
}