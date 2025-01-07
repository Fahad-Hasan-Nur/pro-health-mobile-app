class GenerateUidModel {
  int? patientID;
  int? id;
  String? prescriptionId;

  GenerateUidModel({this.patientID, this.id, this.prescriptionId});

  GenerateUidModel.fromJson(Map<String, dynamic> json) {
    patientID = json['patientID'];
    id = json['id'];
    prescriptionId = json['prescriptionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientID'] = this.patientID;
    data['id'] = this.id;
    data['prescriptionId'] = this.prescriptionId;
    return data;
  }
}
