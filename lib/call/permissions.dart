// import 'package:get/get.dart';
// import 'package:oktoast/oktoast.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter/services.dart';

// class Permissions {
//   static Future<bool> cameraAndMicrophonePermissionsGranted() async {
//     PermissionStatus cameraPermissionStatus = await _getCameraPermission();
//     PermissionStatus microphonePermissionStatus =
//         await _getMicrophonePermission();

//     if (cameraPermissionStatus == PermissionStatus.granted &&
//         microphonePermissionStatus == PermissionStatus.granted) {
//       return true;
//     } else {
//       _handleInvalidPermissions(
//           cameraPermissionStatus, microphonePermissionStatus);
//       return false;
//     }
//   }

//   static Future<bool> checkCameraAndMicrophonePermissionGranted() async {
//     var cameraStatus = await Permission.camera.status;
//     var microphoneStatus = await Permission.microphone.status;

//     print(cameraStatus);
//     print(microphoneStatus);

//     if (!cameraStatus.isGranted) {
//       await Permission.camera.request();
//     }
//     if (!microphoneStatus.isGranted) {
//       await Permission.microphone.request();
//     }

//     if (await Permission.camera.isGranted) {
//       if (await Permission.microphone.isGranted) {
//         return true;
//       } else {
//         Get.snackbar(
//           'Need Permission',
//           'Provide Microphone Permission to record Audio',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.redAccent,
//           colorText: Colors.white,
//         );
//         // showToast('Provide Microphone permission to use audio call',
//         //     position: ToastPosition.bottom, context: );
//       }
//     } else {
//       Get.snackbar(
//         'Need Permission',
//         'Provide Camera Permission to record video',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.redAccent,
//         colorText: Colors.white,
//       );
//     }
//     return false;
//   }

//   static Future<PermissionStatus> _getCameraPermission() async {
//     PermissionStatus permission = await Permission.camera.status;
//     if (permission != PermissionStatus.granted &&
//         permission != PermissionStatus.denied) {
//       Map<Permission, PermissionStatus> permissionStatus =
//           await [Permission.camera].request();
//       return permissionStatus[Permission.camera] ?? PermissionStatus.denied;
//     } else {
//       return permission;
//     }
//   }

//   static Future<PermissionStatus> _getMicrophonePermission() async {
//     PermissionStatus permission = await Permission.microphone.status;
//     if (permission != PermissionStatus.granted &&
//         permission != PermissionStatus.denied) {
//       Map<Permission, PermissionStatus> permissionStatus =
//           await [Permission.microphone].request();
//       return permissionStatus[Permission.microphone] ?? PermissionStatus.denied;
//     } else {
//       return permission;
//     }
//   }

//   static void _handleInvalidPermissions(
//     PermissionStatus cameraPermissionStatus,
//     PermissionStatus microphonePermissionStatus,
//   ) async {
//     print('handle permission $microphonePermissionStatus');

//     if (cameraPermissionStatus == PermissionStatus.denied &&
//         microphonePermissionStatus == PermissionStatus.denied) {
//       throw new PlatformException(
//           code: "PERMISSION_DENIED",
//           message: "Access to camera and microphone denied",
//           details: null);
//     } else if (cameraPermissionStatus == PermissionStatus.denied &&
//         microphonePermissionStatus == PermissionStatus.denied) {
//       throw new PlatformException(
//           code: "PERMISSION_DISABLED",
//           message: "Location data is not available on device",
//           details: null);
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class Permissions {
  static Future<bool> cameraAndMicrophonePermissionsGranted() async {
    PermissionStatus cameraPermissionStatus = await _getCameraPermission();
    PermissionStatus microphonePermissionStatus =
        await _getMicrophonePermission();

    if (cameraPermissionStatus == PermissionStatus.granted &&
        microphonePermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      _handleInvalidPermissions(
          cameraPermissionStatus, microphonePermissionStatus);
      return false;
    }
  }

  static Future<bool> checkCameraAndMicrophonePermissionGranted() async {
    var cameraStatus = await Permission.camera.status;
    var microphoneStatus = await Permission.microphone.status;

    // print(cameraStatus);
    // print(microphoneStatus);

    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
    if (!microphoneStatus.isGranted) {
      await Permission.microphone.request();
    }

    if (await Permission.camera.isGranted) {
      if (await Permission.microphone.isGranted) {
        return true;
      } else {
        Get.snackbar(
          'Need Permission',
          'Provide Microphone Permission to record Audio',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        // showToast('Provide Microphone permission to use audio call',
        //     position: ToastPosition.bottom, context: );
      }
    } else {
      Get.snackbar(
        'Need Permission',
        'Provide Camera Permission to record video',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
    return false;
  }

  static Future<PermissionStatus> _getCameraPermission() async {
    PermissionStatus permission = await Permission.camera.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.camera].request();
      return permissionStatus[Permission.camera] ?? PermissionStatus.denied;
    } else {
      return permission;
    }
  }

  static Future<PermissionStatus> _getMicrophonePermission() async {
    PermissionStatus permission = await Permission.microphone.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.microphone].request();
      return permissionStatus[Permission.microphone] ?? PermissionStatus.denied;
    } else {
      return permission;
    }
  }

  static void _handleInvalidPermissions(
    PermissionStatus cameraPermissionStatus,
    PermissionStatus microphonePermissionStatus,
  ) async {
    // print('handle permission $microphonePermissionStatus');

    if (cameraPermissionStatus == PermissionStatus.denied &&
        microphonePermissionStatus == PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to camera and microphone denied",
          details: null);
    } else if (cameraPermissionStatus == PermissionStatus.denied &&
        microphonePermissionStatus == PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }
}
