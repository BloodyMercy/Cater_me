import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Services/occasion.dart';
import 'package:CaterMe/model/occasion.dart';
import 'package:CaterMe/model/occasions/occasion.dart';
import 'package:CaterMe/model/occasions/occasiontype.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


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





  OccasionService get occasionService => _occasionService;

  set occasionService(OccasionService value) {
    _occasionService = value;
  }




  List<Occasion> _today=[];
  List<Occasion> get today => _today;

  set today(List<Occasion> value) {
    _today = value;
  }
  List<Occasion> _thisWeek=[];
  List<Occasion> get thisWeek => _thisWeek;

  set thisWeek(List<Occasion> value) {
    _thisWeek = value;
  }

  List<Occasion> _all=[];
  List<Occasion> get all => _all;

  set all(List<Occasion> value) {
    _all = value;
  }
  Map<String, dynamic> _alldata={};


  Map<String, dynamic> get alldata => _alldata;

  set alldata(Map<String, dynamic> value) {
    _alldata = value;
  }

  TextEditingController nameofoccasioncontroller = TextEditingController();
  TextEditingController typeofoccasioncontroller = TextEditingController();
  TextEditingController typeofoccasioncontrollername = TextEditingController();
  TextEditingController datechosencontroller = TextEditingController();
  bool _yearlureminder=false;

  bool get yearlureminder => _yearlureminder;

  set yearlureminder(bool value) {
    _yearlureminder = value;
  }

  Future<bool> createOccasions(BuildContext context) async {
    final package=Provider.of<PackagesProvider>(context,listen:false);
    final occa=Provider.of<OccasionProvider>(context,listen:false);
    _occasioncreated = await _occasionService.createOccasion(
        // hasReminder: _yearlureminder,
        name: nameofoccasioncontroller.text,
        typeId: int.parse(typeofoccasioncontroller.text),
        date: datechosencontroller.text,
    );
    if(_occasioncreated.id==0)
      return false;
      else {
      nameofoccasioncontroller.text="";
typeofoccasioncontroller.text="";
    datechosencontroller.text="";
      List<Occasion> l = occa.all;
         // package.alloccasions;
      l.add(_occasioncreated);
      // package.alloccasions = l;
      // package.notifyListeners();
      occa.all=l;
      occa.notifyListeners();
      notifyListeners();
      return true;
    }
  }

  getAllOccasionType(String a) async {
    _listoccasiontype = await _occasionService.getAllOcasionType(a);
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


bool loading=false;
  Future<void>  getallnewoccasion()async {
    loading=false;
//notifyListeners();
    _alldata=await OccasionService.getallnewoccasions();
    if(_alldata.length==0){
print("not data");
    }

    else {
      print("rifaiiiii");
      print(_alldata['all']);
     // _today = List<Occasion>.from(_alldata['today'].map((model) => Occasion.fromJsonadd(model)));
     // _thisWeek = List<Occasion>.from(_alldata['thisWeek'].map((model) => Occasion.fromJsonadd(model)));
      _all = List<Occasion>.from(_alldata['all'].map((model) => Occasion.fromJsonadd(model)));



    }

    loading=true;
    notifyListeners();
  }

deleteoccation(Occasion occ) async {
 await  _occasionService.deleteOcation(occ.id);
 all.remove(occ);
 notifyListeners();
}
updateoccation({int idss }) async {
  datechosencontroller.text=datechosencontroller.text.replaceAll(RegExp('[^A-Za-z0-9]'), '-');
    return await _occasionService.update(id:idss ,       name: nameofoccasioncontroller.text,
  typeId: int.parse(typeofoccasioncontroller.text),
  date: datechosencontroller.text,);
}
}
