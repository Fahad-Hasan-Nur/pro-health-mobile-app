class CaseCommentModel {
  int? commentsId;
  int? caseExchangeID;
  int? doctorId;
  int? memberID;
  String? comments;
  String? reply;

  CaseCommentModel(
      {this.commentsId,
      this.caseExchangeID,
      this.doctorId,
      this.memberID,
      this.comments,
      this.reply});

  CaseCommentModel.fromJson(Map<String, dynamic> json) {
    commentsId = json['commentsId'];
    caseExchangeID = json['caseExchangeID'];
    doctorId = json['doctorId'];
    memberID = json['memberID'];
    comments = json['comments'];
    reply = json['reply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentsId'] = this.commentsId;
    data['caseExchangeID'] = this.caseExchangeID;
    data['doctorId'] = this.doctorId;
    data['memberID'] = this.memberID;
    data['comments'] = this.comments;
    data['reply'] = this.reply;
    return data;
  }
}
