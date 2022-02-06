import 'dart:convert';

import 'package:CaterMe/model/add_on.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

final String url =
    "https://api.mockaroo.com/api/a17da350?count=30&key=61346b40";

List<AddOn> parseAddOn(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var addOn = list.map((e) => AddOn.fromJson(e)).toList();
  return addOn;
}

Future<List<AddOn>> fetchAddOns() async {
  final http.Response response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return compute(parseAddOn, response.body);
  } else {
    throw Exception(response.statusCode);
  }
}
