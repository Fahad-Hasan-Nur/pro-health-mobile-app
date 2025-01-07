class ConsultHistoryPatientModel {
  int? consultHistoryID;
  int? id;
  String? prescription;
  int? patientID;
  int? doctorID;
  String? doctorName;
  int? memberID;
  String? patientName;
  String? bmdcNmuber;
  String? bkashSenderNo;
  String? createOn;

  ConsultHistoryPatientModel(
      {this.consultHistoryID,
      this.id,
      this.prescription,
      this.patientID,
      this.doctorID,
      this.doctorName,
      this.memberID,
      this.patientName,
      this.bmdcNmuber,
      this.bkashSenderNo,
      this.createOn});

  ConsultHistoryPatientModel.fromJson(Map<String, dynamic> json) {
    consultHistoryID = json['consultHistoryID'];
    id = json['id'];
    prescription = json['prescription'];
    patientID = json['patientID'];
    doctorID = json['doctorID'];
    doctorName = json['doctorName'];
    memberID = json['memberID'];
    patientName = json['patientName'];
    bmdcNmuber = json['bmdcNmuber'];
    bkashSenderNo = json['bkashSenderNo'];
    createOn = json['createOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['consultHistoryID'] = this.consultHistoryID;
    data['id'] = this.id;
    data['prescription'] = this.prescription;
    data['patientID'] = this.patientID;
    data['doctorID'] = this.doctorID;
    data['doctorName'] = this.doctorName;
    data['memberID'] = this.memberID;
    data['patientName'] = this.patientName;
    data['bmdcNmuber'] = this.bmdcNmuber;
    data['bkashSenderNo'] = this.bkashSenderNo;
    data['createOn'] = this.createOn;
    return data;
  }
}
