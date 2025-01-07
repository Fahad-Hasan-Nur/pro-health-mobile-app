// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:pro_health/base/utils/constants.dart';
// import 'package:pro_health/base/utils/strings.dart';
// import 'package:pro_health/patient/controllers/profile_controller.dart';
// import 'package:pro_health/patient/views/drawer/custom_drawer_patient.dart';

// class ProfilePatient extends StatefulWidget {
//   static String tag = 'ProfilePatient';
//   @override
//   ProfilePatientState createState() => new ProfilePatientState();
// }

// class ProfilePatientState extends State<ProfilePatient> {
//   PatientProfileController patientProfileController =
//       Get.put(PatientProfileController());

//   var rating = 4.5;
//   double radius = 32;
//   double iconSize = 20;
//   double distance = 2;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final patientImageEdit = Container(
//       width: size.width - 20,
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
//       child: Stack(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 padding: EdgeInsets.only(
//                     left: 10.0, top: 3.0, right: 10.0, bottom: 10.0),
//                 child: Center(
//                   child: Stack(
//                     alignment: Alignment.center,
//                     // ignore: deprecated_member_use
//                     overflow: Overflow.visible,
//                     children: [
//                       Container(
//                         height: 90,
//                         width: 90,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50),
//                           color: Colors.blue,
//                           image: DecorationImage(
//                             image: AssetImage(noImagePath),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: -(radius - distance),
//                         right: -(radius + iconSize + distance),
//                         bottom: -iconSize - distance - 60,
//                         left: radius - 5,
//                         child: Icon(
//                           Icons.circle,
//                           color: Color(0xff6ECEC0),
//                           size: iconSize - 4,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             right: size.width / 4,
//             top: 30,
//             child: InkWell(
//               onTap: () => {},
//               child: SizedBox(
//                   height: 30,
//                   width: 30,
//                   child: Image.asset(
//                     'assets/icons/doctor/edit.png',
//                   )),
//             ),
//           ),
//         ],
//       ),
//     );

//     final patientName = Container(
//       child: Text(
//         '${patientProfileController.patient.value.patientName}',
//         style: TextStyle(
//             fontFamily: 'Segoe',
//             color: kBaseColor,
//             letterSpacing: 0.5,
//             fontSize: 18,
//             fontWeight: FontWeight.w600),
//         textAlign: TextAlign.center,
//       ),
//     );

//     final profileProgress = Container(
//       height: 20,
//       child: Padding(
//         padding: EdgeInsets.only(left: 20, right: 10),
//         child: new LinearPercentIndicator(
//           width: MediaQuery.of(context).size.width - 100,
//           animation: true,
//           lineHeight: 6.0,
//           //leading: new Text("left content"),
//           trailing: new Text(
//             "90.0%",
//             style: TextStyle(
//                 fontSize: 18, color: kBaseColor, fontWeight: FontWeight.bold),
//           ),
//           animationDuration: 2500,
//           percent: 0.9,
//           /*center: Text(
//           "90.0%",
//           style: TextStyle(color: Colors.white),
//         ),*/
//           linearStrokeCap: LinearStrokeCap.roundAll,
//           progressColor: kBaseColor,
//         ),
//       ),
//     );

//     final profileButton = Container(
//       height: 30,
//       padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 130),
//       child: MaterialButton(
//         onPressed: () {
//           Navigator.of(context).pushNamed('');
//         },
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(25),
//         ),
//         padding: EdgeInsets.only(left: 5, top: 3, right: 5, bottom: 5),
//         color: kBaseColor,
//         child: Text('My Profile',
//             style: TextStyle(
//                 fontFamily: "Segoe",
//                 letterSpacing: 0.5,
//                 fontSize: 15,
//                 color: kTitleColor,
//                 fontWeight: FontWeight.w700)),
//       ),
//     );

//     final personalInfo = Card(
//       margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 15.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       elevation: 6,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15.0),
//         child: Column(
//           children: [
//             Container(
//               height: 45,
//               color: kCardTitleColor,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.only(
//                         left: 12.0, top: 8.0, right: 12, bottom: 8),
//                     child: Text(
//                       'Personal Information',
//                       style: TextStyle(
//                           fontFamily: 'Segoe',
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                           color: kBodyTextColor),
//                     ),
//                     alignment: Alignment.centerLeft,
//                   ),
//                   Container(
//                     width: 160,
//                     height: 35,
//                     padding: EdgeInsets.only(left: 120.0),
//                     child: Center(
//                       child: RawMaterialButton(
//                         elevation: 5.0,
//                         child: Image.asset('assets/icons/doctor/edit.png'),
//                         shape: CircleBorder(),
//                         //fillColor: Colors.white,
//                         padding: const EdgeInsets.all(6.0),
//                         onPressed: () {
//                           //editDoctor;
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Obx(
//               () => Container(
//                 padding: const EdgeInsets.all(15),
//                 height: 220,
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: 10, top: 4, right: 10, bottom: 1),
//                           child: Text(
//                             'District :',
//                             style: TextStyle(
//                                 fontFamily: 'Segoe',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 10),
//                           child: Text(
//                             '${patientProfileController.patient.value.districtName}', // 'Gaibandha',
//                             style: TextStyle(),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Divider(
//                         color: Colors.black,
//                         height: 0.0,
//                         thickness: 0.5,
//                         indent: 0.0,
//                         endIndent: 0.0,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: 10, top: 2, right: 10, bottom: 1),
//                           child: Text(
//                             'Thana : ',
//                             style: TextStyle(
//                                 fontFamily: 'Segoe',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 10),
//                           child: Text(
//                             '${patientProfileController.patient.value.policeStationName}',
//                             style: TextStyle(),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Divider(
//                         color: Colors.black,
//                         height: 0.0,
//                         thickness: 0.5,
//                         indent: 0.0,
//                         endIndent: 0.0,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: 10, top: 2, right: 10, bottom: 1),
//                           child: Text(
//                             'Gender :',
//                             style: TextStyle(
//                                 fontFamily: 'Segoe',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 10),
//                           child: Text(
//                             '${patientProfileController.patient.value.gender}',
//                             style: TextStyle(),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Divider(
//                         color: Colors.black,
//                         height: 0.0,
//                         thickness: 0.5,
//                         indent: 0.0,
//                         endIndent: 0.0,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: 10, top: 2, right: 10, bottom: 1),
//                           child: Text(
//                             'Blood Group :',
//                             style: TextStyle(
//                                 fontFamily: 'Segoe',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 10),
//                           child: Text(
//                             '${patientProfileController.patient.value.bloodGroup}',
//                             style: TextStyle(),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Divider(
//                         color: Colors.black,
//                         height: 0.0,
//                         thickness: 0.5,
//                         indent: 0.0,
//                         endIndent: 0.0,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: 10, top: 2, right: 10, bottom: 1),
//                           child: Text(
//                             'Weight :',
//                             style: TextStyle(
//                                 fontFamily: 'Segoe',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 10),
//                           child: Text(
//                             '${patientProfileController.patient.value.weight} Kg',
//                             style: TextStyle(),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Divider(
//                         color: Colors.black,
//                         height: 0.0,
//                         thickness: 0.5,
//                         indent: 0.0,
//                         endIndent: 0.0,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: 10, top: 2, right: 10, bottom: 1),
//                           child: Text(
//                             'Date of Birth :',
//                             style: TextStyle(
//                                 fontFamily: 'Segoe',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 10),
//                           child: Text(
//                             '${patientProfileController.dateOfBirth}',
//                             style: TextStyle(),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Divider(
//                         color: Colors.black,
//                         height: 0.0,
//                         thickness: 0.5,
//                         indent: 0.0,
//                         endIndent: 0.0,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: 10, top: 2, right: 10, bottom: 1),
//                           child: Text(
//                             'Mobile :',
//                             style: TextStyle(
//                                 fontFamily: 'Segoe',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 10),
//                           child: Text(
//                             '${patientProfileController.patient.value.mobile}',
//                             style: TextStyle(),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Divider(
//                         color: Colors.black,
//                         height: 0.0,
//                         thickness: 0.5,
//                         indent: 0.0,
//                         endIndent: 0.0,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: 10, top: 2, right: 10, bottom: 1),
//                           child: Text(
//                             'Email :',
//                             style: TextStyle(
//                                 fontFamily: 'Segoe',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 10),
//                           child: Text(
//                             '${patientProfileController.patient.value.email}',
//                             style: TextStyle(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

//     final personalHistory = Card(
//       margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 15.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       elevation: 6,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15.0),
//         child: Column(
//           children: [
//             Container(
//               height: 45,
//               color: kCardTitleColor,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.only(
//                         left: 12.0, top: 8.0, right: 12, bottom: 8),
//                     child: Text(
//                       'Personal History',
//                       style: TextStyle(
//                           fontFamily: 'Segoe',
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                           color: kBodyTextColor),
//                     ),
//                     alignment: Alignment.centerLeft,
//                   ),
//                   Container(
//                     width: 160,
//                     height: 35,
//                     padding: EdgeInsets.only(left: 120.0),
//                     child: Center(
//                       child: RawMaterialButton(
//                         elevation: 5.0,
//                         child: Image.asset('assets/icons/doctor/edit.png'),
//                         shape: CircleBorder(),
//                         //fillColor: Colors.white,
//                         padding: const EdgeInsets.all(6.0),
//                         onPressed: () {
//                           //editDoctor;
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Obx(
//               () => Container(
//                 padding: const EdgeInsets.all(15),
//                 height: 220,
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: 10, top: 4, right: 10, bottom: 1),
//                           child: Text(
//                             'Allergies :',
//                             style: TextStyle(
//                                 fontFamily: 'Segoe',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 10),
//                           child: Text(
//                             '${patientProfileController.patient.value.allergies}', // 'Gaibandha',
//                             style: TextStyle(),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Divider(
//                         color: Colors.black,
//                         height: 0.0,
//                         thickness: 0.5,
//                         indent: 0.0,
//                         endIndent: 0.0,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: 10, top: 2, right: 10, bottom: 1),
//                           child: Text(
//                             'Occupation : ',
//                             style: TextStyle(
//                                 fontFamily: 'Segoe',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 10),
//                           child: Text(
//                             '${patientProfileController.patient.value.occupation}',
//                             style: TextStyle(),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Divider(
//                         color: Colors.black,
//                         height: 0.0,
//                         thickness: 0.5,
//                         indent: 0.0,
//                         endIndent: 0.0,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: 10, top: 2, right: 10, bottom: 1),
//                           child: Text(
//                             'Smoking :',
//                             style: TextStyle(
//                                 fontFamily: 'Segoe',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 10),
//                           child: Text(
//                             '${patientProfileController.patient.value.smoking}',
//                             style: TextStyle(),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Divider(
//                         color: Colors.black,
//                         height: 0.0,
//                         thickness: 0.5,
//                         indent: 0.0,
//                         endIndent: 0.0,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: 10, top: 2, right: 10, bottom: 1),
//                           child: Text(
//                             'Marital Status :',
//                             style: TextStyle(
//                                 fontFamily: 'Segoe',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 10),
//                           child: Text(
//                             '${patientProfileController.patient.value.maritalStatus}',
//                             style: TextStyle(),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Divider(
//                         color: Colors.black,
//                         height: 0.0,
//                         thickness: 0.5,
//                         indent: 0.0,
//                         endIndent: 0.0,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: 10, top: 2, right: 10, bottom: 1),
//                           child: Text(
//                             'Alcohol :',
//                             style: TextStyle(
//                                 fontFamily: 'Segoe',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 10),
//                           child: Text(
//                             '${patientProfileController.patient.value.alcohol}',
//                             style: TextStyle(),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Divider(
//                         color: Colors.black,
//                         height: 0.0,
//                         thickness: 0.5,
//                         indent: 0.0,
//                         endIndent: 0.0,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: 10, top: 2, right: 10, bottom: 1),
//                           child: Text(
//                             'Exercise :',
//                             style: TextStyle(
//                                 fontFamily: 'Segoe',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 10),
//                           child: Text(
//                             '${patientProfileController.patient.value.exercise}',
//                             style: TextStyle(),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Divider(
//                         color: Colors.black,
//                         height: 0.0,
//                         thickness: 0.5,
//                         indent: 0.0,
//                         endIndent: 0.0,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: 10, top: 2, right: 10, bottom: 1),
//                           child: Text(
//                             'Caffeinated Beverage :',
//                             style: TextStyle(
//                                 fontFamily: 'Segoe',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 10),
//                           child: Text(
//                             '${patientProfileController.patient.value.caffinatedBeverage}',
//                             style: TextStyle(),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Divider(
//                         color: Colors.black,
//                         height: 0.0,
//                         thickness: 0.5,
//                         indent: 0.0,
//                         endIndent: 0.0,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: 10, top: 2, right: 10, bottom: 1),
//                           child: Text(
//                             'Email :',
//                             style: TextStyle(
//                                 fontFamily: 'Segoe',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 10),
//                           child: Text(
//                             '${patientProfileController.patient.value.email}',
//                             style: TextStyle(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

//     return Scaffold(
//       drawer: CustomDrawerPatient(),
//       appBar: AppBar(
//         elevation: 2.0,
//         centerTitle: true,
//         backgroundColor: kBaseColor,
//         shadowColor: Colors.teal,
//         iconTheme: IconThemeData(color: kTitleColor),
//         toolbarHeight: 50,
//         title: Text(
//           'My Profile',
//           style:
//               TextStyle(fontFamily: 'Segoe', fontSize: 18, color: kTitleColor),
//         ),
//       ),
//       backgroundColor: kBackgroundColor,
//       body: Center(
//         child: ListView(
//           shrinkWrap: false,
//           children: <Widget>[
//             patientImageEdit,
//             patientName,
//             profileProgress,
//             profileButton,
//             personalInfo,
//             personalHistory,
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: must_be_immutable

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/models/district_model.dart';
import 'package:pro_health/doctor/models/police_station_model.dart';
import 'package:pro_health/doctor/models/post_office_model.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/doctor/widgets/CustomAlert.dart';
import 'package:pro_health/patient/controllers/profile_controller.dart';
import 'package:pro_health/patient/models/patient_profile_model.dart';
import 'package:pro_health/patient/service/dashboard/profile_service.dart';
import 'package:pro_health/patient/views/bottombar/profile/widgets/camera_icon.dart';
import 'package:pro_health/patient/views/bottombar/profile/widgets/gallery_icon.dart';
import 'package:pro_health/patient/views/bottombar/profile/widgets/profile_image_card.dart';
import 'package:pro_health/patient/views/drawer/custom_drawer_patient.dart';

class ProfilePatient extends StatefulWidget {
  ProfilePatient({Key? key}) : super(key: key);

  @override
  State<ProfilePatient> createState() => _ProfilePatientState();
}

class _ProfilePatientState extends State<ProfilePatient> {
  var rating = 4.5;
  double radius = 32;
  double iconSize = 20;
  double distance = 2;
  PatientProfileService patientProfileService = PatientProfileService();
  ApiServices apiServices = ApiServices();
  int patientId = 0;
  final format = DateFormat("dd-MM-yyyy");
  var patient = PatientProfileModel();
  List<DistrictModel> districts = [];
  List<PoliceStationModel> policestations = [];
  List<PostOfficeModel> postOffices = [];
  var dateOfBirth = '';
  var count = 0;
  var openEditInfoCard = false;
  var openEditHistoryCard = false;
  var updatingPersonalInfo = false;
  var updatingPersonalHistory = false;
  var allergies = '';
  var occupation = '';
  var smoking = '';
  var maritalStatus = '';
  var alcohol = '';
  var exercise = '';
  var caffeinatedBeverages = '';
  var name = '';
  var selectedDistrict = 'Select District';
  var selectedPoliceStation = 'Select Thana';
  var selectedDistrictId = 0;
  var selectedPoliceStationId = 0;
  var selectedPostOffice = 'Select Post Office';
  var selectedPostOfficeId = 0;
  var selectedGender = 'Select Gender';
  var selectedbloodGroup = 'Select blood group';
  var weight = '';
  var selectedMaritalStatus = 'Select Marital Status';
  var mobileNo = '';
  var email = '';
  var editDob = DateTime.now().toIso8601String();

  fetchPoliceStations() async {
    if (selectedDistrictId == 0) {
      if (policestations.isNotEmpty) {
        policestations.clear();
      }
      setState(() {
        policestations.add(
          PoliceStationModel(
            policeStationID: 0,
            districtID: 0,
            policeStationName: 'Select Thana',
            entryBy: 'default',
            entryDate: getTimeNow(),
          ),
        );
        selectedPoliceStation = policestations[0].policeStationName;
        selectedPoliceStationId = policestations[0].policeStationID;
      });
    } else {
      if (policestations.isNotEmpty) {
        policestations.clear();
      }
      var response =
          await apiServices.fetchPoliceStations(selectedDistrictId.toString());
      setState(() {
        policestations.add(
          PoliceStationModel(
            policeStationID: 0,
            districtID: 0,
            policeStationName: 'Select Thana',
            entryBy: 'default',
            entryDate: getTimeNow(),
          ),
        );
        policestations.addAll(response);
      });
    }
    fetchPostOffices();
  }

  fetchPostOffices() async {
    if (selectedPoliceStationId == 0) {
      if (postOffices.isNotEmpty) {
        postOffices.clear();
      }
      setState(() {
        postOffices.add(
          PostOfficeModel(
            postOfficeId: 0,
            districtID: 0,
            policeStationID: 0,
            postOfficeName: 'Select Post Office',
            postCode: '000',
          ),
        );
        selectedPostOffice = postOffices[0].postOfficeName;
        selectedPostOfficeId = postOffices[0].postOfficeId;
      });
    } else {
      if (postOffices.isNotEmpty) {
        postOffices.clear();
      }
      var response = await apiServices
          .fetchPostOffices(selectedPoliceStationId.toString());

      setState(() {
        postOffices.add(
          PostOfficeModel(
            postOfficeId: 0,
            districtID: 0,
            policeStationID: 0,
            postOfficeName: 'Select Post Office',
            postCode: '000',
          ),
        );
        postOffices.addAll(response);
      });
    }
  }

  fetchDistricts() async {
    if (districts.isNotEmpty) {
      districts.clear();
    }
    if (policestations.isNotEmpty) {
      policestations.clear();
    }
    if (postOffices.isNotEmpty) {
      postOffices.clear();
    }
    var response = await apiServices.fetchDistricts();

    if (response.isNotEmpty) {
      setState(() {
        districts.add(
          DistrictModel(
            districtID: 0,
            districtName: 'Select District',
            entryBy: 'default',
            entryDate: getTimeNow(),
          ),
        );
        districts.addAll(response);
      });
    }
    fetchPoliceStations();
  }

  Future<bool> updatePersonalHistory() async {
    setState(() {
      updatingPersonalHistory = true;
    });
    int patientId = await getPatientId();

    Map<String, dynamic> personalHistoryMap = {};
    personalHistoryMap['allergies'] = allergies;
    personalHistoryMap['occupation'] = occupation;
    personalHistoryMap['smoking'] = smoking;
    personalHistoryMap['maritalStatus'] = selectedMaritalStatus;
    personalHistoryMap['alcohol'] = alcohol;
    personalHistoryMap['exercise'] = exercise;
    personalHistoryMap['caffeinatedBeverage'] = caffeinatedBeverages;

    bool response = await patientProfileService.updatePersonalHistory(
        personalHistoryMap, patientId);
    if (response) {
      setState(() {
        updatingPersonalHistory = false;
      });
      // getPatientProfileInfo();
      return true;
    } else {
      setState(() {
        updatingPersonalHistory = false;
      });
      return false;
    }
  }

  Future<bool> updatePersonalInformation() async {
    setState(() {
      updatingPersonalInfo = true;
    });
    int patientId = await getPatientId();

    Map<String, dynamic> personalInfoMap = {};
    personalInfoMap['name'] = name;
    personalInfoMap['districtID'] = selectedDistrictId;
    personalInfoMap['policeStationID'] = selectedPoliceStationId;
    personalInfoMap['postOfficeID'] = selectedPostOfficeId;
    personalInfoMap['gender'] = selectedGender;
    personalInfoMap['bloodGroup'] = selectedbloodGroup;
    personalInfoMap['weight'] = weight;

    personalInfoMap['dateOfBirth'] = editDob; // getValidDateTime(editDob);
    personalInfoMap['email'] = email;
    personalInfoMap['district'] = selectedDistrict;
    personalInfoMap['policeStation'] = selectedPoliceStation;
    personalInfoMap['postOffice'] = selectedPostOffice;

    bool response = await patientProfileService.updatePersonalInfo(
        personalInfoMap, patientId);
    if (response) {
      setState(() {
        updatingPersonalInfo = false;
      });
      getPatientProfileInfo();
      return true;
    } else {
      setState(() {
        updatingPersonalInfo = false;
      });
      return false;
    }
  }

  getPatientProfileInfo() async {
    patientId = await getPatientId();
    patient = await patientProfileService.getPatientProfileInfo(patientId);
    setState(() {
      dateOfBirth = getCustomDate(patient.dateOfBirth ?? '');
      editDob = patient.dateOfBirth ?? getTimeNow();
      selectedDistrict = patient.district ?? 'Select District';
      // selectedDistrict = patient.districtName ?? 'Select District';
      selectedDistrictId = patient.districtID ?? 0;

      selectedPostOfficeId = patient.postOfficeId ?? 0;

      name = patient.patientName ?? '';
      // selectedPoliceStation = patient.policeStationName ?? 'Select Thana';
      selectedPoliceStation = patient.thana ?? 'Select Thana';
      selectedPoliceStationId = patient.policeStationID ?? 0;

      // selectedPostOffice = patient.postOfficeName ?? 'Select Post Office';
      selectedPostOffice = patient.postOffice ?? 'Select Post Office';
      selectedPostOfficeId = patient.postOfficeId ?? 0;

      selectedGender = patient.gender ?? 'Male';
      selectedbloodGroup = patient.bloodGroup ?? 'A+';
      weight = patient.weight ?? '';
      selectedMaritalStatus = patient.maritalStatus ?? 'Married';
      mobileNo = patient.mobile ?? '';
      email = patient.email ?? '';
      allergies = patient.allergies ?? '';
      occupation = patient.occupation ?? '';
      smoking = patient.smoking ?? '';
      alcohol = patient.alcohol ?? '';
      exercise = patient.exercise ?? '';
      caffeinatedBeverages = patient.caffinatedBeverage ?? '';
    });

    fetchDistricts();
  }

  @override
  void initState() {
    getPatientProfileInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final patientImageEdit = Container(
      width: size.width - 20,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: // profileController.openEditInfoCard.value ?
                    () {
                  Get.defaultDialog(
                    title: 'Select Option',
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CameraIcon(
                          profileController:
                              Get.find<PatientProfileController>(),
                          isDoctor: false,
                        ),
                        SizedBox(width: 40),
                        GalleryIcon(
                          profileController:
                              Get.find<PatientProfileController>(),
                          isDoctor: false,
                        ),
                      ],
                    ),
                  );
                  Get.find<PatientProfileController>().openEditInfoCard.value =
                      true;
                },
                // : null,
                child: ProfileImageCard(),
                // child: ProfileImageCard(profileController: Get.find<PatientProfileController>()),
              ),
            ],
          ),
          Positioned(
            right: size.width / 4,
            top: 30,
            child: InkWell(
              onTap: () {
                setState(() {
                  openEditInfoCard = !openEditInfoCard;
                  openEditHistoryCard = !openEditHistoryCard;
                });
              },
              child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    'assets/icons/doctor/edit.png',
                  )),
            ),
          ),
        ],
      ),
    );

    final editPersonalInfo = Card(
      margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 6,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Column(
          children: [
            Container(
              height: 45,
              color: kCardTitleColor,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 12.0, top: 8.0, right: 12, bottom: 8),
                        child: Text(
                          'Update Personal Information',
                          style: TextStyle(
                              fontFamily: 'Segoe',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: kBodyTextColor),
                        ),
                        // alignment: Alignment.centerLeft,
                      ),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          openEditInfoCard = !openEditInfoCard;
                        });
                        getPatientProfileInfo();
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: TextFormField(
                initialValue: name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: UnderlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                onChanged: (val) => name = val,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: TextFormField(
                initialValue: selectedDistrict,
                decoration: InputDecoration(
                  labelText: 'District',
                  border: UnderlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                onChanged: (val) => selectedDistrict = val,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: TextFormField(
                initialValue: selectedPoliceStation,
                decoration: InputDecoration(
                  labelText: 'Thana',
                  border: UnderlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                onChanged: (val) => selectedPoliceStation = val,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: TextFormField(
                initialValue: selectedPostOffice,
                decoration: InputDecoration(
                  labelText: 'Post Office',
                  border: UnderlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                onChanged: (val) => selectedPostOffice = val,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: TextFormField(
                  initialValue: selectedGender,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    hintText: 'Male / Female',
                    border: UnderlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  onChanged: (val) {
                    setState(() {
                      selectedGender = val;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: TextFormField(
                  initialValue: selectedbloodGroup,
                  decoration: InputDecoration(
                    labelText: 'Blood Group',
                    hintText: 'A+',
                    border: UnderlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  onChanged: (val) {
                    setState(() {
                      selectedbloodGroup = val;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  initialValue: weight,
                  decoration: InputDecoration(
                    labelText: 'Weight',
                    hintText: '60',
                    border: UnderlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  onChanged: (val) {
                    setState(() {
                      weight = val;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Container(
                child: DateTimeField(
                  initialValue: DateTime.parse(editDob),
                  format: format,
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                  onChanged: (val) {
                    setState(() {
                      editDob = val!.toIso8601String();
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Date of Birth",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    // border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: TextFormField(
                  initialValue: mobileNo,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Mobile No.',
                    border: UnderlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  onChanged: (val) {
                    setState(() {
                      mobileNo = val;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: TextFormField(
                  initialValue: email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: UnderlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                color: kBaseColor,
                minWidth: 150,
                height: 40,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: () async {
                  bool updated = await updatePersonalInformation();
                  if (updated) {
                    showMyDialog(
                      context,
                      "Success",
                      'Personal information saved successfully.',
                    );
                  } else {
                    showMyDialog(
                      context,
                      "Opps!",
                      'Failed to save information, please try again later.',
                    );
                  }
                },
                child: Text(
                  updatingPersonalInfo ? 'Updating..' : 'Save',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final patientName = Container(
      child: Text(
        '${patient.patientName ?? ''}',
        style: TextStyle(
            fontFamily: 'Segoe',
            color: kBaseColor,
            letterSpacing: 0.5,
            fontSize: 18,
            fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );

    final profileProgress = Container(
      height: 20,
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 10),
        child: new LinearPercentIndicator(
          width: MediaQuery.of(context).size.width - 100,
          animation: true,
          lineHeight: 6.0,
          //leading: new Text("left content"),
          trailing: new Text(
            "90.0%",
            style: TextStyle(
                fontSize: 18, color: kBaseColor, fontWeight: FontWeight.bold),
          ),
          animationDuration: 2500,
          percent: 0.9,
          /*center: Text(
          "90.0%",
          style: TextStyle(color: Colors.white),
        ),*/
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: kBaseColor,
        ),
      ),
    );

    final profileButton = Container(
      height: 30,
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 130),
      child: MaterialButton(
        onPressed: () {
          // Navigator.of(context).pushNamed('');
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.only(left: 5, top: 3, right: 5, bottom: 5),
        color: kBaseColor,
        child: Text('My Profile',
            style: TextStyle(
                fontFamily: "Segoe",
                letterSpacing: 0.5,
                fontSize: 15,
                color: kTitleColor,
                fontWeight: FontWeight.w700)),
      ),
    );

    final personalInfo = Card(
      margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 6,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Column(
          children: [
            Container(
              height: 45,
              color: kCardTitleColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 12.0, top: 8.0, right: 12, bottom: 8),
                    child: Text(
                      'Personal Information',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: kBodyTextColor),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    width: 160,
                    height: 35,
                    padding: EdgeInsets.only(left: 120.0),
                    child: Center(
                      child: RawMaterialButton(
                        elevation: 5.0,
                        child: Image.asset('assets/icons/doctor/edit.png'),
                        shape: CircleBorder(),
                        //fillColor: Colors.white,
                        padding: const EdgeInsets.all(6.0),
                        onPressed: () {
                          setState(() {
                            openEditInfoCard = !openEditInfoCard;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              height: 240,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, top: 4, right: 10, bottom: 1),
                        child: Text(
                          'District :',
                          style: TextStyle(
                              fontFamily: 'Segoe', fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          '${patient.district}', // 'Gaibandha',
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: kTitleColor,
                      height: 0.0,
                      thickness: 0.5,
                      indent: 0.0,
                      endIndent: 0.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, top: 2, right: 10, bottom: 1),
                        child: Text(
                          'Thana : ',
                          style: TextStyle(
                              fontFamily: 'Segoe', fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          '${patient.thana}',
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: kTitleColor,
                      height: 0.0,
                      thickness: 0.5,
                      indent: 0.0,
                      endIndent: 0.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, top: 2, right: 10, bottom: 1),
                        child: Text(
                          'Post Office : ',
                          style: TextStyle(
                              fontFamily: 'Segoe', fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          '${patient.postOffice}',
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: kTitleColor,
                      height: 0.0,
                      thickness: 0.5,
                      indent: 0.0,
                      endIndent: 0.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, top: 2, right: 10, bottom: 1),
                        child: Text(
                          'Gender :',
                          style: TextStyle(
                              fontFamily: 'Segoe', fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          '${patient.gender}',
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: kTitleColor,
                      height: 0.0,
                      thickness: 0.5,
                      indent: 0.0,
                      endIndent: 0.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, top: 2, right: 10, bottom: 1),
                        child: Text(
                          'Blood Group :',
                          style: TextStyle(
                              fontFamily: 'Segoe', fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        // padding: EdgeInsets.only(right: 10),
                        child: Text(
                          '${patient.bloodGroup}',
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: kTitleColor,
                      height: 0.0,
                      thickness: 0.5,
                      indent: 0.0,
                      endIndent: 0.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 2, bottom: 1),
                        child: Text(
                          'Weight :',
                          style: TextStyle(
                              fontFamily: 'Segoe', fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          '${patient.weight} Kg',
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: kTitleColor,
                      height: 0.0,
                      thickness: 0.5,
                      indent: 0.0,
                      endIndent: 0.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, top: 2, right: 10, bottom: 1),
                        child: Text(
                          'Date of Birth :',
                          style: TextStyle(
                              fontFamily: 'Segoe', fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          '$dateOfBirth',
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: kTitleColor,
                      height: 0.0,
                      thickness: 0.5,
                      indent: 0.0,
                      endIndent: 0.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, top: 2, right: 10, bottom: 1),
                        child: Text(
                          'Mobile :',
                          style: TextStyle(
                              fontFamily: 'Segoe', fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          '${patient.mobile}',
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: kTitleColor,
                      height: 0.0,
                      thickness: 0.5,
                      indent: 0.0,
                      endIndent: 0.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, top: 2, right: 10, bottom: 1),
                        child: Text(
                          'Email :',
                          style: TextStyle(
                              fontFamily: 'Segoe', fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          '${patient.email}',
                          style: TextStyle(),
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
    final editPersonalHistory = Card(
      margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 6,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Column(
          children: [
            Container(
              height: 45,
              color: kCardTitleColor,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 12.0, top: 8.0, right: 12, bottom: 8),
                        child: Text(
                          'Update Personal History',
                          style: TextStyle(
                              fontFamily: 'Segoe',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: kBodyTextColor),
                        ),
                        // alignment: Alignment.centerLeft,
                      ),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          openEditHistoryCard = !openEditHistoryCard;
                        });
                        getPatientProfileInfo();
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: TextFormField(
                initialValue: allergies,
                decoration: InputDecoration(
                  labelText: 'Allergy',
                  border: UnderlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                onChanged: (val) {
                  setState(() {
                    allergies = val;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: TextFormField(
                  initialValue: occupation,
                  decoration: InputDecoration(
                    labelText: 'Occupation',
                    border: UnderlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  onChanged: (val) {
                    setState(() {
                      occupation = val;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: TextFormField(
                  initialValue: smoking,
                  decoration: InputDecoration(
                    labelText: 'Smoking',
                    border: UnderlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  onChanged: (val) {
                    setState(() {
                      smoking = val;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: TextFormField(
                  initialValue: selectedMaritalStatus,
                  decoration: InputDecoration(
                    labelText: 'Marital Status',
                    border: UnderlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  onChanged: (val) {
                    setState(() {
                      selectedMaritalStatus = val;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: TextFormField(
                  initialValue: alcohol,
                  decoration: InputDecoration(
                    labelText: 'Alcohol',
                    border: UnderlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  onChanged: (val) {
                    setState(() {
                      alcohol = val;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: TextFormField(
                  initialValue: exercise,
                  decoration: InputDecoration(
                    labelText: 'Exercise',
                    border: UnderlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  onChanged: (val) {
                    setState(() {
                      exercise = val;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: TextFormField(
                  initialValue: caffeinatedBeverages,
                  decoration: InputDecoration(
                    labelText: 'Caffeinated Beverages',
                    border: UnderlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  onChanged: (val) {
                    setState(() {
                      caffeinatedBeverages = val;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                color: kBaseColor,
                minWidth: 150,
                height: 40,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: () async {
                  bool updated = await updatePersonalHistory();
                  if (updated) {
                    showMyDialog(
                      context,
                      "Success",
                      'Personal history information saved successfully.',
                    );
                  } else {
                    showMyDialog(
                      context,
                      "Opps!",
                      'Failed to save information, please try again later.',
                    );
                  }
                },
                child: Text(
                  updatingPersonalHistory ? 'Updating..' : 'Save',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final personalHistory = Card(
      margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 6,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Column(
          children: [
            Container(
              height: 45,
              color: kCardTitleColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 12.0, top: 8.0, right: 12, bottom: 8),
                    child: Text(
                      'Personal History',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: kBodyTextColor),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    width: 160,
                    height: 35,
                    padding: EdgeInsets.only(left: 120.0),
                    child: Center(
                      child: RawMaterialButton(
                        elevation: 5.0,
                        child: Image.asset('assets/icons/doctor/edit.png'),
                        shape: CircleBorder(),
                        //fillColor: Colors.white,
                        padding: const EdgeInsets.all(6.0),
                        onPressed: () {
                          setState(() {
                            openEditHistoryCard = !openEditHistoryCard;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              height: 220,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, top: 4, right: 10, bottom: 1),
                        child: Text(
                          'Allergies :',
                          style: TextStyle(
                              fontFamily: 'Segoe', fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          '${patient.allergies}', // 'Gaibandha',
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: kTitleColor,
                      height: 0.0,
                      thickness: 0.5,
                      indent: 0.0,
                      endIndent: 0.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, top: 2, right: 10, bottom: 1),
                        child: Text(
                          'Occupation : ',
                          style: TextStyle(
                              fontFamily: 'Segoe', fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          '${patient.occupation}',
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: kTitleColor,
                      height: 0.0,
                      thickness: 0.5,
                      indent: 0.0,
                      endIndent: 0.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, top: 2, right: 10, bottom: 1),
                        child: Text(
                          'Smoking :',
                          style: TextStyle(
                              fontFamily: 'Segoe', fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          '${patient.smoking}',
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: kTitleColor,
                      height: 0.0,
                      thickness: 0.5,
                      indent: 0.0,
                      endIndent: 0.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, top: 2, right: 10, bottom: 1),
                        child: Text(
                          'Marital Status :',
                          style: TextStyle(
                              fontFamily: 'Segoe', fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          '${patient.maritalStatus}',
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: kTitleColor,
                      height: 0.0,
                      thickness: 0.5,
                      indent: 0.0,
                      endIndent: 0.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, top: 2, right: 10, bottom: 1),
                        child: Text(
                          'Alcohol :',
                          style: TextStyle(
                              fontFamily: 'Segoe', fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          '${patient.alcohol}',
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: kTitleColor,
                      height: 0.0,
                      thickness: 0.5,
                      indent: 0.0,
                      endIndent: 0.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, top: 2, right: 10, bottom: 1),
                        child: Text(
                          'Exercise :',
                          style: TextStyle(
                              fontFamily: 'Segoe', fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          '${patient.exercise}',
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: kTitleColor,
                      height: 0.0,
                      thickness: 0.5,
                      indent: 0.0,
                      endIndent: 0.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, top: 2, right: 10, bottom: 1),
                        child: Text(
                          'Caffeinated Beverage :',
                          style: TextStyle(
                              fontFamily: 'Segoe', fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          '${patient.caffinatedBeverage}',
                          style: TextStyle(),
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

    return Scaffold(
      drawer: CustomDrawerPatient(),
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: true,
        backgroundColor: kBaseColor,
        shadowColor: Colors.teal,
        iconTheme: IconThemeData(color: kTitleColor),
        toolbarHeight: 50,
        leading: IconButton(
          color: kTitleColor,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back),
        ),
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
            patientImageEdit,
            patientName,
            profileProgress,
            profileButton,
            openEditInfoCard ? editPersonalInfo : personalInfo,
            openEditHistoryCard ? editPersonalHistory : personalHistory,
            // personalHistory,
          ],
        ),
      ),
    );
  }
}
