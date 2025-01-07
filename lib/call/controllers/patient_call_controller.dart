// import 'dart:async';

// import 'package:get/get.dart';
// import 'package:pro_health/base/helper_functions.dart';
// import 'package:pro_health/call/models/call.dart';
// import 'package:pro_health/call/services/call_service.dart';

// class PatientCallController extends GetxController {
//   CallService callService = CallService();
//   var calls = <Call>[].obs;

//   getPatientCalls() async {
//     int patientId = await getPatientId();
//     var response = await callService.getPatientCalls(patientId);
//     if (response.isEmpty) {
//       if (calls.isNotEmpty) {
//         calls.clear();
//       }
//     } else {
//       if (calls.isEmpty) {
//         calls.addAll(response);
//       }
//     }
//     print('calls.length = ${calls.length}');
//   }

//   endCall({required Call call}) async {
//     var response = await callService.endCall(call: call);
//   }

//   @override
//   void onInit() {
//     print('patient pickup layout and controller working');
//     getPatientCalls();
//     Timer.periodic(Duration(seconds: 2), (timer) => getPatientCalls());
//     super.onInit();
//   }
// }

// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:get/get.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/call/models/call.dart';
import 'package:pro_health/call/services/call_service.dart';

class PatientCallController extends GetxController {
  CallService callService = CallService();
  var calls = <Call>[].obs;

  getPatientCalls() async {
    int patientId = await getPatientId();
    var response = await callService.getPatientCalls(patientId);
    if (response.isEmpty) {
      if (calls.isNotEmpty) {
        calls.clear();
        Get.back(result: 'The call ended');
      }
    } else {
      if (calls.isEmpty) {
        calls.addAll(response);
      }
    }
    print('calls.length = ${calls.length}');
  }

  endCall({required Call call}) async {
    var response = await callService.endCall(call: call);
  }

  @override
  void onInit() {
    getPatientCalls();
    Timer.periodic(Duration(seconds: 2), (timer) => getPatientCalls());
    super.onInit();
  }
}
