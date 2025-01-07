class AdvicesModel {
  int? adviceID;
  int? memberID;
  int? specialityID;
  String? advice;

  AdvicesModel({this.adviceID, this.memberID, this.specialityID, this.advice});

  AdvicesModel.fromJson(Map<String, dynamic> json) {
    adviceID = json['adviceID'];
    memberID = json['memberID'];
    specialityID = json['specialityID'];
    advice = json['advice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adviceID'] = this.adviceID;
    data['memberID'] = this.memberID;
    data['specialityID'] = this.specialityID;
    data['advice'] = this.advice;
    return data;
  }
}
