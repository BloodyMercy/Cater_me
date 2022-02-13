class Occassion {
  bool hasReminder=false;
  String name='';
  int profileId=0;
  String title='';
  int typeId=0;
  int type=0;
  String date='';

  Occassion(
      this.hasReminder, this.profileId, this.title, this.typeId, this.date,this.name,this.type);

  Occassion.fromJson(Map<String, dynamic> json) {
    hasReminder = json['hasReminder']??false;
    profileId = json['profileId']??"not found";
    title = json['title']??"not found";
    typeId = json['typeId']??0;
    type = json['type']??0;
    date = json['date']??'not found';
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['hasReminder'] = this.hasReminder;
  //   data['profileId'] = this.profileId;
  //   data['title'] = this.title;
  //   data['typeId'] = this.typeId;
  //   data['date'] = this.date;
  //   return data;
  // }
}