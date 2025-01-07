class NextVisitModel {
  int? id;
  int? memberID;
  String? details;

  NextVisitModel({this.id, this.memberID, this.details});

  NextVisitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberID = json['memberID'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['memberID'] = this.memberID;
    data['details'] = this.details;
    return data;
  }
}
