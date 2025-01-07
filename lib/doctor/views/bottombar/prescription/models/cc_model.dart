class ChiefComplaintModel {
  int? chiefComplainID;
  int? doctorID;
  int? memberID;
  String? chiefComplainName;

  ChiefComplaintModel(
      {this.chiefComplainID,
      this.doctorID,
      this.memberID,
      this.chiefComplainName});

  ChiefComplaintModel.fromJson(Map<String, dynamic> json) {
    chiefComplainID = json['chiefComplainID'];
    doctorID = json['doctorID'];
    memberID = json['memberID'];
    chiefComplainName = json['chiefComplainName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chiefComplainID'] = this.chiefComplainID;
    data['doctorID'] = this.doctorID;
    data['memberID'] = this.memberID;
    data['chiefComplainName'] = this.chiefComplainName;
    return data;
  }
}
