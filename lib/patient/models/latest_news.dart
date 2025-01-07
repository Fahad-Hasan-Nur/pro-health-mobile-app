class LatestNewsModel {
  int? latestNewsID;
  String? description;
  String? createOn;

  LatestNewsModel({this.latestNewsID, this.description, this.createOn});

  LatestNewsModel.fromJson(Map<String, dynamic> json) {
    latestNewsID = json['latestNewsID'];
    description = json['description'];
    createOn = json['createOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latestNewsID'] = this.latestNewsID;
    data['description'] = this.description;
    data['createOn'] = this.createOn;
    return data;
  }
}
