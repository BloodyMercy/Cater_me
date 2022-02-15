import 'package:CaterMe/model/occasion.dart';
import 'package:CaterMe/model/packages.dart';
import 'package:CaterMe/widgets/Packages/package_card.dart';
import 'package:CaterMe/widgets/fake_data.dart';
import 'package:CaterMe/widgets/my_favorites_card.dart';
import 'package:CaterMe/widgets/occasions/occasions_card.dart';
import 'package:flutter/material.dart';

List<OccasionsCard> getOccasions(List<Occasion> occasion) {

  var list = occasion;
  for (final item in list) {
    occasion.sort((a, b) {
      return (a.date).compareTo(b.date);
    });
  }
  var result = list.map((e) => OccasionsCard(e)).toList();
  return result;
}

List<Occasion> getOccasionsToday(List<Occasion> occasion) {
  var list = occasion;
  for (final item in list) {
    occasion.sort((a, b) {
      return (a.date).compareTo(b.date);
    });
  }
  return list;
}

List<PackageCard> getPackages() {
  var list = [];
  var result = list.map((e) => PackageCard(e)).toList();
  return result;
}

List<MyFavoritesCard> getFavorites(List<Package> l) {
  var list = l;
  //var ll=list.where((element) => element.isfavorite);
  var result = list.map((e) => MyFavoritesCard(food: e,))
      .toList();
  return result;
}

List<Widget> getFavoritesImages() {
  var list = Fake_Data;
  var result = list.map((e) => Image.asset(e.image)).toList();
  return result;
}
