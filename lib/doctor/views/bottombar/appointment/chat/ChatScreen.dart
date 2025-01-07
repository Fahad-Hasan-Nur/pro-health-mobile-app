// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/ApiList.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/constants/app_string.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/doctor/services/chat/chat_service_doctor.dart';
import 'package:pro_health/doctor/views/bottombar/appointment/chat/image_view.dart';
import 'package:pro_health/patient/models/chatlist_patient.dart';
import 'package:pro_health/patient/views/bottombar/message/widgets/camera_icon.dart';
import 'package:pro_health/patient/views/bottombar/message/widgets/gallery_icon.dart';

// ignore: must_be_immutable
class ChatScrenpage extends StatefulWidget {
  ChatScrenpage({Key? key, this.title, this.chatList}) : super(key: key);

  final String? title;
  ChatList? chatList;

  @override
  _ChatScrenpageState createState() => _ChatScrenpageState();
}

class _ChatScrenpageState extends State<ChatScrenpage> {
  TextEditingController _messageController = TextEditingController();
  ChatServicesDoctor chatServicesDoctor = ChatServicesDoctor();
  ApiServices apiServices = ApiServices();
  bool _isTyping = false;

  var _timer;

  List chatMessage = [];

  handleSubmit() async {
    String msg = _messageController.text;
    _messageController.clear();

    Map body = {
      "memberID": widget.chatList!.memberID,
      "patientID": widget.chatList!.patientID,
      "doctorID": 0,
      "chatListID": widget.chatList!.chatListID ?? 0,
      "roomID": widget.chatList!.roomID ?? '',
      "sender": DoctorString,
      "message": msg,
      "attachment": "",
      "createOn": getTimeNow(),
      "seenByDoctor": true,
      "seenByPatient": false,
      "isDoctor": true,
      "isPatient": false,
    };
    var response = await apiServices.sendMessageToDb(body);
  }

  _getMessages() async {
    updateChatMessageStatus();
    var response =
        await chatServicesDoctor.getMessages(widget.chatList!.roomID ?? '');

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
                reciever: item.sender == DoctorString ? true : false,
              ),
            );
          });
        }
      }
    }

    print(chatMessage.length);
  }

  updateChatMessageStatus() async {
    await apiServices.updateDoctorMsgSeenStatus(widget.chatList!.roomID ?? '');
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
                // CircleAvatar(
                //   backgroundImage: NetworkImage(
                //       //widget.chatList!.userimage!
                //       "https://images.megapixl.com/6244/62449823.jpg"),
                //   maxRadius: 20,
                // ),
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue,
                    image: DecorationImage(
                      image: (widget.chatList!.profilePic == '' ||
                                  widget.chatList!.profilePic == 'null'
                              ? AssetImage(patientNoImagePath)
                              : NetworkImage(dynamicImageGetApi +
                                  widget.chatList!.profilePic!))
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
                        widget.chatList!.patientName ?? '',
                        style: TextStyle(
                            color: kTitleColor, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    errorDialog(context, "Video call API integration failed."),
              ),
              icon: Icon(
                Icons.videocam_rounded,
                color: Colors.grey[200],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    errorDialog(context, "Voice call API integration failed."),
              ),
              icon: Icon(
                Icons.call,
                color: Colors.grey[200],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.more_vert,
              color: Colors.grey[200],
            ),
          ),
        ],
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
                              isDoctor: true,
                              chatList: widget.chatList,
                            ),
                            SizedBox(width: 40),
                            GalleryIconChat(
                              isDoctor: true,
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
                        hintText: "Type message...",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
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
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),

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
                          Get.to(
                            ImageViewPage(
                              imageUrl: dynamicImageGetApi +
                                  widget.chatMessage!.attachment!,
                            ),
                          );
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
        // child: Align(
        //   alignment: (!widget.chatMessage!.reciever!
        //       ? Alignment.topLeft
        //       : Alignment.topRight),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       color: (widget.chatMessage!.reciever!
        //           ? Colors.lightBlue[600]
        //           : Colors.cyan[50]),
        //     ),
        //     padding: EdgeInsets.all(16),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.end,
        //       children: [
        //         Text(widget.chatMessage!.message!),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}

// // ignore: must_be_immutable
// class ChatWidget extends StatelessWidget {
//   ChatWidget({Key? key, this.chat, this.memberId, required this.controller})
//       : super(key: key);
//   final memberId;
//   ChatList? chat;
//   final AppointmentController controller;
//   @override
//   Widget build(BuildContext context) {
//     return ChatWidgetPage(
//       chat: chat,
//       memberId: this.memberId,
//     );
//   }
// }

// // ignore: must_be_immutable
// class ChatWidgetPage extends StatefulWidget {
//   ChatWidgetPage({Key? key, this.title, this.chat, this.memberId})
//       : super(key: key);
//   final memberId;
//   final String? title;
//   ChatList? chat;

//   @override
//   _ChatWidgetPageState createState() => _ChatWidgetPageState();
// }

// class _ChatWidgetPageState extends State<ChatWidgetPage> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return ChatScrenpage(
//             chatList: widget.chat,
//           );
//           // return ChatScreen(
//           //   chat: widget.chat,
//           // );
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
//                       CircleAvatar(
//                         backgroundImage: NetworkImage(
//                             //widget.chat!.userimage! ??
//                             "https://images.megapixl.com/6244/62449823.jpg"),
//                         maxRadius: 30,
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
//                                 widget.chat!.patientName ?? '',
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
//                                     overflow: TextOverflow.ellipsis,
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
