import 'dart:developer';

class AdvanceDoctorSearch {
  int? doctorID;
  int? specialityID;
  String? doctorName;
  double? rating;
  String? mobileNo;
  String? dateOfBirth;
  String? gender;
  String? eduQualificationID;
  String? experience;
  String? workingPlace;
  double? followupFee;
  double? consultationFeePhysical;
  String? bmdcNmuber;
  String? profilePicture;
  String? consultationDay;
  bool? isOnline;
  int? memberID;
  double? consultationFeeOnline;
  String? availability;
  String? qualificationOne;
  String? qualificationTwo;
  String? designationOne;
  String? designationTwo;
  String? rocket;
  String? bKash;
  String? nagad;
  String? specialityName;

  AdvanceDoctorSearch(
      {this.doctorID,
      this.specialityID,
      this.doctorName,
      this.rating,
      this.mobileNo,
      this.dateOfBirth,
      this.gender,
      this.eduQualificationID,
      this.experience,
      this.workingPlace,
      this.followupFee,
      this.consultationFeePhysical,
      this.bmdcNmuber,
      this.profilePicture,
      this.consultationDay,
      this.isOnline,
      this.memberID,
      this.consultationFeeOnline,
      this.availability,
      this.qualificationOne,
      this.qualificationTwo,
      this.designationOne,
      this.designationTwo,
      this.rocket,
      this.bKash,
      this.nagad,
      this.specialityName});

  AdvanceDoctorSearch.fromJson(Map<String, dynamic> json) {
    doctorID = json['DoctorID'];
    specialityID = json['SpecialityID'];
    doctorName = json['DoctorName'];
    rating = json['Rating'].toDouble();
    mobileNo = json['MobileNo'];
    dateOfBirth = json['DateOfBirth'];
    gender = json['Gender'];
    eduQualificationID = json['EduQualificationID'];
    experience = json['Experience'];
    workingPlace = json['WorkingPlace'];
    followupFee = json['FollowupFee'];
    log('FollowupFee $followupFee');
    consultationFeePhysical = json['ConsultationFeePhysical'].toDouble();
    bmdcNmuber = json['BmdcNmuber'];
    profilePicture = json['ProfilePicture'];
    consultationDay = json['ConsultationDay'];
    isOnline = json['IsOnline'];
    memberID = json['MemberID'];
    consultationFeeOnline = json['ConsultationFeeOnline'];
    availability = json['Availability'];
    qualificationOne = json['QualificationOne'] ?? '';
    qualificationTwo = json['QualificationTwo'] ?? '';
    designationOne = json['DesignationOne'] ?? '';
    designationTwo = json['DesignationTwo'] ?? '';
    rocket = json['Rocket'] ?? '';
    bKash = json['BKash'] ?? '';
    nagad = json['Nagad'] ?? '';
    specialityName = json['SpecialityName'] ?? '';
  }
}
