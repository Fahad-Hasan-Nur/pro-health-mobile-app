class DiseaseConditionModel {
  int? diseaseConditionID;
  int? memberID;
  String? diseaseConditionName;
  String? conditionName;

  DiseaseConditionModel(
      {this.diseaseConditionID,
      this.memberID,
      this.diseaseConditionName,
      this.conditionName});

  DiseaseConditionModel.fromJson(Map<String, dynamic> json) {
    diseaseConditionID = json['diseaseConditionID'];
    memberID = json['memberID'];
    diseaseConditionName = json['diseaseConditionName'];
    conditionName = json['conditionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diseaseConditionID'] = this.diseaseConditionID;
    data['memberID'] = this.memberID;
    data['diseaseConditionName'] = this.diseaseConditionName;
    data['conditionName'] = this.conditionName;
    return data;
  }
}
