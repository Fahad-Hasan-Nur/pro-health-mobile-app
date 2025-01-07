class DoctorAppointmentModel {
  late int doctorID;
  late int memberID;
  String? problem;
  String? stutas;
  String? patientName;
  int? appoitmentID;
  String? createdOn;
  late int patiantID;
  String? profilePic;

  DoctorAppointmentModel(
      {required this.doctorID,
      required this.memberID,
      this.problem,
      this.stutas,
      this.patientName,
      this.appoitmentID,
      this.createdOn,
      required this.patiantID,
      this.profilePic});

  DoctorAppointmentModel.fromJson(Map<String, dynamic> json) {
    doctorID = json['doctorID'];
    memberID = json['memberID'];
    problem = json['problem'];
    stutas = json['stutas'];
    patientName = json['patientName'];
    appoitmentID = json['appoitmentID'];
    createdOn = json['createdOn'];
    patiantID = json['patiantID'];
    profilePic = json['profilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorID'] = this.doctorID;
    data['memberID'] = this.memberID;
    data['problem'] = this.problem;
    data['stutas'] = this.stutas;
    data['patientName'] = this.patientName;
    data['appoitmentID'] = this.appoitmentID;
    data['createdOn'] = this.createdOn;
    data['patiantID'] = this.patiantID;
    data['profilePic'] = this.profilePic;
    return data;
  }
}
