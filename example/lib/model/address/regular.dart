class Regular {
  int percentageOfDaberni=0;
  int hoursOfDaberni=0;
  int tax=0;
  List<NumberOfGuests> numberOfGuests=[];
  List<Events> events=[];

  Regular(
     );

  Regular.fromJson(Map<String, dynamic> json,String a) {
   // percentageOfDaberni = json['percentageOfDaberni'];
    hoursOfDaberni = json['hoursOfDaberni']??0;
    tax = json['tax']==null?0:json['tax']??0;
    if (json['numberOfGuests'] != null) {
      numberOfGuests = <NumberOfGuests>[];
      json['numberOfGuests'].forEach((v) {
        numberOfGuests.add(new NumberOfGuests.fromJson(v,a));
      });
    }
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events.add(new Events.fromJson(v,a));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['percentageOfDaberni'] = this.percentageOfDaberni;
    data['hoursOfDaberni'] = this.hoursOfDaberni;
    data['tax'] = this.tax;
    if (this.numberOfGuests != null) {
      data['numberOfGuests'] =
          this.numberOfGuests.map((v) => v.toJson()).toList();
    }
    if (this.events != null) {
      data['events'] = this.events.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NumberOfGuests {
  int id;
  String title;

  NumberOfGuests({this.id, this.title});

  NumberOfGuests.fromJson(Map<String, dynamic> json,String a) {
    id = json['id']??0;
    if(a=="ar"){
      title = json['titleAR']??"غير معروف";
    }else

    title = json['title']??"not found";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

class Events {
  int id;
  String name;

  Events({this.id, this.name});

  Events.fromJson(Map<String, dynamic> json,String a) {
    id = json['id']??0;
    if(a=="ar"){
      name = json['nameAR']??'غير معروف';
    }else
    name = json['name']??'not found';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}