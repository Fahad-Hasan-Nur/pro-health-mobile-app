// import 'dart:math';

// import 'package:get/get.dart';
// import 'package:pro_health/call/controllers/call_controller.dart';
// import 'package:pro_health/call/models/call.dart';
// import 'package:pro_health/call/views/call_screen_doctor.dart';
// import 'package:pro_health/doctor/models/profile/doctor_profile_model.dart';
// import 'package:pro_health/patient/models/patient_profile_model.dart';
// import 'package:uuid/uuid.dart';

// class CallUtils {
//   static late CallController callController;

//   static String generateUuid() {
//     String uuid = Uuid().v1();
//     String time = DateTime.now().millisecondsSinceEpoch.toString();
//     var rng = Random();
//     var code = rng.nextInt(900000) + 100000;

//     uuid = '$uuid-$time-$code';

//     return uuid;
//   }

//   // static final CallController callController = CallController();
//   static dial(
//       {required DoctorProfileModel from,
//       required PatientProfileModel to,
//       context,
//       required CallController controller}) async {
//     callController = controller;
//     Call call = Call(
//       callerId: from.memberID,
//       callerName: from.doctorName,
//       callerPic: from.profilePicture,
//       receiverId: to.patientID,
//       receiverName: to.patientName,
//       receiverPic: to.profilePic,
//       channelId: generateUuid(),
//     );

//     bool callMade = await callController.makeCall(call: call);
//     call.hasDialed = true;

//     if (callMade) {
//       callController.currentCall.value = call;
//       callController.onGoingCall.value = true;
//       // Get.to(() => CallScreenDoctor(call: call));
//       Get.to(() => CallScreenDoctor(callController: callController));
//     }
//   }
// }

import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pro_health/call/controllers/call_controller.dart';
import 'package:pro_health/call/models/call.dart';
import 'package:pro_health/call/views/call_screen_doctor.dart';
import 'package:pro_health/doctor/models/profile/doctor_profile_model.dart';
import 'package:pro_health/patient/models/patient_profile_model.dart';
import 'package:uuid/uuid.dart';

class CallUtils {
  static String generateUuid() {
    String uuid = Uuid().v1();
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    var rng = Random();
    var code = rng.nextInt(900000) + 100000;

    uuid = '$uuid-$time-$code';

    return uuid;
  }

  static final CallController callController = Get.put(CallController());
  static dial(
      {required DoctorProfileModel from,
      required PatientProfileModel to,
      context}) async {
    Call call = Call(
      callerId: from.memberID,
      callerName: from.doctorName,
      callerPic: from.profilePicture,
      receiverId: to.patientID,
      receiverName: to.patientName,
      receiverPic: to.profilePic,
      channelId: generateUuid(),
    );
    bool callMade = await callController.makeCall(call: call);
    call.hasDialed = true;

    if (callMade) {
      callController.onGoingCall.value = true;
      // Get.to(
      //     () => CallScreenDoctor(call: call, callController: callController));

      Get.to(() => Meeting(
            callController: callController,
            call: call,
          ));
    }
  }
}

class Meeting extends StatefulWidget {
  const Meeting({Key? key, required this.call, required this.callController})
      : super(key: key);
  final Call call;
  final CallController callController;

  @override
  _MeetingState createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "plugintestroom");
  final subjectText = TextEditingController(text: "My Plugin Test Meeting");
  final nameText = TextEditingController(text: "Plugin Test User");
  final emailText = TextEditingController(text: "fake@email.com");
  final iosAppBarRGBAColor =
      TextEditingController(text: "#0080FF80"); //transparent blue
  bool? isAudioOnly = false;
  bool? isAudioMuted = false;
  bool? isVideoMuted = false;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
    _joinMeeting();
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Pro health'),
      // ),
      body: Center(
        child: Text('calling..'),
      ),
      // body: Container(
      //   padding: const EdgeInsets.symmetric(
      //     horizontal: 16.0,
      //   ),
      //   child: kIsWeb
      //       ? Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Container(
      //               width: width * 0.30,
      //               child: meetConfig(),
      //             ),
      //             Container(
      //                 width: width * 0.60,
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Card(
      //                       color: Colors.white54,
      //                       child: SizedBox(
      //                         width: width * 0.60 * 0.70,
      //                         height: width * 0.60 * 0.70,
      //                         child: JitsiMeetConferencing(
      //                           extraJS: [
      //                             // extraJs setup example
      //                             '<script>function echo(){console.log("echo!!!")};</script>',
      //                             '<script src="https://code.jquery.com/jquery-3.5.1.slim.js" integrity="sha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM=" crossorigin="anonymous"></script>'
      //                           ],
      //                         ),
      //                       )),
      //                 ))
      //           ],
      //         )
      //       : meetConfig(),
      // ),
    );
  }

  // Widget meetConfig() {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: <Widget>[
  //         SizedBox(
  //           height: 16.0,
  //         ),
  //         TextField(
  //           controller: serverText,
  //           decoration: InputDecoration(
  //               border: OutlineInputBorder(),
  //               labelText: "Server URL",
  //               hintText: "Hint: Leave empty for meet.jitsi.si"),
  //         ),
  //         SizedBox(
  //           height: 14.0,
  //         ),
  //         TextField(
  //           controller: roomText,
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(),
  //             labelText: "Room",
  //           ),
  //         ),
  //         SizedBox(
  //           height: 14.0,
  //         ),
  //         TextField(
  //           controller: subjectText,
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(),
  //             labelText: "Subject",
  //           ),
  //         ),
  //         SizedBox(
  //           height: 14.0,
  //         ),
  //         TextField(
  //           controller: nameText,
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(),
  //             labelText: "Display Name",
  //           ),
  //         ),
  //         SizedBox(
  //           height: 14.0,
  //         ),
  //         TextField(
  //           controller: emailText,
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(),
  //             labelText: "Email",
  //           ),
  //         ),
  //         SizedBox(
  //           height: 14.0,
  //         ),
  //         TextField(
  //           controller: iosAppBarRGBAColor,
  //           decoration: InputDecoration(
  //               border: OutlineInputBorder(),
  //               labelText: "AppBar Color(IOS only)",
  //               hintText: "Hint: This HAS to be in HEX RGBA format"),
  //         ),
  //         SizedBox(
  //           height: 14.0,
  //         ),
  //         CheckboxListTile(
  //           title: Text("Audio Only"),
  //           value: isAudioOnly,
  //           onChanged: _onAudioOnlyChanged,
  //         ),
  //         SizedBox(
  //           height: 14.0,
  //         ),
  //         CheckboxListTile(
  //           title: Text("Audio Muted"),
  //           value: isAudioMuted,
  //           onChanged: _onAudioMutedChanged,
  //         ),
  //         SizedBox(
  //           height: 14.0,
  //         ),
  //         CheckboxListTile(
  //           title: Text("Video Muted"),
  //           value: isVideoMuted,
  //           onChanged: _onVideoMutedChanged,
  //         ),
  //         Divider(
  //           height: 48.0,
  //           thickness: 2.0,
  //         ),
  //         SizedBox(
  //           height: 64.0,
  //           width: double.maxFinite,
  //           child: ElevatedButton(
  //             onPressed: () {
  //               _joinMeeting();
  //             },
  //             child: Text(
  //               "Join Meeting",
  //               style: TextStyle(color: Colors.white),
  //             ),
  //             style: ButtonStyle(
  //                 backgroundColor:
  //                     MaterialStateColor.resolveWith((states) => Colors.blue)),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 48.0,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  _onAudioOnlyChanged(bool? value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value;
    });
  }

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
      ..userDisplayName = widget.call.callerName
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
        "userInfo": {"displayName": widget.call.callerName}
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
    widget.callController.endCall(call: widget.call);
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
