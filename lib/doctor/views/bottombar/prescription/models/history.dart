class HistoryModel {
  int? historyID;
  int? memberID;
  String? historyType;
  String? createOn;
  String? status;
  String? details;

  HistoryModel(
      {this.historyID,
      this.memberID,
      this.historyType,
      this.createOn,
      this.status,
      this.details});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    historyID = json['historyID'];
    memberID = json['memberID'];
    historyType = json['historyType'];
    createOn = json['createOn'];
    status = json['status'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['historyID'] = this.historyID;
    data['memberID'] = this.memberID;
    data['historyType'] = this.historyType;
    data['createOn'] = this.createOn;
    data['status'] = this.status;
    data['details'] = this.details;
    return data;
  }
}
