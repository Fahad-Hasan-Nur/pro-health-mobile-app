// ignore_for_file: unused_catch_clause

import 'dart:convert';
import 'dart:math';

import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/ApiList.dart';
import 'package:pro_health/doctor/models/chat/single_chat_model.dart';
import 'package:http/http.dart' as http;
import 'package:pro_health/patient/models/chatlist_patient.dart';
import 'package:uuid/uuid.dart';

class ChatServicesPatient {
  // Future<ApiResponse> getChatMessages(var chatListId) async {
  //   ApiResponse apiResponse = ApiResponse();
  //   try {
  //     final response = await http
  //         .get(Uri.parse(singleChatApi + chatListId.toString()), headers: {
  //       'Accept': 'application/json',
  //     });

  //     switch (response.statusCode) {
  //       case 200:
  //         apiResponse.data = jsonDecode(response.body)
  //             .map((p) => SingleChatModel.fromJson(p))
  //             .toList();
  //         apiResponse.data as List<dynamic>;
  //         break;

  //       default:
  //         apiResponse.error = somethingWentWrong;
  //         break;
  //     }
  //   } catch (e) {
  //     apiResponse.error = serverError;
  //   }
  //   return apiResponse;
  // }

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

  Future updatePatientMsgSeenStatus(String rooomID) async {
    var query =
        "update chat set SeenByPatient = 'true' where RoomID = '$rooomID'";
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

  Future sendMessageToDb(Map bodyMap) async {
    print(bodyMap);
    var memberID = bodyMap['memberID'];
    var patientID = bodyMap['patientID'];
    var doctorID = bodyMap['doctorID'] ?? 0;
    var chatListID = bodyMap['chatListID'];
    var roomID = bodyMap['roomID'];
    var sender = bodyMap['sender'];
    var message = bodyMap['message'];
    var attachment = bodyMap['attachment'];
    var createOn = bodyMap['createOn'];
    var seenByDoctor = bodyMap['seenByDoctor'];
    var seenByPatient = bodyMap['seenByPatient'];
    var isDoctor = bodyMap['isDoctor'];
    var isPatient = bodyMap['isPatient'];

    var query =
        "insert into chat(MemberID, PatientID,  DoctorID, ChatListID, RoomID, Sender, Message, Attachment, CreateOn, SeenByDoctor, SeenByPatient, IsDoctor, IsPatient) Values('$memberID', '$patientID','$doctorID', '$chatListID', '$roomID', N'$sender', N'$message', '$attachment', '$createOn', '$seenByDoctor', '$seenByPatient', '$isDoctor', '$isPatient' )";
    // "insert into chat(MemberID, PatientID,  DoctorID, ChatListID, Sender, Message, Attachment, CreateOn, SeenByDoctor, SeenByPatient, IsDoctor, IsPatient) Values('$memberID', '$patientID','$doctorID', '$chatListID', '$sender', '$message', '$attachment', '$createOn', '$seenByDoctor', '$seenByPatient', '$isDoctor', '$isPatient' )";
    print(query);
    // print(query);

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
    int patientId = await getPatientId();

    var url = Uri.parse(chatlistPatientApi + patientId.toString());

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

          if (chats.isNotEmpty) {
            List<SingleChatModel> unseenChats = [];
            chat.lastMessage = chats.last.message;
            chat.timeAgo = getTimeAgo(chats.last.createOn ?? '');
            for (var item in chats) {
              bool isSeen = item.seenByPatient ?? false;
              if (!isSeen) {
                unseenChats.add(item);
              }
            }
            print(unseenChats);

            chat.unseenMsgCount = unseenChats.length;
          }

          chat.isOnline = item['isOnline'];
          chatList.add(chat);
        }
      }
    } catch (e) {
      //
    }

    return chatList;
  }

  Future<Map<String, dynamic>> checkIfRoomExists(int memeberId) async {
    Map<String, dynamic> chatListMap = {"exists": false, "roomID": ''};
    int patientId = await getPatientId();
    List chatslist = [];
    var url = Uri.parse(chatlistPatientApi + patientId.toString());
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          if (item['memberID'] == memeberId) {
            chatslist.add(item);
            break;
          }
        }
        if (chatslist.isNotEmpty) {
          chatListMap['exists'] = true;
          chatListMap['chatlist'] = chatslist[0];
          chatListMap['roomID'] = chatslist[0]['roomID'];
          return chatListMap;
        }
      }
    } catch (e) {
      //
    }

    return chatListMap;
  }

  Future<Map<String, dynamic>> createChatList(
      int memberId, int doctorId) async {
    ChatList chatList = ChatList();
    Map<String, dynamic> chatListMap = {"created": false};
    Map<String, dynamic> roomExists = await checkIfRoomExists(memberId);

    if (roomExists['exists']) {
      String roomID = roomExists['roomID'];
      var chat = roomExists['chatlist'];

      chatList.memberID = chat['memberID'];
      chatList.patientID = chat['patientID'];
      chatList.chatListID = chat['chatListID'];
      chatList.roomID = roomID;
      chatList.patientName = chat['patientName'];
      chatList.doctorName = chat['doctorName'];
      chatList.profilePic = chat['profilePic'];
      chatList.isOnline = chat['isOnline'];
      chatList.profilePicture = getDoctorProfilePic(chat['profilePicture']);

      chatListMap['created'] = false;
      chatListMap['chatlist'] = chatList;
    } else {
      int patientId = await getPatientId();
      String roomId = generateRoomId();
      String createdOn = getTimeNow();

      String query =
          "insert into ChatList(DoctorID, MemberID, PatientID, RoomID, CreatedOn) values('$doctorId','$memberId','$patientId','$roomId','$createdOn')";

      var url = Uri.parse(postApi + query);

      try {
        var response = await http.post(url);
        if (response.statusCode == 200) {
          chatList.memberID = memberId;
          chatList.roomID = roomId;
          chatList.patientID = patientId;

          chatListMap['created'] = true;
          chatListMap['chatlist'] = chatList;
        }
      } catch (e) {
        //
      }
    }

    return chatListMap;
  }

  generateRoomId() {
    var uuid = Uuid();
    String uid = uuid.v1();
    var rng = Random();
    var code = rng.nextInt(900000) + 100000;
    var time = DateTime.now().millisecondsSinceEpoch;
    return "$uid-$code-$time";
  }

  // Future<ApiResponse> getChatList() async {
  //   int patientId = await getPatientId();
  //   ApiResponse apiResponse = ApiResponse();
  //   try {
  //     final response = await http
  //         .get(Uri.parse(chatListApi + patientId.toString()), headers: {
  //       'Accept': 'application/json',
  //     });

  //     switch (response.statusCode) {
  //       case 200:
  //         apiResponse.data = jsonDecode(response.body)
  //             .map((p) => ChatListPatient.fromJson(p))
  //             .toList();
  //         apiResponse.data as List<dynamic>;
  //         break;

  //       default:
  //         apiResponse.error = somethingWentWrong;
  //         break;
  //     }
  //   } catch (e) {
  //     apiResponse.error = serverError;
  //   }
  //   return apiResponse;
  // }

}
