class FavoriteModel {
  int? favoriteID;
  int? patientID;
  int? doctorID;
  String? createOn;
  String? doctorName;
  String? workingPlace;
  String? profilePicture;
  String? designationOne;
  String? designationTwo;
  String? qualificationOne;
  String? qualificationTwo;
  int? memberID;

  FavoriteModel(
      {this.favoriteID,
      this.patientID,
      this.doctorID,
      this.createOn,
      this.doctorName,
      this.workingPlace,
      this.profilePicture,
      this.designationOne,
      this.designationTwo,
      this.qualificationOne,
      this.qualificationTwo,
      this.memberID});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    favoriteID = json['favoriteID'];
    patientID = json['patientID'];
    doctorID = json['doctorID'];
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
    data['favoriteID'] = this.favoriteID;
    data['patientID'] = this.patientID;
    data['doctorID'] = this.doctorID;
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
