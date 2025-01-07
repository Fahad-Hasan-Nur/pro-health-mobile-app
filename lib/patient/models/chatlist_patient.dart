// class ChatListPatient {
//   int? memberID;
//   int? patientID;
//   int? chatListID;
//   String? patientName;
//   String? profilePic;
//   String? doctorName;
//   String? profilePicture;
//   bool? isOnline;

//   ChatListPatient(
//       {this.memberID,
//       this.patientID,
//       this.chatListID,
//       this.patientName,
//       this.profilePic,
//       this.doctorName,
//       this.profilePicture,
//       this.isOnline});

//   ChatListPatient.fromJson(Map<String, dynamic> json) {
//     memberID = json['memberID'];
//     patientID = json['patientID'];
//     chatListID = json['chatListID'];
//     patientName = json['patientName'];
//     profilePic = json['profilePic'];
//     doctorName = json['doctorName'];
//     profilePicture = json['profilePicture'];
//     isOnline = json['isOnline'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['memberID'] = this.memberID;
//     data['patientID'] = this.patientID;
//     data['chatListID'] = this.chatListID;
//     data['patientName'] = this.patientName;
//     data['profilePic'] = this.profilePic;
//     data['doctorName'] = this.doctorName;
//     data['profilePicture'] = this.profilePicture;
//     data['isOnline'] = this.isOnline;
//     return data;
//   }
// }

class ChatList {
  int? chatListID;
  int? memberID;
  int? patientID;
  String? roomID;
  String? patientName;
  String? profilePic;
  String? doctorName;
  String? profilePicture;
  bool? isOnline;
  String? lastMessage;
  String? timeAgo;
  int? unseenMsgCount;

  ChatList({
    this.chatListID,
    this.memberID,
    this.patientID,
    this.roomID,
    this.patientName,
    this.profilePic,
    this.doctorName,
    this.profilePicture,
    this.isOnline,
    this.lastMessage,
    this.timeAgo,
    this.unseenMsgCount,
  });

  ChatList.fromJson(Map<String, dynamic> json) {
    memberID = json['memberID'];
    patientID = json['patientID'];
    chatListID = json['chatListID'];
    patientName = json['patientName'];
    profilePic = json['profilePic'];
    doctorName = json['doctorName'];
    profilePicture = json['profilePicture'];
    isOnline = json['isOnline'];
  }
}
