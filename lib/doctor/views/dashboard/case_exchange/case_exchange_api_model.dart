class CasePostApiModel {
  int? caseExchangeId;
  int? doctorId;
  int? memberID;
  int? specialityID;
  String? caseType;
  String? dateTime;
  String? heading;
  String? description;
  bool? isSave;
  int? saveByMemberID;

  CasePostApiModel(
      {this.caseExchangeId,
      this.doctorId,
      this.memberID,
      this.specialityID,
      this.caseType,
      this.dateTime,
      this.heading,
      this.description,
      this.isSave,
      this.saveByMemberID});

  CasePostApiModel.fromJson(Map<String, dynamic> json) {
    caseExchangeId = json['caseExchangeId'];
    doctorId = json['doctorId'];
    memberID = json['memberID'];
    specialityID = json['specialityID'];
    caseType = json['caseType'];
    dateTime = json['dateTime'];
    heading = json['heading'];
    description = json['description'];
    isSave = json['isSave'];
    saveByMemberID = json['saveByMemberID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caseExchangeId'] = this.caseExchangeId;
    data['doctorId'] = this.doctorId;
    data['memberID'] = this.memberID;
    data['specialityID'] = this.specialityID;
    data['caseType'] = this.caseType;
    data['dateTime'] = this.dateTime;
    data['heading'] = this.heading;
    data['description'] = this.description;
    data['isSave'] = this.isSave;
    data['saveByMemberID'] = this.saveByMemberID;
    return data;
  }
}
