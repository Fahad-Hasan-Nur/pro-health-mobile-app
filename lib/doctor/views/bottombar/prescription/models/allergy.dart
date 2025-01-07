class AllergyModel {
  int? allergyID;
  int? memberID;
  String? allergyType;
  String? createOn;

  AllergyModel(
      {this.allergyID, this.memberID, this.allergyType, this.createOn});

  AllergyModel.fromJson(Map<String, dynamic> json) {
    allergyID = json['allergyID'];
    memberID = json['memberID'];
    allergyType = json['allergyType'];
    createOn = json['createOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allergyID'] = this.allergyID;
    data['memberID'] = this.memberID;
    data['allergyType'] = this.allergyType;
    data['createOn'] = this.createOn;
    return data;
  }
}
