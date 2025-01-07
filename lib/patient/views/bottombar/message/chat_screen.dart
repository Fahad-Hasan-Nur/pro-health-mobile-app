// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';
// import 'package:pro_health/base/utils/constants.dart';
// import 'package:pro_health/patient/models/chatlist_patient.dart';
// import 'global.dart';
// import 'widgets.dart';

// // ignore: must_be_immutable
// class ChatScreen extends StatelessWidget {
//   ChatScreen({Key? key, required this.chatList}) : super(key: key);

//   ChatList chatList;

//   @override
//   Widget build(BuildContext context) {
//     return ChatScrenpage(
//       chatList: chatList,
//     );
//   }
// }

// // ignore: must_be_immutable
// class ChatScrenpage extends StatefulWidget {
//   ChatScrenpage({Key? key, this.title, this.chatList}) : super(key: key);

//   final String? title;
//   ChatList? chatList;

//   @override
//   _ChatScrenpageState createState() => _ChatScrenpageState();
// }

// class _ChatScrenpageState extends State<ChatScrenpage> {
//   File? myImage;
//   Future openCamera() async {
//     // ignore: deprecated_member_use
//     var cameraImage = await ImagePicker().pickImage(source: ImageSource.camera);
//     setState(() {
//       myImage = File(cameraImage!.path);
//     });
//   }

//   List<Asset> images = <Asset>[];
//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<void> addPhotos() async {
//     List<Asset> resultList = <Asset>[];
//     try {
//       resultList = await MultiImagePicker.pickImages(
//         maxImages: 10,
//         enableCamera: true,
//         selectedAssets: images,
//         materialOptions: MaterialOptions(
//           statusBarColor: "#01619B",
//           actionBarColor: "#01619B",
//           actionBarTitle: "All Photos",
//           allViewTitle: "Selected Photos",
//           useDetailsView: false,
//           selectCircleStrokeColor: "#01619B",
//         ),
//       );
//     } on Exception {}
//     if (!mounted) return;
//     setState(() {
//       images = resultList;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           color: Colors.grey[200],
//           icon: Icon(Icons.arrow_back),
//         ),
//         flexibleSpace: SafeArea(
//           child: Container(
//             padding: EdgeInsets.only(right: 16),
//             child: Row(
//               children: <Widget>[
//                 SizedBox(
//                   width: 55,
//                 ),
//                 CircleAvatar(
//                   backgroundImage:
//                       NetworkImage(widget.chatList!.profilePicture ?? ''),
//                   maxRadius: 20,
//                 ),
//                 SizedBox(
//                   width: 12,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         widget.chatList!.doctorName ?? '',
//                         style: TextStyle(
//                             color: kTitleColor, fontWeight: FontWeight.w900),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         actions: [
//           Container(
//             width: 40,
//             padding: EdgeInsets.only(right: 20),
//             child: IconButton(
//               padding: EdgeInsets.all(1),
//               icon: Icon(Icons.videocam_rounded),
//               color: Colors.grey[200],
//               onPressed: () {},
//             ),
//           ),
//           Container(
//             width: 40,
//             height: 40,
//             padding: EdgeInsets.only(right: 20),
//             child: IconButton(
//               padding: EdgeInsets.all(1),
//               icon: Icon(Icons.more_vert),
//               color: Colors.grey[200],
//               onPressed: () {},
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: kBackgroundColor,
//       body: Stack(
//         children: <Widget>[
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(15),
//               itemCount: messages.length,
//               itemBuilder: (ctx, i) {
//                 if (messages[i]['status'] == MessageType.received) {
//                   return ReceivedMessagesWidget(i: i);
//                 } else {
//                   return SentMessageWidget(i: i);
//                 }
//               },
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: Container(
//               height: 60,
//               padding: EdgeInsets.only(left: 10, top: 8, bottom: 8, right: 8),
//               width: double.infinity,
//               color: kTitleColor,
//               child: Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         hintText: "Write a message",
//                         hintStyle: TextStyle(
//                           fontFamily: 'Segoe',
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         contentPadding:
//                             EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0)),
//                         suffixIcon: Container(
//                           height: 30,
//                           width: 30,
//                           padding: EdgeInsets.all(5),
//                           child: FloatingActionButton(
//                             onPressed: () {
//                               addPhotos();
//                             },
//                             child: Icon(
//                               Icons.attach_file_rounded,
//                               color: Colors.grey[800],
//                               size: 25,
//                             ),
//                             backgroundColor: Colors.white,
//                             elevation: 0,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 40,
//                     height: 50,
//                     padding: EdgeInsets.all(3),
//                     child: FloatingActionButton(
//                       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                       onPressed: () {
//                         openCamera();
//                       },
//                       child: Icon(
//                         Icons.camera_alt_outlined,
//                         color: Colors.grey[800],
//                         size: 25,
//                       ),
//                       backgroundColor: kTitleColor,
//                       elevation: 0,
//                     ),
//                   ),
//                   Container(
//                     width: 50,
//                     height: 50,
//                     padding: EdgeInsets.all(1),
//                     child: Center(
//                       child: FloatingActionButton(
//                         onPressed: () {},
//                         child: Icon(
//                           Icons.send,
//                           color: Colors.grey[800],
//                           size: 25,
//                         ),
//                         backgroundColor: kTitleColor,
//                         elevation: 1,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ChatMessage {
//   String? message;
//   bool? reciever;
//   ChatMessage({this.message, this.reciever});
// }

// // class ChatList {
// //   String? name;
// //   String? lastMessage;
// //   String? userimage;
// //   String? time;
// //   String? noOfMessage;

// //   ChatList(
// //       {this.name,
// //       this.lastMessage,
// //       this.userimage,
// //       this.time,
// //       this.noOfMessage});
// // }

// // ignore: must_be_immutable
// class MessageWidget extends StatelessWidget {
//   MessageWidget({Key? key, this.chatMessage}) : super(key: key);
//   ChatMessage? chatMessage;
//   @override
//   Widget build(BuildContext context) {
//     return MessageWidgetPage(
//       chatMessage: chatMessage,
//     );
//   }
// }

// // ignore: must_be_immutable
// class MessageWidgetPage extends StatefulWidget {
//   MessageWidgetPage({Key? key, this.title, this.chatMessage}) : super(key: key);

//   final String? title;
//   ChatMessage? chatMessage;

//   @override
//   _MessageWidgetPageState createState() => _MessageWidgetPageState();
// }

// class _MessageWidgetPageState extends State<MessageWidgetPage> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
//         child: Align(
//           alignment: (!widget.chatMessage!.reciever!
//               ? Alignment.topLeft
//               : Alignment.topRight),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: (widget.chatMessage!.reciever!
//                   ? Colors.lightBlue[600]
//                   : Colors.cyan[50]),
//             ),
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(widget.chatMessage!.message!),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ignore: must_be_immutable
// class ChatWidget extends StatelessWidget {
//   ChatWidget({Key? key, this.chat}) : super(key: key);

//   ChatList? chat;
//   @override
//   Widget build(BuildContext context) {
//     return ChatWidgetPage(
//       chat: chat,
//     );
//   }
// }

// // ignore: must_be_immutable
// class ChatWidgetPage extends StatefulWidget {
//   ChatWidgetPage({Key? key, this.title, this.chat}) : super(key: key);

//   final String? title;
//   ChatList? chat;

//   @override
//   _ChatWidgetPageState createState() => _ChatWidgetPageState();
// }

// class _ChatWidgetPageState extends State<ChatWidgetPage> {
//   double radius = 32;
//   double iconSize = 20;
//   double distance = 2;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return ChatScreen(
//             chatList: widget.chat!,
//           );
//         }));
//       },
//       child: Container(
//         child: Center(
//           child: Container(
//             padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   child: Row(
//                     children: <Widget>[
//                       Stack(
//                         clipBehavior: Clip.none,
//                         children: [
//                           CircleAvatar(
//                             radius: 32,
//                             backgroundColor: kBodyTextColor,
//                             child: CircleAvatar(
//                               backgroundColor: kWhiteShade,
//                               radius: 31,
//                               child: CircleAvatar(
//                                 backgroundColor: Colors.white,
//                                 backgroundImage: NetworkImage(
//                                     widget.chat!.profilePicture ?? ''),
//                                 maxRadius: 30,
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             top: -(radius + 5),
//                             right: -(radius + 15),
//                             bottom: -iconSize - distance - 50,
//                             left: 5,
//                             child: Icon(
//                               Icons.circle,
//                               color: Color(0xff6ECEC0),
//                               size: iconSize - 4,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         width: 16,
//                       ),
//                       Expanded(
//                         child: Container(
//                           color: Colors.transparent,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Text(
//                                 widget.chat!.doctorName ?? '',
//                                 style: TextStyle(
//                                     color: Colors.black54,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18),
//                               ),
//                               SizedBox(
//                                 height: 6,
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     widget.chat!.lastMessage!,
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey.shade500),
//                                   ),
//                                   SizedBox(
//                                     width: 6,
//                                   ),
//                                   Text(
//                                     '.',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey.shade500),
//                                   ),
//                                   SizedBox(
//                                     width: 6,
//                                   ),
//                                   Text(
//                                     widget.chat!.timeAgo ?? '',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey.shade500),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       widget.chat!.unseenMsgCount == 0
//                           ? SizedBox.shrink()
//                           : Container(
//                               height: 20,
//                               width: 20,
//                               decoration: BoxDecoration(
//                                   color: Colors.lightBlue[900],
//                                   borderRadius: BorderRadius.circular(50)),
//                               child: Center(
//                                   child: Text(
//                                 '${widget.chat!.unseenMsgCount ?? 0}',
//                                 style: TextStyle(color: Colors.white),
//                               )),
//                             )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/ApiList.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/constants/app_string.dart';
import 'package:pro_health/doctor/views/bottombar/appointment/chat/image_view.dart';
import 'package:pro_health/patient/controllers/chat_controller.dart';
import 'package:pro_health/patient/models/chatlist_patient.dart';
import 'package:pro_health/patient/service/dashboard/chat_service.dart';
import 'package:pro_health/patient/views/bottombar/message/widgets/camera_icon.dart';
import 'package:pro_health/patient/views/bottombar/message/widgets/gallery_icon.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, this.title, this.chatList}) : super(key: key);

  final String? title;
  ChatList? chatList;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();
  ChatServicesPatient chatServicesPatient = ChatServicesPatient();
  // ApiServices apiServices = ApiServices();
  ChatControllerPatient chatControllerPatient = ChatControllerPatient();
  bool _isTyping = false;

  var _timer;

  List chatMessage = [];

  handleSubmit() async {
    String msg = _messageController.text;
    _messageController.clear();

    int patientId = await getPatientId();

    Map body = {
      "memberID": widget.chatList!.memberID ?? 0,
      "patientID": patientId,
      "chatListID": widget.chatList!.chatListID,
      "roomID": widget.chatList!.roomID,
      "sender": PatientString,
      "message": msg,
      "attachment": "",
      "createOn": getTimeNow(),
      "seenByDoctor": false,
      "seenByPatient": true,
      "isDoctor": false,
      "isPatient": true,
    };
    await chatServicesPatient.sendMessageToDb(body);
  }

  _getMessages() async {
    updateChatMessageStatus();
    var response =
        await chatServicesPatient.getMessages(widget.chatList!.roomID ?? '');

    if (response.isNotEmpty) {
      for (var item in response) {
        var contain = chatMessage.where((chat) => chat.chatID == item.chatID);
        if (contain.isEmpty) {
          setState(() {
            chatMessage.insert(
              0,
              ChatMessage(
                chatID: item.chatID,
                memberID: item.memberID,
                patientID: item.patientID,
                chatListID: item.chatListID,
                roomID: item.roomID,
                sender: item.sender,
                attachment: item.attachment,
                message: item.message,
                reciever: item.sender == PatientString ? true : false,
              ),
            );
          });
        }
      }
    }
  }

  updateChatMessageStatus() async {
    print('update status');

    await chatServicesPatient
        .updatePatientMsgSeenStatus(widget.chatList!.roomID ?? '');
  }

  @override
  void initState() {
    _getMessages();

    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer t) {
      _getMessages();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.grey[200],
          icon: Icon(Icons.arrow_back),
        ),
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 55,
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                    image: DecorationImage(
                      image: (widget.chatList!.profilePicture == '' ||
                                  widget.chatList!.profilePicture == 'null'
                              ? AssetImage(noImagePath)
                              : NetworkImage(widget.chatList!.profilePicture!))
                          as ImageProvider<Object>,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.chatList!.doctorName ?? '',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // actions: [
        //   Container(
        //     padding: EdgeInsets.only(right: 20),
        //     child: IconButton(
        //       onPressed: () => showDialog<String>(
        //         context: context,
        //         builder: (BuildContext context) =>
        //             errorDialog(context, "Video call API integration failed."),
        //       ),
        //       icon: Icon(
        //         Icons.videocam_rounded,
        //         color: Colors.grey[200],
        //       ),
        //     ),
        //   ),
        //   Container(
        //     padding: EdgeInsets.only(right: 20),
        //     child: IconButton(
        //       onPressed: () => showDialog<String>(
        //         context: context,
        //         builder: (BuildContext context) =>
        //             errorDialog(context, "Voice call API integration failed."),
        //       ),
        //       icon: Icon(
        //         Icons.call,
        //         color: Colors.grey[200],
        //       ),
        //     ),
        //   ),
        //   Container(
        //     padding: EdgeInsets.only(right: 20),
        //     child: Icon(
        //       Icons.more_vert,
        //       color: Colors.grey[200],
        //     ),
        //   ),
        // ],
      ),
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: chatMessage.length,
            // shrinkWrap: true,
            reverse: true,
            padding: EdgeInsets.only(top: 10, bottom: 65),
            // physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return MessageWidget(
                chatMessage: chatMessage[index],
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 16, bottom: 10),
              height: 60,
              width: double.infinity,
              color: Colors.grey[800],
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                        title: 'Select Option',
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CameraIconChat(
                              isDoctor: false,
                              chatList: widget.chatList,
                            ),
                            SizedBox(width: 40),
                            GalleryIconChat(
                              isDoctor: false,
                              chatList: widget.chatList,
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.image,
                        color: Colors.white,
                        size: 21,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: "Type message...",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                      controller: _messageController,
                      onChanged: (val) {
                        if (val.length > 0) {
                          setState(() {
                            _isTyping = true;
                          });
                        } else {
                          setState(() {
                            _isTyping = false;
                          });
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    width: 60,
                    height: 60,
                    child: Center(
                      child: FloatingActionButton(
                        onPressed: () {
                          if (_isTyping) {
                            handleSubmit();
                          } else
                            return null;
                        },
                        child: Icon(
                          Icons.send,
                          color: _isTyping ? Colors.white : Colors.black,
                          size: 25,
                        ),
                        backgroundColor: kBaseColor,
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget errorDialog(BuildContext context, String text) {
    return AlertDialog(
      title: const Text(
        'Error!',
        textAlign: TextAlign.center,
      ),
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text(
                'Ok',
                style: TextStyle(fontSize: 17),
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ],
    );
  }
}

class ChatMessage {
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
  String? time;
  bool? isDoctor;
  bool? isPatient;
  bool? reciever;
  ChatMessage({
    this.message,
    this.reciever,
    this.chatID,
    this.memberID,
    this.patientID,
    this.chatListID,
    this.roomID,
    this.sender,
    this.attachment,
    this.createOn,
    this.seenByDoctor,
    this.seenByPatient,
    this.time,
    this.isDoctor,
    this.isPatient,
  });
}

// ignore: must_be_immutable
class MessageWidget extends StatelessWidget {
  MessageWidget({Key? key, this.chatMessage}) : super(key: key);
  ChatMessage? chatMessage;
  @override
  Widget build(BuildContext context) {
    return MessageWidgetPage(
      chatMessage: chatMessage,
    );
  }
}

// ignore: must_be_immutable
class MessageWidgetPage extends StatefulWidget {
  MessageWidgetPage({Key? key, this.title, this.chatMessage}) : super(key: key);

  final String? title;
  ChatMessage? chatMessage;

  @override
  _MessageWidgetPageState createState() => _MessageWidgetPageState();
}

class _MessageWidgetPageState extends State<MessageWidgetPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
        child: Align(
          alignment: (!widget.chatMessage!.reciever!
              ? Alignment.topLeft
              : Alignment.topRight),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: widget.chatMessage!.attachment!.isNotEmpty
                  ? Colors.transparent
                  : (widget.chatMessage!.reciever!
                      ? Colors.lightBlue[600]
                      : Colors.cyan[50]),
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                widget.chatMessage!.attachment!.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          Get.to(ImageViewPage(
                              imageUrl: dynamicImageGetApi +
                                  widget.chatMessage!.attachment!));
                        },
                        child: Container(
                          width: size.width / 2,
                          height: size.width / 2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(dynamicImageGetApi +
                                  widget.chatMessage!.attachment!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : Text(
                        widget.chatMessage!.message ?? '',
                        style: TextStyle(
                          fontSize: 17,
                          color: widget.chatMessage!.reciever!
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
