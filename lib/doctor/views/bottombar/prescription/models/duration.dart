class DurationModel {
  int? durationID;
  int? memberID;
  String? details;
  String? createOn;

  DurationModel({this.durationID, this.memberID, this.details, this.createOn});

  DurationModel.fromJson(Map<String, dynamic> json) {
    durationID = json['durationID'];
    memberID = json['memberID'];
    details = json['details'];
    createOn = json['createOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['durationID'] = this.durationID;
    data['memberID'] = this.memberID;
    data['details'] = this.details;
    data['createOn'] = this.createOn;
    return data;
  }
}
