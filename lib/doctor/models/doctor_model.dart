class DoctorModel {
  int? doctorID;
  int? memberID;
  int? specialityID;
  String? doctorName;
  String? mobileNo;
  String? dateOfBirth;
  String? gender;
  String? doctorDesc;
  String? eduQualificationID;
  String? experience;
  String? workingPlace;
  double? consultationFeeOnline;
  double? consultationFeePhysical;
  double? followupFee;
  String? availability;
  String? consultStartTime;
  String? consultEndTime;
  String? appJoinDate;
  String? bmdcNmuber;
  double? consultDiscount;
  double? followupDiscount;
  String? discountStartDate;
  String? discountEndDate;
  String? password;
  String? consultationDay;
  String? consultationTime;
  String? email;
  String? profilePicture;
  bool? agreementAcceptStatus;
  String? status;
  String? createdBy;
  String? createdOn;
  bool? isOnline;

  DoctorModel(
      {this.doctorID,
      this.memberID,
      this.specialityID,
      this.doctorName,
      this.mobileNo,
      this.dateOfBirth,
      this.gender,
      this.doctorDesc,
      this.eduQualificationID,
      this.experience,
      this.workingPlace,
      this.consultationFeeOnline,
      this.consultationFeePhysical,
      this.followupFee,
      this.availability,
      this.consultStartTime,
      this.consultEndTime,
      this.appJoinDate,
      this.bmdcNmuber,
      this.consultDiscount,
      this.followupDiscount,
      this.discountStartDate,
      this.discountEndDate,
      this.password,
      this.consultationDay,
      this.consultationTime,
      this.email,
      this.profilePicture,
      this.agreementAcceptStatus,
      this.status,
      this.createdBy,
      this.createdOn,
      this.isOnline});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    doctorID = json['doctorID'];
    memberID = json['memberID'];
    specialityID = json['specialityID'];
    doctorName = json['doctorName'];
    mobileNo = json['mobileNo'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    doctorDesc = json['doctorDesc'];
    eduQualificationID = json['eduQualificationID'];
    experience = json['experience'];
    workingPlace = json['workingPlace'];
    consultationFeeOnline = json['consultationFeeOnline'];
    consultationFeePhysical = json['consultationFeePhysical'];
    followupFee = json['followupFee'];
    availability = json['availability'];
    consultStartTime = json['consultStartTime'];
    consultEndTime = json['consultEndTime'];
    appJoinDate = json['appJoinDate'];
    bmdcNmuber = json['bmdcNmuber'];
    consultDiscount = double.parse(json['consultDiscount'].toString());
    followupDiscount = double.parse(json['followupDiscount'].toString());
    discountStartDate = json['discountStartDate'];
    discountEndDate = json['discountEndDate'];
    password = json['password'];
    consultationDay = json['consultationDay'];
    consultationTime = json['consultationTime'];
    email = json['email'];
    profilePicture = json['profilePicture'];
    agreementAcceptStatus = json['agreementAcceptStatus'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    isOnline = json['isOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorID'] = this.doctorID;
    data['memberID'] = this.memberID;
    data['specialityID'] = this.specialityID;
    data['doctorName'] = this.doctorName;
    data['mobileNo'] = this.mobileNo;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['doctorDesc'] = this.doctorDesc;
    data['eduQualificationID'] = this.eduQualificationID;
    data['experience'] = this.experience;
    data['workingPlace'] = this.workingPlace;
    data['consultationFeeOnline'] = this.consultationFeeOnline;
    data['consultationFeePhysical'] = this.consultationFeePhysical;
    data['followupFee'] = this.followupFee;
    data['availability'] = this.availability;
    data['consultStartTime'] = this.consultStartTime;
    data['consultEndTime'] = this.consultEndTime;
    data['appJoinDate'] = this.appJoinDate;
    data['bmdcNmuber'] = this.bmdcNmuber;
    data['consultDiscount'] = this.consultDiscount;
    data['followupDiscount'] = this.followupDiscount;
    data['discountStartDate'] = this.discountStartDate;
    data['discountEndDate'] = this.discountEndDate;
    data['password'] = this.password;
    data['consultationDay'] = this.consultationDay;
    data['consultationTime'] = this.consultationTime;
    data['email'] = this.email;
    data['profilePicture'] = this.profilePicture;
    data['agreementAcceptStatus'] = this.agreementAcceptStatus;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['isOnline'] = this.isOnline;
    return data;
  }
}
