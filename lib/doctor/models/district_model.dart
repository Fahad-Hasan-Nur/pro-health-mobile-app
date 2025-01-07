class DistrictModel {
  late int districtID;
  late String districtName;
  late String entryBy;
  late String entryDate;

  DistrictModel(
      {required this.districtID,
      required this.districtName,
      required this.entryBy,
      required this.entryDate});

  DistrictModel.fromJson(Map<String, dynamic> json) {
    districtID = json['districtID'];
    districtName = json['districtName'];
    entryBy = json['entryBy'];
    entryDate = json['entryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['districtID'] = this.districtID;
    data['districtName'] = this.districtName;
    data['entryBy'] = this.entryBy;
    data['entryDate'] = this.entryDate;
    return data;
  }
}
