class PostOfficeModel {
  late int postOfficeId;
  late int districtID;
  late int policeStationID;
  late String postOfficeName;
  late String postCode;

  PostOfficeModel(
      {required this.postOfficeId,
      required this.districtID,
      required this.policeStationID,
      required this.postOfficeName,
      required this.postCode});

  PostOfficeModel.fromJson(Map<String, dynamic> json) {
    postOfficeId = json['postOfficeId'];
    districtID = json['districtID'];
    policeStationID = json['policeStationID'];
    postOfficeName = json['postOfficeName'];
    postCode = json['postCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postOfficeId'] = this.postOfficeId;
    data['districtID'] = this.districtID;
    data['policeStationID'] = this.policeStationID;
    data['postOfficeName'] = this.postOfficeName;
    data['postCode'] = this.postCode;
    return data;
  }
}
