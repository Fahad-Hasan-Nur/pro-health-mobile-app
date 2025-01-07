class DiagnosisAdviceModel {
  int? diagnosisAdviceID;
  int? diagnosisID;
  int? adviceID;
  int? memberID;
  String? advice;

  DiagnosisAdviceModel(
      {this.diagnosisAdviceID,
      this.diagnosisID,
      this.adviceID,
      this.memberID,
      this.advice});

  DiagnosisAdviceModel.fromJson(Map<String, dynamic> json) {
    diagnosisAdviceID = json['diagnosisAdviceID'];
    diagnosisID = json['diagnosisID'];
    adviceID = json['adviceID'];
    memberID = json['memberID'];
    advice = json['advice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diagnosisAdviceID'] = this.diagnosisAdviceID;
    data['diagnosisID'] = this.diagnosisID;
    data['adviceID'] = this.adviceID;
    data['memberID'] = this.memberID;
    data['advice'] = this.advice;
    return data;
  }
}
