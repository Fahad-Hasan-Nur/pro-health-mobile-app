class SingleChatModel {
  int? chatID;
  int? memberID;
  int? patientID;
  int? doctorID;
  int? chatListID;
  String? roomID;
  String? sender;
  String? message;
  String? attachment;
  String? createOn;
  bool? seenByDoctor;
  bool? seenByPatient;
  bool? isDoctor;
  bool? isPatient;

  SingleChatModel(
      {this.chatID,
      this.memberID,
      this.patientID,
      this.doctorID,
      this.chatListID,
      this.roomID,
      this.sender,
      this.message,
      this.attachment,
      this.createOn,
      this.seenByDoctor,
      this.seenByPatient,
      this.isDoctor,
      this.isPatient});

  SingleChatModel.fromJson(Map<String, dynamic> json) {
    chatID = json['chatID'];
    memberID = json['memberID'];
    patientID = json['patientID'];
    doctorID = json['doctorID'];
    chatListID = json['chatListID'];
    roomID = json['roomID'];
    sender = json['sender'];
    message = json['message'];
    attachment = json['attachment'];
    createOn = json['createOn'];
    seenByDoctor = json['seenByDoctor'];
    seenByPatient = json['seenByPatient'];
    isDoctor = json['isDoctor'];
    isPatient = json['isPatient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatID'] = this.chatID;
    data['memberID'] = this.memberID;
    data['patientID'] = this.patientID;
    data['doctorID'] = this.doctorID;
    data['chatListID'] = this.chatListID;
    data['roomID'] = this.roomID;
    data['sender'] = this.sender;
    data['message'] = this.message;
    data['attachment'] = this.attachment;
    data['createOn'] = this.createOn;
    data['seenByDoctor'] = this.seenByDoctor;
    data['seenByPatient'] = this.seenByPatient;
    data['isDoctor'] = this.isDoctor;
    data['isPatient'] = this.isPatient;
    return data;
  }
}
