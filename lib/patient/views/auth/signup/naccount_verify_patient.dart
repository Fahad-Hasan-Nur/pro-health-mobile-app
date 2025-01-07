import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'account_password_patient.dart';

class NewAccountVerifyPatient extends StatefulWidget {
  static String tag = 'NewAccountVerifyPatient';
  final String mobileno;
  final String newMobileno;
  final bool? isGuestCheckOut;

  const NewAccountVerifyPatient({
    Key? key,
    required this.mobileno,
    this.newMobileno = "",
    this.isGuestCheckOut,
  }) : super(key: key);

  @override
  NewAccountVerifyPatientState createState() =>
      new NewAccountVerifyPatientState();
}

class NewAccountVerifyPatientState extends State<NewAccountVerifyPatient>
    with SingleTickerProviderStateMixin {
  // Constants
  final int time = 30;
  AnimationController? _controller;

  // Variables
  late Size _screenSize;
  int? _currentDigit;
  int? _firstDigit;
  int? _secondDigit;
  int? _thirdDigit;
  int? _fourthDigit;

  Timer? timer;
  int? totalTimeInSeconds;
  late bool _hideResendButton;

  String userName = "";
  bool didReadNotifications = false;
  int unReadNotificationsCount = 0;

  get _getVerificationIcon {
    return Container(
      padding: EdgeInsets.only(top: 45),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40.0,
          child: Image.asset('assets/icons/patient/otp.png'),
        ),
      ),
    );
  }

  get _getVerificationTitleLabel {
    return Container(
      padding: EdgeInsets.only(bottom: 3.0),
      child: Text(
        "Account Verification",
        textAlign: TextAlign.center,
        style: new TextStyle(
            fontFamily: 'Segoe',
            color: kTextLightColor,
            letterSpacing: 0.5,
            fontSize: 20,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  get _getVerticalLine {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: Divider(
        color: Colors.black,
        height: 0.0,
        thickness: 0.5,
        indent: 0.0,
        endIndent: 0.0,
      ),
    );
  }

  get _getVerificationDescLabel {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, left: 8.0, bottom: 25.0, right: 8.0),
      child: Text(
        "Please enter the OTP sent to your registered phone number",
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontFamily: 'Segoe',
          color: kBodyTextColor,
        ),
      ),
    );
  }

  get _getInputField {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _otpTextField(_firstDigit),
          _otpTextField(_secondDigit),
          _otpTextField(_thirdDigit),
          _otpTextField(_fourthDigit),
        ],
      ),
    );
  }

  get _getInputPart {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _getVerificationIcon,
        _getVerificationTitleLabel,
        _getVerticalLine,
        _getVerificationDescLabel,
        _getInputField,
        _hideResendButton ? _getTimerText : _getResendButton,
        _getVerifyButton,
        _getOtpKeyboard
      ],
    );
  }

  get _getTimerText {
    return Container(
      height: 35,
      child: new Offstage(
        offstage: !_hideResendButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(
              Icons.access_time,
              size: 20.0,
              color: kBaseColor,
            ),
            new SizedBox(
              width: 5.0,
            ),
            OtpTimer(_controller, 15.0, kBaseColor)
          ],
        ),
      ),
    );
  }

  get _getResendButton {
    return InkWell(
      child: new Container(
        height: 32,
        width: 120,
        decoration: BoxDecoration(
            color: kResendBtnColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(32)),
        alignment: Alignment.center,
        child: new Text(
          "Resend OTP",
          style: TextStyle(
              fontFamily: 'Segoe',
              letterSpacing: 0.5,
              fontSize: 15,
              color: kWhiteShadow),
        ),
      ),
      onTap: () {
        // Resend you OTP via API or anything
      },
    );
  }

  get _getVerifyButton {
    return Container(
      padding: EdgeInsets.only(bottom: 30.0),
      child: MaterialButton(
        child: Container(
          height: 36,
          width: 120,
          decoration: BoxDecoration(
              color: kButtonColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(25)),
          alignment: Alignment.center,
          child: Text(
            "Verify",
            style: TextStyle(
                fontFamily: 'Segoe',
                letterSpacing: 0.5,
                fontSize: 18,
                color: kWhiteShadow),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AccountPasswordPatient.tag);
        },
      ),
    );
  }

  get _getOtpKeyboard {
    return new Container(
        height: _screenSize.width - 150,
        color: kBackgroundColor,
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "1",
                      onPressed: () {
                        _setCurrentDigit(1);
                      }),
                  _otpKeyboardInputButton(
                      label: "2",
                      onPressed: () {
                        _setCurrentDigit(2);
                      }),
                  _otpKeyboardInputButton(
                      label: "3",
                      onPressed: () {
                        _setCurrentDigit(3);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "4",
                      onPressed: () {
                        _setCurrentDigit(4);
                      }),
                  _otpKeyboardInputButton(
                      label: "5",
                      onPressed: () {
                        _setCurrentDigit(5);
                      }),
                  _otpKeyboardInputButton(
                      label: "6",
                      onPressed: () {
                        _setCurrentDigit(6);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "7",
                      onPressed: () {
                        _setCurrentDigit(7);
                      }),
                  _otpKeyboardInputButton(
                      label: "8",
                      onPressed: () {
                        _setCurrentDigit(8);
                      }),
                  _otpKeyboardInputButton(
                      label: "9",
                      onPressed: () {
                        _setCurrentDigit(9);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new SizedBox(
                    width: 80.0,
                  ),
                  _otpKeyboardInputButton(
                      label: "0",
                      onPressed: () {
                        _setCurrentDigit(0);
                      }),
                  _otpKeyboardActionButton(
                      label: new Icon(
                        Icons.backspace,
                        color: kBaseColor,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_fourthDigit != null) {
                            _fourthDigit = null;
                          } else if (_thirdDigit != null) {
                            _thirdDigit = null;
                          } else if (_secondDigit != null) {
                            _secondDigit = null;
                          } else if (_firstDigit != null) {
                            _firstDigit = null;
                          }
                        });
                      }),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  void initState() {
    totalTimeInSeconds = time;
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: time))
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              setState(() {
                _hideResendButton = !_hideResendButton;
              });
            }
          });
    _controller!.reverse(
        from: _controller!.value == 0.0 ? 1.0 : _controller!.value);
    _startCountdown();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      backgroundColor: kBackgroundColor,
      body: new Container(
        width: _screenSize.width,
        padding: new EdgeInsets.only(top: 40.0),
        child: _getInputPart,
      ),
    );
  }

  Widget _otpTextField(int? digit) {
    return new Container(
      width: 50.0,
      height: 45.0,
      alignment: Alignment.center,
      child: new Text(
        digit != null ? digit.toString() : "",
        style: new TextStyle(
          fontSize: 30.0,
          color: kBaseColor,
        ),
      ),
      decoration: BoxDecoration(
//            color: Colors.grey.withOpacity(0.4),
          border: Border(
              bottom: BorderSide(
        width: 1.0,
        color: Colors.black,
      ))),
    );
  }

  Widget _otpKeyboardInputButton({required String label, VoidCallback? onPressed}) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: onPressed,
        borderRadius: new BorderRadius.circular(40.0),
        child: new Container(
          height: 80.0,
          width: 80.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: new Center(
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 30.0,
                color: kBaseColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _otpKeyboardActionButton({Widget? label, VoidCallback? onPressed}) {
    return new InkWell(
      onTap: onPressed,
      borderRadius: new BorderRadius.circular(40.0),
      child: new Container(
        height: 80.0,
        width: 80.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: new Center(
          child: label,
        ),
      ),
    );
  }

  // Current digit
  void _setCurrentDigit(int i) {
    setState(() {
      _currentDigit = i;
      if (_firstDigit == null) {
        _firstDigit = _currentDigit;
      } else if (_secondDigit == null) {
        _secondDigit = _currentDigit;
      } else if (_thirdDigit == null) {
        _thirdDigit = _currentDigit;
      } else if (_fourthDigit == null) {
        _fourthDigit = _currentDigit;

        /*var otp = _firstDigit.toString() +
            _secondDigit.toString() +
            _thirdDigit.toString() +
            _fourthDigit.toString();*/

        //
      }
    });
  }

  Future<Null> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time;
    });
    _controller!.reverse(
        from: _controller!.value == 0.0 ? 1.0 : _controller!.value);
  }

  void clearOtp() {
    _fourthDigit = null;
    _thirdDigit = null;
    _secondDigit = null;
    _firstDigit = null;
    setState(() {});
  }
}

// ignore: must_be_immutable
class OtpTimer extends StatelessWidget {
  final AnimationController? controller;
  double fontSize;
  Color timeColor = kBaseColor;

  OtpTimer(this.controller, this.fontSize, this.timeColor);

  String get timerString {
    Duration duration = controller!.duration! * controller!.value;
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration? get duration {
    Duration? duration = controller!.duration;
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return new Text(
            timerString,
            style: new TextStyle(
                fontSize: fontSize,
                color: timeColor,
                fontWeight: FontWeight.w600),
          );
        });
  }
}
