class CasePhotoModel {
  int? casePhotoID;
  int? caseExchangeID;
  String? casePhotos;
  String? createdOn;

  CasePhotoModel(
      {this.casePhotoID, this.caseExchangeID, this.casePhotos, this.createdOn});

  CasePhotoModel.fromJson(Map<String, dynamic> json) {
    casePhotoID = json['casePhotoID'];
    caseExchangeID = json['caseExchangeID'];
    casePhotos = json['casePhotos'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['casePhotoID'] = this.casePhotoID;
    data['caseExchangeID'] = this.caseExchangeID;
    data['casePhotos'] = this.casePhotos;
    data['createdOn'] = this.createdOn;
    return data;
  }
}
