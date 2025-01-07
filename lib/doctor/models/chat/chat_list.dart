class ChatListModel {
  int? memberID;
  int? patientID;
  int? chatListID;
  String? patientName;
  String? profilePic;
  String? doctorName;
  String? profilePicicture;

  ChatListModel(
      {this.memberID,
      this.patientID,
      this.chatListID,
      this.patientName,
      this.profilePic,
      this.doctorName,
      this.profilePicicture});

  ChatListModel.fromJson(Map<String, dynamic> json) {
    memberID = json['memberID'];
    patientID = json['patientID'];
    chatListID = json['chatListID'];
    patientName = json['patientName'];
    profilePic = json['profilePic'];
    doctorName = json['doctorName'];
    profilePicicture = json['profilePicicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberID'] = this.memberID;
    data['patientID'] = this.patientID;
    data['chatListID'] = this.chatListID;
    data['patientName'] = this.patientName;
    data['profilePic'] = this.profilePic;
    data['doctorName'] = this.doctorName;
    data['profilePicicture'] = this.profilePicicture;
    return data;
  }
}
