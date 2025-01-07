// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pro_health/base/helper_functions.dart';
// import 'package:pro_health/base/utils/constants.dart';
// import 'package:http/http.dart' as http;
// import 'package:pro_health/patient/controllers/consult_history_controller.dart';
// import 'package:pro_health/patient/models/consult_history_patient.dart';
// import 'package:pro_health/patient/service/dashboard/api_patient.dart';

// class ConsultationHistoryPatient extends StatefulWidget {
//   static String tag = 'ConsultationHistoryPatient';
//   @override
//   ConsultationHistoryPatientState createState() =>
//       new ConsultationHistoryPatientState();
// }

// class ConsultationHistoryPatientState
//     extends State<ConsultationHistoryPatient> {
//   ConsultHistoryController consultHistoryController =
//       Get.put(ConsultHistoryController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 5.0,
//         backgroundColor: kBaseColor,
//         centerTitle: true,
//         toolbarHeight: 50,
//         leading: IconButton(
//           color: kTitleColor,
//           onPressed: () => Navigator.of(context).pop(),
//           icon: Icon(Icons.arrow_back),
//         ),
//         title: Text(
//           'Consultation History',
//           style: TextStyle(
//               fontFamily: 'Segoe',
//               fontSize: 18,
//               color: kTitleColor,
//               letterSpacing: 0.5),
//         ),
//       ),
//       backgroundColor: kBackgroundColor,
//       body: Center(
//         child: Column(
//           children: <Widget>[
//             SizedBox(height: 5),
//             Center(
//               child: Hero(
//                 tag: 'hero',
//                 child: CircleAvatar(
//                   backgroundColor: Colors.transparent,
//                   radius: 35.0,
//                   child: Image.asset(
//                       'assets/icons/patient/consulthistorypage.png'),
//                 ),
//               ),
//             ),
//             Container(
//               width: 250.00,
//               height: 30,
//               child: Text(
//                 'Consultation History',
//                 style: TextStyle(
//                     fontFamily: 'Segoe',
//                     color: kTextLightColor,
//                     letterSpacing: 0.5,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             const Divider(
//               color: kTitleTextColor,
//               height: 0.0,
//               thickness: 0.5,
//               indent: 0.0,
//               endIndent: 0.0,
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.only(top: 15, bottom: 10),
//                 child: ListBody(
//                   children: [
//                     _buildName(
//                         name: "Prof. Mohd. Hanif",
//                         id: "22-03-2021 ",
//                         view: "View Details"),
//                     _buildName(
//                         name: "Doctor Name:",
//                         id: "Date : ",
//                         view: "View Details"),
//                     _buildName(
//                         name: "Doctor Name:",
//                         id: "Date : ",
//                         view: "View Details"),
//                     _buildName(
//                         name: "Doctor Name:",
//                         id: "Date : ",
//                         view: "View Details"),
//                     _buildName(
//                         name: "Doctor Name:",
//                         id: "Date : ",
//                         view: "View Details"),
//                     _buildName(
//                         name: "Doctor Name:",
//                         id: "Date : ",
//                         view: "View Details"),
//                     _buildName(
//                         name: "Doctor Name:",
//                         id: "Date : ",
//                         view: "View Details"),
//                     _buildName(
//                         name: "Doctor Name:",
//                         id: "Date : ",
//                         view: "View Details"),
//                     _buildName(
//                         name: "Doctor Name:",
//                         id: "Date : ",
//                         view: "View Details"),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildName({required String name, required String id, String? view}) {
//     return Container(
//       height: 68.0,
//       padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
//       child: Card(
//         elevation: 5.0,
//         shape: RoundedRectangleBorder(
//             //side: BorderSide(color: Colors.white70, width: 1),
//             side: BorderSide(
//               color: Colors.grey.withOpacity(0.2),
//               width: 1,
//             ),
//             borderRadius: BorderRadius.circular(35.0)),
//         color: Color(0xffd6d7d9),
//         child: Column(
//           children: <Widget>[
//             Container(
//               padding: EdgeInsets.only(
//                   top: 7.0, left: 15.0, bottom: 0.0, right: 15.0),
//               child: Row(
//                 children: <Widget>[
//                   Text(name),
//                   Spacer(),
//                   Text(id),
//                   SizedBox(width: 20),
//                   Container(
//                     height: 35,
//                     padding: EdgeInsets.only(top: 4.0, bottom: 3.0),
//                     child: RawMaterialButton(
//                       elevation: 2,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0)),
//                       fillColor: kWhiteShadow,
//                       child: Text(
//                         "$view",
//                         style: TextStyle(color: kTitleTextColor, fontSize: 12),
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: unused_element

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/views/dashboard/consultation_history/view_pdf.dart';
import 'package:pro_health/patient/controllers/consult_history_controller.dart';

class ConsultationHistoryPatient extends StatefulWidget {
  static String tag = 'ConsultationHistoryPatient';
  @override
  ConsultationHistoryPatientState createState() =>
      new ConsultationHistoryPatientState();
}

class ConsultationHistoryPatientState
    extends State<ConsultationHistoryPatient> {
  ConsultHistoryController consultHistoryController =
      Get.put(ConsultHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: kBaseColor,
        centerTitle: true,
        toolbarHeight: 50,
        leading: IconButton(
          color: kTitleColor,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Consultation History',
          style: TextStyle(
              fontFamily: 'Segoe',
              fontSize: 18,
              color: kTitleColor,
              letterSpacing: 0.5),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 5),
            Center(
              child: Hero(
                tag: 'hero',
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 35.0,
                  child:
                      Image.asset('assets/icons/doctor/consulthistorypage.png'),
                ),
              ),
            ),
            Container(
              width: 250.00,
              height: 30,
              child: Text(
                'Consultation History',
                style: TextStyle(
                    fontFamily: 'Segoe',
                    color: kTextLightColor,
                    letterSpacing: 0.5,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            const Divider(
              color: kTitleTextColor,
              height: 0.0,
              thickness: 0.5,
              indent: 0.0,
              endIndent: 0.0,
            ),
            Obx(
              () => Expanded(
                child: Get.find<ConsultHistoryController>()
                        .consultHistory
                        .isNotEmpty
                    ? ListView.builder(
                        itemCount: Get.find<ConsultHistoryController>()
                            .consultHistory
                            .length,
                        // reverse: true,
                        itemBuilder: (BuildContext context, int index) {
                          var history = Get.find<ConsultHistoryController>()
                              .consultHistory[index];
                          return Container(
                            height: 68.0,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            child: Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  //side: BorderSide(color: Colors.white70, width: 1),
                                  side: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(35.0)),
                              color: Color(0xffd6d7d9),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 7.0,
                                        left: 15.0,
                                        bottom: 0.0,
                                        right: 15.0),
                                    child: Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              history.doctorName ?? '',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Bkash sender: ${history.bkashSenderNo ?? ''}',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),

                                        Spacer(),
                                        // Text('PSR-${consultations[index].appointmentID}'),
                                        Text('id'),
                                        SizedBox(width: 40),
                                        Container(
                                          height: 35,
                                          padding: EdgeInsets.only(
                                              top: 4.0, bottom: 3.0),
                                          child: RawMaterialButton(
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            fillColor: kWhiteShadow,
                                            child: Text(
                                              "View Details",
                                              style: TextStyle(
                                                  color: kTitleTextColor,
                                                  fontSize: 12),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewPdfOnline(
                                                    path: history.prescription,
                                                    doctorId: history.doctorID,
                                                    memberId: history.memberID,
                                                    bmdcNo: history.bmdcNmuber,
                                                  ),
                                                ),
                                              );
                                              // print(consultations[index].prescriptionID);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'No Consultation History found',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
