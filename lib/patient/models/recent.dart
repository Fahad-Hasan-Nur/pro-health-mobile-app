class RecentModel {
  int? recentID;
  int? doctorID;
  int? patientID;
  String? createOn;
  String? doctorName;
  String? workingPlace;
  String? profilePicture;
  String? designationOne;
  String? designationTwo;
  String? qualificationOne;
  String? qualificationTwo;
  int? memberID;

  RecentModel(
      {this.recentID,
      this.doctorID,
      this.patientID,
      this.createOn,
      this.doctorName,
      this.workingPlace,
      this.profilePicture,
      this.designationOne,
      this.designationTwo,
      this.qualificationOne,
      this.qualificationTwo,
      this.memberID});

  RecentModel.fromJson(Map<String, dynamic> json) {
    recentID = json['recentID'];
    doctorID = json['doctorID'];
    patientID = json['patientID'];
    createOn = json['createOn'];
    doctorName = json['doctorName'];
    workingPlace = json['workingPlace'];
    profilePicture = json['profilePicture'];
    designationOne = json['designationOne'];
    designationTwo = json['designationTwo'];
    qualificationOne = json['qualificationOne'];
    qualificationTwo = json['qualificationTwo'];
    memberID = json['memberID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recentID'] = this.recentID;
    data['doctorID'] = this.doctorID;
    data['patientID'] = this.patientID;
    data['createOn'] = this.createOn;
    data['doctorName'] = this.doctorName;
    data['workingPlace'] = this.workingPlace;
    data['profilePicture'] = this.profilePicture;
    data['designationOne'] = this.designationOne;
    data['designationTwo'] = this.designationTwo;
    data['qualificationOne'] = this.qualificationOne;
    data['qualificationTwo'] = this.qualificationTwo;
    data['memberID'] = this.memberID;
    return data;
  }
}
