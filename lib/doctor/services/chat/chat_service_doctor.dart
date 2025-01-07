// ignore_for_file: unused_catch_clause

import 'dart:convert';

import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/ApiList.dart';
import 'package:pro_health/doctor/models/chat/single_chat_model.dart';
import 'package:http/http.dart' as http;
import 'package:pro_health/patient/models/chatlist_patient.dart';

class ChatServicesDoctor {
  Future<List<SingleChatModel>> getMessages(String roomId) async {
    List<SingleChatModel> chats = [];
    var url = Uri.parse(singleChatApi + roomId);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          chats.add(SingleChatModel.fromJson(item));
        }
      }
    } catch (e) {
      //
    }
    return chats;
  }

  Future sendMessageToDb(Map bodyMap) async {
    var memberID = bodyMap['memberID'];
    var patientID = bodyMap['patientID'];
    var doctorID = bodyMap['doctorID'];
    var chatListID = bodyMap['chatListID'];
    var sender = bodyMap['sender'];
    var message = bodyMap['message'];
    var attachment = bodyMap['attachment'];
    var createOn = bodyMap['createOn'];
    var seenByDoctor = bodyMap['seenByDoctor'];
    var seenByPatient = bodyMap['seenByPatient'];
    var isDoctor = bodyMap['isDoctor'];
    var isPatient = bodyMap['isPatient'];

    var query =
        "insert into chat(MemberID, PatientID,  DoctorID, ChatListID, Sender, Message, Attachment, CreateOn, SeenByDoctor, SeenByPatient, IsDoctor, IsPatient) Values('$memberID', '$patientID','$doctorID', '$chatListID', N'$sender', N'$message', '$attachment', '$createOn', '$seenByDoctor', '$seenByPatient', '$isDoctor', '$isPatient' )";

    var url = Uri.parse(postApi + query);

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<ChatList>> getChatList() async {
    List<ChatList> chatList = [];
    int memberId = await getDoctorMemberId();

    var url = Uri.parse(chatListApi + memberId.toString());

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        // print('jsonData $jsonData');
        for (var item in jsonData) {
          List<SingleChatModel> chats = await getMessages(item['roomID']);

          ChatList chat = ChatList();

          chat.chatListID = item['chatListID'];
          chat.roomID = item['roomID'];
          chat.memberID = item['memberID'];
          chat.patientID = item['patientID'];
          chat.patientName = item['patientName'];
          chat.profilePic = item['profilePic'];
          chat.doctorName = item['doctorName'];
          String profilepic = getDoctorProfilePic(item['profilePicture']);
          chat.profilePicture = profilepic;
          chat.profilePic = item['profilePic'] ?? '';

          if (chats.isNotEmpty) {
            List<SingleChatModel> unseenChats = [];
            chat.lastMessage = chats.last.message;
            chat.timeAgo = getTimeAgo(chats.last.createOn ?? '');
            for (var item in chats) {
              bool isSeen = item.seenByDoctor ?? false;
              if (!isSeen) {
                unseenChats.add(item);
              }
            }

            chat.unseenMsgCount = unseenChats.length;
            print(unseenChats.length);
          }

          chat.isOnline = item['isOnline'] ?? false;
          chatList.add(chat);
        }
      }
    } catch (e) {
      //
    }

    return chatList;
  }

  Future updateDoctorMsgSeenStatus(var chatListId) async {
    var query =
        "update chat set SeenByDoctor = 'true' where ChatListID = '$chatListId'";
    var url = Uri.parse(postApi + query);

    try {
      var response = await http.post(url);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      return false;
    }
  }
}
