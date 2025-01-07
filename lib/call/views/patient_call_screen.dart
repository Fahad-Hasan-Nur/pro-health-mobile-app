// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pro_health/call/controllers/call_controller.dart';
// import 'package:pro_health/call/models/call.dart';

// class CallScreenPatient extends StatefulWidget {
//   const CallScreenPatient({Key? key, required this.call}) : super(key: key);
//   final Call call;

//   @override
//   _CallScreenPatientState createState() => _CallScreenPatientState();
// }

// class _CallScreenPatientState extends State<CallScreenPatient> {
//   CallController callController = Get.put(CallController());

//   @override
//   void initState() {
//     print(widget.call);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           alignment: Alignment.center,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Call has been made'),
//               SizedBox(height: 80),
//               TextButton(
//                 style: TextButton.styleFrom(
//                   backgroundColor: Colors.redAccent,
//                   shape: CircleBorder(),
//                 ),
//                 child: Icon(
//                   Icons.call_end,
//                   size: 30,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {
//                   callController.endCall(call: widget.call);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: deprecated_member_use

// import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_health/call/controllers/call_controller.dart';
import 'package:pro_health/call/controllers/patient_call_controller.dart';
import 'package:pro_health/call/models/call.dart';
import 'package:pro_health/configs/agora_config.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class CallScreenPatient extends StatefulWidget {
  const CallScreenPatient({
    Key? key,
    required this.call,
  }) : super(key: key);
  final Call call;

  @override
  _CallScreenPatientState createState() => _CallScreenPatientState();
}

class _CallScreenPatientState extends State<CallScreenPatient> {
  CallController callController = Get.put(CallController());
  PatientCallController patientCallController =
      Get.put(PatientCallController());

  // ClientRole? role = ClientRole.Broadcaster;

  // DoctorCallController doctorCallController = DoctorCallController();

  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  // late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    // initializeAgora();
  }

  // Future<void> initializeAgora() async {
  //   if (APP_ID.isEmpty) {
  //     setState(() {
  //       _infoStrings.add(
  //         'APP_ID missing, please provide your APP_ID in settings.dart',
  //       );
  //       _infoStrings.add('Agora Engine is not starting');
  //     });
  //     return;
  //   }

  //   await _initAgoraRtcEngine();
  //   _addAgoraEventHandlers();
  //   await _engine.enableWebSdkInteroperability(true);
  //   VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
  //   configuration.dimensions = VideoDimensions(width: 1920, height: 1080);
  //   await _engine.setVideoEncoderConfiguration(configuration);
  //   await _engine.joinChannel(null, widget.call.channelId ?? '', null, 0);
  // }

  /// Create agora sdk instance and initialize
  // Future<void> _initAgoraRtcEngine() async {
  //   _engine = await RtcEngine.create(APP_ID);
  //   await _engine.enableVideo();
  // }

  /// Add agora event handlers
  // void _addAgoraEventHandlers() {
  //   _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
  //     setState(() {
  //       final info = 'onError: $code';
  //       _infoStrings.add(info);
  //     });
  //   }, joinChannelSuccess: (channel, uid, elapsed) {
  //     setState(() {
  //       final info = 'onJoinChannel: $channel, uid: $uid';
  //       _infoStrings.add(info);
  //     });
  //   }, leaveChannel: (stats) {
  //     setState(() {
  //       _infoStrings.add('onLeaveChannel');
  //       _users.clear();
  //     });
  //   }, userJoined: (uid, elapsed) {
  //     setState(() {
  //       final info = 'userJoined: $uid';
  //       _infoStrings.add(info);
  //       _users.add(uid);
  //     });
  //   }, userOffline: (uid, elapsed) {
  //     setState(() {
  //       final info = 'userOffline: $uid';
  //       _infoStrings.add(info);
  //       _users.remove(uid);
  //     });
  //   }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
  //     // print('call started');
  //     setState(() {
  //       final info = 'firstRemoteVideo: $uid ${width}x $height';
  //       _infoStrings.add(info);
  //     });
  //   }));
  // }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Info panel to show logs
  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return Text(
                    "null"); // return type can't be null, a widget was required
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // void _onToggleMute() {
  //   setState(() {
  //     muted = !muted;
  //   });
  //   _engine.muteLocalAudioStream(muted);
  // }

  // void _onSwitchCamera() {
  //   _engine.switchCamera();
  // }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            // onPressed: _onToggleMute,
            onPressed: () {},
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () {
              callController.endCall(call: widget.call);
              Get.back();
            },
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            // onPressed: _onSwitchCamera,
            onPressed: () {},
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  /// Helper function to get list of native views
  // List<Widget> _getRenderViews() {
  //   final List<StatefulWidget> list = [];
  //   if (role == ClientRole.Broadcaster) {
  //     list.add(RtcLocalView.SurfaceView());
  //   }
  //   _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
  //   return list;
  // }

  /// Video layout wrapper
  // Widget _viewRows() {
  //  // final views = _getRenderViews();
  //   switch (views.length) {
  //     case 1:
  //       return Container(
  //           child: Column(
  //         children: <Widget>[_videoView(views[0])],
  //       ));
  //     case 2:
  //       return Container(
  //           child: Column(
  //         children: <Widget>[
  //           _expandedVideoRow([views[0]]),
  //           _expandedVideoRow([views[1]])
  //         ],
  //       ));
  //     case 3:
  //       return Container(
  //           child: Column(
  //         children: <Widget>[
  //           _expandedVideoRow(views.sublist(0, 2)),
  //           _expandedVideoRow(views.sublist(2, 3))
  //         ],
  //       ));
  //     case 4:
  //       return Container(
  //           child: Column(
  //         children: <Widget>[
  //           _expandedVideoRow(views.sublist(0, 2)),
  //           _expandedVideoRow(views.sublist(2, 4))
  //         ],
  //       ));
  //     default:
  //   }
  //   return Container();
  // }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  // @override
  // void dispose() {
  //   // clear users
  //   _users.clear();
  //   // destroy sdk
  //   _engine.leaveChannel();
  //   _engine.destroy();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            //_viewRows(),
            _panel(),
            _toolbar(),
          ],
        ),
      ),
    );
  }
}
