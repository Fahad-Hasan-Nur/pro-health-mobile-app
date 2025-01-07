// // ignore_for_file: unused_local_variable

// import 'dart:io';

// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:expansion_tile_card/expansion_tile_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:pro_health/base/helper_functions.dart';
// import 'package:pro_health/base/utils/constants.dart';
// import 'package:pro_health/call/call_utilities.dart';
// import 'package:pro_health/call/controllers/call_controller.dart';
// import 'package:pro_health/call/controllers/doctor_call_controller.dart';
// import 'package:pro_health/call/permissions.dart';
// import 'package:pro_health/call/views/call_screen_doctor.dart';
// import 'package:pro_health/doctor/controllers/appointment_controller.dart';
// import 'package:pro_health/doctor/controllers/prescription_controller2.dart';
// import 'package:pro_health/doctor/models/district_model.dart';
// import 'package:pro_health/doctor/models/medication_model.dart';
// import 'package:pro_health/doctor/models/police_station_model.dart';
// import 'package:pro_health/doctor/models/post_office_model.dart';
// import 'package:pro_health/doctor/models/profile/doctor_profile_model.dart';
// import 'package:pro_health/doctor/services/api_service/api_services.dart';
// import 'package:pro_health/doctor/views/bottombar/prescription/PdfViewPage.dart';
// import 'package:pro_health/doctor/views/bottombar/prescription/classes/pdfApi.dart';
// import 'package:pro_health/doctor/views/bottombar/prescription/data.dart';
// import 'package:pro_health/doctor/views/bottombar/prescription/models/next_visit.dart';
// import 'package:pro_health/doctor/views/bottombar/prescription/prescriptionPage.dart';
// import 'package:pro_health/doctor/views/bottombar/prescription/service/prescription_service.dart';
// import 'package:pro_health/patient/models/consult_history_patient.dart';
// import 'package:pro_health/patient/models/patient_profile_model.dart';
// import 'package:pro_health/patient/service/dashboard/api_patient.dart';
// import 'package:pro_health/patient/service/dashboard/profile_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CreatePrescription extends StatefulWidget {
//   const CreatePrescription({
//     Key? key,
//     required this.appointment,
//     required this.appointmentController,
//   }) : super(key: key);
//   final Map<String, dynamic> appointment;
//   final AppointmentController appointmentController;
//   @override
//   _CreatePrescriptionState createState() =>
//       _CreatePrescriptionState(appointment: this.appointment);
// }

// class _CreatePrescriptionState extends State<CreatePrescription> {
//   _CreatePrescriptionState({required this.appointment});
//   ApiServices apiServices = ApiServices();
//   PatientProfileService patientProfileService = PatientProfileService();
//   PatientApiService patientApiService = PatientApiService();
//   final Map<String, dynamic> appointment;
//   late PatientProfileModel patient;
//   late DoctorProfileModel doctor;

//   PrescriptionController prescriptionController =
//       Get.put(PrescriptionController(), permanent: true);

//   CallController callController = Get.put(CallController(), permanent: true);

//   DoctorCallController doctorCallController = DoctorCallController();

//   final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
//   final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
//   final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();
//   final GlobalKey<ExpansionTileCardState> cardD = new GlobalKey();
//   final GlobalKey<ExpansionTileCardState> cardE = new GlobalKey();
//   final GlobalKey<ExpansionTileCardState> cardF = new GlobalKey();
//   final GlobalKey<ExpansionTileCardState> cardG = new GlobalKey();

//   final _formKey = GlobalKey<FormState>();

//   PrescriptionService prescriptionService = PrescriptionService();

//   late Directory documentDirectory;
//   late String documentPath;

//   bool before = false;
//   bool after = false;
//   bool markedAsAccepted = false;

//   // patient information
//   late String patientName = '';
//   late String phoneNumber = '';
//   late String gender = '';
//   var age = '';
//   var dateOfBirth = DateTime.now().toIso8601String();
//   String selectedtGender = "Male";

//   TextEditingController _ccController = TextEditingController();
//   TextEditingController _diagnosisAdivceController = TextEditingController();
//   TextEditingController _generalAdivceController = TextEditingController();
//   TextEditingController _brandNameController = TextEditingController();
//   TextEditingController _typeDoseController = TextEditingController();
//   TextEditingController _durationController = TextEditingController();
//   TextEditingController _ftController = TextEditingController();
//   TextEditingController _inchController = TextEditingController();
//   TextEditingController _bmiController = TextEditingController();
//   TextEditingController _eddController = TextEditingController();
//   TextEditingController _diseaseConditionController = TextEditingController();
//   TextEditingController _spo2Controller = TextEditingController();
//   TextEditingController _drugHistoryController = TextEditingController();
//   TextEditingController _patientNameController = TextEditingController();
//   TextEditingController _patientPhoneController = TextEditingController();
//   TextEditingController _ageController = TextEditingController();
//   TextEditingController _visitNoController = TextEditingController();
//   // TextEditingController _brandNameController = TextEditingController();

//   MedicationModel medicine = MedicationModel();

//   bool beforeEating = false;
//   bool afterEating = true;

//   var bp;
//   var height;
//   var weight = 0.0;
//   var bmi;
//   var lmp;
//   var edd;
//   var pDose;
//   var pulse;
//   var spo2;
//   var rr;
//   var feet = 0;
//   var inch = 0;
//   var heightInM = 0.0;

//   var drugAlergy;
//   var foodAlergy;

//   bool drugHistory = false;

//   // disease condition.
//   var disease = '';

//   List<String> ccEntry = [];
//   List<String> diseaseConditionEntry = [];
//   List<String> spo2Entry = [];
//   List<String> diagnosisAdviceEntry = [];
//   List<String> drugHistoryEntry = [];

//   List<String> generalAdviceEntry = [];
//   List<String> medicineEntry = [];
//   List<String> spo2List = [];

//   List medicationList = [];

//   final brand = <Brand>[
//     Brand('Fenuc Plus', ''),
//     Brand('Mycin', ''),
//     Brand('5-Fluril', ''),
//     Brand('A-Clox', ''),
//     Brand('Geocef', '')
//   ];
//   Brand? selectedBrand;

//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final formKey = GlobalKey<FormState>();

//   final format = DateFormat("dd-MM-yyyy");

//   String? generatedPdfFilePath;
//   String? fullPath;

//   File? generatedPdfFile;

//   List<DistrictModel> districts = [];
//   List<PoliceStationModel> policestations = [];
//   List<PostOfficeModel> postOffices = [];
//   // List<DoctorModel> referredByDoctors = [];
//   List<NextVisitModel> nextVisits = [];

//   List<String> medicineString = [];
//   static List doctorAppointments = [];

//   var selectedDrugAlergy = 'Unknown';
//   var selectedFoodAlergy = 'Unknown';
//   var selectedDrugHistory = 'Unknown';
//   var selectedFamilyHistory = 'Yes';
//   var selectedMedicalHistory = 'Yes';

//   var selectedDistrict = '';
//   var selectedPoliceStation = '';
//   var selectedPostOffice = '';
//   var selectedDistrictId;
//   var selectedPoliceStationId;
//   var selectedPostOfficeId;
//   late String patientEmail;
//   var currentDate;

//   var selectedNextVisit = 'Select';

//   var referredByName = '';

//   var nextVisitText = '';
//   var paidTakaText = '';
//   var visitNoText = '';

//   var selectedSpo2;

//   String brandName = '';
//   String medicineCategory = '';
//   String medicineGroup = '';
//   String companyName = '';
//   String price = '';
//   bool fdaApproved = false;

//   var patientId = 0;

//   getDate(String dateTime) {
//     // var dateTime = '2021-08-08T13:05:00';
//     var date = DateTime.parse(dateTime);
//     var year = date.year;
//     var month = date.month;
//     var day = date.day;
//     var newMonth = month < 10 ? '0$month' : '$month';
//     var newDay = day < 10 ? '0$day' : '$day';
//     var newDate = '$year-$newMonth-$newDay'; //'$newDay-$newMonth-$year';
//     return newDate;
//   }

//   generateOEMap() {
//     Map<String, dynamic> oeMap = {};
//     oeMap['bp'] = bp;
//     oeMap['height'] = heightInM.toStringAsFixed(2);
//     oeMap['weight'] = weight.toString();
//     oeMap['bmi'] = bmi.toString();
//     oeMap['lmp'] = lmp == null ? null : lmp.toIso8601String();
//     oeMap['edd'] = edd;
//     oeMap['pDose'] = pDose;
//     oeMap['pulse'] = pulse;
//     oeMap['spo2'] = selectedSpo2;
//     oeMap['rr'] = rr;
//     return oeMap;
//   }

//   fetchNextVisits() async {
//     var response = await apiServices.fetchNextVisits();
//     setState(() {
//       nextVisits.add(NextVisitModel.fromJson({
//         "id": 0,
//         "memberID": 0,
//         "details": "Select",
//       }));

//       nextVisits.addAll(response);
//     });
//   }

//   generatePrescriptionInfoMap() {
//     Map<String, dynamic> prescriptionInfoMap = {};

//     prescriptionInfoMap['memberId'] = memberId;
//     prescriptionInfoMap['doctorID'] = doctorId;
//     prescriptionInfoMap['bmdcNo'] = bmdcNmuber;
//     prescriptionInfoMap['patientID'] = appointment['patiantID']; // patientId;
//     prescriptionInfoMap['drugAllergy'] = selectedDrugAlergy;
//     prescriptionInfoMap['foodAllergy'] = selectedFoodAlergy;
//     prescriptionInfoMap['createOn'] = DateTime.now();
//     prescriptionInfoMap['patientName'] = _patientNameController.text;
//     prescriptionInfoMap['age'] = age;
//     prescriptionInfoMap['dist'] = selectedDistrict;
//     prescriptionInfoMap['postOffice'] = selectedPostOffice;
//     prescriptionInfoMap['currentDate'] = DateTime.parse(currentDate);
//     prescriptionInfoMap['mobileNo'] = phoneNumber;
//     prescriptionInfoMap['gender'] = selectedtGender;
//     prescriptionInfoMap['referenceBy'] = referredByName;
//     prescriptionInfoMap['thana'] = selectedPoliceStation;

//     prescriptionInfoMap['nextVisit'] = selectedNextVisit;
//     prescriptionInfoMap['paidTaka'] = paidTakaText;
//     prescriptionInfoMap['visitNo'] = visitNoText;

//     return prescriptionInfoMap;
//   }

//   calcultateEDD(DateTime lmpDate) {
//     var month = lmpDate.month;
//     var day = lmpDate.day;
//     var year = lmpDate.year;

//     if (month > 0 && month < 4) {
//       // jan to mar
//       var newMonth = month + 12;
//       newMonth = newMonth - 3;
//       var newDay = day + 7;
//       if (newDay > 30) {
//         newMonth = newMonth + 1;
//         newDay = newDay - 30;
//       }
//       var newDay2 = newDay < 10 ? '0$newDay' : '$newDay';
//       var newMonth2 = newMonth < 10 ? '0$newMonth' : '$newMonth';
//       setState(() {
//         edd = '$newDay2-$newMonth2-$year';
//         _eddController.text = '$newDay2-$newMonth2-$year';
//       });
//     } else if (month >= 4 && month <= 12) {
//       // april to december
//       var newMonth = month - 3;
//       var newDay = day + 7;

//       var newYear = year + 1;

//       if (newDay > 30) {
//         newMonth = newMonth + 1;
//         newDay = newDay - 30;
//       }
//       var newDay2 = newDay < 10 ? '0$newDay' : '$newDay';
//       var newMonth2 = newMonth < 10 ? '0$newMonth' : '$newMonth';
//       setState(() {
//         edd = '$newDay2-$newMonth2-$newYear';
//         _eddController.text = '$newDay2-$newMonth2-$newYear';
//       });
//     }
//   }

//   fetchDoctorAppointments() async {
//     var response = await apiServices.fetchAccedptedAppoinments(memberId);

//     setState(() {
//       doctorAppointments.addAll(response);
//     });
//   }

//   // static Future<List<String>> getNamesSuggestion(String query) async {
//   //   List<String> names = [];
//   //   for (var patient in doctorAppointments) {
//   //     if (patient['patientName'] != null || patient['patientName'].isNotEmpty) {
//   //       names.add(patient['patientName']);
//   //     }
//   //   }

//   //   return List.of(names).where((name) {
//   //     final nameLower = name.toLowerCase();
//   //     final queryLower = query.toLowerCase();
//   //     return nameLower.contains(queryLower);
//   //   }).toList();
//   // }

//   fetchDistricts() async {
//     if (districts.length > 0) {
//       districts.clear();
//     }
//     var response = await apiServices.fetchDistricts();
//     setState(() {
//       districts.addAll(response);
//       selectedDistrict = districts[0].districtName;
//     });
//   }

//   saveMedicine() {
//     var brandName = _brandNameController.text;
//     var dose = _typeDoseController.text;
//     var duration = _durationController.text;
//     var eatingTime = beforeEating ? 'Before Meal' : 'After Meal';

//     if (brandName.isNotEmpty &&
//         dose.isNotEmpty &&
//         duration.isNotEmpty &&
//         eatingTime.isNotEmpty) {
//       Map medicineMap = Map();
//       medicineMap['BrandName'] = brandName;
//       medicineMap['Dose'] = dose;
//       medicineMap['Duration'] = duration;
//       medicineMap['EatingTime'] = eatingTime;
//       medicineMap['MedicineCategory'] = medicine.medicineCategory ?? '';
//       medicineMap['MedicineGroup'] = medicine.medicineGroup ?? '';
//       medicineMap['CompanyName'] = medicine.companyName ?? '';
//       medicineMap['Price'] = medicine.price ?? '0.0';
//       medicineMap['FDAApproved'] = medicine.fdaApproved;
//       medicineMap['CompanyID'] = medicine.companyId ?? 0;
//       medicineMap['BrandId'] = medicine.brandId ?? 0;
//       medicineMap['GenericID'] = medicine.genericId ?? 0;
//       medicineMap['BeforeMeal'] = beforeEating;
//       medicineMap['AfterMeal'] = afterEating;

//       setState(() {
//         medicationList.add(medicineMap);
//         medicineString.add("$brandName \n$dose ($eatingTime) $duration ");
//       });

//       _brandNameController.clear();
//       _typeDoseController.clear();
//       _durationController.clear();
//       setState(() {
//         brandName = '';
//         medicineCategory = '';
//         companyName = '';
//         price = '';
//         fdaApproved = false;
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Please provide brand name, dose type, duration and Medicine taking time',
//           ),
//         ),
//       );
//     }
//   }

//   fetchPoliceStations(var districtId) async {
//     if (policestations.isNotEmpty) {
//       policestations.clear();
//     }
//     var response = await apiServices.fetchPoliceStations(districtId);
//     setState(() {
//       policestations.addAll(response);
//     });
//     if (policestations.isNotEmpty) {
//       selectedPoliceStation = policestations[0].policeStationName;
//     }
//   }

//   fetchPostOffices(var policeStationId) async {
//     if (postOffices.isNotEmpty) {
//       postOffices.clear();
//     }
//     var response = await apiServices.fetchPostOffices(policeStationId);

//     setState(() {
//       postOffices.addAll(response);
//     });
//     if (postOffices.isNotEmpty) {
//       selectedPostOffice = postOffices[0].postOfficeName;
//     }
//   }

//   // doctor profile information

//   var memberId;
//   var doctorId;
//   var bmdcNmuber;
//   var doctorProfile = [];
//   var doctorNameBangla = '';
//   var doctorNameEnglish = '';
//   var doctorDegree1English = '';
//   var doctorDegree2English = '';
//   var doctorDesignation1English = '';
//   var doctorDesignation2English = '';
//   var doctorWorkplace1English = '';
//   var doctorDegree1Bangla = '';
//   var doctorDegree2Bangla = '';
//   var doctorDesignation1Bangla = '';
//   var doctorDesignation2Bangla = '';
//   var doctorWorkplace1Bangla = '';

//   var chamber1Bangla = '';
//   var chamber1ConsultDayBangla = '';
//   var chamber1ConsultTimeBangla = '';
//   var chamberOneAddress;
//   var chamberTwoAddress;
//   var chamberOneConsultDay;
//   var chamberTwoConsultDay;
//   var chamberOneAddressBangla;
//   var chamberTwoAddressBangla;
//   var chamberOneConsultDayBangla;
//   var chamberTwoConsultDayBangla;
//   var chamberOneConsultStartTime;
//   var chamberTwoConsultStartTime;
//   var chamberOneConsultStartTimeBangla;
//   var chamberTwoConsultStartTimeBangla;
//   var chamberOneConsultEndTimeBangla;
//   var chamberTwoConsultEndTimeBangla;
//   var chamberOneConsultEndTime;
//   var chamberTwoConsultEndTime;
//   var chamberOneConsultTimeBangla;
//   var chamberTwoConsultTimeBangla;

//   var startTime;
//   var endtime;

//   fetchDoctorProfile() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     memberId = prefs.getInt('doctorMemberId');
//     var response = await apiServices.fetchDoctorProfile(memberId);

//     setState(() {
//       doctorProfile.addAll(response);
//     });
//     if (doctorProfile.length > 0) {
//       setState(() {
//         doctorId = doctorProfile[0]['doctorID'] ?? '';
//         bmdcNmuber = doctorProfile[0]['bmdcNmuber'] ?? '';
//         doctorNameEnglish = doctorProfile[0]['doctorName'] ?? '';
//         doctorDegree1English = doctorProfile[0]['qualificationOne'] ?? '';
//         doctorDegree2English = doctorProfile[0]['qualificationTwo'] ?? '';
//         doctorDesignation1English = doctorProfile[0]['designationOne'] ?? '';
//         doctorDesignation2English = doctorProfile[0]['designationTwo'] ?? '';
//         doctorWorkplace1English = doctorProfile[0]['workingPlace'] ?? '';
//         doctorNameBangla = doctorProfile[0]['doctorNameBangla'] ?? '';
//         doctorDegree1Bangla = doctorProfile[0]['qualificationOneBangla'] ?? '';
//         doctorDegree2Bangla = doctorProfile[0]['qualificationTwoBangla'] ?? '';
//         doctorDesignation1Bangla =
//             doctorProfile[0]['designationOneBangla'] ?? '';
//         doctorDesignation2Bangla =
//             doctorProfile[0]['designationTwoBangla'] ?? '';
//         doctorWorkplace1Bangla = doctorProfile[0]['workingPlaceBangla'] ?? '';

//         chamberOneAddress = doctorProfile[0]['chamberOneAddress'] ?? '';
//         chamberTwoAddress = doctorProfile[0]['chamberTwoAddress'] ?? '';
//         chamberOneConsultDay = doctorProfile[0]['chamberOneConsultDay'] ?? '';
//         chamberTwoConsultDay = doctorProfile[0]['chamberTwoConsultDay'] ?? '';
//         chamberTwoConsultDay = doctorProfile[0]['chamberTwoConsultDay'] ?? '';
//         chamberOneAddressBangla =
//             doctorProfile[0]['chamberOneAddressBangla'] ?? '';
//         chamberTwoAddressBangla =
//             doctorProfile[0]['chamberTwoAddressBangla'] ?? '';
//         chamberOneConsultDayBangla =
//             doctorProfile[0]['chamberOneConsultDayBangla'] ?? '';
//         chamberTwoConsultDayBangla =
//             doctorProfile[0]['chamberTwoConsultDayBangla'] ?? '';
//         chamber1ConsultDayBangla = doctorProfile[0]['consultationDay'] ?? '';
//         chamberOneConsultStartTime =
//             getTime(doctorProfile[0]['chamberOneConsultStartTime']);
//         chamberTwoConsultStartTime =
//             getTime(doctorProfile[0]['chamberTwoConsultStartTime']);
//         chamberOneConsultStartTimeBangla =
//             doctorProfile[0]['chamberOneConsultStartTimeBangla'];
//         chamberTwoConsultStartTimeBangla =
//             doctorProfile[0]['chamberTwoConsultStartTimeBangla'];
//         chamberOneConsultEndTimeBangla =
//             doctorProfile[0]['chamberOneConsultEndTimeBangla'];
//         chamberTwoConsultEndTimeBangla =
//             doctorProfile[0]['chamberTwoConsultEndTimeBangla'];
//         chamberOneConsultEndTime =
//             getTime(doctorProfile[0]['chamberOneConsultEndTime']);
//         chamberTwoConsultEndTime =
//             getTime(doctorProfile[0]['chamberTwoConsultEndTime']);
//         chamberOneConsultTimeBangla =
//             '$chamberOneConsultStartTimeBangla - $chamberOneConsultEndTimeBangla';
//         chamberTwoConsultTimeBangla =
//             '$chamberTwoConsultStartTimeBangla - $chamberTwoConsultEndTimeBangla';
//       });
//     }
//     fetchDoctorAppointments();
//   }

//   getTime(var inputTime) {
//     if (inputTime == null || inputTime == 'null' || inputTime == '') {
//       return '0:AM';
//     } else {
//       var dateTime = DateTime.parse(inputTime);
//       var hour = dateTime.hour;
//       var minute = dateTime.minute;
//       var amPm = hour > 12 ? 'PM' : 'AM';
//       hour = hour > 12 ? hour - 12 : hour;
//       var newHour = hour < 10 ? '0$hour' : '$hour';

//       var time = '$newHour:$minute $amPm';
//       return time;
//     }
//   }

//   getSpo2List() {
//     setState(() {
//       spo2List = DataList().spo2PercentList;
//     });
//     if (spo2List.isNotEmpty) {
//       setState(() {
//         selectedSpo2 = spo2List[0];
//       });
//     }
//   }

//   setPatientInformation() async {
//     var response = await patientProfileService.getPatientProfileInfo(patientId);
//     setState(() {
//       patient = response;
//       patientName = appointment['patientName'];
//       _patientNameController.text = appointment['patientName'];
//       phoneNumber = patient.mobile ?? '';
//       _patientPhoneController.text = patient.mobile ?? '';
//       age = getAge(patient.dateOfBirth ?? '');
//       _ageController.text = age;
//     });

//     List<ConsultHistoryPatientModel> consultHistory =
//         await patientApiService.fetchConsultHistoryPatient(patientId);
//     setState(() {
//       visitNoText = (consultHistory.length + 1).toString();
//       _visitNoController.text = visitNoText;
//     });
//   }

//   getDoctor() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     memberId = prefs.getInt('doctorMemberId');
//     var response = await apiServices.getDoctorProfile(memberId);
//     if (response.isNotEmpty) {
//       doctor = response[0];
//     }
//   }

//   @override
//   void initState() {
//     getDoctor();
//     patientId = appointment['patiantID'];
//     setPatientInformation();
//     fetchDoctorProfile();

//     _ftController.text = '0';
//     _inchController.text = '0';

//     fetchDistricts();
//     currentDate = getDate(DateTime.now().toIso8601String());
//     getSpo2List();
//     fetchNextVisits();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final patientInfo = Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: <Widget>[
//             ExpansionTileCard(
//               baseColor: kBackgroundColor,
//               key: cardA,
//               leading: CircleAvatar(
//                 backgroundColor: kShadowColor,
//                 radius: 25,
//                 child: CircleAvatar(
//                   backgroundColor: Colors.transparent,
//                   radius: 23.0,
//                   child: Image.asset('assets/icons/doctor/patientinfo.png'),
//                 ),
//               ),
//               title: Text(
//                 'Patient Information',
//                 style: TextStyle(
//                     fontFamily: 'Segoe',
//                     color: kBaseColor,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700),
//               ),
//               children: <Widget>[
//                 SizedBox(
//                   height: 15,
//                 ),
//                 // ListTile(
//                 //   title: Container(
//                 //     child: TypeAheadField<String?>(
//                 //       textFieldConfiguration: TextFieldConfiguration(
//                 //         controller: _patientNameController,
//                 //         decoration: InputDecoration(
//                 //           labelText: 'Patient Name',
//                 //           hintText: "type or search",
//                 //           contentPadding:
//                 //               EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                 //           border: OutlineInputBorder(
//                 //             borderRadius: BorderRadius.circular(32.0),
//                 //           ),
//                 //         ),
//                 //       ),
//                 //       debounceDuration: Duration(milliseconds: 500),
//                 //       suggestionsCallback: getNamesSuggestion,
//                 //       itemBuilder: (context, String? suggestion) => ListTile(
//                 //         title: Text(suggestion!),
//                 //       ),
//                 //       onSuggestionSelected: (String? suggestion) {
//                 //         _patientNameController.text = suggestion!;
//                 //         patientName = suggestion;
//                 //         for (var item in doctorAppointments) {
//                 //           if (item['patientName'] == suggestion) {
//                 //             patientId = item['patiantID'];
//                 //           }
//                 //         }
//                 //       },
//                 //     ),
//                 //   ),
//                 // ),
//                 ListTile(
//                   title: new TextFormField(
//                       controller: _patientNameController,
//                       decoration: new InputDecoration(
//                         labelText: "Patient Name",
//                         contentPadding:
//                             EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(32.0)),
//                       ),
//                       onChanged: (val) => setState(() =>
//                           patientName = val) // (val) => phoneNumber = val,
//                       ),
//                 ),
//                 ListTile(
//                   title: new TextFormField(
//                     controller: _patientPhoneController,
//                     decoration: new InputDecoration(
//                       labelText: "Mobile Number",
//                       contentPadding:
//                           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(32.0)),
//                     ),
//                     enabled: false,
//                     // onChanged: (val) => setState(() =>
//                     //     phoneNumber = val) // (val) => phoneNumber = val,
//                   ),
//                 ),
//                 ListTile(
//                   title: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(32),
//                       border: Border.all(width: 1, color: Color(0xFFA4A4A4)),
//                     ),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                         isExpanded: true,
//                         value: selectedtGender,
//                         // underline: ,
//                         items: <String>['Male', 'Female'].map((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                         onChanged: (val) {
//                           print(val);
//                           setState(() {
//                             selectedtGender = val!;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 ListTile(
//                   title: new TextFormField(
//                     controller: _ageController,
//                     decoration: new InputDecoration(
//                       labelText: "Age",
//                       contentPadding:
//                           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(32.0)),
//                     ),
//                     onChanged: (val) => setState(() => age = val),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 2,
//                 ),
//                 Text(
//                   'Address',
//                   style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
//                   textAlign: TextAlign.left,
//                 ),
//                 const Divider(
//                   height: 4.0,
//                   color: kTextLightColor,
//                 ),
//                 ListTile(
//                   title: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('District'),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 20),
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(32),
//                           border:
//                               Border.all(width: 1, color: Color(0xFFA4A4A4)),
//                         ),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton<String>(
//                             value: selectedDistrict,
//                             isExpanded: true,
//                             elevation: 16,
//                             onChanged: (String? newValue) {
//                               setState(() {
//                                 selectedDistrict = newValue!;
//                               });
//                               for (var item in districts) {
//                                 if (item.districtName == newValue) {
//                                   setState(() {
//                                     selectedDistrictId = item.districtID;
//                                   });
//                                 }
//                               }

//                               fetchPoliceStations(
//                                   selectedDistrictId.toString());
//                               fetchPostOffices('0');
//                             },
//                             items: districts.map((DistrictModel data) {
//                               return DropdownMenuItem(
//                                 value: data.districtName,
//                                 child: Text(
//                                   data.districtName,
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 ListTile(
//                   title: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Thana'),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 20),
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(32),
//                           border:
//                               Border.all(width: 1, color: Color(0xFFA4A4A4)),
//                         ),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton<String>(
//                             value: selectedPoliceStation,
//                             isExpanded: true,
//                             elevation: 16,
//                             onChanged: (String? newValue) {
//                               setState(() {
//                                 selectedPoliceStation = newValue!;
//                               });
//                               for (var item in policestations) {
//                                 if (item.policeStationName == newValue) {
//                                   setState(() {
//                                     selectedPoliceStationId =
//                                         item.policeStationID;
//                                   });
//                                 }
//                               }
//                               fetchPostOffices(
//                                   selectedPoliceStationId.toString());
//                             },
//                             items:
//                                 policestations.map((PoliceStationModel data) {
//                               return DropdownMenuItem(
//                                 value: data.policeStationName,
//                                 child: Text(
//                                   data.policeStationName,
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 ListTile(
//                   title: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Post Office'),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 20),
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(32),
//                           border:
//                               Border.all(width: 1, color: Color(0xFFA4A4A4)),
//                         ),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton<String>(
//                             value: selectedPostOffice,
//                             isExpanded: true,
//                             elevation: 16,
//                             onChanged: (String? newValue) {
//                               setState(() {
//                                 selectedPostOffice = newValue!;
//                               });
//                               for (var item in postOffices) {
//                                 if (item.postOfficeName == newValue) {
//                                   setState(() {
//                                     selectedPostOfficeId = item.postOfficeId;
//                                   });
//                                 }
//                               }
//                             },
//                             items: postOffices.map((PostOfficeModel data) {
//                               return DropdownMenuItem(
//                                 value: data.postOfficeName,
//                                 child: Text(
//                                   data.postOfficeName,
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Divider(
//                   height: 10.0,
//                 ),
//                 ListTile(
//                   title: DateTimeField(
//                     initialValue: DateTime.parse(currentDate),
//                     format: format,
//                     onShowPicker: (context, currentValue) {
//                       return showDatePicker(
//                           context: context,
//                           firstDate: DateTime(1900),
//                           initialDate: currentValue ?? DateTime.now(),
//                           lastDate: DateTime(2100));
//                     },
//                     onChanged: (val) {
//                       setState(() {
//                         currentDate = val!.toIso8601String();
//                       });
//                     },
//                     decoration: InputDecoration(
//                       labelText: "Current Date",
//                       contentPadding:
//                           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(32.0)),
//                     ),
//                   ),
//                 ),
//                 ListTile(
//                   title: new TextFormField(
//                     initialValue: referredByName,
//                     decoration: new InputDecoration(
//                       labelText: "Referred By",
//                       contentPadding:
//                           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(32.0)),
//                     ),
//                     onChanged: (val) => setState(() => referredByName = val),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );

//     final diseaseCondition = Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//       child: ExpansionTileCard(
//         baseColor: kBackgroundColor,
//         key: cardB,
//         leading: CircleAvatar(
//           backgroundColor: kShadowColor,
//           radius: 25,
//           child: CircleAvatar(
//             backgroundColor: Colors.transparent,
//             radius: 23.0,
//             child: Image.asset('assets/icons/doctor/diseasecondition.png'),
//           ),
//         ),
//         title: Text(
//           'Disease Condition',
//           style: TextStyle(
//               fontFamily: 'Segoe',
//               color: kBaseColor,
//               fontSize: 16,
//               fontWeight: FontWeight.w700),
//         ),
//         children: <Widget>[
//           ListTile(
//             title: Container(
//               child: TypeAheadField<String?>(
//                 textFieldConfiguration: TextFieldConfiguration(
//                   controller: _diseaseConditionController,
//                   decoration: new InputDecoration(
//                     labelText: "Disease Condition",
//                     hintText: "type or search",
//                     contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(32.0),
//                     ),
//                     suffixIcon: IconButton(
//                       onPressed: () {
//                         if (_diseaseConditionController.text.isNotEmpty) {
//                           if (!diseaseConditionEntry
//                               .contains(_diseaseConditionController.text)) {
//                             setState(() {
//                               diseaseConditionEntry
//                                   .add(_diseaseConditionController.text);
//                             });
//                             // insert disease condition to database here
//                             PrescriptionService.saveDiseaseConditionToDB(
//                                 _diseaseConditionController.text, memberId);
//                             _diseaseConditionController.clear();
//                           }
//                         }
//                       },
//                       icon: Icon(Icons.add),
//                     ),
//                   ),
//                 ),
//                 debounceDuration: Duration(milliseconds: 500),
//                 suggestionsCallback:
//                     PrescriptionService.getDiseaseConditionSuggestions,
//                 itemBuilder: (context, String? suggestion) => ListTile(
//                   title: Text(suggestion!),
//                 ),
//                 onSuggestionSelected: (String? suggestion) {
//                   _diseaseConditionController.text = suggestion!;
//                 },
//               ),
//             ),
//           ),
//           diseaseConditionEntry.length > 0
//               ? ListTile(
//                   title: ListView.builder(
//                       shrinkWrap: true,
//                       scrollDirection: Axis.vertical,
//                       itemCount: diseaseConditionEntry.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Text(
//                             '${index + 1}) ${diseaseConditionEntry[index]}');
//                       }))
//               : Container(),
//         ],
//       ),
//     );
//     final chiefComplaint = Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//       child: ExpansionTileCard(
//         baseColor: kBackgroundColor,
//         key: cardC,
//         leading: CircleAvatar(
//           backgroundColor: kShadowColor,
//           radius: 25,
//           child: CircleAvatar(
//             backgroundColor: Colors.transparent,
//             radius: 23.0,
//             child: Image.asset('assets/icons/doctor/cc.png'),
//           ),
//         ),
//         title: Text(
//           'C/C',
//           style: TextStyle(
//               fontFamily: 'Segoe',
//               color: kBaseColor,
//               fontSize: 16,
//               fontWeight: FontWeight.w700),
//         ),
//         children: <Widget>[
//           ListTile(
//             title: Container(
//               child: TypeAheadField<String?>(
//                 textFieldConfiguration: TextFieldConfiguration(
//                   controller: _ccController,
//                   decoration: new InputDecoration(
//                     hintText: "type or search",
//                     contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(32.0),
//                     ),
//                     suffixIcon: IconButton(
//                       onPressed: () {
//                         if (_ccController.text.isNotEmpty) {
//                           if (!ccEntry.contains(_ccController.text)) {
//                             setState(() {
//                               ccEntry.add(_ccController.text);
//                             });
//                             PrescriptionService.saveCCToDB(
//                                 _ccController.text, doctorId, memberId);
//                             _ccController.clear();
//                           }
//                         }
//                       },
//                       icon: Icon(Icons.add),
//                     ),
//                   ),
//                 ),
//                 debounceDuration: Duration(milliseconds: 500),
//                 suggestionsCallback: PrescriptionService.getCCSuggestions,
//                 itemBuilder: (context, String? suggestion) => ListTile(
//                   title: Text(suggestion!),
//                 ),
//                 onSuggestionSelected: (String? suggestion) {
//                   _ccController.text = suggestion!;
//                 },
//               ),
//             ),
//           ),
//           ccEntry.length > 0
//               ? ListTile(
//                   title: ListView.builder(
//                       shrinkWrap: true,
//                       scrollDirection: Axis.vertical,
//                       itemCount: ccEntry.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Text('${index + 1}) ${ccEntry[index]}');
//                       }))
//               : Container(),
//         ],
//       ),
//     );

//     final oE = Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//       child: ExpansionTileCard(
//         baseColor: kBackgroundColor,
//         key: cardD,
//         leading: CircleAvatar(
//           backgroundColor: kShadowColor,
//           radius: 25,
//           child: CircleAvatar(
//             backgroundColor: Colors.transparent,
//             radius: 23.0,
//             child: Image.asset('assets/icons/doctor/oe.png'),
//           ),
//         ),
//         title: Text(
//           'O/E',
//           style: TextStyle(
//               fontFamily: 'Segoe',
//               color: kBaseColor,
//               fontSize: 16,
//               fontWeight: FontWeight.w700),
//         ),
//         children: <Widget>[
//           ListTile(
//             title: Column(
//               children: [
//                 Row(
//                   children: [
//                     Text('Height'),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Container(
//                       width: 80,
//                       height: 40,
//                       child: TextFormField(
//                         initialValue: height,
//                         keyboardType: TextInputType.text,
//                         autofocus: false,
//                         decoration: new InputDecoration(
//                           hintText: "Feet",
//                           contentPadding:
//                               EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(32.0)),
//                         ),
//                         onChanged: (val) {
//                           if (val.isNotEmpty) {
//                             if (int.parse(val) <= 10) {
//                               setState(() => feet = int.parse(val));
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text(
//                                       'feet value can not be more than 10 feet'),
//                                 ),
//                               );
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Container(
//                       width: 80,
//                       height: 40,
//                       child: TextFormField(
//                         initialValue: height,
//                         keyboardType: TextInputType.text,
//                         autofocus: false,
//                         decoration: new InputDecoration(
//                           hintText: "Inch",
//                           contentPadding:
//                               EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(32.0)),
//                         ),
//                         onChanged: (val) {
//                           if (val.isNotEmpty) {
//                             if (int.parse(val) < 12) {
//                               setState(() => inch = int.parse(val));
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text(
//                                       'inch value can not be more than 11 inch'),
//                                 ),
//                               );
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Container(
//                       width: 100,
//                       height: 40,
//                       child: Row(
//                         children: [
//                           Text('$feet ft $inch inch'),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//               ],
//             ),
//           ),

//           ListTile(
//             title: Column(
//               children: [
//                 Row(
//                   children: [
//                     Text('Weight'),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Container(
//                       width: 100,
//                       height: 40,
//                       child: TextFormField(
//                         keyboardType: TextInputType.text,
//                         autofocus: false,
//                         decoration: new InputDecoration(
//                           hintText: "kg",
//                           contentPadding:
//                               EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(32.0)),
//                         ),
//                         onChanged: (val) {
//                           if (val.isNotEmpty) {
//                             if (double.parse(val) > 0) {
//                               setState(() => weight = double.parse(val));
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             title: Row(
//               children: [
//                 MaterialButton(
//                   onPressed: () {
//                     if (feet == 0) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Feet value is required'),
//                         ),
//                       );
//                     } else if (weight == 0) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Weight can not be empty or zero'),
//                         ),
//                       );
//                     } else {
//                       heightInM =
//                           ((feet * 12) + inch) * 0.0254; // 1 inch = 0.0254m
//                       var calculatedBMI =
//                           (weight / (heightInM * heightInM)).toStringAsFixed(2);

//                       setState(() {
//                         bmi = calculatedBMI;
//                         _bmiController.text = calculatedBMI;
//                       });
//                     }
//                   },
//                   child: Text(
//                     'Calculate BMI',
//                     style: TextStyle(
//                       letterSpacing: 1,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   color: Colors.blue,
//                   textColor: Colors.white,
//                 ),
//               ],
//             ),
//           ),

//           ListTile(
//             title: new TextFormField(
//               controller: _bmiController,
//               keyboardType: TextInputType.text,
//               autofocus: false,
//               decoration: new InputDecoration(
//                 labelText: "BMI",
//                 contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(32.0)),
//               ),
//               // onChanged: (val) => setState(() => bmi = val),
//             ),
//           ),
//           ListTile(
//             title: new TextFormField(
//               initialValue: bp,
//               keyboardType: TextInputType.text,
//               autofocus: false,
//               decoration: new InputDecoration(
//                 labelText: "BP",
//                 contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(32.0)),
//               ),
//               onChanged: (val) => setState(() => bp = val),
//             ),
//           ),

//           ListTile(
//             title: DateTimeField(
//               format: format,
//               initialValue: lmp != null ? lmp : null,
//               onShowPicker: (context, currentValue) async {
//                 final date = await showDatePicker(
//                     context: context,
//                     firstDate: DateTime(1900),
//                     initialDate: currentValue ?? DateTime.now(),
//                     lastDate: DateTime(2100));

//                 if (date != null) {
//                   setState(() {
//                     lmp = date;
//                   });
//                   calcultateEDD(lmp);

//                   return date;
//                 }
//               },
//               decoration: InputDecoration(
//                 labelText: "LMP",
//                 contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(32.0)),
//               ),
//             ),
//           ),
//           ListTile(
//             title: new TextFormField(
//               controller: _eddController,
//               keyboardType: TextInputType.text,
//               autofocus: false,
//               decoration: new InputDecoration(
//                 labelText: 'EDD',
//                 contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(32.0)),
//               ),
//               // onChanged: (val) => setState(() => edd = val),
//             ),
//           ),
//           ListTile(
//             title: new TextFormField(
//               keyboardType: TextInputType.text,
//               initialValue: pDose,
//               autofocus: false,
//               decoration: new InputDecoration(
//                 labelText: 'P.dose',
//                 contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(32.0)),
//               ),
//               onChanged: (val) => setState(() => pDose = val),
//             ),
//           ),
//           ListTile(
//             title: new TextFormField(
//               keyboardType: TextInputType.text,
//               autofocus: false,
//               initialValue: pulse,
//               decoration: new InputDecoration(
//                 labelText: "Pulse",
//                 contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(32.0)),
//               ),
//               onChanged: (val) => setState(() => pulse = val),
//             ),
//           ),

//           // spo2 here

//           ListTile(
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('spo2'),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(32),
//                     border: Border.all(width: 1, color: Color(0xFFA4A4A4)),
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton<String>(
//                       isExpanded: true,
//                       hint: Text("Select item"),
//                       value: selectedSpo2,

//                       // underline: ,
//                       items: spo2List.map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (val) {
//                         setState(() {
//                           selectedSpo2 = val!;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             title: new TextFormField(
//               keyboardType: TextInputType.text,
//               initialValue: rr,
//               autofocus: false,
//               decoration: new InputDecoration(
//                 hintText: "R/R",
//                 contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(32.0)),
//               ),
//               onChanged: (val) => setState(() => rr = val),
//             ),
//           ),
//           ExpansionTileCard(
//             baseColor: kBackgroundColor,
//             title: Text(
//               'Allergy (Select Type)',
//               style: TextStyle(
//                   fontFamily: 'Segoe',
//                   color: kBaseColor,
//                   fontWeight: FontWeight.w700),
//             ),
//             contentPadding: EdgeInsets.fromLTRB(28.0, 10.0, 20.0, 10.0),
//             borderRadius: BorderRadius.circular(50.0),
//             children: [
//               ListTile(
//                 title: new DropdownButtonFormField(
//                   //value: selectedDrugAlergy,
//                   decoration: new InputDecoration(
//                     hintText: "Drug",
//                     contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(32.0)),
//                   ),
//                   items: <DropdownMenuItem>[
//                     DropdownMenuItem<int>(
//                       value: 1,
//                       child: Text("Unknown"),
//                     ),
//                     DropdownMenuItem<int>(
//                       value: 2,
//                       child: Text("Known"),
//                     ),
//                   ],
//                   onChanged: (dynamic val) {
//                     if (val == 1) {
//                       setState(() {
//                         selectedDrugAlergy = 'Unknown';
//                       });
//                     } else {
//                       setState(() {
//                         selectedDrugAlergy = 'Known';
//                       });
//                     }
//                   },
//                 ),
//               ),
//               ListTile(
//                 title: new DropdownButtonFormField(
//                   // value: selectedFoodAlergy,
//                   decoration: new InputDecoration(
//                     hintText: "Food",
//                     contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(32.0)),
//                   ),
//                   items: <DropdownMenuItem>[
//                     DropdownMenuItem<int>(
//                       value: 1,
//                       child: Text("Unknown"),
//                     ),
//                     DropdownMenuItem<int>(
//                       value: 2,
//                       child: Text("Known"),
//                     ),
//                   ],
//                   onChanged: (dynamic val) {
//                     if (val == 1) {
//                       setState(() {
//                         selectedFoodAlergy = 'Unknown';
//                       });
//                     } else {
//                       setState(() {
//                         selectedFoodAlergy = 'Known';
//                       });
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );

//     final history = Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//       child: ExpansionTileCard(
//         baseColor: kBackgroundColor,
//         key: cardE,
//         leading: CircleAvatar(
//           backgroundColor: kShadowColor,
//           radius: 25,
//           child: CircleAvatar(
//             backgroundColor: Colors.transparent,
//             radius: 23.0,
//             child: Image.asset('assets/icons/doctor/history.png'),
//           ),
//         ),
//         title: Text(
//           'History',
//           style: TextStyle(
//               fontFamily: 'Segoe',
//               color: kBaseColor,
//               fontSize: 16,
//               fontWeight: FontWeight.w700),
//         ),
//         children: <Widget>[
//           ListTile(
//             title: new DropdownButtonFormField(
//               decoration: new InputDecoration(
//                 hintText: "Drug",
//                 contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(32.0)),
//               ),
//               items: <DropdownMenuItem>[
//                 DropdownMenuItem<int>(
//                   value: 1,
//                   child: Text("Unknown"),
//                 ),
//                 DropdownMenuItem<int>(
//                   value: 2,
//                   child: Text("Known"),
//                 ),
//               ],
//               onChanged: (dynamic val) {
//                 if (val == 1) {
//                   setState(() {
//                     selectedDrugHistory = "Unknown";
//                     drugHistory = false;
//                   });
//                 } else {
//                   setState(() {
//                     selectedDrugHistory = "Known";
//                     drugHistory = true;
//                   });
//                 }
//               },
//             ),
//           ),
//           drugHistory
//               ? ListTile(
//                   title: Container(
//                     child: TypeAheadField<String?>(
//                       textFieldConfiguration: TextFieldConfiguration(
//                         controller: _drugHistoryController,
//                         decoration: new InputDecoration(
//                           labelText: 'Drug History',
//                           hintText: "type or search",
//                           contentPadding:
//                               EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(32.0),
//                           ),
//                           suffixIcon: IconButton(
//                             onPressed: () async {
//                               if (_drugHistoryController.text.isNotEmpty) {
//                                 if (!drugHistoryEntry
//                                     .contains(_drugHistoryController.text)) {
//                                   setState(() {
//                                     drugHistoryEntry
//                                         .add(_drugHistoryController.text);
//                                   });
//                                   PrescriptionService.saveHistoryToDB(
//                                     memberId,
//                                     'drug',
//                                     'known',
//                                     _drugHistoryController.text,
//                                     DateTime.now().toIso8601String(),
//                                   );

//                                   _drugHistoryController.clear();
//                                 }
//                               }
//                             },
//                             icon: Icon(Icons.add),
//                           ),
//                         ),
//                       ),
//                       debounceDuration: Duration(milliseconds: 500),
//                       suggestionsCallback:
//                           PrescriptionService.getDrugHistorySuggestions,
//                       itemBuilder: (context, String? suggestion) => ListTile(
//                         title: Text(suggestion!),
//                       ),
//                       onSuggestionSelected: (String? suggestion) {
//                         _drugHistoryController.text = suggestion!;
//                       },
//                     ),
//                   ),
//                 )
//               : Container(),
//           drugHistoryEntry.isNotEmpty && drugHistory
//               ? ListTile(
//                   title: ListView.builder(
//                       shrinkWrap: true,
//                       scrollDirection: Axis.vertical,
//                       itemCount: drugHistoryEntry.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Text('${index + 1}) ${drugHistoryEntry[index]}');
//                       }))
//               : Container(),
//           ListTile(
//             title: new DropdownButtonFormField(
//               decoration: new InputDecoration(
//                 hintText: "Family",
//                 contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(32.0)),
//               ),
//               items: <DropdownMenuItem>[
//                 DropdownMenuItem<int>(
//                   value: 1,
//                   child: Text("Yes"),
//                 ),
//                 DropdownMenuItem<int>(
//                   value: 2,
//                   child: Text("No"),
//                 ),
//               ],
//               onChanged: (dynamic val) {
//                 if (val == 1) {
//                   setState(() {
//                     selectedFamilyHistory = "Unknown";
//                   });
//                 } else {
//                   setState(() {
//                     selectedFamilyHistory = "Known";
//                   });
//                 }
//               },
//             ),
//           ),
//           ListTile(
//             title: new DropdownButtonFormField(
//               decoration: new InputDecoration(
//                 hintText: "Medical",
//                 contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(32.0)),
//               ),
//               items: <DropdownMenuItem>[
//                 DropdownMenuItem<int>(
//                   value: 1,
//                   child: Text("Yes"),
//                 ),
//                 DropdownMenuItem<int>(
//                   value: 2,
//                   child: Text("No"),
//                 ),
//               ],
//               onChanged: (dynamic val) {
//                 if (val == 1) {
//                   setState(() {
//                     selectedMedicalHistory = "Unknown";
//                   });
//                 } else {
//                   setState(() {
//                     selectedMedicalHistory = "Known";
//                   });
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );

//     final medication = Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//       child: ExpansionTileCard(
//         baseColor: kBackgroundColor,
//         key: cardF,
//         leading: CircleAvatar(
//           backgroundColor: kShadowColor,
//           radius: 25,
//           child: CircleAvatar(
//             backgroundColor: Colors.transparent,
//             radius: 23.0,
//             child: Image.asset('assets/icons/doctor/medication.png'),
//           ),
//         ),
//         title: Text(
//           'Medication',
//           style: TextStyle(
//               fontFamily: 'Segoe',
//               color: kBaseColor,
//               fontSize: 16,
//               fontWeight: FontWeight.w700),
//         ),
//         children: <Widget>[
//           ListTile(
//             title: Card(
//               borderOnForeground: true,
//               color: kWhiteShadow,
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               left: 12.0, top: 10.0, right: 0.0, bottom: 5.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Brand Name',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontFamily: 'Segoe',
//                                     fontSize: 18.0,
//                                     color: kBaseColor,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               Text('$brandName ',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontFamily: 'Segoe',
//                                     fontSize: 15.0,
//                                     color: kBaseColor,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   overflow: TextOverflow.ellipsis),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 30,
//                         child: VerticalDivider(
//                           color: Colors.black54,
//                           thickness: 0.8,
//                         ),
//                       ),
//                       Container(
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               left: 12.0, top: 10.0, right: 0.0, bottom: 5.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Medicine Category',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontFamily: 'Segoe',
//                                     fontSize: 18.0,
//                                     color: kBaseColor,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 '$medicineCategory',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontFamily: 'Segoe',
//                                     fontSize: 18.0,
//                                     color: kBaseColor,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 30,
//                         child: VerticalDivider(
//                           color: Colors.black54,
//                           thickness: 0.8,
//                         ),
//                       ),
//                       Container(
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               left: 12.0, top: 10.0, right: 0.0, bottom: 5.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Group',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontFamily: 'Segoe',
//                                     fontSize: 18.0,
//                                     color: kBaseColor,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 '$medicineGroup',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontFamily: 'Segoe',
//                                     fontSize: 18.0,
//                                     color: kBaseColor,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               left: 12.0, top: 10.0, right: 0.0, bottom: 5.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Company Name',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontFamily: 'Segoe',
//                                     fontSize: 18.0,
//                                     color: kBaseColor,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 '$companyName',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontFamily: 'Segoe',
//                                     fontSize: 18.0,
//                                     color: kBaseColor,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                           height: 30,
//                           child: VerticalDivider(
//                             color: Colors.black54,
//                             thickness: 0.8,
//                           )),
//                       Container(
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               left: 12.0, top: 10.0, right: 0.0, bottom: 5.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Price',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontFamily: 'Segoe',
//                                     fontSize: 18.0,
//                                     color: kBaseColor,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 '$price',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontFamily: 'Segoe',
//                                     fontSize: 18.0,
//                                     color: kBaseColor,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                           height: 30,
//                           child: VerticalDivider(
//                             color: Colors.black54,
//                             thickness: 0.8,
//                           )),
//                       Container(
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               left: 12.0, top: 10.0, right: 0.0, bottom: 5.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'FDA Approved',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontFamily: 'Segoe',
//                                     fontSize: 18.0,
//                                     color: kBaseColor,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 '$fdaApproved',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontFamily: 'Segoe',
//                                     fontSize: 18.0,
//                                     color: kBaseColor,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           ListTile(
//             title: Container(
//               child: TypeAheadField<String?>(
//                 textFieldConfiguration: TextFieldConfiguration(
//                   controller: _brandNameController,
//                   decoration: new InputDecoration(
//                     hintText: "Type Brand Name",
//                     contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(32.0),
//                     ),
//                   ),
//                 ),
//                 debounceDuration: Duration(milliseconds: 500),
//                 suggestionsCallback: PrescriptionController.getBrandSuggestions,
//                 itemBuilder: (context, String? suggestion) => ListTile(
//                   title: Text(suggestion!),
//                 ),
//                 onSuggestionSelected: (String? suggestion) {
//                   setState(() {
//                     _brandNameController.text = suggestion!;
//                   });
//                   for (var item in PrescriptionController.medicationList) {
//                     if (item.brandName == suggestion) {
//                       medicine = item;
//                       setState(() {
//                         _typeDoseController.text = item.dose ?? '';
//                         brandName = item.brandName ?? '';
//                         medicineCategory = item.medicineCategory ?? '';
//                         medicineGroup = item.medicineGroup ?? '';
//                         companyName = item.companyName ?? '';
//                         price = item.price ?? '';
//                         fdaApproved = item.fdaApproved ?? false;
//                       });
//                     }
//                   }
//                 },
//               ),
//             ),
//           ),
//           // ListTile(
//           //   title: new TextFormField(
//           //     keyboardType: TextInputType.text,
//           //     controller: _brandNameController,
//           //     autofocus: false,
//           //     decoration: new InputDecoration(
//           //       hintText: "Type Brand Name",
//           //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//           //       border: OutlineInputBorder(
//           //           borderRadius: BorderRadius.circular(32.0)),
//           //     ),
//           //   ),
//           // ),
//           SizedBox(
//             height: 10,
//           ),
//           ListTile(
//             title: new TextFormField(
//               keyboardType: TextInputType.text,
//               controller: _typeDoseController,
//               autofocus: false,
//               decoration: new InputDecoration(
//                 hintText: "Type Dose",
//                 contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(32.0)),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           ListTile(
//             title: Container(
//               child: TypeAheadField<String?>(
//                 textFieldConfiguration: TextFieldConfiguration(
//                   controller: _durationController,
//                   decoration: new InputDecoration(
//                     hintText: "Duration",
//                     contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(32.0),
//                     ),
//                   ),
//                 ),
//                 debounceDuration: Duration(milliseconds: 500),
//                 suggestionsCallback: PrescriptionService.getDurationSuggestions,
//                 itemBuilder: (context, String? suggestion) => ListTile(
//                   title: Text(suggestion!),
//                 ),
//                 onSuggestionSelected: (String? suggestion) {
//                   _durationController.text = suggestion!;
//                 },
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           ListTile(
//             title: Text(
//               'Taking Medicine',
//               style: TextStyle(
//                   fontFamily: 'Segoe',
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600),
//               textAlign: TextAlign.left,
//             ),
//           ),
//           Row(
//             children: [
//               Container(
//                 width: 160,
//                 height: 40,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           // before = !before;
//                           beforeEating = true;
//                           afterEating = false;
//                         });
//                       },
//                       child: beforeEating
//                           ? Icon(
//                               Icons.check_box,
//                               color: kBaseColor,
//                               size: 20,
//                             )
//                           : Icon(
//                               Icons.check_box_outline_blank,
//                               color: Colors.black54,
//                               size: 20,
//                             ),
//                     ),
//                     SizedBox(width: 5),
//                     Text("Before Meal"),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: 150,
//                 height: 40,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           // after = !after;
//                           beforeEating = false;
//                           afterEating = true;
//                         });
//                       },
//                       child: afterEating
//                           ? Icon(
//                               Icons.check_box,
//                               color: kBaseColor,
//                               size: 20,
//                             )
//                           : Icon(
//                               Icons.check_box_outline_blank,
//                               color: Colors.black54,
//                               size: 20,
//                             ),
//                     ),
//                     SizedBox(width: 2),
//                     Text("After Meal"),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           ListTile(
//             title: Text(
//               'Previous entered field data show as a label text. Entered all field data show as a label text.',
//               style: TextStyle(
//                   fontFamily: 'Segoe',
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600),
//               textAlign: TextAlign.left,
//             ),
//           ),
//           Container(
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 5.0, horizontal: 120),
//               child: MaterialButton(
//                 onPressed: () {
//                   // Navigator.of(context).pushNamed('');

//                   saveMedicine();
//                 },
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 padding: EdgeInsets.only(left: 6, top: 6, right: 6, bottom: 6),
//                 color: kButtonColor,
//                 child: Text('Add',
//                     style: TextStyle(
//                         fontFamily: 'Segoe',
//                         fontSize: 15,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700)),
//               ),
//             ),
//           ),
//           medicationList.length > 0
//               ? ListTile(
//                   title: ListView.builder(
//                       shrinkWrap: true,
//                       scrollDirection: Axis.vertical,
//                       itemCount: medicationList.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Card(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   medicationList[index]['BrandName'],
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 SizedBox(height: 5),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         Text(medicationList[index]['Dose']),
//                                         SizedBox(width: 20),
//                                         Text(
//                                             '- ( ${medicationList[index]['EatingTime']} )'),
//                                         SizedBox(width: 20),
//                                         Text(
//                                             ' ${medicationList[index]['Duration']}'),
//                                       ],
//                                     ),
//                                     IconButton(
//                                       onPressed: () {
//                                         setState(() {
//                                           medicationList.removeAt(index);
//                                           medicineString.removeAt(index);
//                                         });
//                                       },
//                                       icon: Icon(
//                                         Icons.delete,
//                                         color: Colors.red,
//                                         size: 30,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }))
//               : Container(),
//           ListTile(
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Next Visit'),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(32),
//                     border: Border.all(width: 1, color: Color(0xFFA4A4A4)),
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton<String>(
//                       value: selectedNextVisit,
//                       isExpanded: true,
//                       elevation: 16,
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           selectedNextVisit = newValue!;
//                         });
//                       },
//                       items: nextVisits.map((NextVisitModel data) {
//                         return DropdownMenuItem(
//                           value: data.details,
//                           child: Text(
//                             data.details!,
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             title: TextFormField(
//               keyboardType: TextInputType.text,
//               decoration: new InputDecoration(
//                 hintText: "Paid Taka",
//                 contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(32.0)),
//               ),
//               onChanged: (val) => setState(() => paidTakaText = val),
//             ),
//           ),
//           ListTile(
//             title: new TextFormField(
//               // keyboardType: TextInputType.number,
//               enabled: false,
//               controller: _visitNoController,
//               decoration: new InputDecoration(
//                 hintText: "Visit No.",
//                 labelText: "Visit No.",
//                 contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(32.0)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//     final advises = Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//       child: ExpansionTileCard(
//         baseColor: kBackgroundColor,
//         key: cardG,
//         leading: CircleAvatar(
//           backgroundColor: kShadowColor,
//           radius: 25,
//           child: CircleAvatar(
//             backgroundColor: Colors.transparent,
//             radius: 23.0,
//             child: Image.asset('assets/icons/doctor/advises.png'),
//           ),
//         ),
//         title: Text(
//           'Advices',
//           style: TextStyle(
//               fontFamily: 'Segoe',
//               color: kBaseColor,
//               fontSize: 16,
//               fontWeight: FontWeight.w700),
//         ),
//         children: <Widget>[
//           ListTile(
//             title: Container(
//               child: TypeAheadField<String?>(
//                 textFieldConfiguration: TextFieldConfiguration(
//                   controller: _diagnosisAdivceController,
//                   decoration: new InputDecoration(
//                     hintText: "Diagnosis Advices",
//                     contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(32.0),
//                     ),
//                     suffixIcon: IconButton(
//                       onPressed: () async {
//                         if (_diagnosisAdivceController.text.isNotEmpty) {
//                           if (!diagnosisAdviceEntry
//                               .contains(_diagnosisAdivceController.text)) {
//                             setState(() {
//                               diagnosisAdviceEntry
//                                   .add(_diagnosisAdivceController.text);
//                             });
//                             await prescriptionService.saveDiagnosisAdivceToDB(
//                                 memberId, _diagnosisAdivceController.text);
//                             _diagnosisAdivceController.clear();
//                           }
//                         }
//                       },
//                       icon: Icon(Icons.add),
//                     ),
//                   ),
//                 ),
//                 debounceDuration: Duration(milliseconds: 500),
//                 suggestionsCallback:
//                     PrescriptionService.getDiagnosisAdviceSuggestions,
//                 itemBuilder: (context, String? suggestion) => ListTile(
//                   title: Text(suggestion!),
//                 ),
//                 onSuggestionSelected: (String? suggestion) {
//                   _diagnosisAdivceController.text = suggestion!;
//                 },
//               ),
//             ),
//           ),
//           diagnosisAdviceEntry.length > 0
//               ? ListTile(
//                   title: ListView.builder(
//                       shrinkWrap: true,
//                       scrollDirection: Axis.vertical,
//                       itemCount: diagnosisAdviceEntry.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Text(
//                             '${index + 1}) ${diagnosisAdviceEntry[index]}');
//                       }))
//               : Container(),
//           ListTile(
//             title: Container(
//               child: TypeAheadField<String?>(
//                 textFieldConfiguration: TextFieldConfiguration(
//                   controller: _generalAdivceController,
//                   decoration: new InputDecoration(
//                     hintText: "General Advices",
//                     contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(32.0),
//                     ),
//                     suffixIcon: IconButton(
//                       onPressed: () async {
//                         if (_generalAdivceController.text.isNotEmpty) {
//                           if (!generalAdviceEntry
//                               .contains(_generalAdivceController.text)) {
//                             setState(() {
//                               generalAdviceEntry
//                                   .add(_generalAdivceController.text);
//                             });
//                             await prescriptionService.saveGeneralAdivceToDB(
//                                 memberId, _generalAdivceController.text);
//                             _generalAdivceController.clear();
//                           }
//                         }
//                       },
//                       icon: Icon(Icons.add),
//                     ),
//                   ),
//                 ),
//                 debounceDuration: Duration(milliseconds: 500),
//                 suggestionsCallback:
//                     PrescriptionService.getGeneralAdviceSuggestions,
//                 itemBuilder: (context, String? suggestion) => ListTile(
//                   title: Text(suggestion!),
//                 ),
//                 onSuggestionSelected: (String? suggestion) {
//                   _generalAdivceController.text = suggestion!;
//                 },
//               ),
//             ),
//           ),
//           generalAdviceEntry.length > 0
//               ? ListTile(
//                   title: ListView.builder(
//                       shrinkWrap: true,
//                       scrollDirection: Axis.vertical,
//                       itemCount: generalAdviceEntry.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Text(
//                             '${index + 1}) ${generalAdviceEntry[index]}');
//                       }))
//               : Container(),
//         ],
//       ),
//     );

//     final preview = Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 90),
//       child: MaterialButton(
//         onPressed: () async {
//           // writeOnPdf();
//           // await savePdf();
//           var oEMap = generateOEMap();
//           var prescriptionInfoMap = generatePrescriptionInfoMap();
//           var returnMap = await prescriptionService.savePrescription(
//             generalAdviceEntry,
//             diagnosisAdviceEntry,
//             drugHistoryEntry,
//             oEMap,
//             ccEntry,
//             diseaseConditionEntry,
//             prescriptionInfoMap,
//             medicationList,
//             false,
//           );

//           final url = '${returnMap['pdfUrl']}';
//           final fileName = '${returnMap['prescriptionID']}';
//           final file = await PdfApi.loadNetwork(url, fileName);

//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => PdfViewPage(pdfFile: file),
//             ),
//           );
//         },
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(25),
//         ),
//         padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
//         color: kWhiteShadow,
//         child: Text('Preview',
//             style: TextStyle(
//                 fontFamily: "Segoe",
//                 fontSize: 15,
//                 color: kBaseColor,
//                 fontWeight: FontWeight.w700)),
//       ),
//     );

//     final saveAndPrint = Padding(
//       padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 90),
//       child: MaterialButton(
//         onPressed: () async {
//           var response = await apiServices.updateDoctorAppointmentStatus(
//             'accepted',
//             appointment['appoitmentID'],
//           );

//           var oEMap = generateOEMap();
//           var prescriptionInfoMap = generatePrescriptionInfoMap();
//           var returnMap = await prescriptionService.savePrescription(
//             generalAdviceEntry,
//             diagnosisAdviceEntry,
//             drugHistoryEntry,
//             oEMap,
//             ccEntry,
//             diseaseConditionEntry,
//             prescriptionInfoMap,
//             medicationList,
//             true,
//           );

//           final url = '${returnMap['pdfUrl']}';
//           final fileName = '${returnMap['prescriptionID']}';
//           final file = await PdfApi.loadNetwork(url, fileName);

//           Map<String, dynamic> conslutHistory = {};
//           conslutHistory['prescription'] = url;
//           conslutHistory['patientId'] = appointment['patiantID'];
//           conslutHistory['doctorId'] = appointment['doctorID'];
//           conslutHistory['memberId'] = appointment['memberID'];
//           conslutHistory['patientName'] = appointment['patientName'];
//           conslutHistory['bkashSenderNo'] = appointment['bkashSenderNo'];
//           conslutHistory['bmdcNo'] = bmdcNmuber;

//           await apiServices.saveConsultHistory(conslutHistory);

//           // saveConsultHistory;

//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => PdfViewPage(
//                 pdfFile: file,
//                 path: url,
//                 bmdcNo: bmdcNmuber,
//                 memberId: memberId,
//                 doctorId: doctorId,
//                 title: '${returnMap['prescriptionID']}',
//               ),
//             ),
//           );
//         },
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(25),
//         ),
//         padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
//         color: kWhiteShadow,
//         child: Text('Save and Print',
//             style: TextStyle(
//                 fontFamily: "Segoe",
//                 fontSize: 15,
//                 color: kBaseColor,
//                 fontWeight: FontWeight.w700)),
//       ),
//     );

//     final teleMedicine = Padding(
//       padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 90),
//       child: MaterialButton(
//         onPressed: () async {
//           var oEMap = generateOEMap();
//           var prescriptionInfoMap = generatePrescriptionInfoMap();
//           var returnMap = await prescriptionService.savePrescription(
//             generalAdviceEntry,
//             diagnosisAdviceEntry,
//             drugHistoryEntry,
//             oEMap,
//             ccEntry,
//             diseaseConditionEntry,
//             prescriptionInfoMap,
//             medicationList,
//             false,
//           );

//           final url = '${returnMap['pdfUrl']}';
//           final fileName = '${returnMap['prescriptionID']}';
//           await PdfApi.shareFile(url, fileName);

//           // openPDF(context, file);
//         },
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(25),
//         ),
//         padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
//         color: kWhiteShadow,
//         child: Text(
//           'Send to Patient',
//           style: TextStyle(
//             fontFamily: "Segoe",
//             fontSize: 15,
//             color: kBaseColor,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),
//     );

//     return Scaffold(
//       // drawer: CustomDrawerDoctor(),
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: kBaseColor,
//         iconTheme: IconThemeData(color: kTitleColor),
//         toolbarHeight: 50,
//         elevation: 2.0,
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.phone),
//           ),
//           IconButton(
//             onPressed: () async {
//               bool granted =
//                   await Permissions.checkCameraAndMicrophonePermissionGranted();
//               if (granted) {
//                 CallUtils.dial(
//                   from: doctor,
//                   to: patient,
//                   context: context,
//                   controller: callController,
//                 );
//               }
//             },
//             icon: Icon(Icons.videocam_rounded),
//           ),
//         ],
//         title: Text(
//           'Write Prescription',
//           style: TextStyle(
//             fontFamily: 'Segoe',
//             color: kTitleColor,
//           ),
//         ),
//       ),
//       backgroundColor: kBackgroundColor,
//       body: Center(
//         child: ListView(
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             Obx(
//               () => Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   callController.onGoingCall.value
//                       ? MaterialButton(
//                           onPressed: () {
//                             // Get.to(() => CallScreenDoctor(call: call, callController: callController, ),);
//                             Get.to(
//                               () => CallScreenDoctor(
//                                 callController: callController,
//                               ),
//                             );
//                           },
//                           child: Text('Back to Call'),
//                         )
//                       : Container(),
//                   !markedAsAccepted
//                       ? MaterialButton(
//                           minWidth: 150,
//                           onPressed: () async {
//                             var response =
//                                 await apiServices.updateDoctorAppointmentStatus(
//                               'accepted',
//                               appointment['appoitmentID'],
//                             );
//                             if (response) {
//                               setState(() {
//                                 markedAsAccepted = true;
//                               });
//                               widget.appointmentController.appoinments.clear();
//                               widget.appointmentController.queueAppointments
//                                   .clear();
//                               widget.appointmentController
//                                   .fetchDoctorAppoinments();
//                             }
//                           },
//                           child: Text(
//                             'Mark as Accepted',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           color: kBaseColor,
//                         )
//                       : Container(),
//                 ],
//               ),
//             ),
//             patientInfo,
//             diseaseCondition,
//             chiefComplaint,
//             oE,
//             history,
//             medication,
//             advises,
//             preview,
//             saveAndPrint,
//             teleMedicine,
//             SizedBox(
//               height: 50,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: unused_local_variable, unused_field

import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/call/call_utilities.dart';
import 'package:pro_health/call/controllers/doctor_call_controller.dart';
import 'package:pro_health/call/permissions.dart';
import 'package:pro_health/doctor/controllers/appointment_controller.dart';
import 'package:pro_health/doctor/controllers/prescription_controller2.dart';
import 'package:pro_health/doctor/models/district_model.dart';
import 'package:pro_health/doctor/models/medication_model.dart';
import 'package:pro_health/doctor/models/police_station_model.dart';
import 'package:pro_health/doctor/models/post_office_model.dart';
import 'package:pro_health/doctor/models/profile/doctor_profile_model.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/PdfViewPage.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/pdfApi.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/data.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/models/next_visit.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/prescriptionPage.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/service/prescription_service.dart';
import 'package:pro_health/patient/models/consult_history_patient.dart';
import 'package:pro_health/patient/models/patient_profile_model.dart';
import 'package:pro_health/patient/service/dashboard/api_patient.dart';
import 'package:pro_health/patient/service/dashboard/profile_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePrescription extends StatefulWidget {
  const CreatePrescription({
    Key? key,
    required this.appointment,
    required this.appointmentController,
  }) : super(key: key);
  final Map<String, dynamic> appointment;
  final AppointmentController appointmentController;
  @override
  _CreatePrescriptionState createState() =>
      _CreatePrescriptionState(appointment: this.appointment);
}

class _CreatePrescriptionState extends State<CreatePrescription> {
  _CreatePrescriptionState({required this.appointment});
  ApiServices apiServices = ApiServices();
  PatientProfileService patientProfileService = PatientProfileService();
  PatientApiService patientApiService = PatientApiService();
  final Map<String, dynamic> appointment;
  late PatientProfileModel patient;
  late DoctorProfileModel doctor;

  PrescriptionController prescriptionController =
      Get.put(PrescriptionController());

  DoctorCallController doctorCallController = DoctorCallController();

  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardD = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardE = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardF = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardG = new GlobalKey();

  final _formKey = GlobalKey<FormState>();

  PrescriptionService prescriptionService = PrescriptionService();

  late Directory documentDirectory;
  late String documentPath;

  bool before = false;
  bool after = false;
  bool markedAsAccepted = false;

  // patient information
  late String patientName = '';
  late String phoneNumber = '';
  late String gender = '';
  var age = '';
  var dateOfBirth = DateTime.now().toIso8601String();
  String selectedtGender = "Male";

  TextEditingController _ccController = TextEditingController();
  TextEditingController _diagnosisAdivceController = TextEditingController();
  TextEditingController _generalAdivceController = TextEditingController();
  TextEditingController _brandNameController = TextEditingController();
  TextEditingController _typeDoseController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  TextEditingController _ftController = TextEditingController();
  TextEditingController _inchController = TextEditingController();
  TextEditingController _bmiController = TextEditingController();
  TextEditingController _eddController = TextEditingController();
  TextEditingController _diseaseConditionController = TextEditingController();
  TextEditingController _spo2Controller = TextEditingController();
  TextEditingController _drugHistoryController = TextEditingController();
  TextEditingController _patientNameController = TextEditingController();
  TextEditingController _patientPhoneController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _visitNoController = TextEditingController();
  TextEditingController _compareBrandController = TextEditingController();
  // TextEditingController _brandNameController = TextEditingController();

  MedicationModel medicine = MedicationModel();

  int selectedGenericId = 0;

  bool beforeEating = false;
  bool afterEating = true;

  var bp;
  var height;
  var weight = 0.0;
  var bmi;
  var lmp;
  var edd;
  var pDose;
  var pulse;
  var spo2;
  var rr;
  var feet = 0;
  var inch = 0;
  var heightInM = 0.0;

  var drugAlergy;
  var foodAlergy;

  bool drugHistory = false;

  // disease condition.
  var disease = '';

  List<String> ccEntry = [];
  List<String> diseaseConditionEntry = [];
  List<String> spo2Entry = [];
  List<String> diagnosisAdviceEntry = [];
  List<String> drugHistoryEntry = [];

  List<String> generalAdviceEntry = [];
  List<String> medicineEntry = [];
  List<String> spo2List = [];

  List medicationList = [];

  final brand = <Brand>[
    Brand('Fenuc Plus', ''),
    Brand('Mycin', ''),
    Brand('5-Fluril', ''),
    Brand('A-Clox', ''),
    Brand('Geocef', '')
  ];
  Brand? selectedBrand;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final format = DateFormat("dd-MM-yyyy");

  String? generatedPdfFilePath;
  String? fullPath;

  File? generatedPdfFile;

  List<DistrictModel> districts = [];
  List<PoliceStationModel> policestations = [];
  List<PostOfficeModel> postOffices = [];
  // List<DoctorModel> referredByDoctors = [];
  List<NextVisitModel> nextVisits = [];

  List<String> medicineString = [];
  static List doctorAppointments = [];

  var selectedDrugAlergy = 'Unknown';
  var selectedFoodAlergy = 'Unknown';
  var selectedDrugHistory = 'Unknown';
  var selectedFamilyHistory = 'Yes';
  var selectedMedicalHistory = 'Yes';

  var selectedDistrict = '';
  var selectedPoliceStation = '';
  var selectedPostOffice = '';
  var selectedDistrictId;
  var selectedPoliceStationId;
  var selectedPostOfficeId;
  late String patientEmail;
  var currentDate;

  var selectedNextVisit = 'Select';

  var referredByName = '';

  var nextVisitText = '';
  var paidTakaText = '';
  var visitNoText = '';

  var selectedSpo2;

  String brandName = '';
  String genericName = '';
  String medicineCategory = '';
  String medicineGroup = '';
  String companyName = '';
  String price = '';
  // var fdaApproved;
  bool fdaApproved = false;
  bool openCompareCard = false;

  var patientId = 0;

  getDate(String dateTime) {
    // var dateTime = '2021-08-08T13:05:00';
    var date = DateTime.parse(dateTime);
    var year = date.year;
    var month = date.month;
    var day = date.day;
    var newMonth = month < 10 ? '0$month' : '$month';
    var newDay = day < 10 ? '0$day' : '$day';
    var newDate = '$year-$newMonth-$newDay'; //'$newDay-$newMonth-$year';
    return newDate;
  }

  generateOEMap() {
    Map<String, dynamic> oeMap = {};
    oeMap['bp'] = bp;
    oeMap['height'] = heightInM.toStringAsFixed(2);
    oeMap['weight'] = weight.toString();
    oeMap['bmi'] = bmi.toString();
    oeMap['lmp'] = lmp == null ? null : lmp.toIso8601String();
    oeMap['edd'] = edd;
    oeMap['pDose'] = pDose;
    oeMap['pulse'] = pulse;
    oeMap['spo2'] = selectedSpo2;
    oeMap['rr'] = rr;
    return oeMap;
  }

  fetchNextVisits() async {
    var response = await apiServices.fetchNextVisits();
    setState(() {
      nextVisits.add(NextVisitModel.fromJson({
        "id": 0,
        "memberID": 0,
        "details": "Select",
      }));

      nextVisits.addAll(response);
    });
  }

  generatePrescriptionInfoMap() {
    Map<String, dynamic> prescriptionInfoMap = {};

    prescriptionInfoMap['memberId'] = memberId;
    prescriptionInfoMap['doctorID'] = doctorId;
    prescriptionInfoMap['bmdcNo'] = bmdcNmuber;
    prescriptionInfoMap['patientID'] = appointment['patiantID']; // patientId;
    prescriptionInfoMap['drugAllergy'] = selectedDrugAlergy;
    prescriptionInfoMap['foodAllergy'] = selectedFoodAlergy;
    prescriptionInfoMap['createOn'] = DateTime.now();
    prescriptionInfoMap['patientName'] = _patientNameController.text;
    prescriptionInfoMap['age'] = age;
    prescriptionInfoMap['dist'] = selectedDistrict;
    prescriptionInfoMap['postOffice'] = selectedPostOffice;
    prescriptionInfoMap['currentDate'] = DateTime.parse(currentDate);
    prescriptionInfoMap['mobileNo'] = phoneNumber;
    prescriptionInfoMap['gender'] = selectedtGender;
    prescriptionInfoMap['referenceBy'] = referredByName;
    prescriptionInfoMap['thana'] = selectedPoliceStation;

    prescriptionInfoMap['nextVisit'] = selectedNextVisit;
    prescriptionInfoMap['paidTaka'] = paidTakaText;
    prescriptionInfoMap['visitNo'] = visitNoText;

    return prescriptionInfoMap;
  }

  calcultateEDD(DateTime lmpDate) {
    var month = lmpDate.month;
    var day = lmpDate.day;
    var year = lmpDate.year;

    if (month > 0 && month < 4) {
      // jan to mar
      var newMonth = month + 12;
      newMonth = newMonth - 3;
      var newDay = day + 7;
      if (newDay > 30) {
        newMonth = newMonth + 1;
        newDay = newDay - 30;
      }
      var newDay2 = newDay < 10 ? '0$newDay' : '$newDay';
      var newMonth2 = newMonth < 10 ? '0$newMonth' : '$newMonth';
      setState(() {
        edd = '$newDay2-$newMonth2-$year';
        _eddController.text = '$newDay2-$newMonth2-$year';
      });
    } else if (month >= 4 && month <= 12) {
      // april to december
      var newMonth = month - 3;
      var newDay = day + 7;

      var newYear = year + 1;

      if (newDay > 30) {
        newMonth = newMonth + 1;
        newDay = newDay - 30;
      }
      var newDay2 = newDay < 10 ? '0$newDay' : '$newDay';
      var newMonth2 = newMonth < 10 ? '0$newMonth' : '$newMonth';
      setState(() {
        edd = '$newDay2-$newMonth2-$newYear';
        _eddController.text = '$newDay2-$newMonth2-$newYear';
      });
    }
  }

  fetchDoctorAppointments() async {
    var response = await apiServices.fetchAccedptedAppoinments(memberId);

    setState(() {
      doctorAppointments.addAll(response);
    });
  }

  // static Future<List<String>> getNamesSuggestion(String query) async {
  //   List<String> names = [];
  //   for (var patient in doctorAppointments) {
  //     if (patient['patientName'] != null || patient['patientName'].isNotEmpty) {
  //       names.add(patient['patientName']);
  //     }
  //   }

  //   return List.of(names).where((name) {
  //     final nameLower = name.toLowerCase();
  //     final queryLower = query.toLowerCase();
  //     return nameLower.contains(queryLower);
  //   }).toList();
  // }

  fetchDistricts() async {
    if (districts.length > 0) {
      districts.clear();
    }
    var response = await apiServices.fetchDistricts();
    setState(() {
      districts.addAll(response);
      selectedDistrict = districts[0].districtName;
    });
  }

  saveMedicine() {
    var brandName = _brandNameController.text;
    var dose = _typeDoseController.text;
    var duration = _durationController.text;
    var eatingTime = beforeEating ? 'Before Meal' : 'After Meal';

    if (brandName.isNotEmpty &&
        dose.isNotEmpty &&
        duration.isNotEmpty &&
        eatingTime.isNotEmpty) {
      Map medicineMap = Map();
      medicineMap['BrandName'] = brandName;
      medicineMap['Dose'] = dose;
      medicineMap['Duration'] = duration;
      medicineMap['EatingTime'] = eatingTime;
      medicineMap['MedicineCategory'] = medicine.medicineCategory ?? '';
      medicineMap['MedicineGroup'] = medicine.medicineGroup ?? '';
      medicineMap['CompanyName'] = medicine.companyName ?? '';
      medicineMap['Price'] = medicine.price ?? '0.0';
      medicineMap['FDAApproved'] = medicine.fdaApproved;
      medicineMap['CompanyID'] = medicine.companyId ?? 0;
      medicineMap['BrandId'] = medicine.brandId ?? 0;
      medicineMap['GenericID'] = medicine.genericId ?? 0;
      medicineMap['BeforeMeal'] = beforeEating;
      medicineMap['AfterMeal'] = afterEating;

      setState(() {
        medicationList.add(medicineMap);
        medicineString.add("$brandName \n$dose ($eatingTime) $duration ");
      });

      _brandNameController.clear();
      _typeDoseController.clear();
      _durationController.clear();
      setState(() {
        brandName = '';
        genericName = '';
        medicineCategory = '';
        companyName = '';
        price = '';
        fdaApproved = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please provide brand name, dose type, duration and Medicine taking time',
          ),
        ),
      );
    }
  }

  fetchPoliceStations(var districtId) async {
    if (policestations.isNotEmpty) {
      policestations.clear();
    }
    var response = await apiServices.fetchPoliceStations(districtId);
    setState(() {
      policestations.addAll(response);
    });
    if (policestations.isNotEmpty) {
      selectedPoliceStation = policestations[0].policeStationName;
    }
  }

  fetchPostOffices(var policeStationId) async {
    if (postOffices.isNotEmpty) {
      postOffices.clear();
    }
    var response = await apiServices.fetchPostOffices(policeStationId);

    setState(() {
      postOffices.addAll(response);
    });
    if (postOffices.isNotEmpty) {
      selectedPostOffice = postOffices[0].postOfficeName;
    }
  }

  // doctor profile information

  var memberId;
  var doctorId;
  var bmdcNmuber;
  var doctorProfile = [];
  var doctorNameBangla = '';
  var doctorNameEnglish = '';
  var doctorDegree1English = '';
  var doctorDegree2English = '';
  var doctorDesignation1English = '';
  var doctorDesignation2English = '';
  var doctorWorkplace1English = '';
  var doctorDegree1Bangla = '';
  var doctorDegree2Bangla = '';
  var doctorDesignation1Bangla = '';
  var doctorDesignation2Bangla = '';
  var doctorWorkplace1Bangla = '';

  var chamber1Bangla = '';
  var chamber1ConsultDayBangla = '';
  var chamber1ConsultTimeBangla = '';
  var chamberOneAddress;
  var chamberTwoAddress;
  var chamberOneConsultDay;
  var chamberTwoConsultDay;
  var chamberOneAddressBangla;
  var chamberTwoAddressBangla;
  var chamberOneConsultDayBangla;
  var chamberTwoConsultDayBangla;
  var chamberOneConsultStartTime;
  var chamberTwoConsultStartTime;
  var chamberOneConsultStartTimeBangla;
  var chamberTwoConsultStartTimeBangla;
  var chamberOneConsultEndTimeBangla;
  var chamberTwoConsultEndTimeBangla;
  var chamberOneConsultEndTime;
  var chamberTwoConsultEndTime;
  var chamberOneConsultTimeBangla;
  var chamberTwoConsultTimeBangla;

  var startTime;
  var endtime;

  fetchDoctorProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    memberId = prefs.getInt('doctorMemberId');
    var response = await apiServices.fetchDoctorProfile(memberId);

    setState(() {
      doctorProfile.addAll(response);
    });
    if (doctorProfile.length > 0) {
      setState(() {
        doctorId = doctorProfile[0]['doctorID'] ?? '';
        bmdcNmuber = doctorProfile[0]['bmdcNmuber'] ?? '';
        doctorNameEnglish = doctorProfile[0]['doctorName'] ?? '';
        doctorDegree1English = doctorProfile[0]['qualificationOne'] ?? '';
        doctorDegree2English = doctorProfile[0]['qualificationTwo'] ?? '';
        doctorDesignation1English = doctorProfile[0]['designationOne'] ?? '';
        doctorDesignation2English = doctorProfile[0]['designationTwo'] ?? '';
        doctorWorkplace1English = doctorProfile[0]['workingPlace'] ?? '';
        doctorNameBangla = doctorProfile[0]['doctorNameBangla'] ?? '';
        doctorDegree1Bangla = doctorProfile[0]['qualificationOneBangla'] ?? '';
        doctorDegree2Bangla = doctorProfile[0]['qualificationTwoBangla'] ?? '';
        doctorDesignation1Bangla =
            doctorProfile[0]['designationOneBangla'] ?? '';
        doctorDesignation2Bangla =
            doctorProfile[0]['designationTwoBangla'] ?? '';
        doctorWorkplace1Bangla = doctorProfile[0]['workingPlaceBangla'] ?? '';

        chamberOneAddress = doctorProfile[0]['chamberOneAddress'] ?? '';
        chamberTwoAddress = doctorProfile[0]['chamberTwoAddress'] ?? '';
        chamberOneConsultDay = doctorProfile[0]['chamberOneConsultDay'] ?? '';
        chamberTwoConsultDay = doctorProfile[0]['chamberTwoConsultDay'] ?? '';
        chamberTwoConsultDay = doctorProfile[0]['chamberTwoConsultDay'] ?? '';
        chamberOneAddressBangla =
            doctorProfile[0]['chamberOneAddressBangla'] ?? '';
        chamberTwoAddressBangla =
            doctorProfile[0]['chamberTwoAddressBangla'] ?? '';
        chamberOneConsultDayBangla =
            doctorProfile[0]['chamberOneConsultDayBangla'] ?? '';
        chamberTwoConsultDayBangla =
            doctorProfile[0]['chamberTwoConsultDayBangla'] ?? '';
        chamber1ConsultDayBangla = doctorProfile[0]['consultationDay'] ?? '';
        chamberOneConsultStartTime =
            getTime(doctorProfile[0]['chamberOneConsultStartTime']);
        chamberTwoConsultStartTime =
            getTime(doctorProfile[0]['chamberTwoConsultStartTime']);
        chamberOneConsultStartTimeBangla =
            doctorProfile[0]['chamberOneConsultStartTimeBangla'];
        chamberTwoConsultStartTimeBangla =
            doctorProfile[0]['chamberTwoConsultStartTimeBangla'];
        chamberOneConsultEndTimeBangla =
            doctorProfile[0]['chamberOneConsultEndTimeBangla'];
        chamberTwoConsultEndTimeBangla =
            doctorProfile[0]['chamberTwoConsultEndTimeBangla'];
        chamberOneConsultEndTime =
            getTime(doctorProfile[0]['chamberOneConsultEndTime']);
        chamberTwoConsultEndTime =
            getTime(doctorProfile[0]['chamberTwoConsultEndTime']);
        chamberOneConsultTimeBangla =
            '$chamberOneConsultStartTimeBangla - $chamberOneConsultEndTimeBangla';
        chamberTwoConsultTimeBangla =
            '$chamberTwoConsultStartTimeBangla - $chamberTwoConsultEndTimeBangla';
      });
    }
    fetchDoctorAppointments();
  }

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

  getSpo2List() {
    setState(() {
      spo2List = DataList().spo2PercentList;
    });
    if (spo2List.isNotEmpty) {
      setState(() {
        selectedSpo2 = spo2List[0];
      });
    }
  }

  setPatientInformation() async {
    var response = await patientProfileService.getPatientProfileInfo(patientId);
    setState(() {
      patient = response;
      patientName = appointment['patientName'];
      _patientNameController.text = appointment['patientName'];
      phoneNumber = patient.mobile ?? '';
      _patientPhoneController.text = patient.mobile ?? '';
      age = getAge(patient.dateOfBirth ?? '');
      _ageController.text = age;
    });

    List<ConsultHistoryPatientModel> consultHistory =
        await patientApiService.fetchConsultHistoryPatient(patientId);
    setState(() {
      visitNoText = (consultHistory.length + 1).toString();
      _visitNoController.text = visitNoText;
    });
  }

  getDoctor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    memberId = prefs.getInt('doctorMemberId');
    var response = await apiServices.getDoctorProfile(memberId);
    if (response.isNotEmpty) {
      doctor = response[0];
    }
  }

  @override
  void initState() {
    getDoctor();
    patientId = appointment['patiantID'];
    setPatientInformation();
    fetchDoctorProfile();

    _ftController.text = '0';
    _inchController.text = '0';

    fetchDistricts();
    currentDate = getDate(DateTime.now().toIso8601String());
    getSpo2List();
    fetchNextVisits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final patientInfo = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            ExpansionTileCard(
              baseColor: kBackgroundColor,
              key: cardA,
              leading: CircleAvatar(
                backgroundColor: kShadowColor,
                radius: 25,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 23.0,
                  child: Image.asset('assets/icons/doctor/patientinfo.png'),
                ),
              ),
              title: Text(
                'Patient Information',
                style: TextStyle(
                    fontFamily: 'Segoe',
                    color: kBaseColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                // ListTile(
                //   title: Container(
                //     child: TypeAheadField<String?>(
                //       textFieldConfiguration: TextFieldConfiguration(
                //         controller: _patientNameController,
                //         decoration: InputDecoration(
                //           labelText: 'Patient Name',
                //           hintText: "type or search",
                //           contentPadding:
                //               EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(32.0),
                //           ),
                //         ),
                //       ),
                //       debounceDuration: Duration(milliseconds: 500),
                //       suggestionsCallback: getNamesSuggestion,
                //       itemBuilder: (context, String? suggestion) => ListTile(
                //         title: Text(suggestion!),
                //       ),
                //       onSuggestionSelected: (String? suggestion) {
                //         _patientNameController.text = suggestion!;
                //         patientName = suggestion;
                //         for (var item in doctorAppointments) {
                //           if (item['patientName'] == suggestion) {
                //             patientId = item['patiantID'];
                //           }
                //         }
                //       },
                //     ),
                //   ),
                // ),
                ListTile(
                  title: new TextFormField(
                      controller: _patientNameController,
                      decoration: new InputDecoration(
                        labelText: "Patient Name",
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                      onChanged: (val) => setState(() =>
                          patientName = val) // (val) => phoneNumber = val,
                      ),
                ),
                ListTile(
                  title: new TextFormField(
                    controller: _patientPhoneController,
                    decoration: new InputDecoration(
                      labelText: "Mobile Number",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                    enabled: false,
                    // onChanged: (val) => setState(() =>
                    //     phoneNumber = val) // (val) => phoneNumber = val,
                  ),
                ),
                ListTile(
                  title: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(width: 1, color: Color(0xFFA4A4A4)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedtGender,
                        // underline: ,
                        items: <String>['Male', 'Female'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (val) {
                          print(val);
                          setState(() {
                            selectedtGender = val!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: new TextFormField(
                    controller: _ageController,
                    decoration: new InputDecoration(
                      labelText: "Age",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                    onChanged: (val) => setState(() => age = val),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Address',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
                const Divider(
                  height: 4.0,
                  color: kTextLightColor,
                ),
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('District'),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          border:
                              Border.all(width: 1, color: Color(0xFFA4A4A4)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedDistrict,
                            isExpanded: true,
                            elevation: 16,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedDistrict = newValue!;
                              });
                              for (var item in districts) {
                                if (item.districtName == newValue) {
                                  setState(() {
                                    selectedDistrictId = item.districtID;
                                  });
                                }
                              }

                              fetchPoliceStations(
                                  selectedDistrictId.toString());
                              fetchPostOffices('0');
                            },
                            items: districts.map((DistrictModel data) {
                              return DropdownMenuItem(
                                value: data.districtName,
                                child: Text(
                                  data.districtName,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Thana'),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          border:
                              Border.all(width: 1, color: Color(0xFFA4A4A4)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedPoliceStation,
                            isExpanded: true,
                            elevation: 16,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedPoliceStation = newValue!;
                              });
                              for (var item in policestations) {
                                if (item.policeStationName == newValue) {
                                  setState(() {
                                    selectedPoliceStationId =
                                        item.policeStationID;
                                  });
                                }
                              }
                              fetchPostOffices(
                                  selectedPoliceStationId.toString());
                            },
                            items:
                                policestations.map((PoliceStationModel data) {
                              return DropdownMenuItem(
                                value: data.policeStationName,
                                child: Text(
                                  data.policeStationName,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Post Office'),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          border:
                              Border.all(width: 1, color: Color(0xFFA4A4A4)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedPostOffice,
                            isExpanded: true,
                            elevation: 16,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedPostOffice = newValue!;
                              });
                              for (var item in postOffices) {
                                if (item.postOfficeName == newValue) {
                                  setState(() {
                                    selectedPostOfficeId = item.postOfficeId;
                                  });
                                }
                              }
                            },
                            items: postOffices.map((PostOfficeModel data) {
                              return DropdownMenuItem(
                                value: data.postOfficeName,
                                child: Text(
                                  data.postOfficeName,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 10.0,
                ),
                ListTile(
                  title: DateTimeField(
                    initialValue: DateTime.parse(currentDate),
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
                        currentDate = val!.toIso8601String();
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Current Date",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                ),
                ListTile(
                  title: new TextFormField(
                    initialValue: referredByName,
                    decoration: new InputDecoration(
                      labelText: "Referred By",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                    onChanged: (val) => setState(() => referredByName = val),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );

    final diseaseCondition = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ExpansionTileCard(
        baseColor: kBackgroundColor,
        key: cardB,
        leading: CircleAvatar(
          backgroundColor: kShadowColor,
          radius: 25,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 23.0,
            child: Image.asset('assets/icons/doctor/diseasecondition.png'),
          ),
        ),
        title: Text(
          'Disease Condition',
          style: TextStyle(
              fontFamily: 'Segoe',
              color: kBaseColor,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        children: <Widget>[
          ListTile(
            title: Container(
              child: TypeAheadField<String?>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _diseaseConditionController,
                  decoration: new InputDecoration(
                    labelText: "Disease Condition",
                    hintText: "type or search",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (_diseaseConditionController.text.isNotEmpty) {
                          if (!diseaseConditionEntry
                              .contains(_diseaseConditionController.text)) {
                            setState(() {
                              diseaseConditionEntry
                                  .add(_diseaseConditionController.text);
                            });
                            // insert disease condition to database here
                            PrescriptionService.saveDiseaseConditionToDB(
                                _diseaseConditionController.text, memberId);
                            _diseaseConditionController.clear();
                          }
                        }
                      },
                      icon: Icon(Icons.add),
                    ),
                  ),
                ),
                debounceDuration: Duration(milliseconds: 500),
                suggestionsCallback:
                    PrescriptionService.getDiseaseConditionSuggestions,
                itemBuilder: (context, String? suggestion) => ListTile(
                  title: Text(suggestion!),
                ),
                onSuggestionSelected: (String? suggestion) {
                  _diseaseConditionController.text = suggestion!;
                },
              ),
            ),
          ),
          diseaseConditionEntry.length > 0
              ? ListTile(
                  title: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: diseaseConditionEntry.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                            '${index + 1}) ${diseaseConditionEntry[index]}');
                      }))
              : Container(),
        ],
      ),
    );
    final chiefComplaint = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ExpansionTileCard(
        baseColor: kBackgroundColor,
        key: cardC,
        leading: CircleAvatar(
          backgroundColor: kShadowColor,
          radius: 25,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 23.0,
            child: Image.asset('assets/icons/doctor/cc.png'),
          ),
        ),
        title: Text(
          'C/C',
          style: TextStyle(
              fontFamily: 'Segoe',
              color: kBaseColor,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        children: <Widget>[
          ListTile(
            title: Container(
              child: TypeAheadField<String?>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _ccController,
                  decoration: new InputDecoration(
                    hintText: "type or search",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (_ccController.text.isNotEmpty) {
                          if (!ccEntry.contains(_ccController.text)) {
                            setState(() {
                              ccEntry.add(_ccController.text);
                            });
                            PrescriptionService.saveCCToDB(
                                _ccController.text, doctorId, memberId);
                            _ccController.clear();
                          }
                        }
                      },
                      icon: Icon(Icons.add),
                    ),
                  ),
                ),
                debounceDuration: Duration(milliseconds: 500),
                suggestionsCallback: PrescriptionService.getCCSuggestions,
                itemBuilder: (context, String? suggestion) => ListTile(
                  title: Text(suggestion!),
                ),
                onSuggestionSelected: (String? suggestion) {
                  _ccController.text = suggestion!;
                },
              ),
            ),
          ),
          ccEntry.length > 0
              ? ListTile(
                  title: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: ccEntry.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text('${index + 1}) ${ccEntry[index]}');
                      }))
              : Container(),
        ],
      ),
    );

    final oE = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ExpansionTileCard(
        baseColor: kBackgroundColor,
        key: cardD,
        leading: CircleAvatar(
          backgroundColor: kShadowColor,
          radius: 25,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 23.0,
            child: Image.asset('assets/icons/doctor/oe.png'),
          ),
        ),
        title: Text(
          'O/E',
          style: TextStyle(
              fontFamily: 'Segoe',
              color: kBaseColor,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        children: <Widget>[
          ListTile(
            title: Column(
              children: [
                Row(
                  children: [
                    Text('Height'),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 40,
                      child: TextFormField(
                        initialValue: height,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        decoration: new InputDecoration(
                          hintText: "Feet",
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            if (int.parse(val) <= 10) {
                              setState(() => feet = int.parse(val));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'feet value can not be more than 10 feet'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 80,
                      height: 40,
                      child: TextFormField(
                        initialValue: height,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        decoration: new InputDecoration(
                          hintText: "Inch",
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            if (int.parse(val) < 12) {
                              setState(() => inch = int.parse(val));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'inch value can not be more than 11 inch'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 100,
                      height: 40,
                      child: Row(
                        children: [
                          Text('$feet ft $inch inch'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),

          ListTile(
            title: Column(
              children: [
                Row(
                  children: [
                    Text('Weight'),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        decoration: new InputDecoration(
                          hintText: "kg",
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            if (double.parse(val) > 0) {
                              setState(() => weight = double.parse(val));
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                MaterialButton(
                  onPressed: () {
                    if (feet == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Feet value is required'),
                        ),
                      );
                    } else if (weight == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Weight can not be empty or zero'),
                        ),
                      );
                    } else {
                      heightInM =
                          ((feet * 12) + inch) * 0.0254; // 1 inch = 0.0254m
                      var calculatedBMI =
                          (weight / (heightInM * heightInM)).toStringAsFixed(2);

                      setState(() {
                        bmi = calculatedBMI;
                        _bmiController.text = calculatedBMI;
                      });
                    }
                  },
                  child: Text(
                    'Calculate BMI',
                    style: TextStyle(
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),

          ListTile(
            title: new TextFormField(
              controller: _bmiController,
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: new InputDecoration(
                labelText: "BMI",
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              // onChanged: (val) => setState(() => bmi = val),
            ),
          ),
          ListTile(
            title: new TextFormField(
              initialValue: bp,
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: new InputDecoration(
                labelText: "BP",
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              onChanged: (val) => setState(() => bp = val),
            ),
          ),

          ListTile(
            title: DateTimeField(
              format: format,
              initialValue: lmp != null ? lmp : null,
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));

                if (date != null) {
                  setState(() {
                    lmp = date;
                  });
                  calcultateEDD(lmp);

                  return date;
                }
              },
              decoration: InputDecoration(
                labelText: "LMP",
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
          ListTile(
            title: new TextFormField(
              controller: _eddController,
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: new InputDecoration(
                labelText: 'EDD',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              // onChanged: (val) => setState(() => edd = val),
            ),
          ),
          ListTile(
            title: new TextFormField(
              keyboardType: TextInputType.text,
              initialValue: pDose,
              autofocus: false,
              decoration: new InputDecoration(
                labelText: 'P.dose',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              onChanged: (val) => setState(() => pDose = val),
            ),
          ),
          ListTile(
            title: new TextFormField(
              keyboardType: TextInputType.text,
              autofocus: false,
              initialValue: pulse,
              decoration: new InputDecoration(
                labelText: "Pulse",
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              onChanged: (val) => setState(() => pulse = val),
            ),
          ),

          // spo2 here

          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('spo2'),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(width: 1, color: Color(0xFFA4A4A4)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text("Select item"),
                      value: selectedSpo2,

                      // underline: ,
                      items: spo2List.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedSpo2 = val!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: new TextFormField(
              keyboardType: TextInputType.text,
              initialValue: rr,
              autofocus: false,
              decoration: new InputDecoration(
                hintText: "R/R",
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              onChanged: (val) => setState(() => rr = val),
            ),
          ),
          ExpansionTileCard(
            baseColor: kBackgroundColor,
            title: Text(
              'Allergy (Select Type)',
              style: TextStyle(
                  fontFamily: 'Segoe',
                  color: kBaseColor,
                  fontWeight: FontWeight.w700),
            ),
            contentPadding: EdgeInsets.fromLTRB(28.0, 10.0, 20.0, 10.0),
            borderRadius: BorderRadius.circular(50.0),
            children: [
              ListTile(
                title: new DropdownButtonFormField(
                  //value: selectedDrugAlergy,
                  decoration: new InputDecoration(
                    hintText: "Drug",
                    contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                  items: <DropdownMenuItem>[
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text("Unknown"),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text("Known"),
                    ),
                  ],
                  onChanged: (dynamic val) {
                    if (val == 1) {
                      setState(() {
                        selectedDrugAlergy = 'Unknown';
                      });
                    } else {
                      setState(() {
                        selectedDrugAlergy = 'Known';
                      });
                    }
                  },
                ),
              ),
              ListTile(
                title: new DropdownButtonFormField(
                  // value: selectedFoodAlergy,
                  decoration: new InputDecoration(
                    hintText: "Food",
                    contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                  items: <DropdownMenuItem>[
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text("Unknown"),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text("Known"),
                    ),
                  ],
                  onChanged: (dynamic val) {
                    if (val == 1) {
                      setState(() {
                        selectedFoodAlergy = 'Unknown';
                      });
                    } else {
                      setState(() {
                        selectedFoodAlergy = 'Known';
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final history = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ExpansionTileCard(
        baseColor: kBackgroundColor,
        key: cardE,
        leading: CircleAvatar(
          backgroundColor: kShadowColor,
          radius: 25,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 23.0,
            child: Image.asset('assets/icons/doctor/history.png'),
          ),
        ),
        title: Text(
          'History',
          style: TextStyle(
              fontFamily: 'Segoe',
              color: kBaseColor,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        children: <Widget>[
          ListTile(
            title: new DropdownButtonFormField(
              decoration: new InputDecoration(
                hintText: "Drug",
                contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              items: <DropdownMenuItem>[
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text("Unknown"),
                ),
                DropdownMenuItem<int>(
                  value: 2,
                  child: Text("Known"),
                ),
              ],
              onChanged: (dynamic val) {
                if (val == 1) {
                  setState(() {
                    selectedDrugHistory = "Unknown";
                    drugHistory = false;
                  });
                } else {
                  setState(() {
                    selectedDrugHistory = "Known";
                    drugHistory = true;
                  });
                }
              },
            ),
          ),
          drugHistory
              ? ListTile(
                  title: Container(
                    child: TypeAheadField<String?>(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _drugHistoryController,
                        decoration: new InputDecoration(
                          labelText: 'Drug History',
                          hintText: "type or search",
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              if (_drugHistoryController.text.isNotEmpty) {
                                if (!drugHistoryEntry
                                    .contains(_drugHistoryController.text)) {
                                  setState(() {
                                    drugHistoryEntry
                                        .add(_drugHistoryController.text);
                                  });
                                  PrescriptionService.saveHistoryToDB(
                                    memberId,
                                    'drug',
                                    'known',
                                    _drugHistoryController.text,
                                    DateTime.now().toIso8601String(),
                                  );

                                  _drugHistoryController.clear();
                                }
                              }
                            },
                            icon: Icon(Icons.add),
                          ),
                        ),
                      ),
                      debounceDuration: Duration(milliseconds: 500),
                      suggestionsCallback:
                          PrescriptionService.getDrugHistorySuggestions,
                      itemBuilder: (context, String? suggestion) => ListTile(
                        title: Text(suggestion!),
                      ),
                      onSuggestionSelected: (String? suggestion) {
                        _drugHistoryController.text = suggestion!;
                      },
                    ),
                  ),
                )
              : Container(),
          drugHistoryEntry.isNotEmpty && drugHistory
              ? ListTile(
                  title: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: drugHistoryEntry.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text('${index + 1}) ${drugHistoryEntry[index]}');
                      }))
              : Container(),
          ListTile(
            title: new DropdownButtonFormField(
              decoration: new InputDecoration(
                hintText: "Family",
                contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              items: <DropdownMenuItem>[
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text("Yes"),
                ),
                DropdownMenuItem<int>(
                  value: 2,
                  child: Text("No"),
                ),
              ],
              onChanged: (dynamic val) {
                if (val == 1) {
                  setState(() {
                    selectedFamilyHistory = "Unknown";
                  });
                } else {
                  setState(() {
                    selectedFamilyHistory = "Known";
                  });
                }
              },
            ),
          ),
          ListTile(
            title: new DropdownButtonFormField(
              decoration: new InputDecoration(
                hintText: "Medical",
                contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              items: <DropdownMenuItem>[
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text("Yes"),
                ),
                DropdownMenuItem<int>(
                  value: 2,
                  child: Text("No"),
                ),
              ],
              onChanged: (dynamic val) {
                if (val == 1) {
                  setState(() {
                    selectedMedicalHistory = "Unknown";
                  });
                } else {
                  setState(() {
                    selectedMedicalHistory = "Known";
                  });
                }
              },
            ),
          ),
        ],
      ),
    );

    final medication = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ExpansionTileCard(
        baseColor: kBackgroundColor,
        key: cardF,
        leading: CircleAvatar(
          backgroundColor: kShadowColor,
          radius: 25,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 23.0,
            child: Image.asset('assets/icons/doctor/medication.png'),
          ),
        ),
        title: Text(
          'Medication',
          style: TextStyle(
              fontFamily: 'Segoe',
              color: kBaseColor,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        children: <Widget>[
          // ListTile(
          //   title: Card(
          //     borderOnForeground: true,
          //     color: kWhiteShadow,
          //     elevation: 4,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     child: Column(
          //       children: [
          //         Row(
          //           children: [
          //             Container(
          //               child: Padding(
          //                 padding: EdgeInsets.only(
          //                     left: 12.0, top: 10.0, right: 0.0, bottom: 5.0),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       'Brand Name',
          //                       textAlign: TextAlign.center,
          //                       style: TextStyle(
          //                           fontFamily: 'Segoe',
          //                           fontSize: 18.0,
          //                           color: kBaseColor,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                     Text('$brandName ',
          //                         textAlign: TextAlign.center,
          //                         style: TextStyle(
          //                           fontFamily: 'Segoe',
          //                           fontSize: 15.0,
          //                           color: kBaseColor,
          //                           fontWeight: FontWeight.w600,
          //                         ),
          //                         overflow: TextOverflow.ellipsis),
          //                   ],
          //                 ),
          //               ),
          //             ),
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
          //                     left: 12.0, top: 10.0, right: 0.0, bottom: 5.0),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       'Medicine Category',
          //                       textAlign: TextAlign.center,
          //                       style: TextStyle(
          //                           fontFamily: 'Segoe',
          //                           fontSize: 18.0,
          //                           color: kBaseColor,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                     Text(
          //                       '$medicineCategory',
          //                       textAlign: TextAlign.center,
          //                       style: TextStyle(
          //                           fontFamily: 'Segoe',
          //                           fontSize: 18.0,
          //                           color: kBaseColor,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
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
          //                     left: 12.0, top: 10.0, right: 0.0, bottom: 5.0),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       'Group',
          //                       textAlign: TextAlign.center,
          //                       style: TextStyle(
          //                           fontFamily: 'Segoe',
          //                           fontSize: 18.0,
          //                           color: kBaseColor,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                     Text(
          //                       '$medicineGroup',
          //                       textAlign: TextAlign.center,
          //                       style: TextStyle(
          //                           fontFamily: 'Segoe',
          //                           fontSize: 18.0,
          //                           color: kBaseColor,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //         Row(
          //           children: [
          //             Container(
          //               child: Padding(
          //                 padding: EdgeInsets.only(
          //                     left: 12.0, top: 10.0, right: 0.0, bottom: 5.0),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       'Company Name',
          //                       textAlign: TextAlign.center,
          //                       style: TextStyle(
          //                           fontFamily: 'Segoe',
          //                           fontSize: 18.0,
          //                           color: kBaseColor,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                     Text(
          //                       '$companyName',
          //                       textAlign: TextAlign.center,
          //                       style: TextStyle(
          //                           fontFamily: 'Segoe',
          //                           fontSize: 18.0,
          //                           color: kBaseColor,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             Container(
          //                 height: 30,
          //                 child: VerticalDivider(
          //                   color: Colors.black54,
          //                   thickness: 0.8,
          //                 )),
          //             Container(
          //               child: Padding(
          //                 padding: EdgeInsets.only(
          //                     left: 12.0, top: 10.0, right: 0.0, bottom: 5.0),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       'Price',
          //                       textAlign: TextAlign.center,
          //                       style: TextStyle(
          //                           fontFamily: 'Segoe',
          //                           fontSize: 18.0,
          //                           color: kBaseColor,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                     Text(
          //                       '$price',
          //                       textAlign: TextAlign.center,
          //                       style: TextStyle(
          //                           fontFamily: 'Segoe',
          //                           fontSize: 18.0,
          //                           color: kBaseColor,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             Container(
          //                 height: 30,
          //                 child: VerticalDivider(
          //                   color: Colors.black54,
          //                   thickness: 0.8,
          //                 )),
          //             Container(
          //               child: Padding(
          //                 padding: EdgeInsets.only(
          //                     left: 12.0, top: 10.0, right: 0.0, bottom: 5.0),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       'FDA Approved',
          //                       textAlign: TextAlign.center,
          //                       style: TextStyle(
          //                           fontFamily: 'Segoe',
          //                           fontSize: 18.0,
          //                           color: kBaseColor,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                     Text(
          //                       '$fdaApproved',
          //                       textAlign: TextAlign.center,
          //                       style: TextStyle(
          //                           fontFamily: 'Segoe',
          //                           fontSize: 18.0,
          //                           color: kBaseColor,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Medication Details',
                        style: TextStyle(
                          color: kBaseColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width / 1.5,
                          color: kBaseColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Table(
                      // border: TableBorder.all(color: Color(0xFFD2DBDB)),
                      columnWidths: const {
                        0: FractionColumnWidth(.4),
                        1: FractionColumnWidth(.6),
                      },
                      children: [
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Brand Name",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF525252),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '$brandName',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF525252),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Generic Name",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF525252),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '$genericName',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF525252),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Medicine Category",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF525252),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '$medicineCategory',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF525252),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Group",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF525252),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '$medicineGroup',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF525252),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Company Name",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF525252),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '$companyName',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF525252),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Price",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF525252),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '$price ৳',
                                // '${package.createdAt}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF525252),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "FDA Approved",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF525252),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                fdaApproved ? 'Approved' : 'Not Approved',
                                style: TextStyle(
                                  color: fdaApproved
                                      ? Colors.green
                                      : Colors.redAccent,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  child: Container(
                    child: TypeAheadField<String?>(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _brandNameController,
                        decoration: new InputDecoration(
                          hintText: "Type Brand Name",
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                      debounceDuration: Duration(milliseconds: 500),
                      suggestionsCallback:
                          PrescriptionController.getBrandSuggestions,
                      itemBuilder: (context, String? suggestion) => ListTile(
                        title: Text(suggestion!),
                      ),
                      onSuggestionSelected: (String? suggestion) {
                        setState(() {
                          _brandNameController.text = suggestion!;
                        });
                        for (var item
                            in PrescriptionController.medicationList) {
                          if (item.brandName == suggestion) {
                            medicine = item;
                            setState(() {
                              selectedGenericId = item.genericId ?? 0;
                              genericName = item.genericName ?? '';
                              PrescriptionController.selectedGenericId.value =
                                  item.genericId ?? 0;
                              // _typeDoseController.text = item.dose ?? '';
                              brandName = item.brandName ?? '';
                              medicineCategory = item.medicineCategory ?? '';
                              medicineGroup = item.medicineGroup ?? '';
                              companyName = item.companyName ?? '';
                              price = item.price ?? '';
                              fdaApproved = item.fdaApproved ?? false;
                            });
                          }
                        }
                      },
                    ),
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    if (_brandNameController.text.isNotEmpty) {
                      setState(() {
                        openCompareCard = true;
                      });
                    } else {
                      Get.defaultDialog(
                        title: 'Brand',
                        content:
                            Text('Please select or write a brand name first'),
                        textCancel: 'Ok',
                      );
                    }
                  },
                  child: Icon(Icons.read_more_rounded, size: 30),
                ),
              ],
            ),
          ),

          openCompareCard
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text(
                              'Compare Other Brands',
                              style: TextStyle(
                                fontSize: 18,
                                color: kBaseColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                height: 1,
                                color: kBaseColor,
                                width: MediaQuery.of(context).size.width / 1.5,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                child: TypeAheadField<String?>(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    controller: _compareBrandController,
                                    decoration: new InputDecoration(
                                      hintText: "Type Brand Name",
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                      ),
                                    ),
                                  ),
                                  debounceDuration: Duration(milliseconds: 500),
                                  suggestionsCallback: PrescriptionController
                                      .getCompareBrandSuggestions,
                                  itemBuilder: (context, String? suggestion) =>
                                      ListTile(
                                    title: Text(suggestion!),
                                  ),
                                  onSuggestionSelected: (String? suggestion) {
                                    setState(() {
                                      _compareBrandController.text =
                                          suggestion!;
                                    });
                                    for (var item in PrescriptionController
                                        .medicationList) {
                                      if (item.brandName == suggestion) {
                                        medicine = item;
                                        setState(() {
                                          // _brandNameController.text = item.brandName ?? '';

                                          brandName = item.brandName ?? '';
                                          medicineCategory =
                                              item.medicineCategory ?? '';
                                          medicineGroup =
                                              item.medicineGroup ?? '';
                                          companyName = item.companyName ?? '';
                                          price = item.price ?? '';
                                          fdaApproved =
                                              item.fdaApproved ?? false;
                                        });
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                            MaterialButton(
                              color: kBaseColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () {
                                setState(() {
                                  openCompareCard = false;
                                });
                              },
                              child: Text(
                                'Ok',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),

          // ListTile(
          //   title: new TextFormField(
          //     keyboardType: TextInputType.text,
          //     controller: _brandNameController,
          //     autofocus: false,
          //     decoration: new InputDecoration(
          //       hintText: "Type Brand Name",
          //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(32.0)),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 10,
          ),
          // ListTile(
          //   title: new TextFormField(
          //     keyboardType: TextInputType.text,
          //     controller: _typeDoseController,
          //     autofocus: false,
          //     decoration: new InputDecoration(
          //       hintText: "Type Dose",
          //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(32.0)),
          //     ),
          //   ),
          // ),
          ListTile(
            title: Container(
              child: TypeAheadField<String?>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _typeDoseController,
                  decoration: new InputDecoration(
                    hintText: "Type Dose",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
                debounceDuration: Duration(milliseconds: 500),
                suggestionsCallback: PrescriptionService.getDoseSuggestion,
                itemBuilder: (context, String? suggestion) => ListTile(
                  title: Text(suggestion!),
                ),
                onSuggestionSelected: (String? suggestion) {
                  _typeDoseController.text = suggestion!;
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Container(
              child: TypeAheadField<String?>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _durationController,
                  decoration: new InputDecoration(
                    hintText: "Duration",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
                debounceDuration: Duration(milliseconds: 500),
                suggestionsCallback: PrescriptionService.getDurationSuggestions,
                itemBuilder: (context, String? suggestion) => ListTile(
                  title: Text(suggestion!),
                ),
                onSuggestionSelected: (String? suggestion) {
                  _durationController.text = suggestion!;
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text(
              'Taking Medicine',
              style: TextStyle(
                  fontFamily: 'Segoe',
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
            ),
          ),
          Row(
            children: [
              Container(
                width: 160,
                height: 40,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // before = !before;
                          beforeEating = true;
                          afterEating = false;
                        });
                      },
                      child: beforeEating
                          ? Icon(
                              Icons.check_box,
                              color: kBaseColor,
                              size: 20,
                            )
                          : Icon(
                              Icons.check_box_outline_blank,
                              color: Colors.black54,
                              size: 20,
                            ),
                    ),
                    SizedBox(width: 5),
                    Text("Before Meal"),
                  ],
                ),
              ),
              Container(
                width: 150,
                height: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // after = !after;
                          beforeEating = false;
                          afterEating = true;
                        });
                      },
                      child: afterEating
                          ? Icon(
                              Icons.check_box,
                              color: kBaseColor,
                              size: 20,
                            )
                          : Icon(
                              Icons.check_box_outline_blank,
                              color: Colors.black54,
                              size: 20,
                            ),
                    ),
                    SizedBox(width: 2),
                    Text("After Meal"),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text(
              'Previous entered field data show as a label text. Entered all field data show as a label text.',
              style: TextStyle(
                  fontFamily: 'Segoe',
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 120),
              child: MaterialButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed('');

                  saveMedicine();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.only(left: 6, top: 6, right: 6, bottom: 6),
                color: kButtonColor,
                child: Text('Add',
                    style: TextStyle(
                        fontFamily: 'Segoe',
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          ),
          medicationList.length > 0
              ? ListTile(
                  title: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: medicationList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  medicationList[index]['BrandName'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(medicationList[index]['Dose']),
                                        SizedBox(width: 20),
                                        Text(
                                            '- ( ${medicationList[index]['EatingTime']} )'),
                                        SizedBox(width: 20),
                                        Text(
                                            ' ${medicationList[index]['Duration']}'),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          medicationList.removeAt(index);
                                          medicineString.removeAt(index);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }))
              : Container(),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Next Visit'),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(width: 1, color: Color(0xFFA4A4A4)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedNextVisit,
                      isExpanded: true,
                      elevation: 16,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedNextVisit = newValue!;
                        });
                      },
                      items: nextVisits.map((NextVisitModel data) {
                        return DropdownMenuItem(
                          value: data.details,
                          child: Text(
                            data.details!,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: TextFormField(
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                hintText: "Paid Taka",
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              onChanged: (val) => setState(() => paidTakaText = val),
            ),
          ),
          ListTile(
            title: new TextFormField(
              // keyboardType: TextInputType.number,
              enabled: false,
              controller: _visitNoController,
              decoration: new InputDecoration(
                hintText: "Visit No.",
                labelText: "Visit No.",
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
        ],
      ),
    );
    final advises = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ExpansionTileCard(
        baseColor: kBackgroundColor,
        key: cardG,
        leading: CircleAvatar(
          backgroundColor: kShadowColor,
          radius: 25,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 23.0,
            child: Image.asset('assets/icons/doctor/advises.png'),
          ),
        ),
        title: Text(
          'Advices',
          style: TextStyle(
              fontFamily: 'Segoe',
              color: kBaseColor,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        children: <Widget>[
          ListTile(
            title: Container(
              child: TypeAheadField<String?>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _diagnosisAdivceController,
                  decoration: new InputDecoration(
                    hintText: "Diagnosis Advices",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        if (_diagnosisAdivceController.text.isNotEmpty) {
                          if (!diagnosisAdviceEntry
                              .contains(_diagnosisAdivceController.text)) {
                            setState(() {
                              diagnosisAdviceEntry
                                  .add(_diagnosisAdivceController.text);
                            });
                            await prescriptionService.saveDiagnosisAdivceToDB(
                                memberId, _diagnosisAdivceController.text);
                            _diagnosisAdivceController.clear();
                          }
                        }
                      },
                      icon: Icon(Icons.add),
                    ),
                  ),
                ),
                debounceDuration: Duration(milliseconds: 500),
                suggestionsCallback:
                    PrescriptionService.getDiagnosisAdviceSuggestions,
                itemBuilder: (context, String? suggestion) => ListTile(
                  title: Text(suggestion!),
                ),
                onSuggestionSelected: (String? suggestion) {
                  _diagnosisAdivceController.text = suggestion!;
                },
              ),
            ),
          ),
          diagnosisAdviceEntry.length > 0
              ? ListTile(
                  title: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: diagnosisAdviceEntry.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                            '${index + 1}) ${diagnosisAdviceEntry[index]}');
                      }))
              : Container(),
          ListTile(
            title: Container(
              child: TypeAheadField<String?>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _generalAdivceController,
                  decoration: new InputDecoration(
                    hintText: "General Advices",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        if (_generalAdivceController.text.isNotEmpty) {
                          if (!generalAdviceEntry
                              .contains(_generalAdivceController.text)) {
                            setState(() {
                              generalAdviceEntry
                                  .add(_generalAdivceController.text);
                            });
                            await prescriptionService.saveGeneralAdivceToDB(
                                memberId, _generalAdivceController.text);
                            _generalAdivceController.clear();
                          }
                        }
                      },
                      icon: Icon(Icons.add),
                    ),
                  ),
                ),
                debounceDuration: Duration(milliseconds: 500),
                suggestionsCallback:
                    PrescriptionService.getGeneralAdviceSuggestions,
                itemBuilder: (context, String? suggestion) => ListTile(
                  title: Text(suggestion!),
                ),
                onSuggestionSelected: (String? suggestion) {
                  _generalAdivceController.text = suggestion!;
                },
              ),
            ),
          ),
          generalAdviceEntry.length > 0
              ? ListTile(
                  title: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: generalAdviceEntry.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                            '${index + 1}) ${generalAdviceEntry[index]}');
                      }))
              : Container(),
        ],
      ),
    );

    final preview = Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 90),
      child: MaterialButton(
        onPressed: () async {
          // writeOnPdf();
          // await savePdf();
          var oEMap = generateOEMap();
          var prescriptionInfoMap = generatePrescriptionInfoMap();
          var returnMap = await prescriptionService.savePrescription(
            generalAdviceEntry,
            diagnosisAdviceEntry,
            drugHistoryEntry,
            oEMap,
            ccEntry,
            diseaseConditionEntry,
            prescriptionInfoMap,
            medicationList,
            false,
          );

          final url = '${returnMap['pdfUrl']}';
          final fileName = '${returnMap['prescriptionID']}';
          final file = await PdfApi.loadNetwork(url, fileName);

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PdfViewPage(pdfFile: file),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
        color: kWhiteShadow,
        child: Text('Preview',
            style: TextStyle(
                fontFamily: "Segoe",
                fontSize: 15,
                color: kBaseColor,
                fontWeight: FontWeight.w700)),
      ),
    );

    final saveAndPrint = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 90),
      child: MaterialButton(
        onPressed: () async {
          var response = await apiServices.updateDoctorAppointmentStatus(
            'accepted',
            appointment['appoitmentID'],
          );

          var oEMap = generateOEMap();
          var prescriptionInfoMap = generatePrescriptionInfoMap();
          var returnMap = await prescriptionService.savePrescription(
            generalAdviceEntry,
            diagnosisAdviceEntry,
            drugHistoryEntry,
            oEMap,
            ccEntry,
            diseaseConditionEntry,
            prescriptionInfoMap,
            medicationList,
            true,
          );

          final url = '${returnMap['pdfUrl']}';
          final fileName = '${returnMap['prescriptionID']}';
          final file = await PdfApi.loadNetwork(url, fileName);

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PdfViewPage(
                pdfFile: file,
                path: url,
                bmdcNo: bmdcNmuber,
                memberId: memberId,
                doctorId: doctorId,
                title: '${returnMap['prescriptionID']}',
              ),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
        color: kWhiteShadow,
        child: Text('Save and Print',
            style: TextStyle(
                fontFamily: "Segoe",
                fontSize: 15,
                color: kBaseColor,
                fontWeight: FontWeight.w700)),
      ),
    );

    final teleMedicine = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 90),
      child: MaterialButton(
        onPressed: () async {
          var oEMap = generateOEMap();
          var prescriptionInfoMap = generatePrescriptionInfoMap();
          var returnMap = await prescriptionService.savePrescription(
            generalAdviceEntry,
            diagnosisAdviceEntry,
            drugHistoryEntry,
            oEMap,
            ccEntry,
            diseaseConditionEntry,
            prescriptionInfoMap,
            medicationList,
            true,
          );

          final url = '${returnMap['pdfUrl']}';
          final fileName = '${returnMap['prescriptionID']}';
          // await PdfApi.shareFile(url, fileName);
          Get.snackbar(
            "Sent",
            "Prescription Sent to patient.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black,
            colorText: Colors.white,
          );

          // openPDF(context, file);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
        color: kWhiteShadow,
        child: Text(
          'Send to Patient',
          style: TextStyle(
            fontFamily: "Segoe",
            fontSize: 15,
            color: kBaseColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        // drawer: CustomDrawerDoctor(),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kBaseColor,
          iconTheme: IconThemeData(color: kTitleColor),
          toolbarHeight: 50,
          elevation: 2.0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.phone),
            ),
            IconButton(
              onPressed: () async {
                bool granted = await Permissions
                    .checkCameraAndMicrophonePermissionGranted();
                if (granted) {
                  CallUtils.dial(
                    from: doctor,
                    to: patient,
                    context: context,
                  );
                }
              },
              icon: Icon(Icons.videocam_rounded),
            ),
          ],
          title: Text(
            'Write Prescription',
            style: TextStyle(
              fontFamily: 'Segoe',
              color: kTitleColor,
            ),
          ),
        ),
        backgroundColor: kBackgroundColor,
        body: Center(
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  !markedAsAccepted
                      ? MaterialButton(
                          minWidth: 150,
                          onPressed: () async {
                            var response =
                                await apiServices.updateDoctorAppointmentStatus(
                              'accepted',
                              appointment['appoitmentID'],
                            );
                            if (response) {
                              setState(() {
                                markedAsAccepted = true;
                              });
                              widget.appointmentController.appoinments.clear();
                              widget.appointmentController.queueAppointments
                                  .clear();
                              widget.appointmentController
                                  .fetchDoctorAppoinments();
                            }
                          },
                          child: Text(
                            'Mark as Accepted',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: kBaseColor,
                        )
                      : Container(),
                ],
              ),
              patientInfo,
              diseaseCondition,
              chiefComplaint,
              oE,
              history,
              medication,
              advises,
              preview,
              saveAndPrint,
              teleMedicine,
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
