// import 'package:get/get.dart';
// import 'package:pro_health/base/helper_functions.dart';
// import 'package:pro_health/call/models/call.dart';
// import 'package:pro_health/call/services/call_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DoctorCallController extends GetxController {
//   CallService callService = CallService();
//   var calls = <Call>[].obs;

//   getDoctorCalls() async {
//     int memberId = await getDoctorMemberId();
//     var response = await callService.getDoctorCalls(memberId);
//     if (response.isEmpty) {
//       if (calls.isNotEmpty) {
//         calls.clear();
//       }
//     } else {
//       if (calls.isEmpty) {
//         calls.addAll(response);
//       }
//     }
//   }

//   @override
//   void onInit() {
//     // interval(calls, (callback) => null)
//     getDoctorCalls();
//     super.onInit();
//   }
// }

import 'dart:async';

import 'package:get/get.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/call/models/call.dart';
import 'package:pro_health/call/services/call_service.dart';

class DoctorCallController extends GetxController {
  CallService callService = CallService();
  var calls = <Call>[].obs;

  getDoctorCalls() async {
    // print('getdoctorcalls function listening');
    int memberId = await getDoctorMemberId();
    var response = await callService.getDoctorCalls(memberId);

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
  }

  @override
  void onInit() {
    // interval(calls, (callback) => null)
    // print('controller calling');

    getDoctorCalls();
    Timer.periodic(Duration(seconds: 2), (timer) => getDoctorCalls());
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
