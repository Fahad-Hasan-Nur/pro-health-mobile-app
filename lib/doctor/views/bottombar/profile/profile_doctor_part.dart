// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/doctor/controllers/profile/profile_controller.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/doctor/services/auth_service/auth_service.dart';
import 'package:pro_health/doctor/views/bottombar/profile/editDoctorProfile.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfileDoctor extends StatefulWidget {
  ProfileDoctor({Key? key, this.title}) : super(key: key);
  final String? title;
  static String tag = 'ProfileDoctor';

  @override
  ProfileDoctorState createState() => new ProfileDoctorState();
}

class ProfileDoctorState extends State<ProfileDoctor> {
  // final _editDoctorProfileKey = GlobalKey<FormState>();
  ApiServices apiServices = ApiServices();
  AuthService authService = AuthService();

  // var qualificationOne = '';
  // var qualificationTwo = '';

  // var validity;
  // var doctorPhone;
  // var doctorProfileInfo = [];
  // var consultations = [];
  // List<DoctorSpecialityModel> doctorSpeciality = [];

  // var consultationNumber;
  // String? name = '';
  // String? degree = '';
  // var workPlace;
  // var speciality;
  // var bmdcNum;
  // var doctorExperience;
  // var doctorStarRating;
  // var consultationsCount;
  // var onlineConsultionFee;
  // var physicalConsultationFee;
  // var doctorFollowupFee;
  // var doctorChamberAddress1;
  // var doctorChamberAddress2;
  // var doctorConsultationDay;
  // var consultationStartTime;
  // var consultationEndTime;
  // String? doctorProfilePic = '';
  // var memberId;
  // var appJoinDate;
  // var expireDate;
  // int? validityDaysLeft = 0;

  // var chamberOneAddress;
  // var chamberTwoAddress;
  // var chamberOneConsultDay;
  // var chamberTwoConsultDay;
  // var chamberOneConsultTime;
  // var chamberOneConsultTimeBangla;
  // var chamberTwoConsultTime;
  // var chamberTwoConsultTimeBangla;
  // var consultStartTimeString;
  // var consultEndTimeString;

  // double? rating = 0.0;
  double radius = 32;
  double iconSize = 20;
  double distance = 2;

  final format = DateFormat("hh:mm a");

  // final values = <bool>[true, false, true, false, true, false, true];

  var alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: true,
    isOverlayTapDismiss: false,
    descStyle: TextStyle(fontWeight: FontWeight.bold),
    descTextAlign: TextAlign.start,
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.red,
    ),
    alertElevation: 10,
    alertAlignment: Alignment.topCenter,
  );

  // fetchDoctorProfileInfo() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int? doctorMemberId = prefs.getInt('doctorMemberId');
  //   int? validityDays = prefs.getInt('ValidityDaysLeft');
  //   print(doctorMemberId);
  //   var doctorProfile = await apiServices.fetchDoctorProfile(doctorMemberId);
  //   if (doctorProfile.length > 0) {
  //     setState(() {
  //       name = doctorProfile[0]['doctorName'];
  //       memberId = doctorProfile[0]['memberID'];
  //       qualificationOne = doctorProfile[0]['qualificationOne'] ?? '';
  //       qualificationTwo = doctorProfile[0]['qualificationTwo'] ?? '';
  //       chamberOneAddress = doctorProfile[0]['chamberOneAddress'] ?? '';
  //       chamberTwoAddress = doctorProfile[0]['chamberTwoAddress'] ?? '';
  //       chamberOneConsultDay = doctorProfile[0]['chamberOneConsultDay'] ?? '';
  //       chamberTwoConsultDay = doctorProfile[0]['chamberTwoConsultDay'] ?? '';
  //       degree = doctorProfile[0]['eduQualificationID'];
  //       workPlace = doctorProfile[0]['workingPlace'];
  //       speciality = doctorProfile[0]['specialityName'];
  //       bmdcNum = doctorProfile[0]['bmdcNmuber'];
  //       doctorExperience = doctorProfile[0]['experience'];
  //       rating = doctorProfile[0]['rating'] != null
  //           ? doctorProfile[0]['rating'].toDouble()
  //           : 0.0;

  //       onlineConsultionFee = doctorProfile[0]['consultationFeeOnline'];
  //       physicalConsultationFee = doctorProfile[0]['consultationFeePhysical'];
  //       doctorFollowupFee = doctorProfile[0]['followupFee'];
  //       doctorChamberAddress1 = doctorProfile[0]['chamberAddress'];
  //       doctorChamberAddress2 = doctorProfile[0]['chamberAddressTwo'];
  //       doctorConsultationDay = doctorProfile[0]['consultationDay'];
  //       appJoinDate = doctorProfile[0]['appJoinDate'];
  //       expireDate = doctorProfile[0]['expireDate'];
  //       consultationStartTime = getTime(doctorProfile[0]['consultStartTime']);
  //       consultationEndTime = getTime(doctorProfile[0]['consultEndTime']);
  //       consultStartTimeString = doctorProfile[0]['consultStartTime'];
  //       consultEndTimeString = doctorProfile[0]['consultEndTime'];
  //       // doctorProfilePic = doctorProfile[0]['profilePicture'];

  //       doctorProfilePic =
  //           getDoctorProfilePic(doctorProfile[0]['profilePicture']);

  //       validityDaysLeft = validityDays;
  //     });
  //   }
  //   getSpeciality();

  //   print('validity days left $validityDaysLeft');
  //   print('consult member id $doctorMemberId');
  //   // fetchConsultations(doctorMemberId);
  //   fetchConsults(doctorMemberId);
  //   // getValidityDays(appJoinDate, expireDate);
  // }

  // fetchConsults(var doctorMemberId) async {
  //   var response = await apiServices.fetchConsultation(doctorMemberId);
  //   if (response.length > 0) {
  //     setState(() {
  //       consultations.addAll(response);
  //     });
  //   }
  //   if (consultations.length > 0) {
  //     setState(() {
  //       consultationNumber = consultations.length;
  //     });
  //   }
  // }

  getTime(var inputTime) {
    if (inputTime == null || inputTime == 'null' || inputTime == '') {
      return '0:AM';
    } else {
      var dateTime = DateTime.parse(inputTime);
      var hour = dateTime.hour;
      var minute = dateTime.minute;
      var amPm = hour > 12 ? 'PM' : 'AM';
      hour = hour > 12 ? hour - 12 : hour;
      var newHour = hour < 10 ? '0$hour' : '$hour';

      var time = '$newHour:$minute $amPm';
      return time;
    }
  }

  // getSpeciality() async {
  //   var specialities = await apiServices.fetchSpeciality();
  //   setState(() {
  //     doctorSpeciality.addAll(specialities);
  //   });
  //   // print(doctorSpeciality);
  // }

  // getValidityDays(var appJoinDate, var expireDate) async {
  //   DateTime dateTimeCreatedAt = DateTime.parse(appJoinDate);
  //   DateTime dateTimeNow = DateTime.now();
  //   final differenceInDays = dateTimeNow.difference(dateTimeCreatedAt).inDays;
  //   var defaultValidityDays = 365;
  //   var defaultDaysLeft = defaultValidityDays - differenceInDays;

  //   if (defaultDaysLeft <= 0) {
  //     DateTime renewDate = DateTime.parse(expireDate);
  //     DateTime dateTimeNow = DateTime.now();

  //     final newDifferenceInDays = renewDate.difference(dateTimeNow).inDays;

  //     setState(() {
  //       validityDaysLeft = newDifferenceInDays;
  //     });
  //   } else {
  //     setState(() {
  //       validityDaysLeft = defaultDaysLeft;
  //     });
  //   }

  //   checkValidity(validityDaysLeft);
  // }

  // checkValidity(var daysLeft) {
  //   daysLeft = 4;
  //   if (daysLeft <= 5 && daysLeft > 0) {
  //     // show alert that account validity will be expire soon
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (_) => ShowValidityPage(daysLeft: daysLeft),
  //       ),
  //     );
  //   } else if (daysLeft <= 0) {
  //     // Navigate to renew page.
  //   }
  // }

  // fetchConsultations(var memberid) async {
  //   var response = await apiServices.fetchConsultation(memberid);
  // }

  @override
  void initState() {
    // fetchDoctorProfileInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final verticalDivider = Container(
      child: const Divider(
        color: kTitleTextColor,
        height: 2,
        thickness: 0.5,
        indent: 0.0,
        endIndent: 0.0,
      ),
    );
    final validationImageEdit = Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15.0, right: 10),
              child: SizedBox(
                child: Obx(
                  () => Text(
                    'Validity: ${Get.find<DoctorProfileController>().validityDaysLeft.value} Days',
                    style: TextStyle(fontFamily: 'Segoe', fontSize: 13.0),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: 10.0, top: 3.0, right: 10.0, bottom: 10.0),
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  // ignore: deprecated_member_use
                  overflow: Overflow.visible,
                  children: [
                    Obx(
                      () => Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blue,
                          image: DecorationImage(
                            image: (Get.find<DoctorProfileController>()
                                            .profilePic
                                            .value ==
                                        '' ||
                                    Get.find<DoctorProfileController>()
                                            .profilePic
                                            .value ==
                                        'null'
                                ? AssetImage(noImagePath)
                                : NetworkImage(
                                    Get.find<DoctorProfileController>()
                                        .profilePic
                                        .value)) as ImageProvider<Object>,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -(radius - distance),
                      right: -(radius + iconSize + distance),
                      bottom: -iconSize - distance - 65,
                      left: radius,
                      child: Icon(
                        Icons.circle,
                        color: Color(0xff6ECEC0),
                        size: iconSize - 4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 35,
              padding: EdgeInsets.only(left: 35),
              child: Center(
                child: RawMaterialButton(
                  elevation: 5.0,
                  child: Image.asset('assets/icons/doctor/edit.png'),
                  shape: CircleBorder(),
                  //fillColor: Colors.white,
                  padding: const EdgeInsets.all(6.0),
                  onPressed: () {
                    // editDoctor;
                    Get.to(
                      () => EditDoctorProfile(
                        doctorSpeciality: Get.find<DoctorProfileController>()
                            .doctorSpecialityList
                            .value,
                        memberid:
                            Get.find<DoctorProfileController>().memberId.value,
                      ),
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => EditDoctorProfile(
                    //       doctorSpeciality:
                    //           profileController.doctorSpecialityList.value,
                    //       memberid: profileController.memberId.value,
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final doctorName = Padding(
      padding: EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 5.0),
      child: Obx(
        () => Text(
          Get.find<DoctorProfileController>().doctor.value.doctorName ??
              'Doctor Name', // == null ? 'Doctor Name' : name! ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Segoe',
              fontSize: 20.0,
              letterSpacing: 0.5,
              color: kBaseColor,
              fontWeight: FontWeight.w600),
        ),
      ),
    );

    final doctorDegree = Padding(
      padding: EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 5.0),
      child: Obx(
        () => Text(
          '${Get.find<DoctorProfileController>().doctorProfile.value.qualificationOne ?? ''}${Get.find<DoctorProfileController>().doctorProfile.value.qualificationTwo ?? ''}'
                  .isEmpty
              ? 'Your Qualification I.e: MBBS etc'
              : '${Get.find<DoctorProfileController>().doctorProfile.value.qualificationOne}, ${Get.find<DoctorProfileController>().doctorProfile.value.qualificationTwo}',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Segoe',
              fontSize: 18.0,
              color: kBodyTextColor,
              fontWeight: FontWeight.w600),
        ),
      ),
    );

    final doctorWorkPlace = Padding(
      padding: EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 5.0),
      child: Obx(
        () => Text(
          Get.find<DoctorProfileController>()
                  .doctorProfile
                  .value
                  .workingPlace ??
              'Your Work Place', // == null ? 'Your Work Place' : workPlace,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Segoe',
              fontSize: 18.0,
              color: kTextLightColor,
              fontWeight: FontWeight.w600),
        ),
      ),
    );

    final specialtyButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 120),
      child: MaterialButton(
        onPressed: () {
          Navigator.of(context).pushNamed('');
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
        color: kBaseColor,
        child: Obx(
          () => Text(
            Get.find<DoctorProfileController>()
                    .doctorProfile
                    .value
                    .specialityName ??
                'Your speciality', // == null ? 'Your speciality' : speciality,
            style: TextStyle(
                fontFamily: "Segoe",
                letterSpacing: 0.5,
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );

    final bmdcNumber = Padding(
      padding: EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 5.0),
      child: Obx(
        () => Text(
          'BMDC Registration No. ${Get.find<DoctorProfileController>().doctorProfile.value.bmdcNmuber ?? ''}',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Segoe',
              fontSize: 18.0,
              color: kTextLightColor,
              fontWeight: FontWeight.w600),
        ),
      ),
    );

    final experience = Padding(
      padding: EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 5.0),
      child: Obx(
        () => Text(
          '${Get.find<DoctorProfileController>().doctor.value.experience ?? ''}'
                  .isEmpty
              ? 'No Experience Added'
              : 'Experience: ${Get.find<DoctorProfileController>().doctor.value.experience ?? ''}+ Years',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Segoe',
              fontSize: 18.0,
              color: kTextLightColor,
              fontWeight: FontWeight.w600),
        ),
      ),
    );

    final starRating = Center(
      //padding: EdgeInsets.only(left: 0.0),
      child: Obx(
        () {
          print(Get.find<DoctorProfileController>().averageRating.value);
          return RatingStars(
            value: Get.find<DoctorProfileController>().averageRating.value,
            onValueChanged: (v) {},
            starBuilder: (index, color) => Icon(
              Icons.star,
              color: color,
            ),
            starCount: 5,
            starSize: 30,
            maxValue: 5,
            starSpacing: 2,
            maxValueVisibility: true,
            valueLabelVisibility: false,
            animationDuration: Duration(milliseconds: 1000),
            valueLabelPadding:
                const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
            valueLabelMargin: const EdgeInsets.only(right: 8),
            starOffColor: const Color(0xFFFFFFFF),
            starColor: Colors.yellow,
          );
        },
      ),
    );

    // final consultations = Container(
    //   padding: EdgeInsets.only(left: 6.0, top: 2.0, right: 6.0, bottom: 2.0),
    //   child: Card(
    //     borderOnForeground: true,
    //     color: kConsultationColor,
    //     elevation: 3,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(10.0),
    //     ),
    //     child: Column(
    //       children: [
    //         Row(
    //           children: [
    //             Container(
    //                 child: Padding(
    //               padding: EdgeInsets.only(
    //                   left: 0.0, top: 10.0, right: 0.0, bottom: 5.0),
    //               child: Text(
    //                 '   Consultations Number ',
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                     fontFamily: 'Segoe',
    //                     fontSize: 18.0,
    //                     color: kTitleTextColor,
    //                     fontWeight: FontWeight.w600),
    //               ),
    //             )),
    //             Container(
    //               height: 30,
    //               child: VerticalDivider(
    //                 color: Colors.black54,
    //                 thickness: 0.8,
    //               ),
    //             ),
    //             Container(
    //               child: Padding(
    //                 padding: EdgeInsets.only(
    //                     left: 5.0, top: 10.0, right: 0.0, bottom: 5.0),
    //                 child: Text(
    //                   consultationNumber == null ? '0' : '$consultationNumber',
    //                   textAlign: TextAlign.center,
    //                   style: TextStyle(
    //                       fontFamily: 'Segoe',
    //                       fontSize: 18.0,
    //                       color: kTextLightColor,
    //                       fontWeight: FontWeight.w600),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //         Row(
    //           children: [
    //             Container(
    //                 child: Padding(
    //               padding: EdgeInsets.only(
    //                   left: 0.0, top: 0.0, right: 0.0, bottom: 5.0),
    //               child: Text(
    //                 '   Consultation Fees (Online)',
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                     fontFamily: 'Segoe',
    //                     fontSize: 18.0,
    //                     color: kTitleTextColor,
    //                     fontWeight: FontWeight.w600),
    //               ),
    //             )),
    //             Container(
    //                 height: 30,
    //                 child: VerticalDivider(
    //                   color: Colors.black54,
    //                   thickness: 0.8,
    //                 )),
    //             Container(
    //               child: Padding(
    //                 padding: EdgeInsets.only(
    //                     left: 0.0, top: 0.0, right: 0.0, bottom: 5.0),
    //                 child: Text(
    //                   onlineConsultionFee == null
    //                       ? '0 Tk'
    //                       : onlineConsultionFee.toString(),
    //                   textAlign: TextAlign.center,
    //                   style: TextStyle(
    //                       fontFamily: 'Segoe',
    //                       fontSize: 18.0,
    //                       color: kTextLightColor,
    //                       fontWeight: FontWeight.w600),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //         Row(
    //           children: [
    //             Container(
    //                 child: Padding(
    //               padding: EdgeInsets.only(
    //                   left: 0.0, top: 0.0, right: 0.0, bottom: 5.0),
    //               child: Text(
    //                 '   Consultation Fees (Physical)',
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                     fontFamily: 'Segoe',
    //                     fontSize: 18.0,
    //                     color: kTitleTextColor,
    //                     fontWeight: FontWeight.w600),
    //               ),
    //             )),
    //             Container(
    //                 height: 30,
    //                 child: VerticalDivider(
    //                   color: Colors.black54,
    //                   thickness: 0.8,
    //                 )),
    //             Container(
    //               child: Padding(
    //                 padding: EdgeInsets.only(
    //                     left: 0.0, top: 0.0, right: 0.0, bottom: 5.0),
    //                 child: Text(
    //                   physicalConsultationFee == null
    //                       ? '0 Tk'
    //                       : physicalConsultationFee.toString(),
    //                   textAlign: TextAlign.center,
    //                   style: TextStyle(
    //                       fontFamily: 'Segoe',
    //                       fontSize: 18.0,
    //                       color: kTextLightColor,
    //                       fontWeight: FontWeight.w600),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //         Row(
    //           children: [
    //             Container(
    //                 child: Padding(
    //               padding: EdgeInsets.only(
    //                   left: 0.0, top: 0.0, right: 0.0, bottom: 15.0),
    //               child: Text(
    //                 '   Follow-up Fees ',
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                     fontFamily: 'Segoe',
    //                     fontSize: 18.0,
    //                     color: kTitleTextColor,
    //                     fontWeight: FontWeight.w600),
    //               ),
    //             )),
    //             Container(
    //                 height: 30,
    //                 child: VerticalDivider(
    //                   color: Colors.black54,
    //                   thickness: 0.8,
    //                 )),
    //             Container(
    //               child: Padding(
    //                 padding: EdgeInsets.only(
    //                     left: 0.0, top: 0.0, right: 0.0, bottom: 15.0),
    //                 child: Text(
    //                   doctorFollowupFee == null
    //                       ? '0 Tk'
    //                       : doctorFollowupFee.toString(),
    //                   textAlign: TextAlign.center,
    //                   style: TextStyle(
    //                       fontFamily: 'Segoe',
    //                       fontSize: 18.0,
    //                       color: kTextLightColor,
    //                       fontWeight: FontWeight.w600),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    // final chamberAddress1 = Row(
    //   children: [
    //     Container(
    //         child: Padding(
    //       padding:
    //           EdgeInsets.only(left: 18.0, top: 0.0, right: 0.0, bottom: 5.0),
    //       child: Text(
    //         'Chamber Address- 1:',
    //         textAlign: TextAlign.left,
    //         style: TextStyle(
    //             fontFamily: 'Segoe',
    //             fontSize: 17.0,
    //             color: kTitleTextColor,
    //             fontWeight: FontWeight.w600),
    //       ),
    //     )),
    //     Container(
    //       height: 55,
    //       child: VerticalDivider(
    //         color: Colors.black54,
    //         thickness: 0.8,
    //       ),
    //     ),
    //     Expanded(
    //       child: Padding(
    //         padding:
    //             EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 5.0),
    //         child: Text(
    //           doctorChamberAddress1 == null ? '' : doctorChamberAddress1,
    //           textAlign: TextAlign.left,
    //           style: TextStyle(
    //               fontFamily: 'Segoe',
    //               fontSize: 15.0,
    //               color: kTextLightColor,
    //               fontWeight: FontWeight.w600),
    //         ),
    //       ),
    //     ),
    //   ],
    // );

    // final chamberAddress2 = Row(
    //   children: [
    //     Container(
    //         child: Padding(
    //       padding:
    //           EdgeInsets.only(left: 15.0, top: 0.0, right: 0.0, bottom: 0.0),
    //       child: Text(
    //         'Chamber Address- 2:',
    //         textAlign: TextAlign.left,
    //         style: TextStyle(
    //             fontFamily: 'Segoe',
    //             fontSize: 17.0,
    //             color: kTitleTextColor,
    //             fontWeight: FontWeight.w600),
    //       ),
    //     )),
    //     Container(
    //       height: 55,
    //       child: VerticalDivider(
    //         color: Colors.black54,
    //         thickness: 0.8,
    //       ),
    //     ),
    //     Expanded(
    //       child: Padding(
    //         padding:
    //             EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 0.0),
    //         child: Text(
    //           doctorChamberAddress2 == null ? '' : doctorChamberAddress2,
    //           textAlign: TextAlign.left,
    //           style: TextStyle(
    //               fontFamily: 'Segoe',
    //               fontSize: 15.0,
    //               color: kTextLightColor,
    //               fontWeight: FontWeight.w600),
    //         ),
    //       ),
    //     ),
    //   ],
    // );

    // final consultationDay = Row(
    //   children: [
    //     Expanded(
    //         child: Padding(
    //       padding:
    //           EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 0.0),
    //       child: Text(
    //         'Consultation Day:',
    //         textAlign: TextAlign.center,
    //         style: TextStyle(
    //             fontFamily: 'Segoe',
    //             fontSize: 18.0,
    //             color: kTitleTextColor,
    //             fontWeight: FontWeight.w600),
    //       ),
    //     )),
    //     Expanded(
    //       child: Padding(
    //         padding:
    //             EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 0.0),
    //         child: Text(
    //           doctorConsultationDay == null ? '' : doctorConsultationDay,
    //           textAlign: TextAlign.left,
    //           style: TextStyle(
    //               fontFamily: 'Segoe',
    //               fontSize: 16.0,
    //               color: kTextLightColor,
    //               fontWeight: FontWeight.w600),
    //         ),
    //       ),
    //     ),
    //   ],
    // );

    // final consultationTime = Row(
    //   children: [
    //     Expanded(
    //         child: Padding(
    //       padding:
    //           EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 0.0),
    //       child: Text(
    //         'Consultation Time:',
    //         textAlign: TextAlign.center,
    //         style: TextStyle(
    //             fontFamily: 'Segoe',
    //             fontSize: 18.0,
    //             color: kTitleTextColor,
    //             fontWeight: FontWeight.w600),
    //       ),
    //     )),
    //     Expanded(
    //       child: Padding(
    //         padding:
    //             EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 0.0),
    //         child: Text(
    //           '$consultationStartTime - $consultationEndTime',
    //           textAlign: TextAlign.left,
    //           style: TextStyle(
    //               fontFamily: 'Segoe',
    //               fontSize: 16.0,
    //               color: kTextLightColor,
    //               fontWeight: FontWeight.w600),
    //         ),
    //       ),
    //     ),
    //   ],
    // );

    final doctorInformation = Container(
      child: Column(
        children: [
          Container(
            padding:
                EdgeInsets.only(left: 6.0, top: 40.0, right: 6.0, bottom: 10.0),
            child: Card(
              borderOnForeground: true,
              color: kConsultationColor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          child: Padding(
                        padding: EdgeInsets.only(
                            left: 0.0, top: 10.0, right: 0.0, bottom: 5.0),
                        child: Text(
                          '   Consultations Number ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Segoe',
                              fontSize: 18.0,
                              color: kTitleTextColor,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                      Container(
                        height: 30,
                        child: VerticalDivider(
                          color: Colors.black54,
                          thickness: 0.8,
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 5.0, top: 10.0, right: 0.0, bottom: 5.0),
                          child: Obx(
                            () => Text(
                              '${Get.find<DoctorProfileController>().consultationNumber.value}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Segoe',
                                  fontSize: 18.0,
                                  color: kTextLightColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          child: Padding(
                        padding: EdgeInsets.only(
                            left: 0.0, top: 0.0, right: 0.0, bottom: 5.0),
                        child: Text(
                          '   Consultation Fees (Online)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Segoe',
                              fontSize: 18.0,
                              color: kTitleTextColor,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                      Container(
                          height: 30,
                          child: VerticalDivider(
                            color: Colors.black54,
                            thickness: 0.8,
                          )),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 0.0, top: 0.0, right: 0.0, bottom: 5.0),
                          child: Obx(
                            () => Text(
                              '${Get.find<DoctorProfileController>().doctorProfile.value.consultationFeeOnline ?? 0} Tk',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Segoe',
                                  fontSize: 18.0,
                                  color: kTextLightColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          child: Padding(
                        padding: EdgeInsets.only(
                            left: 0.0, top: 0.0, right: 0.0, bottom: 5.0),
                        child: Text(
                          '   Consultation Fees (Physical)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Segoe',
                              fontSize: 18.0,
                              color: kTitleTextColor,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                      Container(
                          height: 30,
                          child: VerticalDivider(
                            color: Colors.black54,
                            thickness: 0.8,
                          )),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 0.0, top: 0.0, right: 0.0, bottom: 5.0),
                          child: Obx(
                            () => Text(
                              '${Get.find<DoctorProfileController>().doctorProfile.value.consultationFeePhysical ?? 0} Tk',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Segoe',
                                  fontSize: 18.0,
                                  color: kTextLightColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          child: Padding(
                        padding: EdgeInsets.only(
                            left: 0.0, top: 0.0, right: 0.0, bottom: 15.0),
                        child: Text(
                          '   Follow-up Fees ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Segoe',
                              fontSize: 18.0,
                              color: kTitleTextColor,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                      Container(
                          height: 30,
                          child: VerticalDivider(
                            color: Colors.black54,
                            thickness: 0.8,
                          )),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 0.0, top: 0.0, right: 0.0, bottom: 15.0),
                          child: Obx(
                            () => Text(
                              '${Get.find<DoctorProfileController>().doctorProfile.value.followupFee ?? 0} Tk',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Segoe',
                                  fontSize: 18.0,
                                  color: kTextLightColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                  child: Padding(
                padding: EdgeInsets.only(
                    left: 18.0, top: 0.0, right: 0.0, bottom: 5.0),
                child: Text(
                  'Chamber 1:',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'Segoe',
                      fontSize: 17.0,
                      color: kTitleTextColor,
                      fontWeight: FontWeight.w600),
                ),
              )),
              Container(
                height: 55,
                child: VerticalDivider(
                  color: Colors.black54,
                  thickness: 0.8,
                ),
              ),
              Expanded(
                  child: Table(
                // border: TableBorder.all(color: Color(0xFFD2DBDB)),
                columnWidths: const {
                  0: FractionColumnWidth(.2),
                  1: FractionColumnWidth(.8),
                },
                children: [
                  TableRow(
                    children: [
                      Text(
                        "Address",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF525252),
                        ),
                      ),
                      Text(
                        '${Get.find<DoctorProfileController>().doctorProfile.value.chamberOneAddress ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF525252),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        "Days",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF525252),
                        ),
                      ),
                      Text(
                        '${Get.find<DoctorProfileController>().doctorProfile.value.chamberOneConsultDay ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF525252),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        "Time",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF525252),
                        ),
                      ),
                      Text(
                        '${Get.find<DoctorProfileController>().doctorProfile.value.chamberOneConsultTime ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF525252),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
            ],
          ),
          verticalDivider,
          Row(
            children: [
              Container(
                  child: Padding(
                padding: EdgeInsets.only(
                    left: 18.0, top: 0.0, right: 0.0, bottom: 5.0),
                child: Text(
                  'Chamber 2:',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'Segoe',
                      fontSize: 17.0,
                      color: kTitleTextColor,
                      fontWeight: FontWeight.w600),
                ),
              )),
              Container(
                height: 55,
                child: VerticalDivider(
                  color: Colors.black54,
                  thickness: 0.8,
                ),
              ),
              Expanded(
                  child: Table(
                // border: TableBorder.all(color: Color(0xFFD2DBDB)),
                columnWidths: const {
                  0: FractionColumnWidth(.2),
                  1: FractionColumnWidth(.8),
                },
                children: [
                  TableRow(
                    children: [
                      Text(
                        "Address",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF525252),
                        ),
                      ),
                      Text(
                        '${Get.find<DoctorProfileController>().doctorProfile.value.chamberTwoAddress ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF525252),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        "Days",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF525252),
                        ),
                      ),
                      Text(
                        '${Get.find<DoctorProfileController>().doctorProfile.value.chamberTwoConsultDay ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF525252),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        "Time",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF525252),
                        ),
                      ),
                      Text(
                        '${Get.find<DoctorProfileController>().doctorProfile.value.chamberTwoConsultTime ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF525252),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      // drawer: CustomDrawerDoctor(),
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: true,
        backgroundColor: kBaseColor,
        shadowColor: Colors.teal,
        iconTheme: IconThemeData(color: kTitleColor),
        toolbarHeight: 50,
        title: Text(
          'My Profile',
          style:
              TextStyle(fontFamily: 'Segoe', fontSize: 18, color: kTitleColor),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: ListView(
          shrinkWrap: false,
          children: <Widget>[
            Row(
              children: [
                validationImageEdit,
              ],
            ),
            //doctorImg,
            const Divider(
              color: kTitleTextColor,
              height: 5,
              thickness: 0.6,
              indent: 0.0,
              endIndent: 0.0,
            ),
            doctorName,
            doctorDegree,
            doctorWorkPlace,
            SizedBox(
              height: 5,
            ),
            specialtyButton,
            bmdcNumber,
            experience,
            starRating,
            SizedBox(
              height: 4,
            ),
            doctorInformation,
            // consultations,
            // SizedBox(
            //   height: 8,
            // ),
            // chamberAddress1,
            // const Divider(
            //   color: kBodyTextColor,
            //   height: 0.0,
            //   thickness: 0.5,
            //   indent: 0.0,
            //   endIndent: 0.0,
            // ),
            // /*FDottedLine(
            //   color: kBodyTextColor,
            //   width: 160.0,
            //   strokeWidth: 0.5,
            //   dottedLength: 8.0,
            //   space: 2.0,
            // ),*/
            // chamberAddress2,
            // SizedBox(
            //   height: 10.0,
            // ),
            // consultationDay,
            // SizedBox(
            //   height: 2,
            // ),
            // consultationTime,
            // SizedBox(
            //   height: 50.0,
            // ),
            //forgotLabel,
            //SignInWithFB,
            //SocialLogin,
            //SignUp
          ],
        ),
      ),
    );
  }

  printIntAsDay(int day) {
    print(
        'Received integer: $day. Corresponds to day: ${intDayToEnglish(day)}');
  }

  String intDayToEnglish(int day) {
    if (day % 7 == DateTime.saturday % 7) return 'Saturday';
    if (day % 7 == DateTime.sunday % 7) return 'Sunday';
    if (day % 7 == DateTime.monday % 7) return 'Monday';
    if (day % 7 == DateTime.tuesday % 7) return 'Tuesday';
    if (day % 7 == DateTime.wednesday % 7) return 'Wednesday';
    if (day % 7 == DateTime.thursday % 7) return 'Thursday';
    if (day % 7 == DateTime.friday % 7) return 'Friday';
    throw '🐞 This should never have happened: $day';
  }
}

String? numberValidator(String? value) {
  if (value == null) {
    return null;
  }
  final n = num.tryParse(value);
  if (n == null) {
    return '"$value" is not a valid number!';
  }
  return null;
}
