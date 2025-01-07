// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:pro_health/base/utils/strings.dart';
// import 'package:pro_health/call/controllers/call_controller.dart';
// import 'package:pro_health/call/models/call.dart';
// import 'package:pro_health/call/permissions.dart';
// import 'package:pro_health/call/services/call_service.dart';
// import 'package:pro_health/call/views/patient_call_screen.dart';

// class PickupScreen extends StatelessWidget {
//   PickupScreen({Key? key, required this.call}) : super(key: key);

//   final Call call;
//   CallController callController = CallController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 100),
//           child: Center(
//             child: Column(
//               children: [
//                 Text(
//                   'Incomming Call ...',
//                   style: TextStyle(fontSize: 30),
//                 ),
//                 SizedBox(height: 50),
//                 Image.asset(
//                   noImagePath,
//                   height: 150,
//                   width: 150,
//                 ),
//                 SizedBox(height: 15),
//                 Text(
//                   '${call.callerName}',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 75),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     TextButton(
//                       style: TextButton.styleFrom(
//                         backgroundColor: Colors.redAccent,
//                         shape: CircleBorder(),
//                       ),
//                       child: Icon(
//                         Icons.call_end,
//                         size: 30,
//                         color: Colors.white,
//                       ),
//                       onPressed: () {
//                         callController.endCall(call: call);
//                       },
//                     ),
//                     SizedBox(width: 25),
//                     TextButton(
//                       style: TextButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         shape: CircleBorder(),
//                       ),
//                       child: Icon(
//                         Icons.call_end,
//                         size: 30,
//                         color: Colors.white,
//                       ),
//                       onPressed: () async => await Permissions
//                               .cameraAndMicrophonePermissionsGranted()
//                           ? Get.to(
//                               () => CallScreenPatient(call: call),
//                               transition: Transition.rightToLeft,
//                             )
//                           : {},
//                     ),
//                     // IconButton(
//                     //   onPressed: () {
//                     //     callController.endCall(call: call);
//                     //   },
//                     //   icon: Icon(Icons.call_end, color: Colors.amber),
//                     //   color: Colors.blue,
//                     // ),
//                     // SizedBox(width: 25),
//                     // IconButton(
//                     //   onPressed: () {
//                     //     Get.to(() => CallScreenPatient(call: call));
//                     //   },
//                     //   icon: Icon(
//                     //     Icons.call,
//                     //     color: Colors.green,
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/call/controllers/call_controller.dart';
import 'package:pro_health/call/models/call.dart';
import 'package:pro_health/call/permissions.dart';
import 'package:pro_health/call/views/patient_call_screen.dart';

class PickupScreen extends StatefulWidget {
  PickupScreen({Key? key, required this.call}) : super(key: key);

  final Call call;

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  CallController callController = CallController();

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  bool? isAudioOnly = false;
  bool? isAudioMuted = false;
  bool? isVideoMuted = false;

  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "plugintestroom");
  final subjectText = TextEditingController(text: "My Plugin Test Meeting");
  final nameText = TextEditingController(text: "Plugin Test User");
  final emailText = TextEditingController(text: "fake@email.com");
  final iosAppBarRGBAColor =
      TextEditingController(text: "#0080FF80"); //transparent blue

  _joinMeeting() async {
    String? serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;

    // Enable or disable any feature flag here
    // If feature flag are not provided, default values will be used
    // Full list of feature flags (and defaults) available in the README
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    };
    if (!kIsWeb) {
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
    }
    // Define meetings options here
    var options = JitsiMeetingOptions(room: widget.call.channelId ?? '')
      ..serverURL = serverUrl
      ..subject = "Online Consultation"
      ..userDisplayName = widget.call.receiverName
      ..iosAppBarRGBAColor = iosAppBarRGBAColor.text
      ..audioOnly = isAudioOnly
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": widget.call.channelId,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": widget.call.receiverName}
      };

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            print('call disconnected');
            debugPrint("${options.room} terminated with message: $message");
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
  }

  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    callController.endCall(call: widget.call);
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 100),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Incomming Call ...',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 50),
                Image.asset(
                  noImagePath,
                  height: 150,
                  width: 150,
                ),
                SizedBox(height: 15),
                Text(
                  '${widget.call.callerName}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 75),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: CircleBorder(),
                      ),
                      child: Icon(
                        Icons.call_end,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        callController.endCall(call: widget.call);
                      },
                    ),
                    SizedBox(width: 25),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: CircleBorder(),
                      ),
                      child: Icon(
                        Icons.call_end,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        bool granted = await Permissions
                            .checkCameraAndMicrophonePermissionGranted();
                        if (granted) {
                          JitsiMeet.addListener(JitsiMeetingListener(
                              onConferenceWillJoin: _onConferenceWillJoin,
                              onConferenceJoined: _onConferenceJoined,
                              onConferenceTerminated: _onConferenceTerminated,
                              onError: _onError));
                          _joinMeeting();

                          // var message = await Get.to(
                          //   () => CallScreenPatient(call: call),
                          //   transition: Transition.rightToLeft,
                          // );
                          // print('message $message');
                          // if (message != null || message != '') {
                          //   Get.snackbar(
                          //     'Call Ended',
                          //     'This call has been ended',
                          //     snackPosition: SnackPosition.BOTTOM,
                          //     colorText: Colors.white,
                          //     backgroundColor: Colors.black54,
                          //   );
                          // }
                        }
                      },
                      // onPressed: () async => await Permissions
                      //         .cameraAndMicrophonePermissionsGranted()
                      //     ? Get.to(
                      //         () => CallScreenPatient(call: call),
                      //         transition: Transition.rightToLeft,
                      //       )
                      //     : {},
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     callController.endCall(call: call);
                    //   },
                    //   icon: Icon(Icons.call_end, color: Colors.amber),
                    //   color: Colors.blue,
                    // ),
                    // SizedBox(width: 25),
                    // IconButton(
                    //   onPressed: () {
                    //     Get.to(() => CallScreenPatient(call: call));
                    //   },
                    //   icon: Icon(
                    //     Icons.call,
                    //     color: Colors.green,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
