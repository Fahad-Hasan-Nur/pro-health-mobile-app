// class Call {
//   int? callingId;
//   int? callerId;
//   String? callerName;
//   String? callerPic;
//   int? receiverId;
//   String? receiverName;
//   String? receiverPic;
//   String? channelId;
//   bool? hasDialed;

//   Call(
//       {this.callingId,
//       this.callerId,
//       this.callerName,
//       this.callerPic,
//       this.receiverId,
//       this.receiverName,
//       this.receiverPic,
//       this.channelId,
//       this.hasDialed});

//   Call.fromJson(Map<String, dynamic> json) {
//     callingId = json['callingId'];
//     callerId = json['callerId'];
//     callerName = json['callerName'];
//     callerPic = json['callerPic'];
//     receiverId = json['receiverId'];
//     receiverName = json['receiverName'];
//     receiverPic = json['receiverPic'];
//     channelId = json['channelId'];
//     hasDialed = json['hasDialed'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['callingId'] = this.callingId;
//     data['callerId'] = this.callerId;
//     data['callerName'] = this.callerName;
//     data['callerPic'] = this.callerPic;
//     data['receiverId'] = this.receiverId;
//     data['receiverName'] = this.receiverName;
//     data['receiverPic'] = this.receiverPic;
//     data['channelId'] = this.channelId;
//     data['hasDialed'] = this.hasDialed;
//     return data;
//   }
// }

class Call {
  int? callingId;
  int? callerId;
  String? callerName;
  String? callerPic;
  int? receiverId;
  String? receiverName;
  String? receiverPic;
  String? channelId;
  bool? hasDialed;

  Call(
      {this.callingId,
      this.callerId,
      this.callerName,
      this.callerPic,
      this.receiverId,
      this.receiverName,
      this.receiverPic,
      this.channelId,
      this.hasDialed});

  Call.fromJson(Map<String, dynamic> json) {
    callingId = json['callingId'];
    callerId = json['callerId'];
    callerName = json['callerName'];
    callerPic = json['callerPic'];
    receiverId = json['receiverId'];
    receiverName = json['receiverName'];
    receiverPic = json['receiverPic'];
    channelId = json['channelId'];
    hasDialed = json['hasDialed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['callingId'] = this.callingId;
    data['callerId'] = this.callerId;
    data['callerName'] = this.callerName;
    data['callerPic'] = this.callerPic;
    data['receiverId'] = this.receiverId;
    data['receiverName'] = this.receiverName;
    data['receiverPic'] = this.receiverPic;
    data['channelId'] = this.channelId;
    data['hasDialed'] = this.hasDialed;
    return data;
  }
}
