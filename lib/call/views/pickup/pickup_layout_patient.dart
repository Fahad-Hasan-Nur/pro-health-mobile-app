// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pro_health/call/controllers/call_controller.dart';
// import 'package:pro_health/call/controllers/patient_call_controller.dart';
// import 'package:pro_health/call/models/call.dart';
// import 'package:pro_health/call/views/pickup/pickup_screen.dart';

// class PickupLayoutPatient extends StatelessWidget {
//   PickupLayoutPatient({Key? key, required this.scaffold}) : super(key: key);

//   final Widget scaffold;
//   // final CallController callController = CallController();
//   final PatientCallController patientCallController =
//       Get.put(PatientCallController(), permanent: true);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return patientCallController.calls.isNotEmpty
//           ? PickupScreen(call: patientCallController.calls[0])
//           : scaffold;
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_health/call/controllers/patient_call_controller.dart';
import 'package:pro_health/call/views/pickup/pickup_screen.dart';

class PickupLayoutPatient extends StatelessWidget {
  PickupLayoutPatient({Key? key, required this.scaffold}) : super(key: key);

  final Widget scaffold;
  // final CallController callController = CallController();
  final PatientCallController patientCallController =
      Get.put(PatientCallController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return patientCallController.calls.isNotEmpty
          ? PickupScreen(call: patientCallController.calls[0])
          : scaffold;
    });
  }
}
