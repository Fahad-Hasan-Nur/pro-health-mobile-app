class CaseExchangeModel {
  late int doctorID;
  late int memberID;
  late String doctorName;
  late String eduQualificationID;
  String? profilePicture;
  String? heading;
  String? description;
  bool? isSave;
  String? caseType;
  late String dateTime;
  late int caseExchangeId;
  int? specialityID;
  int? saveByMemberID;

  CaseExchangeModel(
      {required this.doctorID,
      required this.memberID,
      required this.doctorName,
      required this.eduQualificationID,
      required this.profilePicture,
      required this.heading,
      required this.description,
      required this.isSave,
      required this.caseType,
      required this.dateTime,
      required this.caseExchangeId,
      required this.specialityID,
      required this.saveByMemberID});

  CaseExchangeModel.fromJson(Map<String, dynamic> json) {
    doctorID = json['doctorID'];
    memberID = json['memberID'];
    doctorName = json['doctorName'];
    eduQualificationID = json['eduQualificationID'];
    profilePicture = json['profilePicture'];
    heading = json['heading'];
    description = json['description'];
    isSave = json['isSave'];
    caseType = json['caseType'];
    dateTime = json['dateTime'];
    caseExchangeId = json['caseExchangeId'];
    specialityID = json['specialityID'];
    saveByMemberID = json['saveByMemberID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorID'] = this.doctorID;
    data['memberID'] = this.memberID;
    data['doctorName'] = this.doctorName;
    data['eduQualificationID'] = this.eduQualificationID;
    data['profilePicture'] = this.profilePicture;
    data['heading'] = this.heading;
    data['description'] = this.description;
    data['isSave'] = this.isSave;
    data['caseType'] = this.caseType;
    data['dateTime'] = this.dateTime;
    data['caseExchangeId'] = this.caseExchangeId;
    data['specialityID'] = this.specialityID;
    data['saveByMemberID'] = this.saveByMemberID;
    return data;
  }
}
