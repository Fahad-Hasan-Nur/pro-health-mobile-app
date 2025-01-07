class PatientProfileModel {
  int? patientID;
  String? patientName;
  int? memberID;
  String? fatherHusband;
  String? dateOfBirth;
  String? gender;
  String? villageHouse;
  String? roadBlockSector;
  int? districtID;
  int? policeStationID;
  int? postOfficeId;
  String? mobile;
  String? password;
  String? profilePic;
  bool? agreementAcceptStatus;
  String? bloodGroup;
  String? weight;
  String? email;
  String? allergies;
  String? occupation;
  String? smoking;
  String? maritalStatus;
  String? alcohol;
  String? exercise;
  String? caffinatedBeverage;
  String? districtName;
  String? entryBy;
  String? entryDate;
  String? policeStationName;
  String? postOfficeName;
  String? postCode;
  String? district;
  String? thana;
  String? postOffice;

  PatientProfileModel(
      {this.patientID,
      this.patientName,
      this.memberID,
      this.fatherHusband,
      this.dateOfBirth,
      this.gender,
      this.villageHouse,
      this.roadBlockSector,
      this.districtID,
      this.policeStationID,
      this.postOfficeId,
      this.mobile,
      this.password,
      this.profilePic,
      this.agreementAcceptStatus,
      this.bloodGroup,
      this.weight,
      this.email,
      this.allergies,
      this.occupation,
      this.smoking,
      this.maritalStatus,
      this.alcohol,
      this.exercise,
      this.caffinatedBeverage,
      this.districtName,
      this.entryBy,
      this.entryDate,
      this.policeStationName,
      this.postOfficeName,
      this.postCode,
      this.district,
      this.thana,
      this.postOffice});

  PatientProfileModel.fromJson(Map<String, dynamic> json) {
    patientID = json['patientID'];
    patientName = json['patientName'];
    memberID = json['memberID'];
    fatherHusband = json['father_Husband'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    villageHouse = json['village_House'];
    roadBlockSector = json['road_Block_Sector'];
    districtID = json['districtID'];
    policeStationID = json['policeStationID'];
    postOfficeId = json['postOfficeId'];
    mobile = json['mobile'];
    password = json['password'];
    profilePic = json['profilePic'];
    agreementAcceptStatus = json['agreementAcceptStatus'];
    bloodGroup = json['bloodGroup'];
    weight = json['weight'];
    email = json['email'];
    allergies = json['allergies'];
    occupation = json['occupation'];
    smoking = json['smoking'];
    maritalStatus = json['maritalStatus'];
    alcohol = json['alcohol'];
    exercise = json['exercise'];
    caffinatedBeverage = json['caffinatedBeverage'];
    districtName = json['districtName'];
    entryBy = json['entryBy'];
    entryDate = json['entryDate'];
    policeStationName = json['policeStationName'];
    postOfficeName = json['postOfficeName'];
    postCode = json['postCode'];
    district = json['district'];
    thana = json['thana'];
    postOffice = json['postOffice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientID'] = this.patientID;
    data['patientName'] = this.patientName;
    data['memberID'] = this.memberID;
    data['father_Husband'] = this.fatherHusband;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['village_House'] = this.villageHouse;
    data['road_Block_Sector'] = this.roadBlockSector;
    data['districtID'] = this.districtID;
    data['policeStationID'] = this.policeStationID;
    data['postOfficeId'] = this.postOfficeId;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['profilePic'] = this.profilePic;
    data['agreementAcceptStatus'] = this.agreementAcceptStatus;
    data['bloodGroup'] = this.bloodGroup;
    data['weight'] = this.weight;
    data['email'] = this.email;
    data['allergies'] = this.allergies;
    data['occupation'] = this.occupation;
    data['smoking'] = this.smoking;
    data['maritalStatus'] = this.maritalStatus;
    data['alcohol'] = this.alcohol;
    data['exercise'] = this.exercise;
    data['caffinatedBeverage'] = this.caffinatedBeverage;
    data['districtName'] = this.districtName;
    data['entryBy'] = this.entryBy;
    data['entryDate'] = this.entryDate;
    data['policeStationName'] = this.policeStationName;
    data['postOfficeName'] = this.postOfficeName;
    data['postCode'] = this.postCode;
    data['district'] = this.district;
    data['thana'] = this.thana;
    data['postOffice'] = this.postOffice;
    return data;
  }
}
