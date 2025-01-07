class ConsultHistoryDoctorModel {
  int? consultHistoryID;
  int? id;
  String? prescription;
  int? patientID;
  int? doctorID;
  int? memberID;
  String? patientName;
  String? phone;
  String? bmdcNo;
  String? bkashSenderNo;
  String? createOn;

  ConsultHistoryDoctorModel(
      {this.consultHistoryID,
      this.id,
      this.prescription,
      this.patientID,
      this.doctorID,
      this.memberID,
      this.patientName,
      this.phone,
      this.bmdcNo,
      this.bkashSenderNo,
      this.createOn});

  ConsultHistoryDoctorModel.fromJson(Map<String, dynamic> json) {
    consultHistoryID = json['consultHistoryID'];
    id = json['id'];
    prescription = json['prescription'];
    patientID = json['patientID'];
    doctorID = json['doctorID'];
    memberID = json['memberID'];
    patientName = json['patientName'];
    phone = json['phone'];
    bmdcNo = json['bmdcNo'];
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
    data['memberID'] = this.memberID;
    data['patientName'] = this.patientName;
    data['phone'] = this.phone;
    data['bmdcNo'] = this.bmdcNo;
    data['bkashSenderNo'] = this.bkashSenderNo;
    data['createOn'] = this.createOn;
    return data;
  }
}
