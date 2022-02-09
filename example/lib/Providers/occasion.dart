import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Services/occasion.dart';
import 'package:CaterMe/model/occasion.dart';
import 'package:CaterMe/model/occasions/occasion.dart';
import 'package:CaterMe/model/occasions/occasiontype.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class OccasionProvider extends ChangeNotifier {
  OccasionService _occasionService = OccasionService();

  List<Occassion> _listoccasion = [];
  List<OccassionType> _listoccasiontype = [];
  List<String> _listoccasiontypename = [];
Occasion _occasioncreated=Occasion();

  List<String> get listoccasiontypename => _listoccasiontypename;

  set listoccasiontypename(List<String> value) {
    _listoccasiontypename = value;
  }

  List<OccassionType> get listoccasiontype => _listoccasiontype;

  set listoccasiontype(List<OccassionType> value) {
    _listoccasiontype = value;
  }

  Occasion get occasioncreated => _occasioncreated;

  set occasioncreated(Occasion value) {
    _occasioncreated = value;
  }

  set listoccasion(List<Occassion> value) {
    _listoccasion = value;
  }

  List<Occassion> get listoccasion => _listoccasion;


  TextEditingController nameofoccasioncontroller = TextEditingController();
  TextEditingController typeofoccasioncontroller = TextEditingController();
  TextEditingController datechosencontroller = TextEditingController();
  bool _yearlureminder=false;

  bool get yearlureminder => _yearlureminder;

  set yearlureminder(bool value) {
    _yearlureminder = value;
  }

  Future<bool> createOccasions(BuildContext context) async {
    final package=Provider.of<PackagesProvider>(context,listen:false);
    _occasioncreated = await _occasionService.createOccasion(
        hasReminder: _yearlureminder,
        name: nameofoccasioncontroller.text,
        typeId: int.parse(typeofoccasioncontroller.text),
        date: datechosencontroller.text,
    );
    if(_occasioncreated.id==0)
      return false;
      else {
      List<Occasion> l = package.alloccasions;
      l.add(_occasioncreated);
      package.alloccasions = l;
      package.notifyListeners();
      notifyListeners();
      return true;
    }
  }

  getAllOccasionType() async {
    _listoccasiontype = await _occasionService.getAllOcasionType();
    List<String> listname=[];
   for(int i=0;i<_listoccasiontype.length;i++){
      listname.add(_listoccasiontype[i].name);
   }
    _listoccasiontypename=listname;
    notifyListeners();
  }

  cleardata(){
    _yearlureminder=false;
   nameofoccasioncontroller.text="";
   typeofoccasioncontroller.text="";
     datechosencontroller.text="";
  }
}
