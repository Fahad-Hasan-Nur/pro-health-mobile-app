import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
// import 'package:page_transition/page_transition.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/patient/views/bottombar/home/doctor_profile.dart';
import 'package:pro_health/patient/views/bottombar/home/home_patient.dart';
import 'package:pro_health/patient/views/dashboard/dashboard_patient.dart';

class RequestApproval extends StatefulWidget {
  RequestApproval(
      {Key? key,
      this.title,
      required this.createAppointmentMap,
      required this.doctorInfo})
      : super(key: key);
  final String? title;
  static String tag = 'RequestApproval';
  final Map<String, dynamic> createAppointmentMap;
  final Map<String, dynamic> doctorInfo;
  @override
  RequestApprovalState createState() => new RequestApprovalState(
      createAppointmentMap: this.createAppointmentMap,
      doctorInfo: this.doctorInfo);
}

class RequestApprovalState extends State<RequestApproval> {
  RequestApprovalState(
      {required this.createAppointmentMap, required this.doctorInfo});
  final Map<String, dynamic> createAppointmentMap;
  final Map<String, dynamic> doctorInfo;

  var rating = 5.0;
  @override
  Widget build(BuildContext context) {
    final doctorCard = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(width: 1, color: Colors.blue),
                            image: DecorationImage(
                              image: (doctorInfo['doctorPic'] == 'null' ||
                                          doctorInfo['doctorPic'].isEmpty
                                      ? AssetImage(noImagePath)
                                      : NetworkImage(doctorInfo['doctorPic']))
                                  as ImageProvider<Object>,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${doctorInfo['doctorName']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${doctorInfo['qualification']}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: kBodyTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '${doctorInfo['rating']}',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Container(
                        child: RatingStars(
                          value: doctorInfo['rating'],
                          onValueChanged: (v) {},
                          starBuilder: (index, color) => Icon(
                            Icons.star,
                            color: color,
                          ),
                          starCount: 5,
                          starSize: 20,
                          maxValue: 5,
                          starSpacing: 1,
                          maxValueVisibility: true,
                          valueLabelVisibility: false,
                          animationDuration: Duration(milliseconds: 1000),
                          valueLabelPadding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 8),
                          valueLabelMargin: const EdgeInsets.only(right: 8),
                          starOffColor: const Color(0xffe7e8ea),
                          starColor: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    final verticalDivider = Container(
      child: Divider(
        color: Colors.black,
        height: 0.0,
        thickness: 0.5,
        indent: 15.0,
        endIndent: 15.0,
      ),
    );
    final splashScreen = Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 40),
            child: Text(
              'Please wait while processing Your request',
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'Segoe',
                color: kTextLightColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
              height: 300,
              child: AnimatedSplashScreen(
                splash: 'assets/icons/patient/request.png',
                nextScreen: Approval(doctorInfo: doctorInfo),
                splashTransition: SplashTransition.rotationTransition,
                // pageTransitionType: PageTransitionType.scale,
                backgroundColor: kBackgroundColor,
                splashIconSize: 80,
                duration: 5000,
                centered: true,
              )
              // child: SplashScreen(
              //   seconds: 5,
              //   navigateAfterSeconds: new Approval(),
              //   backgroundColor: kBackgroundColor,
              //   image: Image.asset(
              // 'assets/icons/patient/request.png',
              //     fit: BoxFit.contain,
              //   ),
              //   photoSize: 80,
              //   loadingText: Text(
              //     'Your request is being processing...',
              //     style: TextStyle(
              //       fontFamily: 'Segoe',
              //       fontSize: 16,
              //       color: kTextLightColor,
              //       fontWeight: FontWeight.w700,
              //     ),
              //   ),
              //   loaderColor: kBaseColor,
              // ),
              ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: kBaseColor,
        centerTitle: true,
        toolbarHeight: 50,
        leading: IconButton(
          color: kTitleColor,
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Requesting',
            style: TextStyle(fontFamily: 'Segoe', color: kTitleColor)),
      ),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: ListView(
          shrinkWrap: false,
          children: <Widget>[
            doctorCard,
            verticalDivider,
            splashScreen,
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Approval extends StatelessWidget {
  Approval({required this.doctorInfo});
  final Map<String, dynamic> doctorInfo;
  var rating = 5.0;
  @override
  Widget build(BuildContext context) {
    final doctorCard = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(width: 1, color: Colors.blue),
                            image: DecorationImage(
                              image: (doctorInfo['doctorPic'] == 'null' ||
                                          doctorInfo['doctorPic'].isEmpty
                                      ? AssetImage(noImagePath)
                                      : NetworkImage(doctorInfo['doctorPic']))
                                  as ImageProvider<Object>,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${doctorInfo['doctorName']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${doctorInfo['qualification']}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: kBodyTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '${doctorInfo['rating']}',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Container(
                        child: RatingStars(
                          value: doctorInfo['rating'],
                          onValueChanged: (v) {},
                          starBuilder: (index, color) => Icon(
                            Icons.star,
                            color: color,
                          ),
                          starCount: 5,
                          starSize: 20,
                          maxValue: 5,
                          starSpacing: 1,
                          maxValueVisibility: true,
                          valueLabelVisibility: false,
                          animationDuration: Duration(milliseconds: 1000),
                          valueLabelPadding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 8),
                          valueLabelMargin: const EdgeInsets.only(right: 8),
                          starOffColor: const Color(0xffe7e8ea),
                          starColor: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    final verticalDivider = Container(
      child: Divider(
        color: Colors.black,
        height: 0.0,
        thickness: 0.5,
        indent: 15.0,
        endIndent: 15.0,
      ),
    );
    final approvalScreen = Container(
      child: Column(
        children: [
          // Container(
          //   padding: EdgeInsets.symmetric(vertical: 25, horizontal: 80),
          //   child: Row(
          //     children: [
          //       Container(
          //         padding: EdgeInsets.only(right: 4),
          //         child: Icon(
          //           Icons.warning_amber_rounded,
          //           color: Colors.redAccent,
          //         ),
          //       ),
          //       Container(
          //         padding: EdgeInsets.only(left: 4),
          //         child: Text(
          //           'You may end this session',
          //           style: TextStyle(
          //             fontFamily: 'Segoe',
          //             letterSpacing: 0.5,
          //             color: Colors.redAccent,
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 30),
            child: Text(
              'Your appointment request has been submitted Successfully.',
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'Segoe',
                color: kTextLightColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 50),
            child: Image.asset(
              'assets/icons/patient/success.png',
              fit: BoxFit.contain,
              scale: 6,
            ),
          ),
          Container(
            child: Text(
              'Doctor will call you very soon...',
              style: TextStyle(
                fontFamily: 'Segoe',
                fontSize: 17,
                color: kTextLightColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 20),
          MaterialButton(
            onPressed: () => Get.back(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
            color: kBaseColor,
            child: Container(
              width: 150,
              padding: EdgeInsets.only(left: 15, right: 35),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.white,
                  ),
                  Text(
                    'Go Back',
                    style: TextStyle(
                      fontFamily: "Segoe",
                      letterSpacing: 0.5,
                      fontSize: 17,
                      color: kTitleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    return new Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: kBaseColor,
        centerTitle: true,
        toolbarHeight: 50,
        leading: IconButton(
          color: kTitleColor,
          onPressed: () =>
              Get.off(() => HomePatient(), transition: Transition.rightToLeft),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Consultation Approval Status',
            style: TextStyle(fontFamily: 'Segoe', color: kTitleColor)),
      ),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: ListView(
          shrinkWrap: false,
          children: <Widget>[
            doctorCard,
            verticalDivider,
            approvalScreen,
          ],
        ),
      ),
    );
  }
}
