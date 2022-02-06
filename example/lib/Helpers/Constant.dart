




import 'package:CaterMe/Services/ApiLink.dart';
import 'package:CaterMe/model/RestCallAPi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
Future<bool> checkserver() async {



ErrorMessage em=new ErrorMessage();
em.response=true;
try {

  SharedPreferences prefs = await SharedPreferences.getInstance();

if(prefs.getString("token")==null){
 // em.response;
  return true;
}

  var headers = {
    'Authorization': 'Bearer ${prefs.getString("token")}'   };
  var request = http.Request('GET', Uri.parse(ApiLink.GetPackages));

  request.headers.addAll(headers);

  http.StreamedResponse responses = await request.send();
  var response = await http.Response.fromStream(responses);
  if (response.statusCode == 200) {

   return false;
  }
  else {
    print(response.reasonPhrase);
    em.response=false;
    return true;
  }



}catch(e){
em.response=false;
  return false;
}

}


final Future<bool> checkservers=checkserver();