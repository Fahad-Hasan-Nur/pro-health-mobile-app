class PoliceStationModel {
  late int policeStationID;
  late int districtID;
  late String policeStationName;
  late String entryBy;
  late String entryDate;

  PoliceStationModel(
      {required this.policeStationID,
      required this.districtID,
      required this.policeStationName,
      required this.entryBy,
      required this.entryDate});

  PoliceStationModel.fromJson(Map<String, dynamic> json) {
    policeStationID = json['policeStationID'];
    districtID = json['districtID'];
    policeStationName = json['policeStationName'];
    entryBy = json['entryBy'];
    entryDate = json['entryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['policeStationID'] = this.policeStationID;
    data['districtID'] = this.districtID;
    data['policeStationName'] = this.policeStationName;
    data['entryBy'] = this.entryBy;
    data['entryDate'] = this.entryDate;
    return data;
  }
}
