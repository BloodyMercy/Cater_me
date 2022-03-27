import 'package:CaterMe/Services/GalleryService.dart';
import 'package:CaterMe/model/GaleryModel.dart';
import 'package:flutter/cupertino.dart';

class GalleryProvider with ChangeNotifier{
  GalleryService _service =GalleryService() ;
  List<GalleryModel> _homepage =[];
  List<GalleryModel> _seeall =[];
  bool _loading =false;
  GalleryProvider.getdata(){
    // gethomepage();
  }
  List<GalleryModel> get seeall => _seeall;

  List<GalleryModel> get homepage => _homepage;

  bool get loading => _loading;
  gethomepage() async {
   // _homepage=await _service.getimageshomepage();
    _loading=true;
    notifyListeners();
  }
  getseeall() async {
    _loading=false;
    _seeall =await _service.getimageseeall();
    _loading=true;
    notifyListeners();
  }
}