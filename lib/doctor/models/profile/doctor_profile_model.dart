class DoctorProfileModel {
  int? doctorID;
  int? memberID;
  int? specialityID;
  String? doctorName;
  String? dateOfBirth;
  String? gender;
  String? workingPlace;
  double? consultationFeeOnline;
  double? consultationFeePhysical;
  double? followupFee;
  String? appJoinDate;
  String? bmdcNmuber;
  String? profilePicture;
  String? createdOn;
  String? doctorNameBangla;
  String? workingPlaceBangla;
  String? qualificationOne;
  String? qualificationTwo;
  String? qualificationOneBangla;
  String? qualificationTwoBangla;
  String? designationOne;
  String? designationTwo;
  String? designationOneBangla;
  String? designationTwoBangla;
  bool? isOnline;
  int? chamberDoctorID;
  String? chamberOneAddress;
  String? chamberTwoAddress;
  String? chamberOneConsultDay;
  String? chamberTwoConsultDay;
  String? chamberOneConsultStartTime;
  String? chamberTwoConsultStartTime;
  String? chamberOneConsultEndTime;
  String? chamberTwoConsultEndTime;
  String? chamberOneAddressBangla;
  String? chamberTwoAddressBangla;
  String? chamberOneConsultDayBangla;
  String? chamberTwoConsultDayBangla;
  String? chamberOneConsultStartTimeBangla;
  String? chamberTwoConsultStartTimeBangla;
  String? chamberOneConsultEndTimeBangla;
  String? chamberTwoConsultEndTimeBangla;
  String? subscriptionDays;
  String? expireDate;
  String? subscriptionStatus;
  String? specialityName;
  String? experience;
  String? chamberOneConsultTime;
  String? chamberOneConsultTimeBangla;
  String? chamberTwoConsultTime;
  String? chamberTwoConsultTimeBangla;
  String? bKash;
  String? rocket;
  String? nagad;

  DoctorProfileModel(
      {this.doctorID,
      this.memberID,
      this.specialityID,
      this.doctorName,
      this.dateOfBirth,
      this.gender,
      this.workingPlace,
      this.consultationFeeOnline,
      this.consultationFeePhysical,
      this.followupFee,
      this.appJoinDate,
      this.bmdcNmuber,
      this.profilePicture,
      this.createdOn,
      this.doctorNameBangla,
      this.workingPlaceBangla,
      this.qualificationOne,
      this.qualificationTwo,
      this.qualificationOneBangla,
      this.qualificationTwoBangla,
      this.designationOne,
      this.designationTwo,
      this.designationOneBangla,
      this.designationTwoBangla,
      this.isOnline,
      this.chamberDoctorID,
      this.chamberOneAddress,
      this.chamberTwoAddress,
      this.chamberOneConsultDay,
      this.chamberTwoConsultDay,
      this.chamberOneConsultStartTime,
      this.chamberTwoConsultStartTime,
      this.chamberOneConsultEndTime,
      this.chamberTwoConsultEndTime,
      this.chamberOneAddressBangla,
      this.chamberTwoAddressBangla,
      this.chamberOneConsultDayBangla,
      this.chamberTwoConsultDayBangla,
      this.chamberOneConsultStartTimeBangla,
      this.chamberTwoConsultStartTimeBangla,
      this.chamberOneConsultEndTimeBangla,
      this.chamberTwoConsultEndTimeBangla,
      this.subscriptionDays,
      this.expireDate,
      this.subscriptionStatus,
      this.specialityName,
      this.experience,
      this.chamberOneConsultTime,
      this.chamberOneConsultTimeBangla,
      this.chamberTwoConsultTime,
      this.chamberTwoConsultTimeBangla,
      this.bKash,
      this.rocket,
      this.nagad});

  DoctorProfileModel.fromJson(Map<String, dynamic> json) {
    doctorID = json['doctorID'];
    memberID = json['memberID'];
    specialityID = json['specialityID'];
    doctorName = json['doctorName'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    workingPlace = json['workingPlace'];
    consultationFeeOnline =
        double.parse(json['consultationFeeOnline'].toString());
    consultationFeePhysical =
        double.parse(json['consultationFeePhysical'].toString());
    followupFee = double.parse(json['followupFee'].toString());
    appJoinDate = json['appJoinDate'];
    bmdcNmuber = json['bmdcNmuber'];
    profilePicture = json['profilePicture'];
    createdOn = json['createdOn'];
    doctorNameBangla = json['doctorNameBangla'];
    workingPlaceBangla = json['workingPlaceBangla'];
    qualificationOne = json['qualificationOne'];
    qualificationTwo = json['qualificationTwo'];
    qualificationOneBangla = json['qualificationOneBangla'];
    qualificationTwoBangla = json['qualificationTwoBangla'];
    designationOne = json['designationOne'];
    designationTwo = json['designationTwo'];
    designationOneBangla = json['designationOneBangla'];
    designationTwoBangla = json['designationTwoBangla'];
    isOnline = json['isOnline'];
    chamberDoctorID = json['chamberDoctorID'];
    chamberOneAddress = json['chamberOneAddress'];
    chamberTwoAddress = json['chamberTwoAddress'];
    chamberOneConsultDay = json['chamberOneConsultDay'];
    chamberTwoConsultDay = json['chamberTwoConsultDay'];
    chamberOneConsultStartTime = json['chamberOneConsultStartTime'];
    chamberTwoConsultStartTime = json['chamberTwoConsultStartTime'];
    chamberOneConsultEndTime = json['chamberOneConsultEndTime'];
    chamberTwoConsultEndTime = json['chamberTwoConsultEndTime'];
    chamberOneAddressBangla = json['chamberOneAddressBangla'];
    chamberTwoAddressBangla = json['chamberTwoAddressBangla'];
    chamberOneConsultDayBangla = json['chamberOneConsultDayBangla'];
    chamberTwoConsultDayBangla = json['chamberTwoConsultDayBangla'];
    chamberOneConsultStartTimeBangla = json['chamberOneConsultStartTimeBangla'];
    chamberTwoConsultStartTimeBangla = json['chamberTwoConsultStartTimeBangla'];
    chamberOneConsultEndTimeBangla = json['chamberOneConsultEndTimeBangla'];
    chamberTwoConsultEndTimeBangla = json['chamberTwoConsultEndTimeBangla'];
    subscriptionDays = json['subscriptionDays'];
    expireDate = json['expireDate'];
    subscriptionStatus = json['subscriptionStatus'];
    specialityName = json['specialityName'];
    experience = json['experience'];
    chamberOneConsultTime = json['chamberOneConsultTime'];
    chamberOneConsultTimeBangla = json['chamberOneConsultTimeBangla'];
    chamberTwoConsultTime = json['chamberTwoConsultTime'];
    chamberTwoConsultTimeBangla = json['chamberTwoConsultTimeBangla'];
    bKash = json['bKash'];
    rocket = json['rocket'];
    nagad = json['nagad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorID'] = this.doctorID;
    data['memberID'] = this.memberID;
    data['specialityID'] = this.specialityID;
    data['doctorName'] = this.doctorName;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['workingPlace'] = this.workingPlace;
    data['consultationFeeOnline'] = this.consultationFeeOnline;
    data['consultationFeePhysical'] = this.consultationFeePhysical;
    data['followupFee'] = this.followupFee;
    data['appJoinDate'] = this.appJoinDate;
    data['bmdcNmuber'] = this.bmdcNmuber;
    data['profilePicture'] = this.profilePicture;
    data['createdOn'] = this.createdOn;
    data['doctorNameBangla'] = this.doctorNameBangla;
    data['workingPlaceBangla'] = this.workingPlaceBangla;
    data['qualificationOne'] = this.qualificationOne;
    data['qualificationTwo'] = this.qualificationTwo;
    data['qualificationOneBangla'] = this.qualificationOneBangla;
    data['qualificationTwoBangla'] = this.qualificationTwoBangla;
    data['designationOne'] = this.designationOne;
    data['designationTwo'] = this.designationTwo;
    data['designationOneBangla'] = this.designationOneBangla;
    data['designationTwoBangla'] = this.designationTwoBangla;
    data['isOnline'] = this.isOnline;
    data['chamberDoctorID'] = this.chamberDoctorID;
    data['chamberOneAddress'] = this.chamberOneAddress;
    data['chamberTwoAddress'] = this.chamberTwoAddress;
    data['chamberOneConsultDay'] = this.chamberOneConsultDay;
    data['chamberTwoConsultDay'] = this.chamberTwoConsultDay;
    data['chamberOneConsultStartTime'] = this.chamberOneConsultStartTime;
    data['chamberTwoConsultStartTime'] = this.chamberTwoConsultStartTime;
    data['chamberOneConsultEndTime'] = this.chamberOneConsultEndTime;
    data['chamberTwoConsultEndTime'] = this.chamberTwoConsultEndTime;
    data['chamberOneAddressBangla'] = this.chamberOneAddressBangla;
    data['chamberTwoAddressBangla'] = this.chamberTwoAddressBangla;
    data['chamberOneConsultDayBangla'] = this.chamberOneConsultDayBangla;
    data['chamberTwoConsultDayBangla'] = this.chamberTwoConsultDayBangla;
    data['chamberOneConsultStartTimeBangla'] =
        this.chamberOneConsultStartTimeBangla;
    data['chamberTwoConsultStartTimeBangla'] =
        this.chamberTwoConsultStartTimeBangla;
    data['chamberOneConsultEndTimeBangla'] =
        this.chamberOneConsultEndTimeBangla;
    data['chamberTwoConsultEndTimeBangla'] =
        this.chamberTwoConsultEndTimeBangla;
    data['subscriptionDays'] = this.subscriptionDays;
    data['expireDate'] = this.expireDate;
    data['subscriptionStatus'] = this.subscriptionStatus;
    data['specialityName'] = this.specialityName;
    data['experience'] = this.experience;
    data['chamberOneConsultTime'] = this.chamberOneConsultTime;
    data['chamberOneConsultTimeBangla'] = this.chamberOneConsultTimeBangla;
    data['chamberTwoConsultTime'] = this.chamberTwoConsultTime;
    data['chamberTwoConsultTimeBangla'] = this.chamberTwoConsultTimeBangla;
    data['bKash'] = this.bKash;
    data['rocket'] = this.rocket;
    data['nagad'] = this.nagad;
    return data;
  }
}
