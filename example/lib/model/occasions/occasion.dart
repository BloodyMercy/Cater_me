class Occassion {
  bool hasReminder=false;
  String name='';
  int profileId=0;
  String title='';
  int typeId=0;
  String date='';

  Occassion(
      this.hasReminder, this.profileId, this.title, this.typeId, this.date,this.name);

  Occassion.fromJson(Map<String, dynamic> json) {
    hasReminder = json['hasReminder'];
    profileId = json['profileId'];
    title = json['title'];
    typeId = json['typeId'];
    date = json['date'];
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