class PatientRelativesModel {
  int? relativeID;
  int? patientID;
  String? name;
  String? relationship;
  String? age;
  String? weight;
  String? gender;
  String? problem;
  String? createOn;

  PatientRelativesModel(
      {this.relativeID,
      this.patientID,
      this.name,
      this.relationship,
      this.age,
      this.weight,
      this.gender,
      this.problem,
      this.createOn});

  PatientRelativesModel.fromJson(Map<String, dynamic> json) {
    relativeID = json['relativeID'];
    patientID = json['patientID'];
    name = json['name'];
    relationship = json['relationship'];
    age = json['age'];
    weight = json['weight'];
    gender = json['gender'];
    problem = json['problem'];
    createOn = json['createOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['relativeID'] = this.relativeID;
    data['patientID'] = this.patientID;
    data['name'] = this.name;
    data['relationship'] = this.relationship;
    data['age'] = this.age;
    data['weight'] = this.weight;
    data['gender'] = this.gender;
    data['problem'] = this.problem;
    data['createOn'] = this.createOn;
    return data;
  }
}
