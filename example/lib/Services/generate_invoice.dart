// import 'dart:convert';
//
// import 'package:CaterMe/Services/ApiLink.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// class GenerateInvoice {
//   Future<String> generateInvoicepdf(int id)async {
//     try{
//       SharedPreferences prefs=await SharedPreferences.getInstance();
//       var headers={'Authorization': 'Bearer ${prefs.getString("token")}'};
//       var request=http.Request('GET',Uri.parse(ApiLink.GenerateInvoice+"/$id"));
//       request.headers.addAll(headers);
//       http.StreamedResponse responses =await request.send();
//       var response = await http.Response.fromStream(responses);
//       if (response.statusCode == 200) {
//         String responseData = json.decode(response.body);
//       // String link = responseData[];
//         return responseData??'Not found';
//       } else {
//         print(response.reasonPhrase);
//         return "";
//       }
//     } catch (e) {
//       return "";
//     }
//   }
// }