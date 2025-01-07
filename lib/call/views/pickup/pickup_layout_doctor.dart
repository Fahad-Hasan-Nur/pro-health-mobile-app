// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pro_health/call/controllers/call_controller.dart';
// import 'package:pro_health/call/controllers/doctor_call_controller.dart';
// import 'package:pro_health/call/controllers/patient_call_controller.dart';
// import 'package:pro_health/call/models/call.dart';
// import 'package:pro_health/call/views/pickup/pickup_screen.dart';

// class PickupLayoutDoctor extends StatelessWidget {
//   PickupLayoutDoctor({Key? key, required this.scaffold}) : super(key: key);

//   final Widget scaffold;
//   // final CallController callController = CallController();
//   final DoctorCallController doctorCallController =
//       Get.put(DoctorCallController(), permanent: true);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return doctorCallController.calls.isNotEmpty
//           ? PickupScreen(call: doctorCallController.calls[0])
//           : scaffold;
//     });
//   }
// }
