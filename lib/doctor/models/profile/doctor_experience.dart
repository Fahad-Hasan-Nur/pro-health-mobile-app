class DoctorExperienceModel {
  int? experienceID;
  int? doctorID;
  int? memberID;
  String? hospitalName;
  String? designation;
  String? department;
  String? duration;
  String? workingPeriod;
  String? joiningDate;
  String? leavingDate;

  DoctorExperienceModel(
      {this.experienceID,
      this.doctorID,
      this.memberID,
      this.hospitalName,
      this.designation,
      this.department,
      this.duration,
      this.workingPeriod,
      this.joiningDate,
      this.leavingDate});

  DoctorExperienceModel.fromJson(Map<String, dynamic> json) {
    experienceID = json['experienceID'];
    doctorID = json['doctorID'];
    memberID = json['memberID'];
    hospitalName = json['hospitalName'];
    designation = json['designation'];
    department = json['department'];
    duration = json['duration'];
    workingPeriod = json['workingPeriod'];
    joiningDate = json['joiningDate'];
    leavingDate = json['leavingDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['experienceID'] = this.experienceID;
    data['doctorID'] = this.doctorID;
    data['memberID'] = this.memberID;
    data['hospitalName'] = this.hospitalName;
    data['designation'] = this.designation;
    data['department'] = this.department;
    data['duration'] = this.duration;
    data['workingPeriod'] = this.workingPeriod;
    data['joiningDate'] = this.joiningDate;
    data['leavingDate'] = this.leavingDate;
    return data;
  }
}
