// import 'package:pro_health/call/models/call.dart';
// import 'package:pro_health/call/services/call_service.dart';
// import 'package:get/get.dart';

// class CallController extends GetxController {
//   CallService callService = CallService();
//   var onGoingCall = false.obs;
//   var currentCall = Call().obs;

//   makeCall({required Call call}) async {
//     var response = await callService.makeNewCall(call: call);
//     return response;
//   }

//   endCall({required Call call}) async {
//     bool callEnded = await callService.endCall(call: call);
//     if (callEnded) {
//       onGoingCall.value = false;
//     }
//   }
// }

import 'package:pro_health/call/models/call.dart';
import 'package:pro_health/call/services/call_service.dart';
import 'package:get/get.dart';

class CallController extends GetxController {
  CallService callService = CallService();
  var onGoingCall = false.obs;

  makeCall({required Call call}) async {
    var response = await callService.makeNewCall(call: call);
    return response;
  }

  endCall({required Call call}) async {
    bool callEnded = await callService.endCall(call: call);
    if (callEnded) {
      onGoingCall.value = false;
    }
  }
}
