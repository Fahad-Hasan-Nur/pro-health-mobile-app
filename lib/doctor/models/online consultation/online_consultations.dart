class OnlineConsultationModel {
  late int onlineConsultationID;
  late int appointmentID;
  late int memberID;
  late int doctorID;
  late int patientID;
  late int? prescriptionID;
  late String patientName;
  late String createdOn;

  OnlineConsultationModel(
      {required this.onlineConsultationID,
      required this.appointmentID,
      required this.memberID,
      required this.doctorID,
      required this.patientID,
      this.prescriptionID,
      required this.patientName,
      required this.createdOn});

  OnlineConsultationModel.fromJson(Map<String, dynamic> json) {
    onlineConsultationID = json['onlineConsultationID'];
    appointmentID = json['appointmentID'];
    memberID = json['memberID'];
    doctorID = json['doctorID'];
    patientID = json['patientID'];
    prescriptionID = json['prescriptionID'];
    patientName = json['patientName'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['onlineConsultationID'] = this.onlineConsultationID;
    data['appointmentID'] = this.appointmentID;
    data['memberID'] = this.memberID;
    data['doctorID'] = this.doctorID;
    data['patientID'] = this.patientID;
    data['prescriptionID'] = this.prescriptionID;
    data['patientName'] = this.patientName;
    data['createdOn'] = this.createdOn;
    return data;
  }
}
