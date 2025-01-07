class CaseLikeModel {
  int? caseLikeId;
  int? caseExchangeID;
  int? memberID;
  int? likeStatus;
  int? status;

  CaseLikeModel(
      {this.caseLikeId,
      this.caseExchangeID,
      this.memberID,
      this.likeStatus,
      this.status});

  CaseLikeModel.fromJson(Map<String, dynamic> json) {
    caseLikeId = json['caseLikeId'];
    caseExchangeID = json['caseExchangeID'];
    memberID = json['memberID'];
    likeStatus = json['likeStatus'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caseLikeId'] = this.caseLikeId;
    data['caseExchangeID'] = this.caseExchangeID;
    data['memberID'] = this.memberID;
    data['likeStatus'] = this.likeStatus;
    data['status'] = this.status;
    return data;
  }
}
