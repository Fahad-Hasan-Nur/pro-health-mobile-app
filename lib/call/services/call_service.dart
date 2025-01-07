// import 'dart:convert';

// import 'package:pro_health/base/utils/ApiList.dart';
// import 'package:pro_health/call/models/call.dart';
// import 'package:http/http.dart' as http;

// class CallService {
//   Future<bool> makeNewCall({required Call call}) async {
//     int callerId = call.callerId ?? 0;
//     String callerName = call.callerName ?? '';
//     String callerPic = call.callerPic ?? '';
//     int receiverId = call.receiverId ?? 0;
//     String receiverName = call.receiverName ?? '';
//     String receiverPic = call.receiverPic ?? '';
//     String channelId = call.channelId ?? '';

//     String hasDialedQuery =
//         "insert into Call(CallerID, CallerName, CallerPIc, ReceiverID, ReceiverName, ReceiverPic, ChanneliD, HasDialed) values('$callerId','$callerName', '$callerPic','$receiverId','$receiverName', '$receiverPic', '$channelId', 'true')";
//     String hasNotDialedQuery =
//         "insert into Call(CallerID, CallerName, CallerPIc, ReceiverID, ReceiverName, ReceiverPic, ChanneliD, HasDialed) values('$callerId','$callerName', '$callerPic','$receiverId','$receiverName', '$receiverPic', '$channelId', 'false')";
//     var query = hasDialedQuery + ';' + hasNotDialedQuery;
//     print(query);
//     var url = Uri.parse(postApi + query);

//     try {
//       var response = await http.post(url);
//       if (response.statusCode == 200) {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }

//   Future<bool> endCall({required Call call}) async {
//     int receiverId = call.receiverId ?? 0;

//     String deleteQuery = "delete from Call where ReceiverID = '$receiverId'";

//     var url = Uri.parse(postApi + deleteQuery);

//     try {
//       var response = await http.post(url);
//       if (response.statusCode == 200) {
//         return true;
//       }
//     } catch (e) {
//       //
//     }

//     return false;
//   }

//   Future<List<Call>> getDoctorCalls(int memebrId) async {
//     List<Call> runningCalls = [];

//     var url = Uri.parse(doctorCallApi + memebrId.toString());

//     try {
//       var response = await http.get(url);
//       if (response.statusCode == 200) {
//         var jsonData = json.decode(response.body);
//         for (var item in jsonData) {
//           if (item['hasDialed']) {
//             runningCalls.add(Call.fromJson(item));
//           }
//         }
//       }
//     } catch (e) {
//       //
//     }

//     return runningCalls;
//   }

//   Future<List<Call>> getPatientCalls(int patientId) async {
//     List<Call> runningCalls = [];

//     var url = Uri.parse(patientCallApi + patientId.toString());

//     try {
//       var response = await http.get(url);
//       if (response.statusCode == 200) {
//         var jsonData = json.decode(response.body);
//         for (var item in jsonData) {
//           if (!item['hasDialed']) {
//             runningCalls.add(Call.fromJson(item));
//           }
//         }
//       }
//     } catch (e) {
//       //
//     }

//     return runningCalls;
//   }
// }

import 'dart:convert';

import 'package:pro_health/base/utils/ApiList.dart';
import 'package:pro_health/call/models/call.dart';
import 'package:http/http.dart' as http;

class CallService {
  Future<bool> makeNewCall({required Call call}) async {
    int callerId = call.callerId ?? 0;
    String callerName = call.callerName ?? '';
    String callerPic = call.callerPic ?? '';
    int receiverId = call.receiverId ?? 0;
    String receiverName = call.receiverName ?? '';
    String receiverPic = call.receiverPic ?? '';
    String channelId = call.channelId ?? '';

    String hasDialedQuery =
        "insert into Call(CallerID, CallerName, CallerPIc, ReceiverID, ReceiverName, ReceiverPic, ChanneliD, HasDialed) values('$callerId','$callerName', '$callerPic','$receiverId','$receiverName', '$receiverPic', '$channelId', 'true')";
    String hasNotDialedQuery =
        "insert into Call(CallerID, CallerName, CallerPIc, ReceiverID, ReceiverName, ReceiverPic, ChanneliD, HasDialed) values('$callerId','$callerName', '$callerPic','$receiverId','$receiverName', '$receiverPic', '$channelId', 'false')";
    var query = hasDialedQuery + ';' + hasNotDialedQuery;
    // print(query);
    var url = Uri.parse(postApi + query);

    try {
      var response = await http.post(url);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // print(e);
      return false;
    }
  }

  Future<bool> endCall({required Call call}) async {
    int receiverId = call.receiverId ?? 0;

    String deleteQuery = "delete from Call where ReceiverID = '$receiverId'";

    var url = Uri.parse(postApi + deleteQuery);

    try {
      var response = await http.post(url);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      //
    }

    return false;
  }

  Future<List<Call>> getDoctorCalls(int memebrId) async {
    List<Call> runningCalls = [];

    var url = Uri.parse(doctorCallApi + memebrId.toString());

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          if (item['hasDialed']) {
            runningCalls.add(Call.fromJson(item));
          }
        }
      }
    } catch (e) {
      //
    }

    return runningCalls;
  }

  Future<List<Call>> getPatientCalls(int patientId) async {
    List<Call> runningCalls = [];

    var url = Uri.parse(patientCallApi + patientId.toString());

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          if (!item['hasDialed']) {
            runningCalls.add(Call.fromJson(item));
          }
        }
      }
    } catch (e) {
      //
    }

    return runningCalls;
  }
}
