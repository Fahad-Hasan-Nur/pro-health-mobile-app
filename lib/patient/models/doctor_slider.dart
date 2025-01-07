class DoctorSliderModel {
  int? photoID;

  String? description;
  String? photoURL;
  String? entryBy;
  String? entryDate;
  String? photoType;
  int? projectId;

  DoctorSliderModel(
      {this.photoID,
      this.description,
      this.photoURL,
      this.entryBy,
      this.entryDate,
      this.photoType,
      this.projectId});

  DoctorSliderModel.fromJson(Map<String, dynamic> json) {
    photoID = json['photoID'];

    description = json['description'];
    photoURL = json['photoURL'];
    entryBy = json['entryBy'];
    entryDate = json['entryDate'];
    photoType = json['photoType'];
    projectId = json['projectId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photoID'] = this.photoID;

    data['description'] = this.description;
    data['photoURL'] = this.photoURL;
    data['entryBy'] = this.entryBy;
    data['entryDate'] = this.entryDate;
    data['photoType'] = this.photoType;
    data['projectId'] = this.projectId;
    return data;
  }
}
