class PatientComplainModel {
  int? complainID;
  int? patientID;
  String? problem;
  String? date;
  String? email;
  String? phone;

  PatientComplainModel(
      {this.complainID,
      this.patientID,
      this.problem,
      this.date,
      this.email,
      this.phone});

  PatientComplainModel.fromJson(Map<String, dynamic> json) {
    complainID = json['complainID'];
    patientID = json['patientID'];
    problem = json['problem'];
    date = json['date'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['complainID'] = this.complainID;
    data['patientID'] = this.patientID;
    data['problem'] = this.problem;
    data['date'] = this.date;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}
