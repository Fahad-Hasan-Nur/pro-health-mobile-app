// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/patient/controllers/doctor_profile_patient_part_controller.dart';
// import 'package:pro_health/patient/service/dashboard/patient_api_service.dart';

// import 'package:smooth_star_rating/smooth_star_rating.dart';

class DoctorProfile extends StatefulWidget {
  DoctorProfile({required this.doctorMemberId, this.doctorId});
  static String tag = 'DoctorProfile';
  final doctorMemberId;
  final doctorId;
  @override
  DoctorProfileState createState() => new DoctorProfileState();
}

class DoctorProfileState extends State<DoctorProfile> {
  DoctorProfileControllerPatientPart profileController =
      Get.put(DoctorProfileControllerPatientPart());

  var radius = 32.0;
  var iconSize = 20.0;
  var distance = 2.0;

  @override
  Widget build(BuildContext context) {
    profileController.callFunctions(
      memberID: widget.doctorMemberId,
      doctorID: widget.doctorId,
    );
    final validationImageEdit = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () async {
              Get.find<DoctorProfileControllerPatientPart>().gotoChatScreen();
              // Get.to(() => MessagePatient());
            },
            child: Container(
              width: 120,
              padding: EdgeInsets.only(left: 18.0),
              child: CircleAvatar(
                backgroundColor: kWhiteShade,
                radius: 23,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 22.0,
                  child: Image.asset('assets/icons/patient/messagepage.png'),
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
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blue,
                        image: DecorationImage(
                          image: (Get.find<DoctorProfileControllerPatientPart>()
                                          .doctorProfilePic
                                          .value ==
                                      '' ||
                                  Get.find<DoctorProfileControllerPatientPart>()
                                          .doctorProfilePic
                                          .value ==
                                      'null'
                              ? AssetImage(noImagePath)
                              : NetworkImage(
                                  Get.find<DoctorProfileControllerPatientPart>()
                                      .doctorProfilePic
                                      .value)) as ImageProvider<Object>,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -(radius - distance),
                    right: -(radius + iconSize + distance - 10),
                    bottom: -iconSize - distance - 55,
                    left: radius,
                    child: Obx(
                      () => Icon(
                        Icons.circle,
                        color: Get.find<DoctorProfileControllerPatientPart>()
                                .isOnline
                                .value
                            ? Color(0xff6ECEC0)
                            : Colors.grey,
                        size: iconSize - 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 120,
            child: Column(
              children: [
                Container(
                  height: 20,
                  child: Text(
                    'Patient in queue',
                    style: TextStyle(
                        fontFamily: 'Segoe',
                        color: Colors.redAccent,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  width: 35,
                  height: 35,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                          color: kBaseColor,
                          width: 1.5,
                          style: BorderStyle.solid),
                    ),
                    onPressed: () {
                      // Navigator.of(context).pushNamed('');
                    },
                    padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
                    color: kBackgroundColor,
                    child: Obx(
                      () => Text(
                        Get.find<DoctorProfileControllerPatientPart>()
                                    .patientInQueue
                                    .value <
                                10
                            ? '0${Get.find<DoctorProfileControllerPatientPart>().patientInQueue.value}'
                            : '${Get.find<DoctorProfileControllerPatientPart>().patientInQueue.value}',
                        style: TextStyle(
                          fontFamily: "Segoe",
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    final verticalDivider = Container(
      child: const Divider(
        color: kTitleTextColor,
        height: 2,
        thickness: 0.5,
        indent: 0.0,
        endIndent: 0.0,
      ),
    );
    final doctorName = Container(
      padding: EdgeInsets.only(left: 95, right: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 2),
            child: Obx(
              () => Text(
                Get.find<DoctorProfileControllerPatientPart>().name.value == ''
                    ? 'Doctor Name'
                    : Get.find<DoctorProfileControllerPatientPart>().name.value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Segoe',
                  fontSize: 20.0,
                  letterSpacing: 0.5,
                  color: kBaseColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            height: 25,
            child: FloatingActionButton(
              backgroundColor: kBackgroundColor,
              elevation: 0,
              child: Obx(
                () => Icon(
                  Get.find<DoctorProfileControllerPatientPart>().liked.value
                      ? Icons.favorite
                      : Icons.favorite_border_rounded,
                  color:
                      Get.find<DoctorProfileControllerPatientPart>().liked.value
                          ? Colors.pink
                          : null,
                ),
              ),
              onPressed: () async {
                Get.find<DoctorProfileControllerPatientPart>()
                    .updateLikeDislike();
              },
            ),
          ),
        ],
      ),
    );

    final doctorDegree = Padding(
      padding: EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 5.0),
      child: Obx(() {
        String qualificationOne = Get.find<DoctorProfileControllerPatientPart>()
            .qualificationOne
            .value;
        String qualificationTwo = Get.find<DoctorProfileControllerPatientPart>()
            .qualificationTwo
            .value;
        return Text(
          '$qualificationOne$qualificationTwo'.isEmpty
              ? 'No Qualification Found'
              : '$qualificationOne, $qualificationTwo',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Segoe',
              fontSize: 18.0,
              color: kBodyTextColor,
              fontWeight: FontWeight.w600),
        );
      }),
    );

    final doctorWorkPlace = Padding(
      padding: EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 5.0),
      child: Obx(
        () => Text(
          Get.find<DoctorProfileControllerPatientPart>().workPlace.value == ''
              ? 'Your Work Place'
              : Get.find<DoctorProfileControllerPatientPart>().workPlace.value,
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
          // Navigator.of(context).pushNamed('');
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
        color: kBaseColor,
        child: Obx(
          () => Text(
            Get.find<DoctorProfileControllerPatientPart>().speciality.value ==
                    ''
                ? 'Your speciality'
                : Get.find<DoctorProfileControllerPatientPart>()
                    .speciality
                    .value,
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
          'BMDC Registration No. ' +
              (Get.find<DoctorProfileControllerPatientPart>().bmdcNum.value ==
                      ''
                  ? ''
                  : Get.find<DoctorProfileControllerPatientPart>()
                      .bmdcNum
                      .value),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Segoe',
              fontSize: 18.0,
              color: kTextLightColor,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
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
                              '${Get.find<DoctorProfileControllerPatientPart>().consultationNumber.value}',
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
                              '${Get.find<DoctorProfileControllerPatientPart>().onlineConsultionFee.value} Tk',
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
                              '${Get.find<DoctorProfileControllerPatientPart>().physicalConsultationFee.value} Tk',
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
                              '${Get.find<DoctorProfileControllerPatientPart>().doctorFollowupFee.value}',
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
                      Obx(
                        () => Text(
                          Get.find<DoctorProfileControllerPatientPart>()
                              .chamberOneAddress
                              .value,
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF525252),
                          ),
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
                      Obx(
                        () => Text(
                          Get.find<DoctorProfileControllerPatientPart>()
                              .chamberOneConsultDay
                              .value,
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF525252),
                          ),
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
                      Obx(
                        () => Text(
                          Get.find<DoctorProfileControllerPatientPart>()
                              .chamberOneConsultTime
                              .value,
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF525252),
                          ),
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
                      Obx(
                        () => Text(
                          Get.find<DoctorProfileControllerPatientPart>()
                              .chamberTwoAddress
                              .value,
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF525252),
                          ),
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
                      Obx(
                        () => Text(
                          Get.find<DoctorProfileControllerPatientPart>()
                              .chamberTwoConsultDay
                              .value,
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF525252),
                          ),
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
                      Obx(
                        () => Text(
                          Get.find<DoctorProfileControllerPatientPart>()
                              .chamberTwoConsultTime
                              .value,
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF525252),
                          ),
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
    final seeDoctorNowButton = Container(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 80),
      child: MaterialButton(
        onPressed: () {
          Get.find<DoctorProfileControllerPatientPart>().seeDoctorNow();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
        color: kBaseColor,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35),
              child: Icon(
                Icons.videocam_rounded,
                color: kTitleColor,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 35),
              child: Text(
                'See Doctor Now',
                style: TextStyle(
                    fontFamily: "Segoe",
                    letterSpacing: 0.5,
                    fontSize: 15,
                    color: kTitleColor,
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
    final doctorExperience = Container(
      margin: const EdgeInsets.only(top: 20),
      child: Obx(
        () => Column(
          children: [
            Get.find<DoctorProfileControllerPatientPart>().experiences.length >
                    0
                ? ListTile(
                    title: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount:
                            Get.find<DoctorProfileControllerPatientPart>()
                                .experiences
                                .length,
                        itemBuilder: (BuildContext context, int index) {
                          var experience =
                              Get.find<DoctorProfileControllerPatientPart>()
                                  .experiences[index];

                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 6,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 25,
                                    color: kCardTitleColor,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 12.0,
                                          top: 4.0,
                                          right: 12,
                                          bottom: 1),
                                      child: Text(
                                        experience['hospitalName'],
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: kBodyTextColor),
                                      ),
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                  Container(
                                    height: 70,
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 10, top: 6),
                                                child: Text(
                                                  'Designation:',
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe,',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 4, top: 6),
                                                child: Text(
                                                  experience['designation'],
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe,',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  'Department:',
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe,',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 4),
                                                child: Text(
                                                  experience['department'],
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe,',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  'Duration:',
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe,',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 4),
                                                child: Text(
                                                  experience['duration'],
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe,',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  'Employment Period:',
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe,',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 4),
                                                child: Text(
                                                  experience['workingPeriod'],
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe,',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                : Container(
                    height: 100,
                    child: Center(
                      child: Text('No Experience Found'),
                    ),
                  ),
          ],
        ),
      ),
    );

    final doctorReviews = Container(
      child: Obx(
        () => Column(
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 30.0, top: 30.0, right: 20.0, bottom: 10.0),
                    child: Obx(
                      () => Text(
                        'Reviews (${Get.find<DoctorProfileControllerPatientPart>().reviews.length})',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            fontSize: 16,
                            letterSpacing: 0.5,
                            color: kTextLightColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 110,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 20.0, top: 30.0, right: 20.0, bottom: 10.0),
                    child: Obx(
                      () => Text(
                        'Ratings (${Get.find<DoctorProfileControllerPatientPart>().averageRating.value}/5.0)',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            fontSize: 16,
                            letterSpacing: 0.5,
                            color: kTextLightColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Get.find<DoctorProfileControllerPatientPart>()
                          .newReviews
                          .length >
                      0
                  ? Obx(
                      () => ListView.builder(
                        itemCount:
                            Get.find<DoctorProfileControllerPatientPart>()
                                .newReviews
                                .length,
                        itemBuilder: (BuildContext context, int index) {
                          var newReview =
                              Get.find<DoctorProfileControllerPatientPart>()
                                  .newReviews[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.blue),
                                                image: DecorationImage(
                                                  image: (newReview[
                                                                  'profilePic'] ==
                                                              null ||
                                                          newReview[
                                                                  'profilePic'] ==
                                                              'null' ||
                                                          newReview[
                                                                  'profilePic'] ==
                                                              ''
                                                      ? AssetImage(
                                                          patientNoImagePath)
                                                      : NetworkImage(newReview[
                                                          'profilePic'])) as ImageProvider<
                                                      Object>,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  newReview['patientName'],
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  newReview['reviewDate'],
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: kBodyTextColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              '${newReview['rating']}',
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1,
                                            ),
                                            Container(
                                              child: RatingStars(
                                                value: newReview['rating'],
                                                onValueChanged: (v) {},
                                                starBuilder: (index, color) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: color,
                                                ),
                                                starCount: 5,
                                                starSize: 20,
                                                maxValue: 5,
                                                starSpacing: 1,
                                                maxValueVisibility: true,
                                                valueLabelVisibility: false,
                                                animationDuration: Duration(
                                                    milliseconds: 1000),
                                                valueLabelPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 1,
                                                        horizontal: 8),
                                                valueLabelMargin:
                                                    const EdgeInsets.only(
                                                        right: 8),
                                                starOffColor:
                                                    const Color(0xffe7e8ea),
                                                starColor: Colors.yellow,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    child: Container(
                                        child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            newReview['comments'],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    )),
                                  ),
                                  Container(),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text(
                        'No Review found yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: kBodyTextColor,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );

    return Material(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 2.0,
            backgroundColor: kBaseColor,
            iconTheme: IconThemeData(color: kTitleColor),
            centerTitle: true,
            toolbarHeight: 50,
            title: Text('Doctor\'s Profile',
                style: TextStyle(
                    fontFamily: 'Segoe', fontSize: 18, color: kTitleColor)),
          ),
          backgroundColor: kBackgroundColor,
          body: Center(
            child: Column(
              children: [
                validationImageEdit,
                verticalDivider,
                doctorName,
                doctorDegree,
                doctorWorkPlace,
                specialtyButton,
                bmdcNumber,
                SizedBox(
                  height: 10,
                ),
                Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: Container(
                    height: 30,
                    child: TabBar(
                      unselectedLabelColor: kBaseColor,
                      labelColor: kTitleColor,
                      indicatorColor: kBaseColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: BoxDecoration(
                        gradient:
                            LinearGradient(colors: [kBaseColor, kButtonColor]),
                        borderRadius: BorderRadius.circular(30),
                        color: kBaseColor,
                      ),
                      tabs: [
                        Tab(
                          child: Container(
                            width: 205,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border:
                                    Border.all(color: kBaseColor, width: 1.0)),
                            padding: EdgeInsets.only(bottom: 2),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Information",
                                style: TextStyle(
                                    fontFamily: 'Segoe',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            width: 205,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border:
                                    Border.all(color: kBaseColor, width: 1.0)),
                            padding: EdgeInsets.only(bottom: 2),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Experience",
                                style: TextStyle(
                                    fontFamily: 'Segoe',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            width: 205,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border:
                                    Border.all(color: kBaseColor, width: 1.0)),
                            padding: EdgeInsets.only(bottom: 2),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Reviews",
                                style: TextStyle(
                                    fontFamily: 'Segoe',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TabBarView(
                    children: [
                      Container(
                        color: kBackgroundColor,
                        child: Column(
                          children: [
                            Expanded(child: doctorInformation),
                            SizedBox(height: 20),
                            seeDoctorNowButton,
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Container(
                        color: kBackgroundColor,
                        child: Column(
                          children: [
                            Expanded(child: doctorExperience),
                            SizedBox(height: 10),
                            seeDoctorNowButton,
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Container(
                        color: kBackgroundColor,
                        child: Column(
                          children: [
                            Expanded(child: doctorReviews),
                            SizedBox(
                              height: 12,
                            ),
                            seeDoctorNowButton,
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
