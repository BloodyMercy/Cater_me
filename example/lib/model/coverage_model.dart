class CoverageAddressModel {
  bool isInCoverage=false;
  String message="";

  CoverageAddressModel();

  CoverageAddressModel.fromJson(Map<String, dynamic> json,String a) {
    isInCoverage = json['isInCoverage'];
    if(a=="ar"){
      message = json['messageAr']??"غير معروف";
    }else{
      message = json['message']??"Not found";
    }
  }
}