// // ignore_for_file: unused_local_variable

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:pro_health/base/utils/strings.dart';
// import 'package:pro_health/doctor/controllers/appointment_controller.dart';
// import 'package:pro_health/doctor/services/api_service/api_services.dart';
// import 'package:pro_health/doctor/views/bottombar/appointment/chat/ChatScreen.dart';
// import 'package:pro_health/doctor/views/dashboard/consultation_history/create_prescription.dart';
// import 'package:pro_health/doctor/views/drawer/custom_drawer_doctor.dart';
// import 'package:pro_health/base/utils/constants.dart';
// // import 'chat/ChatScreen.dart';

// class OnlineConsultancy extends StatefulWidget {
//   static String tag = 'OnlineConsultancy';
//   @override
//   OnlineConsultancyState createState() => new OnlineConsultancyState();
// }

// class OnlineConsultancyState extends State<OnlineConsultancy> {
//   AppointmentController appointmentController =
//       Get.put(AppointmentController());
//   ApiServices apiServices = ApiServices();

//   @override
//   Widget build(BuildContext context) {
//     final appointmentLogo = Container(
//       padding: EdgeInsets.only(top: 2),
//       child: Hero(
//         tag: 'hero',
//         child: CircleAvatar(
//           backgroundColor: Colors.transparent,
//           radius: 35.0,
//           child: Image.asset('assets/icons/doctor/appointments.png'),
//         ),
//       ),
//     );

//     final appointmentTitle = Container(
//       padding: EdgeInsets.only(bottom: 5),
//       child: Text(
//         'Appointment',
//         style: TextStyle(
//             fontFamily: 'Segoe',
//             color: kTextLightColor,
//             letterSpacing: 0.5,
//             fontSize: 18,
//             fontWeight: FontWeight.w600),
//         textAlign: TextAlign.center,
//       ),
//     );

//     final verticalDivider = Container(
//       child: Divider(
//         color: Colors.black,
//         height: 0.0,
//         thickness: 0.5,
//         indent: 0.0,
//         endIndent: 0.0,
//       ),
//     );

//     // Appointment Tab

//     final topCard = Card(
//       margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       elevation: 15,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20.0),
//         child: Column(
//           children: [
//             Container(
//               height: 65,
//               color: kCardTitleColor,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.only(left: 12.0, top: 10.0),
//                     child: Text(
//                       'Appointment Request',
//                       style: TextStyle(fontSize: 16, color: kBodyTextColor),
//                     ),
//                     alignment: Alignment.centerLeft,
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(left: 10.0),
//                     child: Row(
//                       children: [
//                         Icon(Icons.access_time,
//                             size: 20, color: kBodyTextColor),
//                         SizedBox(
//                           width: 2.0,
//                         ),
//                         Obx(
//                           () => Text(
//                             appointmentController.appoinments.length > 0
//                                 ? appointmentController.appoinments[0]
//                                     ['createdOn']
//                                 : '',
//                             style:
//                                 TextStyle(fontSize: 16, color: kBodyTextColor),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 height: 60,
//                 color: Colors.white,
//                 child: Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(left: 20, right: 10),
//                       height: 35,
//                       width: 35,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50),
//                         border: Border.all(width: 1, color: Colors.blue),
//                         // image: DecorationImage(
//                         //   image: (appoinments.length > 0
//                         //       ? (appoinments[0]['profilePic'] == null ||
//                         //               appoinments[0]['profilePic'] == 'null' ||
//                         //               appoinments[0]['profilePic'] == ''
//                         //           ? AssetImage(patientNoImagePath)
//                         //           : NetworkImage(appoinments[0]['profilePic']))
//                         //       : AssetImage(
//                         //           patientNoImagePath)) as ImageProvider<Object>,
//                         // ),
//                         image: DecorationImage(
//                           image: AssetImage(patientNoImagePath),
//                         ),
//                       ),
//                     ),
//                     // Container(
//                     //   padding: EdgeInsets.only(left: 20, right: 10),
//                     //   child: CircleAvatar(
//                     //     radius: 18,
//                     //     backgroundColor: kBaseColor,
//                     //     child: CircleAvatar(
//                     //       backgroundColor: Colors.white,
//                     //       radius: 17.0,
//                     //       child: appoinments.length > 0
//                     //           ? (appoinments[0]['profilePic'] == null ||
//                     //                   appoinments[0]['profilePic'] == 'null' ||
//                     //                   appoinments[0]['profilePic'] == ''
//                     //               ? Image.asset(noImagePath)
//                     //               : Image.network(appoinments[0]['profilePic']))
//                     //           : Image.asset(noImagePath),
//                     //     ),
//                     //   ),
//                     // ),
//                     SizedBox(
//                       width: 8,
//                     ),
//                     Container(
//                       child: Obx(
//                         () => Text(
//                           appointmentController.appoinments.length > 0
//                               ? appointmentController.appoinments[0]
//                                   ['patientName']
//                               : '',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 10, right: 60),
//               child: Container(
//                 height: 90,
//                 width: MediaQuery.of(context).size.width / 1.3,
//                 decoration: BoxDecoration(
//                     color: kTitleColor,
//                     shape: BoxShape.rectangle,
//                     borderRadius: BorderRadius.circular(10)),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Expanded(
//                               child: Obx(
//                                 () => Text(
//                                   "Problem: ${appointmentController.appoinments.length > 0 ? appointmentController.appoinments[0]['problem'].trim() : ''}",
//                                   textAlign: TextAlign.start,
//                                   style: TextStyle(
//                                     fontFamily: 'Segoe',
//                                     letterSpacing: 0.5,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 5.0,
//             ),
//             Container(
//               height: 60,
//               child: Row(
//                 children: [
//                   Container(
//                     width: 178,
//                     padding: EdgeInsets.only(left: 25.0, right: 25.0),
//                     child: MaterialButton(
//                       elevation: 5,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(24),
//                       ),
//                       onPressed: () async {
//                         appointmentController.isLoading.value = true;

//                         Map<String, dynamic> currentAppointment =
//                             appointmentController.appoinments[0];

//                         Get.to(
//                           () => CreatePrescription(
//                             appointment: currentAppointment,
//                             appointmentController: appointmentController,
//                           ),
//                         );
//                       },
//                       padding: EdgeInsets.only(top: 2.0, bottom: 3.0),
//                       color: kButtonColor,
//                       child: Text(
//                         'Accept',
//                         style: TextStyle(
//                           fontFamily: "Segoe",
//                           letterSpacing: 0.5,
//                           fontSize: 16,
//                           color: kWhiteShadow,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 178,
//                     padding: EdgeInsets.only(left: 25.0, right: 20.0),
//                     child: MaterialButton(
//                       elevation: 5,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(24),
//                         side: BorderSide(
//                             color: kBaseColor,
//                             width: 0.8,
//                             style: BorderStyle.solid),
//                       ),
//                       onPressed: () async {
//                         var response =
//                             await apiServices.updateDoctorAppointmentStatus(
//                                 'declined',
//                                 appointmentController.appoinments[0]
//                                     ['appoitmentID']);
//                         if (response) {
//                           appointmentController.appoinments.clear();
//                           appointmentController.queueAppointments.clear();
//                           appointmentController.fetchDoctorAppoinments();
//                         }
//                       },
//                       padding: EdgeInsets.only(top: 2.0, bottom: 3.0),
//                       color: kWhiteShadow,
//                       child: Text('Decline',
//                           style: TextStyle(
//                               fontFamily: "Segoe",
//                               letterSpacing: 0.5,
//                               fontSize: 16,
//                               color: kBaseColor)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//     final nextAppointmentTitle = Container(
//       padding: EdgeInsets.only(left: 20.0, top: 5.0, right: 20.0, bottom: 10.0),
//       alignment: Alignment.centerLeft,
//       child: Text(
//         'Next Appointments',
//         style: TextStyle(fontSize: 20, color: kTextLightColor),
//       ),
//     );

//     // Message Tab

//     final searchMessage = Container(
//       height: 65,
//       padding: EdgeInsets.only(left: 30, top: 25, right: 30, bottom: 5),
//       child: TextFormField(
//         keyboardType: TextInputType.text,
//         autofocus: false,
//         initialValue: '',
//         style:
//             TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
//         autocorrect: true,
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white,
//           hintText: 'Search',
//           hintStyle: TextStyle(
//               fontFamily: 'Segoe', fontSize: 20, fontWeight: FontWeight.w500),
//           contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
//           prefixIcon: Container(
//             child: Icon(
//               Icons.search_rounded,
//               size: 26,
//             ),
//           ),
//         ),
//       ),
//     );
//     final messageHome = Expanded(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Obx(
//               () => ListView.builder(
//                 // itemCount: chatList.length,
//                 itemCount: appointmentController.chatList.length,
//                 shrinkWrap: true,
//                 padding: EdgeInsets.only(top: 16, bottom: 20),
//                 physics: NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   return Container(
//                     // child: ChatWidget(
//                     //   memberId: memberId,
//                     //   chat: chatList[index],
//                     // ),
//                     child: ChatWidget(
//                       memberId: appointmentController.memberId,
//                       chat: appointmentController.chatList[index],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

//     return Material(
//       child: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           drawer: CustomDrawerDoctor(),
//           appBar: AppBar(
//             elevation: 2.0,
//             backgroundColor: kBaseColor,
//             iconTheme: IconThemeData(color: kTitleColor),
//             shadowColor: Colors.teal,
//             centerTitle: true,
//             toolbarHeight: 50,
//             title: Text('Emergency Online Consultation',
//                 style: TextStyle(
//                     fontFamily: 'Segoe', fontSize: 18, color: kTitleColor)),
//           ),
//           backgroundColor: kBackgroundColor,
//           body: Center(
//             child: Obx(
//               () => Column(
//                 children: [
//                   appointmentLogo,
//                   appointmentTitle,
//                   verticalDivider,
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Theme(
//                     data: ThemeData(
//                       splashColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//                     ),
//                     child: Container(
//                       height: 35,
//                       child: TabBar(
//                         unselectedLabelColor: kBaseColor,
//                         labelColor: kTitleColor,
//                         indicatorColor: kBaseColor,
//                         indicatorSize: TabBarIndicatorSize.label,
//                         indicator: BoxDecoration(
//                             gradient: LinearGradient(
//                                 colors: [kBaseColor, kBaseColor]),
//                             borderRadius: BorderRadius.circular(50),
//                             color: kBaseColor),
//                         tabs: [
//                           Tab(
//                             child: Container(
//                               width: 205,
//                               height: 34,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(40),
//                                   border: Border.all(
//                                       color: kBaseColor, width: 1.0)),
//                               child: Align(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   "Appointment",
//                                   style: TextStyle(
//                                     fontFamily: 'Segoe',
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Tab(
//                             child: Container(
//                               width: 205,
//                               height: 34,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(40),
//                                   border: Border.all(
//                                       color: kBaseColor, width: 1.0)),
//                               child: Align(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   "Message",
//                                   style: TextStyle(
//                                     fontFamily: 'Segoe',
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: TabBarView(
//                       children: [
//                         Container(
//                           // child: appoinments.length > 0
//                           child: appointmentController.appoinments.length > 0
//                               ? Column(
//                                   children: [
//                                     topCard,
//                                     nextAppointmentTitle,
//                                     Expanded(
//                                       child: appointmentController
//                                                   .queueAppointments.length >
//                                               0
//                                           ? ListView.builder(
//                                               itemCount: appointmentController
//                                                   .queueAppointments.length,
//                                               itemBuilder:
//                                                   (BuildContext context,
//                                                       int index) {
//                                                 var appointment =
//                                                     appointmentController
//                                                             .queueAppointments[
//                                                         index];
//                                                 return Padding(
//                                                   padding: const EdgeInsets
//                                                           .symmetric(
//                                                       horizontal: 20,
//                                                       vertical: 5),
//                                                   child: Container(
//                                                     height: 60,
//                                                     decoration: BoxDecoration(
//                                                         color: Colors.white,
//                                                         shape:
//                                                             BoxShape.rectangle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(20)),
//                                                     alignment: Alignment.center,
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Row(
//                                                           children: [
//                                                             SizedBox(
//                                                               width: 10,
//                                                             ),
//                                                             Container(
//                                                               height: 35,
//                                                               width: 35,
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             50),
//                                                                 border: Border.all(
//                                                                     width: 1,
//                                                                     color: Colors
//                                                                         .blue),
//                                                                 // image:
//                                                                 //     DecorationImage(
//                                                                 //   image: (appointment['profilePic'] == null ||
//                                                                 //           appointment['profilePic'] ==
//                                                                 //               'null' ||
//                                                                 //           appointment['profilePic'] ==
//                                                                 //               ''
//                                                                 //       ? AssetImage(
//                                                                 //           patientNoImagePath)
//                                                                 //       : NetworkImage(
//                                                                 //           appointment
//                                                                 //               [
//                                                                 //               'profilePic'])) as ImageProvider<
//                                                                 //       Object>,
//                                                                 // ),
//                                                                 image:
//                                                                     DecorationImage(
//                                                                   image: AssetImage(
//                                                                       patientNoImagePath),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             SizedBox(
//                                                               width: 10,
//                                                             ),
//                                                             Container(
//                                                               padding: EdgeInsets
//                                                                   .only(
//                                                                       top:
//                                                                           10.0),
//                                                               child: Column(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 children: [
//                                                                   Container(
//                                                                     child: Text(
//                                                                       appointment[
//                                                                           'patientName'],
//                                                                       style: TextStyle(
//                                                                           fontSize:
//                                                                               16),
//                                                                     ),
//                                                                   ),
//                                                                   Container(
//                                                                     child: Text(
//                                                                       appointment[
//                                                                           'createdOn'],
//                                                                       style: TextStyle(
//                                                                           fontSize:
//                                                                               14),
//                                                                     ),
//                                                                   )
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 );
//                                               },
//                                             )
//                                           : Center(
//                                               child: Text(
//                                               'No next appointment found',
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: kTextLightColor,
//                                               ),
//                                             )),
//                                     ),
//                                   ],
//                                 )
//                               : Center(
//                                   child: Text(
//                                     'No appointments found right now',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       color: kTextLightColor,
//                                     ),
//                                   ),
//                                 ),
//                         ),
//                         Container(
//                           child: Column(
//                             children: [
//                               searchMessage,
//                               messageHome,
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ========================================

// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pro_health/base/utils/ApiList.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/doctor/controllers/appointment_controller.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/doctor/services/chat/chat_service_doctor.dart';
import 'package:pro_health/doctor/views/bottombar/appointment/chat/ChatScreen.dart';
import 'package:pro_health/doctor/views/dashboard/consultation_history/create_prescription.dart';
import 'package:pro_health/doctor/views/drawer/custom_drawer_doctor.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/patient/models/chatlist_patient.dart';

class OnlineConsultancy extends StatefulWidget {
  static String tag = 'OnlineConsultancy';
  @override
  OnlineConsultancyState createState() => new OnlineConsultancyState();
}

class OnlineConsultancyState extends State<OnlineConsultancy> {
  AppointmentController appointmentController =
      Get.put(AppointmentController());
  ApiServices apiServices = ApiServices();

  ChatServicesDoctor chatServicesPatient = ChatServicesDoctor();

  TextEditingController searchController = TextEditingController();

  double radius = 32;
  double iconSize = 20;
  double distance = 2;
  var _timer;

  List<ChatList> chatList = [];
  List<ChatList> foundChatList = [];

  bool isSearching = false;

  void runFilter(String enteredKeyword) {
    List<ChatList> results = [];
    if (enteredKeyword.trim().isEmpty) {
      setState(() {
        isSearching = false;
        results = chatList;
      });
    } else {
      setState(() {
        isSearching = true;
      });

      results = chatList
          .where((patient) => patient.patientName!
              .toLowerCase()
              .contains(enteredKeyword.trim().toLowerCase()))
          .toList();
    }
    setState(() {
      foundChatList = results;
    });
  }

  getChatList() async {
    var response = await chatServicesPatient.getChatList();
    if (response.isNotEmpty) {
      if (chatList.isNotEmpty) {
        chatList.clear();
        setState(() {
          chatList.addAll(response);
        });
      } else {
        setState(() {
          chatList.addAll(response);
        });
      }
    }
  }

  @override
  void initState() {
    getChatList();
    const oneSec = Duration(seconds: 3);
    _timer = Timer.periodic(oneSec, (Timer t) => getChatList());

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appointmentLogo = Container(
      padding: EdgeInsets.only(top: 2),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 35.0,
          child: Image.asset('assets/icons/doctor/appointments.png'),
        ),
      ),
    );

    final appointmentTitle = Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        'Appointment',
        style: TextStyle(
            fontFamily: 'Segoe',
            color: kTextLightColor,
            letterSpacing: 0.5,
            fontSize: 18,
            fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );

    final verticalDivider = Container(
      child: Divider(
        color: Colors.black,
        height: 0.0,
        thickness: 0.5,
        indent: 0.0,
        endIndent: 0.0,
      ),
    );

    // Appointment Tab

    final topCard = Card(
      margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 15,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Column(
          children: [
            Container(
              height: 65,
              color: kCardTitleColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 12.0, top: 10.0),
                    child: Text(
                      'Appointment Request',
                      style: TextStyle(fontSize: 16, color: kBodyTextColor),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Icon(Icons.access_time,
                            size: 20, color: kBodyTextColor),
                        SizedBox(
                          width: 2.0,
                        ),
                        Obx(
                          () => Text(
                            appointmentController.appoinments.length > 0
                                ? appointmentController.appoinments[0]
                                    ['createdOn']
                                : '',
                            style:
                                TextStyle(fontSize: 16, color: kBodyTextColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 60,
                color: Colors.white,
                child: Row(
                  children: [
                    Obx(() {
                      var appoinment = appointmentController.appoinments[0];
                      return Container(
                        padding: EdgeInsets.only(left: 20, right: 10),
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 1, color: Colors.blue),
                          image: DecorationImage(
                            image: appoinment['profilePic'] == null ||
                                    appoinment['profilePic'] == 'null' ||
                                    appoinment['profilePic'] == ''
                                ? AssetImage(patientNoImagePath)
                                : NetworkImage(appoinment['profilePic'])
                                    as ImageProvider<Object>,
                          ),
                          // image: DecorationImage(
                          //   image: AssetImage(patientNoImagePath),
                          // ),
                        ),
                      );
                    }),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      child: Obx(
                        () => Text(
                          appointmentController.appoinments.length > 0
                              ? appointmentController.appoinments[0]
                                      ['patientName'] ??
                                  ''
                              : '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          color: kTitleColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10)),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Obx(
                                      () => Text(
                                        // "Problem: ${appoinments.length > 0 ? appoinments[0]['problem'].trim() : ''}",
                                        "Problem: ${appointmentController.appoinments.length > 0 ? appointmentController.appoinments[0]['problem'].trim() ?? "" : ''}",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'Segoe',
                                          letterSpacing: 0.5,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 80,
                    width: 2,
                    color: Colors.grey[200],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 110,
                    child: Obx(() {
                      var appoinment = appointmentController.appoinments[0];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bkash No.',
                            style: TextStyle(color: kTextLightColor),
                          ),
                          Text('${appoinment['paymentPhone']}'),
                          SizedBox(height: 10),
                          Text(
                            'Transaction ID',
                            style: TextStyle(color: kTextLightColor),
                          ),
                          Text('${appoinment['trxID']}'),
                          SizedBox(height: 10),
                          Text(
                            'Paid to No.',
                            style: TextStyle(color: kTextLightColor),
                          ),
                          Text('${appoinment['paidToPhone']}'),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              height: 60,
              child: Row(
                children: [
                  Container(
                    width: 178,
                    padding: EdgeInsets.only(left: 25.0, right: 25.0),
                    child: MaterialButton(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      onPressed: () async {
                        appointmentController.isLoading.value = true;

                        Map<String, dynamic> currentAppointment =
                            appointmentController.appoinments[0];

                        Get.to(
                          () => CreatePrescription(
                            appointment: currentAppointment,
                            appointmentController: appointmentController,
                          ),
                        );
                      },
                      padding: EdgeInsets.only(top: 2.0, bottom: 3.0),
                      color: kButtonColor,
                      child: Text(
                        'Accept',
                        style: TextStyle(
                          fontFamily: "Segoe",
                          letterSpacing: 0.5,
                          fontSize: 16,
                          color: kWhiteShadow,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 178,
                    padding: EdgeInsets.only(left: 25.0, right: 20.0),
                    child: MaterialButton(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: BorderSide(
                            color: kBaseColor,
                            width: 0.8,
                            style: BorderStyle.solid),
                      ),
                      onPressed: () async {
                        var response =
                            await apiServices.updateDoctorAppointmentStatus(
                                'declined',
                                appointmentController.appoinments[0]
                                    ['appoitmentID']);
                        if (response) {
                          appointmentController.appoinments.clear();
                          appointmentController.queueAppointments.clear();
                          appointmentController.fetchDoctorAppoinments();
                        }
                      },
                      padding: EdgeInsets.only(top: 2.0, bottom: 3.0),
                      color: kWhiteShadow,
                      child: Text('Decline',
                          style: TextStyle(
                              fontFamily: "Segoe",
                              letterSpacing: 0.5,
                              fontSize: 16,
                              color: kBaseColor)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // final topCard = Card(
    //   margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    //   elevation: 15,
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.circular(20.0),
    //     child: Column(
    //       children: [
    //         Container(
    //           height: 65,
    //           color: kCardTitleColor,
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Container(
    //                 padding: EdgeInsets.only(left: 12.0, top: 10.0),
    //                 child: Text(
    //                   'Appointment Request',
    //                   style: TextStyle(fontSize: 16, color: kBodyTextColor),
    //                 ),
    //                 alignment: Alignment.centerLeft,
    //               ),
    //               Container(
    //                 padding: EdgeInsets.only(left: 10.0),
    //                 child: Row(
    //                   children: [
    //                     Icon(Icons.access_time,
    //                         size: 20, color: kBodyTextColor),
    //                     SizedBox(
    //                       width: 2.0,
    //                     ),
    //                     Obx(
    //                       () => Text(
    //                         appointmentController.appoinments.length > 0
    //                             ? appointmentController.appoinments[0]
    //                                 ['createdOn']
    //                             : '',
    //                         style:
    //                             TextStyle(fontSize: 16, color: kBodyTextColor),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Container(
    //             height: 60,
    //             color: Colors.white,
    //             child: Row(
    //               children: [
    //                 Container(
    //                   padding: EdgeInsets.only(left: 20, right: 10),
    //                   height: 35,
    //                   width: 35,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(50),
    //                     border: Border.all(width: 1, color: Colors.blue),
    //                     // image: DecorationImage(
    //                     //   image: (appoinments.length > 0
    //                     //       ? (appoinments[0]['profilePic'] == null ||
    //                     //               appoinments[0]['profilePic'] == 'null' ||
    //                     //               appoinments[0]['profilePic'] == ''
    //                     //           ? AssetImage(patientNoImagePath)
    //                     //           : NetworkImage(appoinments[0]['profilePic']))
    //                     //       : AssetImage(
    //                     //           patientNoImagePath)) as ImageProvider<Object>,
    //                     // ),
    //                     image: DecorationImage(
    //                       image: AssetImage(patientNoImagePath),
    //                     ),
    //                   ),
    //                 ),
    //                 // Container(
    //                 //   padding: EdgeInsets.only(left: 20, right: 10),
    //                 //   child: CircleAvatar(
    //                 //     radius: 18,
    //                 //     backgroundColor: kBaseColor,
    //                 //     child: CircleAvatar(
    //                 //       backgroundColor: Colors.white,
    //                 //       radius: 17.0,
    //                 //       child: appoinments.length > 0
    //                 //           ? (appoinments[0]['profilePic'] == null ||
    //                 //                   appoinments[0]['profilePic'] == 'null' ||
    //                 //                   appoinments[0]['profilePic'] == ''
    //                 //               ? Image.asset(noImagePath)
    //                 //               : Image.network(appoinments[0]['profilePic']))
    //                 //           : Image.asset(noImagePath),
    //                 //     ),
    //                 //   ),
    //                 // ),
    //                 SizedBox(
    //                   width: 8,
    //                 ),
    //                 Container(
    //                   child: Obx(
    //                     () => Text(
    //                       appointmentController.appoinments.length > 0
    //                           ? appointmentController.appoinments[0]
    //                               ['patientName']
    //                           : '',
    //                       style: TextStyle(fontSize: 16),
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(left: 10, right: 60),
    //           child: Container(
    //             height: 90,
    //             width: MediaQuery.of(context).size.width / 1.3,
    //             decoration: BoxDecoration(
    //                 color: kTitleColor,
    //                 shape: BoxShape.rectangle,
    //                 borderRadius: BorderRadius.circular(10)),
    //             child: SingleChildScrollView(
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: Row(
    //                       children: [
    //                         SizedBox(
    //                           width: 10,
    //                         ),
    //                         Expanded(
    //                           child: Obx(
    //                             () => Text(
    //                               // "Problem: ${appoinments.length > 0 ? appoinments[0]['problem'].trim() : ''}",
    //                               "Problem: ${appointmentController.appoinments.length > 0 ? appointmentController.appoinments[0]['problem'].trim() : ''}",
    //                               textAlign: TextAlign.start,
    //                               style: TextStyle(
    //                                 fontFamily: 'Segoe',
    //                                 letterSpacing: 0.5,
    //                                 fontSize: 16,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 5.0,
    //         ),
    //         Container(
    //           height: 60,
    //           child: Row(
    //             children: [
    //               Container(
    //                 width: 178,
    //                 padding: EdgeInsets.only(left: 25.0, right: 25.0),
    //                 child: MaterialButton(
    //                   elevation: 5,
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(24),
    //                   ),
    //                   onPressed: () async {
    //                     appointmentController.isLoading.value = true;

    //                     Map<String, dynamic> currentAppointment =
    //                         appointmentController.appoinments[0];

    //                     Get.to(
    //                       () => CreatePrescription(
    //                         appointment: currentAppointment,
    //                         appointmentController: appointmentController,
    //                       ),
    //                     );
    //                   },
    //                   padding: EdgeInsets.only(top: 2.0, bottom: 3.0),
    //                   color: kButtonColor,
    //                   child: Text(
    //                     'Accept',
    //                     style: TextStyle(
    //                       fontFamily: "Segoe",
    //                       letterSpacing: 0.5,
    //                       fontSize: 16,
    //                       color: kWhiteShadow,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 width: 178,
    //                 padding: EdgeInsets.only(left: 25.0, right: 20.0),
    //                 child: MaterialButton(
    //                   elevation: 5,
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(24),
    //                     side: BorderSide(
    //                         color: kBaseColor,
    //                         width: 0.8,
    //                         style: BorderStyle.solid),
    //                   ),
    //                   onPressed: () async {
    //                     var response =
    //                         await apiServices.updateDoctorAppointmentStatus(
    //                             'declined',
    //                             appointmentController.appoinments[0]
    //                                 ['appoitmentID']);
    //                     if (response) {
    //                       appointmentController.appoinments.clear();
    //                       appointmentController.queueAppointments.clear();
    //                       appointmentController.fetchDoctorAppoinments();
    //                     }
    //                   },
    //                   padding: EdgeInsets.only(top: 2.0, bottom: 3.0),
    //                   color: kWhiteShadow,
    //                   child: Text('Decline',
    //                       style: TextStyle(
    //                           fontFamily: "Segoe",
    //                           letterSpacing: 0.5,
    //                           fontSize: 16,
    //                           color: kBaseColor)),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    final nextAppointmentTitle = Container(
      padding: EdgeInsets.only(left: 20.0, top: 5.0, right: 20.0, bottom: 10.0),
      alignment: Alignment.centerLeft,
      child: Text(
        'Next Appointments',
        style: TextStyle(fontSize: 20, color: kTextLightColor),
      ),
    );

    // Message Tab

    final searchMessage = Container(
      height: 60,
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(left: 30, top: 25, right: 30, bottom: 0),
        child: TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          controller: searchController,
          onChanged: (val) => runFilter(val),
          style:
              TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
          autocorrect: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Search',
            hintStyle: TextStyle(
                fontFamily: 'Segoe', fontSize: 20, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            prefixIcon: Container(
              child: Icon(
                Icons.search_rounded,
                size: 26,
              ),
            ),
          ),
        ),
      ),
    );
    final messageHome = Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: isSearching ? foundChatList.length : chatList.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16, bottom: 20),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                ChatList? chat =
                    isSearching ? foundChatList[index] : chatList[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ChatScrenpage(
                        chatList: chat,
                      );
                    }));
                  },
                  child: Container(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 10, bottom: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.blue,
                                      image: DecorationImage(
                                        image: (chat.profilePic == '' ||
                                                    chat.profilePic == 'null'
                                                ? AssetImage(patientNoImagePath)
                                                : NetworkImage(
                                                    dynamicImageGetApi +
                                                        chat.profilePic!))
                                            as ImageProvider<Object>,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  chat.patientName ?? '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  chat.lastMessage ?? '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Colors.grey.shade500),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                chat.timeAgo ?? '',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        Colors.grey.shade500),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  chat.unseenMsgCount == 0
                                      ? SizedBox.shrink()
                                      : Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              color: Colors.lightBlue[900],
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Center(
                                            child: Text(
                                              '${chat.unseenMsgCount ?? 0}',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );

    return Material(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: CustomDrawerDoctor(),
          appBar: AppBar(
            elevation: 2.0,
            backgroundColor: kBaseColor,
            iconTheme: IconThemeData(color: kTitleColor),
            shadowColor: Colors.teal,
            centerTitle: true,
            toolbarHeight: 50,
            title: Text('Emergency Online Consultancy',
                style: TextStyle(
                    fontFamily: 'Segoe', fontSize: 18, color: kTitleColor)),
          ),
          backgroundColor: kBackgroundColor,
          body: Center(
            child: Obx(
              () => Column(
                children: [
                  appointmentLogo,
                  appointmentTitle,
                  verticalDivider,
                  SizedBox(
                    height: 10,
                  ),
                  Theme(
                    data: ThemeData(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    child: Container(
                      height: 35,
                      child: TabBar(
                        unselectedLabelColor: kBaseColor,
                        labelColor: kTitleColor,
                        indicatorColor: kBaseColor,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [kBaseColor, kBaseColor]),
                            borderRadius: BorderRadius.circular(50),
                            color: kBaseColor),
                        tabs: [
                          Tab(
                            child: Container(
                              width: 205,
                              height: 34,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                      color: kBaseColor, width: 1.0)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Appointment",
                                  style: TextStyle(
                                    fontFamily: 'Segoe',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              width: 205,
                              height: 34,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                      color: kBaseColor, width: 1.0)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Message",
                                  style: TextStyle(
                                    fontFamily: 'Segoe',
                                    fontSize: 16,
                                  ),
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
                          // child: appoinments.length > 0
                          child: appointmentController.appoinments.length > 0
                              ? Column(
                                  children: [
                                    topCard,
                                    nextAppointmentTitle,
                                    Expanded(
                                      child:
                                          appointmentController
                                                      .queueAppointments
                                                      .length >
                                                  0
                                              ? ListView.builder(
                                                  itemCount:
                                                      appointmentController
                                                          .queueAppointments
                                                          .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    var appointment =
                                                        appointmentController
                                                                .queueAppointments[
                                                            index];
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20,
                                                          vertical: 5),
                                                      child: Container(
                                                        height: 60,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            shape: BoxShape
                                                                .rectangle,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Container(
                                                                  height: 35,
                                                                  width: 35,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .blue),
                                                                    // image:
                                                                    //     DecorationImage(
                                                                    //   image: (appointment['profilePic'] == null ||
                                                                    //           appointment['profilePic'] ==
                                                                    //               'null' ||
                                                                    //           appointment['profilePic'] ==
                                                                    //               ''
                                                                    //       ? AssetImage(
                                                                    //           patientNoImagePath)
                                                                    //       : NetworkImage(
                                                                    //           appointment
                                                                    //               [
                                                                    //               'profilePic'])) as ImageProvider<
                                                                    //       Object>,
                                                                    // ),
                                                                    image:
                                                                        DecorationImage(
                                                                      image: AssetImage(
                                                                          patientNoImagePath),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 10.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          appointment['patientName'] ??
                                                                              '',
                                                                          style:
                                                                              TextStyle(fontSize: 16),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          appointment[
                                                                              'createdOn'],
                                                                          style:
                                                                              TextStyle(fontSize: 14),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Center(
                                                  child: Text(
                                                  'No next appointment found',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: kTextLightColor,
                                                  ),
                                                )),
                                    ),
                                  ],
                                )
                              : Center(
                                  child: Text(
                                    'No appointments found right now',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: kTextLightColor,
                                    ),
                                  ),
                                ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              searchMessage,
                              messageHome,
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
