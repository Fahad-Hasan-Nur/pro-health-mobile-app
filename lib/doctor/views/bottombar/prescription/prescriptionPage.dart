// ignore_for_file: unused_field

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dio/dio.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
// import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pro_health/doctor/models/district_model.dart';
import 'package:pro_health/doctor/models/police_station_model.dart';
import 'package:pro_health/doctor/models/post_office_model.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/Advice.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/Chamber.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/Doctor.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/Investigation.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/Medicine.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/NextPlan.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/OE.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/Patient.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/PdfViewPage.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/chiefCompliant.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/pdfApi.dart';
// import 'package:pro_health/doctor/views/bottombar/prescription/classes/pdfPrescription.dart';
// import 'package:pro_health/doctor/views/bottombar/prescription/classes/pdf_view_screen2.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/qrcode.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/data.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/models/next_visit.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/prescription.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/service/prescription_service.dart';
import 'package:pro_health/doctor/views/drawer/custom_drawer_doctor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class PrescriptionPage extends StatefulWidget {
  static String tag = 'PrescriptionPage';
  PrescriptionPage({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  PrescriptionPageState createState() => PrescriptionPageState();
}

class PrescriptionPageState extends State<PrescriptionPage> {
  ApiServices apiServices = ApiServices();

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

  // patient information
  late String patientName = '';
  late String phoneNumber = '';
  late String gender = '';
  var age = '';
  var dateOfBirth = DateTime.now().toIso8601String();
  String selectedtGender = "Male";

  // On Examination == OE

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

  // final newPatient = <NewPatient>[
  //   NewPatient('Sohail', '12345'),
  //   NewPatient('Mahmud', '12345'),
  //   NewPatient('Sami', '12345'),
  //   NewPatient('Alamin', '12345')
  // ];
  // NewPatient? selectedNewPatient;

  // final nextVisit = <NextVisit>[
  //   NextVisit('After Day 1', ''),
  //   NextVisit('After Day 2', ''),
  //   NextVisit('After Day 3', ''),
  //   NextVisit('After Day 4', ''),
  //   NextVisit('After Day 5', '')
  // ];
  // NextVisit? selectedNextVisit;

  // final paidTK = <PaidTK>[
  //   PaidTK('100', ''),
  //   PaidTK('200', ''),
  //   PaidTK('300', ''),
  //   PaidTK('After Day 4', ''),
  //   PaidTK('After Day 5', '')
  // ];
  // PaidTK? selectedPaidTK;

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
  var currentDate; // = getDataAndTime(DateTime.now().toIso8601String()) ;
  // var currentDate = DateFormat("dd-MM-yyyy")
  //     .format(DateTime.parse(DateTime.now().toIso8601String()));
  // DateFormat("dd-MM-yyyy").format(DateTime.parse("2019-09-30"));
  //.toIso8601String();

  var selectedNextVisit = 'Select';

  var referredByName = '';

  var nextVisitText = '';
  var paidTakaText = '';
  var visitNoText = '';

  var selectedSpo2;

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
    prescriptionInfoMap['patientID'] = patientId;
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

  /*
    calculate Estimated Delivery date by using Naegele's Formula.

    Every month will be treated as number, 
    if LMP is between April to December then 
    April = 4,
    May = 5,
    June = 6,
    July = 7,
    August = 8,
    September = 9,
    October = 10,
    November = 11,
    December = 12,

      1. deduct 3 from  months,
      2. add 7 in days,
      3. add 1 in year.

    if LMP is between Jan to March then
    1. deduct 3 from months
    2. add 7 in days.

    Jan = 13,
    Feb = 14,
    Mar = 15,
    and Apr - december will be same as before.
  */

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
      print('else part listening');
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

  // var selectedReferredById;

  // fetchReferredByDoctors() async {
  //   var response = await apiServices.fetchReferredByDoctors();
  //   setState(() {
  //     referredByDoctors.addAll(response);
  //     referredByName = referredByDoctors[0].doctorName;
  //   });
  // }

  fetchDoctorAppointments() async {
    var response = await apiServices.fetchAccedptedAppoinments(memberId);
    print(response);
    setState(() {
      doctorAppointments.addAll(response);
    });
    print(doctorAppointments);
  }

  static Future<List<String>> getNamesSuggestion(String query) async {
    List<String> names = [];
    for (var patient in doctorAppointments) {
      if (patient['patientName'] != null || patient['patientName'].isNotEmpty) {
        names.add(patient['patientName']);
      }
    }

    print(doctorAppointments);
    print(names);

    return List.of(names).where((name) {
      final nameLower = name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  }

  fetchDistricts() async {
    if (districts.length > 0) {
      districts.clear();
    }
    var response = await apiServices.fetchDistricts();
    setState(() {
      // districts.add(DistrictModel.fromJson({
      //   "districtID": 0,
      //   "districtName": "Select District",
      //   "entryBy": "default",
      //   "entryDate": "2020-12-06T10:28:52.23"
      // }));
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
      medicineMap['MedicineCategory'] = 'default';
      medicineMap['MedicineGroup'] = 'default';
      medicineMap['CompanyName'] = 'default';
      medicineMap['Price'] = '0.0';
      medicineMap['FDAApproved'] = true;
      medicineMap['CompanyID'] = 0;
      medicineMap['BrandId'] = 0;
      medicineMap['GenericID'] = 0;
      medicineMap['BeforeMeal'] = false;
      medicineMap['AfterMeal'] = true;

      setState(() {
        medicationList.add(medicineMap);
        medicineString.add("$brandName \n$dose ($eatingTime) $duration ");
      });

      _brandNameController.clear();
      _typeDoseController.clear();
      _durationController.clear();
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
      // postOffices.add(PostOfficeModel.fromJson({
      //   "postOfficeId": 0,
      //   "districtID": 0,
      //   "policeStationID": 0,
      //   "postOfficeName": "Select Post Code",
      //   "postCode": ""
      // }));
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

  @override
  void initState() {
    fetchDoctorProfile();

    _ftController.text = '0';
    _inchController.text = '0';

    fetchDistricts();
    currentDate = getDate(DateTime.now().toIso8601String());
    getSpo2List();
    fetchNextVisits();
    // fetchReferredByDoctors();
    super.initState();
    // generateExampleDocument();
  }

  final pdf = pw.Document();

  Prescription makePrescription() {
    final prescription = Prescription(
      doctor: Doctor(
        doctorNameBangla: doctorNameBangla,
        docorNameEnglish: doctorNameEnglish,
        doctorDegree1Bangla: doctorDegree1Bangla,
        doctorDegree1English: doctorDegree1English,
        doctorDegree2Bangla: doctorDegree2Bangla,
        doctorDegree2English: doctorDegree2English,
        doctorDesignation1Bangla: doctorDesignation1Bangla,
        doctorDesignation1English: doctorDesignation1English,
        doctorDesignation2Bangla: doctorDesignation2Bangla,
        doctorDesignation2English: doctorDesignation2English,
        doctorWorkplace1Bangla: doctorWorkplace1Bangla,
        doctorWorkplace1English: doctorWorkplace1English,
      ),
      patient: Patient(
        name: patientName, // 'Md. Kamrul',
        age: age, //'27',
        gender: selectedtGender, // 'Male',
        thana: selectedPoliceStation, // 'Kumarkhali',
        id: "000/1", //'000/1',
        referredBy: referredByName,
        date: currentDate, // 'Dr. XYZ',
        dist: selectedDistrict,
        mobile: phoneNumber,
      ),
      chamber: Chamber(
        // chamber1English:
        //     "Ibne sina the Lab and Consultation Center, Dhanmandi, Road-15, Hourse - 36, Dhaka 1209",
        // chamber1ConsultDayEnglish: "Sunday to Wednesday",
        // chamber1ConsultTimeEnglish: "06 PM to 09 PM"
        chamber1Bangla: chamber1Bangla, //
        chamber1ConsultDayBangla: chamber1ConsultDayBangla, //
        chamber1ConsultTimeBangla: chamber1ConsultTimeBangla, //
      ),

      advice: Advice(
        advices: generalAdviceEntry,
      ),

      cc: ChiefCompliant(
        cc: ccEntry,
      ),

      oe: OE(
        oe: [
          'BP: $bp',
          'Pulse: $pulse',
          'Weight: $weight Kg',
          'D. Allergy: $drugAlergy',
        ],
      ),
      investigation: Investigation(
        investigation: [
          // 'CBC',
          // 'Xray',
        ],
      ),

      nextPlan: NextPlan(
        nextPlan: [
          nextVisitText, // Text('৭ দিন পর আবার আসবেন / অপারেশন'), //
        ],
      ),
      qrCode: QrCode(
        data: "123456",
      ),

      medicine: Medicine(
        medicine: medicineString,
      ),

      // doctor: Doctor(
      //   // doctorNameBangla: "Dr. Umme Salma", //'ডাঃ উম্মে সালমা',
      //   doctorNameBangla: "Dr. Umme Salma",
      //   docorNameEnglish: "Dr. Umme Salma",
      //   // doctorDegree1Bangla: "MBBS, BCS (Health)", //"এম বি বি এস, বিসিএস(স্বাস্থ্য)",
      //   doctorDegree1Bangla: "MBBS, BCS (Health)",
      //   doctorDegree1English: "MBBS, BCS (Health)",
      //   // doctorDegree2Bangla: "FCPS (Obs & Gynae)", //"এফ সি পি এস (গাইনি এন্ড অবস)", //
      //   doctorDegree2Bangla: "FCPS (Obs & Gynae)",
      //   doctorDegree2English: "FCPS (Obs & Gynae)",
      //   // doctorDesignation1Bangla:
      //   //     "Consultant (Gynae & High Risk Pregnancy)", //"কনসালটেন্ট (গাইনি ও হাই রিস্ক প্রেগনেন্সি)", //
      //   doctorDesignation1Bangla: "Consultant (Gynae & High Risk Pregnancy)",
      //   doctorDesignation1English: "Consultant (Gynae & High Risk Pregnancy)",
      //   // doctorDesignation2Bangla:
      //   //     "Consultant (Gynae & Obs Department)", //"কনসালটেন্ট (গাইনি ও অবস বিভাগ)", //
      //   doctorDesignation2Bangla: "Consultant (Gynae & Obs Department)",
      //   doctorDesignation2English: "Consultant (Gynae & Obs Department)",
      //   // doctorWorkplace1Bangla:
      //   //     "Bangabondhu Sheikh Mujib Medical University (PG)", //"বঙ্গবন্ধু শেখ মুজিব মেডিকেল বিশ্ববিদ্যালয় (পিজি হাসপাতাল)", //
      //   doctorWorkplace1Bangla:
      //       "Bangabondhu Sheikh Mujib Medical University (PG)",
      //   doctorWorkplace1English:
      //       "Bangabondhu Sheikh Mujib Medical University (PG)",
      // ),
      // patient: Patient(
      //   name: 'Md. Kamrul',
      //   age: '27',
      //   gender: 'Male',
      //   thana: 'Kumarkhali',
      //   id: '000/1',
      //   referredBy: 'Dr. XYZ',
      // ),
      // chamber: Chamber(
      //   chamber1Bangla:
      //       "Ibne Sina the Lab and Consultation Center, Dhanmandi, Rode-15, House 36, Dhaka - 1209 ",
      //   chamber1ConsultDayBangla: "Sunday to Wednesday",
      //   chamber1ConsultTimeBangla: "05 PM to 9 PM",
      //   // chamber1Bangla:
      //   //     "Ibne Sina the Lab and Consultation Center, Dhanmandi, Rode-15, House 36, Dhaka - 1209 ", // 'ইবনে সিনা ডি ল্যাব এন্ড কনসালটেশন সেন্টার, ধানমন্ডি, রোড নং ১৫, বাড়ি নং ৩৬, ঢাকা - ১২০৯', //
      //   // chamber1ConsultDayBangla:
      //   //     "Sunday to Wednesday", //'শনিবার থেকে বুধবার', //
      //   // chamber1ConsultTimeBangla:
      //   //     "05 PM to 9 PM", //'বিকেল ৫ টা থেকে রাত ৯ টা', //
      // ),
      // advice: Advice(
      //   advices: [
      //     Text('Drink Enough Water'), //Text('বেশি করে পানি খাবেন'), //
      //     Text("Take Enough Rest"), //Text('পর্যাপ্ত ঘুমাবেন'), //
      //     Text("Give Up Smoking"), //Text('ধুম্পান বর্জন করুন'), //
      //     Text(
      //         'Do Physical Excersize regularly'), // Text( 'নিয়মিত ব্যায়াম করুন'), //
      //   ],
      // ),
      // cc: ChiefCompliant(
      //   cc: [
      //     Text('Fever for 3 Days'),
      //     Text('Back Pain'),
      //   ],
      // ),
      // oe: OE(
      //   oe: [
      //     Text('BP: 120/90'),
      //     Text('Pulse: 80'),
      //     Text('Weight: 80 Kg'),
      //     Text('D. Allergy: Unknown'),
      //   ],
      // ),
      // investigation: Investigation(
      //   investigation: [
      //     Text('CBC'),
      //     Text('Xray'),
      //   ],
      // ),
      // medicine: Medicine(
      //   medicine: [
      //     Text(
      //         'TAB. ROZITH (500 mg) \n0+1+0 After Meal 5 Days'), //Text('TAB. ROZITH (500 mg) \n০+১+০ (খাওয়ার পর) ৫ দিন'),
      //     Text(
      //         'TAB. SERGEL (20 mg) \n1+0+1 30 Minute before meal 14 days'), // Text('TAB. SERGEL (20 mg) \n১+০+১ (খাওয়ার ৩০ মিনিট আগে) ১৪ দিন'),
      //     Text(
      //         'TAB. ACE (500 mg) \n1+1+1 After meal 10 days'), // Text('TAB. ACE (500 mg) \n১+১+১ (খাওয়ার পর) ১০ দিন'),
      //     Text(
      //         'CAP. LYRIC (150 mg) \n1+0+1 After meal 7 days'), // Text('CAP. LYRIC (150 mg) \n১+০+১ (খাওয়ার পর) ৭ দিন'),
      //     Text(
      //         'TAB. NEURO-B \n1+0+1 After meal 15 days'), // Text('TAB. NEURO-B \n১+০+১ (খাওয়ার পর) ১৫ দিন'),
      //   ],
      // ),
      // nextPlan: NextPlan(
      //   nextPlan: [
      //     Text(
      //         'Come back again after 7 Days'), // Text('৭ দিন পর আবার আসবেন / অপারেশন'), //
      //   ],
      // ),
      // qrCode: QrCode(
      //   data: '123456',
      // ),
    );

    return prescription;
  }

  writeOnPdf() {
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(25),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 0,
              child: pw.Text("Easy Approach Document",
                  style: pw.TextStyle(fontSize: 40))),
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit a1met, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
          pw.Header(level: 1, child: pw.Text("Second Heading")),
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
        ];
      },
    ));
  }

  Future savePdf() async {
    documentDirectory = await getApplicationDocumentsDirectory();

    documentPath = documentDirectory.path;
    var time = DateTime.now().toLocal();
    print(time);

    var name = Random().nextInt(100000) + 1000000;

    // ignore: unused_local_variable
    generatedPdfFile = File("$documentPath/${time.millisecond}$name.pdf");

    generatedPdfFile!.writeAsBytesSync(await pdf.save());

    fullPath = generatedPdfFile!.path;
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
                //     child: SimpleAutocompleteFormField<NewPatient>(
                //       decoration: InputDecoration(
                //         hintText: "Type Patient Name",
                //         contentPadding:
                //             EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(32.0)),
                //       ),
                //       suggestionsHeight: 80.0,
                //       itemBuilder: (context, newPatient) => Padding(
                //         padding: EdgeInsets.all(8.0),
                //         child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(newPatient!.name,
                //                   style:
                //                       TextStyle(fontWeight: FontWeight.bold)),
                //               Text(newPatient.phone)
                //             ]),
                //       ),
                //       onSearch: (search) async => newPatient
                //           .where((newPatient) =>
                //               newPatient.name
                //                   .toLowerCase()
                //                   .contains(search.toLowerCase()) ||
                //               newPatient.phone
                //                   .toLowerCase()
                //                   .contains(search.toLowerCase()))
                //           .toList(),
                //       itemFromString: (string) => newPatient.singleWhereOrNull(
                //           (newPatient) =>
                //               newPatient.name.toLowerCase() ==
                //               string.toLowerCase()),
                //       onChanged: (value) =>
                //           setState(() => selectedNewPatient = value),
                //       onSaved: (value) =>
                //           setState(() => selectedNewPatient = value),
                //       validator: (person) =>
                //           person == null ? 'Invalid Patient.' : null,
                //     ),
                //   ),
                // ),

                ListTile(
                  title: Container(
                    child: TypeAheadField<String?>(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _patientNameController,
                        decoration: InputDecoration(
                          labelText: 'Patient Name',
                          hintText: "type or search",
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                      debounceDuration: Duration(milliseconds: 500),
                      suggestionsCallback: getNamesSuggestion,
                      itemBuilder: (context, String? suggestion) => ListTile(
                        title: Text(suggestion!),
                      ),
                      onSuggestionSelected: (String? suggestion) {
                        _patientNameController.text = suggestion!;
                        patientName = suggestion;
                        for (var item in doctorAppointments) {
                          if (item['patientName'] == suggestion) {
                            patientId = item['patiantID'];
                          }
                        }
                      },
                    ),
                  ),
                ),

                // ListTile(
                //   title: new TextFormField(
                //     initialValue: patientName,
                //     decoration: new InputDecoration(
                //       labelText: "Patient Name",
                //       hintText: "Type Patient Name",
                //       contentPadding:
                //           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(32.0)),
                //     ),
                //     onChanged: (val) => setState(() => patientName = val),
                //   ),
                // ),

                ListTile(
                  title: new TextFormField(
                      initialValue: phoneNumber,
                      decoration: new InputDecoration(
                        labelText: "Mobile Number",
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                      onChanged: (val) => setState(() =>
                          phoneNumber = val) // (val) => phoneNumber = val,
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
                // ListTile(
                //   title: DateTimeField(
                //     initialValue: DateTime.parse(dateOfBirth),
                //     format: format,
                //     onShowPicker: (context, currentValue) {
                //       return showDatePicker(
                //           context: context,
                //           firstDate: DateTime(1900),
                //           initialDate: currentValue ?? DateTime.now(),
                //           lastDate: DateTime(2100));
                //     },
                //     onChanged: (val) {
                //       setState(() {
                //         dateOfBirth = val!.toIso8601String();
                //       });
                //       print(dateOfBirth);
                //     },
                //     decoration: InputDecoration(
                //       labelText: "Date of Birth",
                //       contentPadding:
                //           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(32.0)),
                //     ),
                //   ),
                // ),
                ListTile(
                  title: new TextFormField(
                    initialValue: age,
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
                // ListTile(
                //   title: new TextFormField(
                //     // initialValue: selectedDistrict,
                //     decoration: new InputDecoration(
                //       labelText: "District",
                //       contentPadding:
                //           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(32.0)),
                //     ),
                //     onChanged: (val) => setState(() => selectedDistrict = val),
                //   ),
                // ),
                // ListTile(
                //   title: new TextFormField(
                //     // initialValue: selectedPoliceStation,
                //     decoration: new InputDecoration(
                //       labelText: "Thana",
                //       contentPadding:
                //           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(32.0)),
                //     ),
                //     onChanged: (val) =>
                //         setState(() => selectedPoliceStation = val),
                //   ),
                // ),
                // ListTile(
                //   title: new TextFormField(
                //     // initialValue: selectedPostOffice,
                //     decoration: new InputDecoration(
                //       labelText: "Post Office",
                //       contentPadding:
                //           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(32.0)),
                //     ),
                //     onChanged: (val) =>
                //         setState(() => selectedPostOffice = val),
                //   ),
                // ),
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
                // ListTile(
                //   title: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text('District'),
                //       Container(
                //         padding: EdgeInsets.symmetric(horizontal: 20),
                //         width: MediaQuery.of(context).size.width,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(32),
                //           border:
                //               Border.all(width: 1, color: Color(0xFFA4A4A4)),
                //         ),
                //         child: DropdownButtonHideUnderline(
                //           child: DropdownButton<String>(
                //             isExpanded: true,
                //             hint: Text("Select item"),
                //             value: selectedSpo2,

                //             // underline: ,
                //             items: spo2List.map((String value) {
                //               return DropdownMenuItem<String>(
                //                 value: value,
                //                 child: Text(value),
                //               );
                //             }).toList(),
                //             onChanged: (val) {
                //               print(val);
                //               setState(() {
                //                 selectedSpo2 = val!;
                //               });
                //             },
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // ListTile(
                //   title: Container(
                //     height: 60,
                //     padding: EdgeInsets.symmetric(horizontal: 20),
                //     width: MediaQuery.of(context).size.width,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(32),
                //       border: Border.all(width: 1, color: Color(0xFFA4A4A4)),
                //     ),
                //     child: DropdownButtonHideUnderline(
                //       child: DropdownButton<String>(
                //         value: selectedDistrict,
                //         isExpanded: true,
                //         elevation: 16,
                //         onChanged: (String? newValue) {
                //           setState(() {
                //             selectedDistrict = newValue!;
                //           });
                //           for (var item in districts) {
                //             if (item.districtName == newValue) {
                //               setState(() {
                //                 selectedDistrictId = item.districtID;
                //               });
                //             }
                //           }

                //           fetchPoliceStations(selectedDistrictId.toString());
                //           fetchPostOffices('0');
                //         },
                //         items: districts.map((DistrictModel data) {
                //           return DropdownMenuItem(
                //             value: data.districtName,
                //             child: Text(
                //               data.districtName,
                //             ),
                //           );
                //         }).toList(),
                //       ),
                //     ),
                //   ),
                // ),
                // ListTile(
                //   title: Container(
                //     padding: EdgeInsets.symmetric(horizontal: 20),
                //     width: MediaQuery.of(context).size.width,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(32),
                //       border: Border.all(width: 1, color: Color(0xFFA4A4A4)),
                //     ),
                //     child: DropdownButtonHideUnderline(
                //       child: DropdownButton<String>(
                //         value: selectedPoliceStation,
                //         isExpanded: true,
                //         elevation: 16,
                //         onChanged: (String? newValue) {
                //           setState(() {
                //             selectedPoliceStation = newValue!;
                //           });
                //           for (var item in policestations) {
                //             if (item.policeStationName == newValue) {
                //               setState(() {
                //                 selectedPoliceStationId = item.policeStationID;
                //               });
                //             }
                //           }
                //           fetchPostOffices(selectedPoliceStationId.toString());
                //         },
                //         items: policestations.map((PoliceStationModel data) {
                //           return DropdownMenuItem(
                //             value: data.policeStationName,
                //             child: Text(
                //               data.policeStationName,
                //             ),
                //           );
                //         }).toList(),
                //       ),
                //     ),
                //   ),
                // ),
                // ListTile(
                //   title: Container(
                //     padding: EdgeInsets.symmetric(horizontal: 20),
                //     width: MediaQuery.of(context).size.width,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(32),
                //       border: Border.all(width: 1, color: Color(0xFFA4A4A4)),
                //     ),
                //     child: DropdownButtonHideUnderline(
                //       child: DropdownButton<String>(
                //         value: selectedPostOffice,
                //         isExpanded: true,
                //         elevation: 16,
                //         onChanged: (String? newValue) {
                //           setState(() {
                //             selectedPostOffice = newValue!;
                //           });
                //           for (var item in postOffices) {
                //             if (item.postOfficeName == newValue) {
                //               setState(() {
                //                 selectedPostOfficeId = item.postOfficeId;
                //               });
                //             }
                //           }
                //         },
                //         items: postOffices.map((PostOfficeModel data) {
                //           return DropdownMenuItem(
                //             value: data.postOfficeName,
                //             child: Text(
                //               data.postOfficeName,
                //             ),
                //           );
                //         }).toList(),
                //       ),
                //     ),
                //   ),
                // ),
                const Divider(
                  height: 10.0,
                ),
                // ListTile(
                //   title: new TextFormField(
                //     decoration: new InputDecoration(
                //       hintText: "Email Address",
                //       contentPadding:
                //           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(32.0)),
                //     ),
                //     onChanged: (val) => patientEmail = val,
                //   ),
                // ),
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

                // ListTile(
                //   title: Container(
                //     height: 60,
                //     padding: EdgeInsets.symmetric(horizontal: 20),
                //     width: MediaQuery.of(context).size.width,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(32),
                //       border: Border.all(width: 1, color: Color(0xFFA4A4A4)),
                //     ),
                //     child: DropdownButtonHideUnderline(
                //       child: DropdownButtonFormField<String>(
                //         value: selectedReferredById,
                //         decoration: new InputDecoration(
                //           hintText: "Referred By",
                //           contentPadding:
                //               EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                //           border: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(32.0)),
                //         ),
                //         isExpanded: true,
                //         elevation: 16,
                //         onChanged: (String? newValue) {
                //           setState(() {
                //             referredByName = newValue!;
                //           });
                //           for (var item in referredByDoctors) {
                //             if (item.doctorName == newValue) {
                //               setState(() {
                //                 selectedReferredById = item.doctorId;
                //               });
                //             }
                //           }
                //         },
                //         items: referredByDoctors.map((DoctorProfileModel data) {
                //           return DropdownMenuItem(
                //             value: data.doctorName,
                //             child: Text(
                //               data.doctorName!,
                //             ),
                //           );
                //         }).toList(),
                //       ),
                //     ),
                //   ),
                // ),

                // ListTile(
                //   title: Container(
                //     padding: EdgeInsets.symmetric(horizontal: 20),
                //     width: MediaQuery.of(context).size.width,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(32),
                //       border: Border.all(width: 1, color: Color(0xFFA4A4A4)),
                //     ),
                //     child: DropdownButtonHideUnderline(
                //       child: DropdownButton<String>(
                //         value: referredByName,
                //         isExpanded: true,
                //         elevation: 16,
                //         onChanged: (String? newValue) {
                //           setState(() {
                //             referredByName = newValue!;
                //           });
                //           for (var item in referredByDoctors) {
                //             if (item.doctorName == newValue) {
                //               setState(() {
                //                 selectedReferredById = item.doctorID;
                //               });
                //             }
                //           }
                //         },
                //         items: referredByDoctors.map((DoctorModel data) {
                //           return DropdownMenuItem(
                //             value: data.doctorName,
                //             child: Text(
                //               data.doctorName!,
                //             ),
                //           );
                //         }).toList(),
                //       ),
                //     ),
                //   ),
                // ),

                // ListTile(
                //   title: new DropdownButtonFormField(
                //     decoration: new InputDecoration(
                //       hintText: "Referred By",
                //       contentPadding:
                //           EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(32.0)),
                //     ),
                //     items: <DropdownMenuItem>[
                //       DropdownMenuItem<int>(
                //         value: 1,
                //         child: Text("Doctors-D001"),
                //       ),
                //       DropdownMenuItem<int>(
                //         value: 2,
                //         child: Text("Doctors-D002"),
                //       ),
                //       DropdownMenuItem<int>(
                //         value: 3,
                //         child: Text("Doctors-D003"),
                //       ),
                //     ],
                //     onChanged: (dynamic val) => print(val),
                //     onSaved: (dynamic val) => print(val),
                //   ),
                // ),

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
                /*new ListTile(
                        title: const Text("Referred By"),
                        trailing: const Icon(Icons.check_circle, color: Colors.green,),
                      ),*/
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
          // ListTile(
          //   title: new TextFormField(
          //     initialValue: disease,
          //     keyboardType: TextInputType.text,
          //     autofocus: false,
          //     decoration: new InputDecoration(
          //       hintText: "type/search something",
          //       // suffixIcon: IconButton(
          //       //   onPressed: addDiseaseCondition,
          //       //   icon: Icon(Icons.add),
          //       // ),
          //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(32.0)),
          //     ),
          //     onChanged: (val) => setState(() => disease = val),
          //   ),
          // ),
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

          // ListTile(
          //   title: Container(
          //     child: SimpleAutocompleteFormField<Brand>(
          //       decoration: InputDecoration(
          //         hintText: "Type Chief Complaint",
          //         contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(32.0)),
          //       ),
          //       suggestionsHeight: 80.0,
          //       itemBuilder: (context, person) => Padding(
          //         padding: EdgeInsets.all(8.0),
          //         child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(person!.name,
          //                   style: TextStyle(fontWeight: FontWeight.bold)),
          //               Text(person.address)
          //             ]),
          //       ),
          //       onSearch: (search) async => brand
          //           .where((person) =>
          //               person.name
          //                   .toLowerCase()
          //                   .contains(search.toLowerCase()) ||
          //               person.address
          //                   .toLowerCase()
          //                   .contains(search.toLowerCase()))
          //           .toList(),
          //       itemFromString: (string) => brand.singleWhereOrNull((person) =>
          //           person.name.toLowerCase() == string.toLowerCase()),
          //       onChanged: (value) => setState(() => selectedBrand = value),
          //       onSaved: (value) => setState(() => selectedBrand = value),
          //       validator: (person) =>
          //           person == null ? 'Invalid person.' : null,
          //     ),
          //   ),
          // ),
          // ListTile(
          //   title: new TextFormField(
          //     keyboardType: TextInputType.text,
          //     autofocus: false,
          //     decoration: new InputDecoration(
          //       hintText: "Type",
          //       suffixIcon: IconButton(
          //         // onPressed: addChiefComplaint,
          //         onPressed: () {
          //           if (_ccController.text.isNotEmpty) {
          //             setState(() {
          //               ccEntry.add(_ccController.text);
          //             });
          //             _ccController.clear();
          //           }
          //         },
          //         icon: Icon(Icons.add),
          //       ),
          //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(32.0),
          //       ),
          //     ),
          //     controller: _ccController,
          //   ),
          // ),
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
          // ListTile(
          //   title: new TextFormField(
          //     initialValue: weight.toString(),
          //     keyboardType: TextInputType.text,
          //     autofocus: false,
          //     decoration: new InputDecoration(
          //       hintText: "Weight (kg)",
          //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(32.0)),
          //     ),
          //     onChanged: (val) => setState(() => weight = double.parse(val)),
          //   ),
          // ),

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
                      print(calculatedBMI);
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

          // ListTile(
          //   title: Container(
          //     height: 40,
          //     child: Column(
          //       children: [
          //         Text('Height'),
          //         Row(
          //           children: [
          //             TextFormField(
          //               initialValue: height,
          //               keyboardType: TextInputType.text,
          //               autofocus: false,
          //               decoration: new InputDecoration(
          //                 hintText: "Feet",
          //                 contentPadding:
          //                     EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //                 border: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(32.0)),
          //               ),
          //               onChanged: (val) => setState(() => height = val),
          //             ),
          //             // TextFormField(
          //             //   initialValue: height,
          //             //   keyboardType: TextInputType.text,
          //             //   autofocus: false,
          //             //   decoration: new InputDecoration(
          //             //     hintText: "Inch",
          //             //     contentPadding:
          //             //         EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //             //     border: OutlineInputBorder(
          //             //         borderRadius: BorderRadius.circular(32.0)),
          //             //   ),
          //             //   onChanged: (val) => setState(() => height = val),
          //             // ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // ListTile(
          //   title: new TextFormField(
          //     initialValue: height,
          //     keyboardType: TextInputType.text,
          //     autofocus: false,
          //     decoration: new InputDecoration(
          //       hintText: "Height",
          //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(32.0)),
          //     ),
          //     onChanged: (val) => setState(() => height = val),
          //   ),
          // ),

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
          // ListTile(
          //   title: new TextFormField(
          //     initialValue: lmp,
          //     keyboardType: TextInputType.text,
          //     autofocus: false,
          //     decoration: new InputDecoration(
          //       hintText: "LMP",
          //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(32.0)),
          //     ),
          //     onChanged: (val) => setState(() => lmp = val),
          //   ),
          // ),

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
          // ListTile(
          //   title: new TextFormField(
          //     initialValue: spo2,
          //     keyboardType: TextInputType.text,
          //     autofocus: false,
          //     decoration: new InputDecoration(
          //       hintText: "SPO2",
          //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(32.0)),
          //     ),
          //     onChanged: (val) => setState(() => spo2 = val),
          //   ),
          // ),

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
                        print(val);
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
              // ListTile(
              //   title: Container(
              //     padding: EdgeInsets.symmetric(horizontal: 20),
              //     width: MediaQuery.of(context).size.width,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(32),
              //       border: Border.all(width: 1, color: Color(0xFFA4A4A4)),
              //     ),
              //     child: DropdownButtonHideUnderline(
              //       child: DropdownButton<String>(
              //         isExpanded: true,
              //         value: selectedDrugAlergy,
              //         items: <String>['Unknown', 'Known'].map((String value) {
              //           return DropdownMenuItem<String>(
              //             value: value,
              //             child: Text(value),
              //           );
              //         }).toList(),
              //         onChanged: (val) {
              //           setState(() {
              //             selectedDrugAlergy = val!;
              //           });
              //         },
              //       ),
              //     ),
              //   ),
              // ),

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
          ListTile(
            title: Card(
              borderOnForeground: true,
              color: kWhiteShadow,
              elevation: 4,
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
                            left: 12.0, top: 10.0, right: 0.0, bottom: 5.0),
                        child: Text(
                          'Brand Name',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Segoe',
                              fontSize: 18.0,
                              color: kBaseColor,
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
                              left: 0.0, top: 10.0, right: 0.0, bottom: 5.0),
                          child: Text(
                            'Medicine Category',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Segoe',
                                fontSize: 18.0,
                                color: kBaseColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
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
                              left: 0.0, top: 10.0, right: 0.0, bottom: 5.0),
                          child: Text(
                            'Group',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Segoe',
                                fontSize: 18.0,
                                color: kBaseColor,
                                fontWeight: FontWeight.w600),
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
                            left: 20.0, top: 0.0, right: 0.0, bottom: 10.0),
                        child: Text(
                          'Company Name',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Segoe',
                              fontSize: 18.0,
                              color: kBaseColor,
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
                              left: 0.0, top: 0.0, right: 0.0, bottom: 10.0),
                          child: Text(
                            'Price',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Segoe',
                                fontSize: 18.0,
                                color: kBaseColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Container(
                          height: 30,
                          child: VerticalDivider(
                            color: Colors.black54,
                            thickness: 0.8,
                          )),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 0.0, top: 0.0, right: 0.0, bottom: 10.0),
                          child: Text(
                            'FDA Approved',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Segoe',
                                fontSize: 18.0,
                                color: kBaseColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // ListTile(
          //   title: Container(
          //     child: SimpleAutocompleteFormField<Brand>(
          //       decoration: InputDecoration(
          //         hintText: "Type Brand Name",
          //         contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(32.0)),
          //       ),
          //       suggestionsHeight: 80.0,
          //       itemBuilder: (context, person) => Padding(
          //         padding: EdgeInsets.all(8.0),
          //         child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(person!.name,
          //                   style: TextStyle(fontWeight: FontWeight.bold)),
          //               Text(person.address)
          //             ]),
          //       ),
          //       onSearch: (search) async => brand
          //           .where((person) =>
          //               person.name
          //                   .toLowerCase()
          //                   .contains(search.toLowerCase()) ||
          //               person.address
          //                   .toLowerCase()
          //                   .contains(search.toLowerCase()))
          //           .toList(),
          //       itemFromString: (string) => brand.singleWhereOrNull((person) =>
          //           person.name.toLowerCase() == string.toLowerCase()),
          //       onChanged: (value) => setState(() => selectedBrand = value),
          //       onSaved: (value) => setState(() => selectedBrand = value),
          //       validator: (person) =>
          //           person == null ? 'Invalid person.' : null,
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 10,
          ),
          // ListTile(
          //   title: Container(
          //     child: SimpleAutocompleteFormField<Brand>(
          //       decoration: InputDecoration(
          //         hintText: "Type Dose",
          //         contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(32.0)),
          //       ),
          //       suggestionsHeight: 80.0,
          //       itemBuilder: (context, person) => Padding(
          //         padding: EdgeInsets.all(8.0),
          //         child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(person!.name,
          //                   style: TextStyle(fontWeight: FontWeight.bold)),
          //               Text(person.address)
          //             ]),
          //       ),
          //       onSearch: (search) async => brand
          //           .where((person) =>
          //               person.name
          //                   .toLowerCase()
          //                   .contains(search.toLowerCase()) ||
          //               person.address
          //                   .toLowerCase()
          //                   .contains(search.toLowerCase()))
          //           .toList(),
          //       itemFromString: (string) => brand.singleWhereOrNull((person) =>
          //           person.name.toLowerCase() == string.toLowerCase()),
          //       onChanged: (value) => setState(() => selectedBrand = value),
          //       onSaved: (value) => setState(() => selectedBrand = value),
          //       validator: (person) => person == null ? 'Invalid dose.' : null,
          //     ),
          //   ),
          // ),

          ListTile(
            title: new TextFormField(
              keyboardType: TextInputType.text,
              controller: _brandNameController,
              autofocus: false,
              decoration: new InputDecoration(
                hintText: "Type Brand Name",
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          ListTile(
            title: new TextFormField(
              keyboardType: TextInputType.text,
              controller: _typeDoseController,
              autofocus: false,
              decoration: new InputDecoration(
                hintText: "Type Dose",
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
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
          // ListTile(
          //   title: new TextFormField(
          //     keyboardType: TextInputType.text,
          //     controller: _durationController,
          //     autofocus: false,
          //     decoration: new InputDecoration(
          //       hintText: "Duration",
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
          //   title: Container(
          //     child: SimpleAutocompleteFormField<Brand>(
          //       decoration: InputDecoration(
          //         hintText: "Duration",
          //         contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(32.0)),
          //       ),
          //       suggestionsHeight: 80.0,
          //       itemBuilder: (context, person) => Padding(
          //         padding: EdgeInsets.all(8.0),
          //         child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(person!.name,
          //                   style: TextStyle(fontWeight: FontWeight.bold)),
          //               Text(person.address)
          //             ]),
          //       ),
          //       onSearch: (search) async => brand
          //           .where((person) =>
          //               person.name
          //                   .toLowerCase()
          //                   .contains(search.toLowerCase()) ||
          //               person.address
          //                   .toLowerCase()
          //                   .contains(search.toLowerCase()))
          //           .toList(),
          //       itemFromString: (string) => brand.singleWhereOrNull((person) =>
          //           person.name.toLowerCase() == string.toLowerCase()),
          //       onChanged: (value) => setState(() => selectedBrand = value),
          //       onSaved: (value) => setState(() => selectedBrand = value),
          //       validator: (person) =>
          //           person == null ? 'Invalid person.' : null,
          //     ),
          //   ),
          // ),
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

          // ListTile(
          //   title: TextFormField(
          //     keyboardType: TextInputType.multiline,
          //     decoration: InputDecoration(
          //       hintText: "",
          //       contentPadding:
          //           EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(10.0)),
          //     ),
          //     maxLines: 25,
          //     minLines: 6,
          //     scrollPadding: const EdgeInsets.all(20),
          //   ),
          // ),

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

          // ListTile(
          //   title: TextFormField(
          //     keyboardType: TextInputType.text,
          //     decoration: new InputDecoration(
          //       hintText: "Next Visit",
          //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(32.0)),
          //       suffixText: 'Month/Day',
          //       suffixStyle: TextStyle(color: kBodyTextColor),
          //     ),
          //     onChanged: (val) => setState(() => nextVisitText = val),
          //   ),
          // ),

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
          // ListTile(
          //   title: Container(
          //     child: SimpleAutocompleteFormField<NextVisit>(
          //       decoration: InputDecoration(
          //         hintText: "Next Visit",
          //         contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(32.0)),
          //       ),
          //       suggestionsHeight: 80.0,
          //       itemBuilder: (context, nextVisit) => Padding(
          //         padding: EdgeInsets.all(8.0),
          //         child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(nextVisit!.name,
          //                   style: TextStyle(fontWeight: FontWeight.bold)),
          //               Text(nextVisit.address)
          //             ]),
          //       ),
          //       onSearch: (search) async => nextVisit
          //           .where((nextVisit) =>
          //               nextVisit.name
          //                   .toLowerCase()
          //                   .contains(search.toLowerCase()) ||
          //               nextVisit.address
          //                   .toLowerCase()
          //                   .contains(search.toLowerCase()))
          //           .toList(),
          //       itemFromString: (string) => nextVisit.singleWhereOrNull(
          //           (nextVisit) =>
          //               nextVisit.name.toLowerCase() == string.toLowerCase()),
          //       onChanged: (value) => setState(() => selectedNextVisit = value),
          //       onSaved: (value) => setState(() => selectedNextVisit = value),
          //       validator: (nextVisit) =>
          //           nextVisit == null ? 'Invalid person.' : null,
          //     ),
          //   ),
          // ),
          // ListTile(
          //   title: Container(
          //     child: SimpleAutocompleteFormField<PaidTK>(
          //       decoration: InputDecoration(
          //         hintText: "Paid (TK)",
          //         contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(32.0)),
          //       ),
          //       suggestionsHeight: 80.0,
          //       itemBuilder: (context, paidTK) => Padding(
          //         padding: EdgeInsets.all(8.0),
          //         child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(paidTK!.name,
          //                   style: TextStyle(fontWeight: FontWeight.bold)),
          //               Text(paidTK.address)
          //             ]),
          //       ),
          //       onSearch: (search) async => paidTK
          //           .where((paidTK) =>
          //               paidTK.name
          //                   .toLowerCase()
          //                   .contains(search.toLowerCase()) ||
          //               paidTK.address
          //                   .toLowerCase()
          //                   .contains(search.toLowerCase()))
          //           .toList(),
          //       itemFromString: (string) => paidTK.singleWhereOrNull((paidTK) =>
          //           paidTK.name.toLowerCase() == string.toLowerCase()),
          //       onChanged: (value) => setState(() => selectedPaidTK = value),
          //       onSaved: (value) => setState(() => selectedPaidTK = value),
          //       validator: (paidTK) =>
          //           paidTK == null ? 'Invalid person.' : null,
          //     ),
          //   ),
          // ),
          ListTile(
            title: new TextFormField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                hintText: "Visit No.",
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              onChanged: (val) => setState(() => visitNoText = val),
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
          // ListTile(
          //   title: new TextField(
          //     //controller: _controller,
          //     keyboardType: TextInputType.text,
          //     decoration: new InputDecoration(
          //       hintText: "Diagnosis Advise",
          //       suffixIcon: IconButton(
          //         onPressed: addDiagnosisAdvise,
          //         icon: Icon(Icons.add),
          //       ),
          //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(32.0)),
          //     ),
          //   ),
          // ),
          // ListTile(
          //   title: Container(
          //     child: TypeAheadField<String?>(
          //       textFieldConfiguration: TextFieldConfiguration(
          //         controller: _diagnosisAdivceController,
          //         decoration: new InputDecoration(
          //           hintText: "Diagnosis Advices",
          //           contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //           border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(32.0),
          //           ),
          //           suffixIcon: IconButton(
          //             onPressed: () {
          //               if (_diagnosisAdivceController.text.isNotEmpty) {
          //                 if (!diagnosisAdviceEntry
          //                     .contains(_diagnosisAdivceController.text)) {
          //                   setState(() {
          //                     diagnosisAdviceEntry
          //                         .add(_diagnosisAdivceController.text);
          //                   });
          //                   _diagnosisAdivceController.clear();
          //                 }
          //               }
          //             },
          //             icon: Icon(Icons.add),
          //           ),
          //         ),
          //       ),
          //       debounceDuration: Duration(milliseconds: 500),
          //       suggestionsCallback: PrescriptionService.getCCSuggestions,
          //       itemBuilder: (context, String? suggestion) => ListTile(
          //         title: Text(suggestion!),
          //       ),
          //       onSuggestionSelected: (String? suggestion) {
          //         _diagnosisAdivceController.text = suggestion!;
          //       },
          //     ),
          //   ),
          // ),
          // ListTile(
          //   title: new TextFormField(
          //     keyboardType: TextInputType.text,
          //     autofocus: false,
          //     decoration: new InputDecoration(
          //       hintText: "Diagnosis Advice",
          //       suffixIcon: IconButton(
          //         // onPressed: addChiefComplaint,
          //         onPressed: () {
          //           if (_diagnosisAdivceController.text.isNotEmpty) {
          //             setState(() {
          //               diagnosisAdviceEntry
          //                   .add(_diagnosisAdivceController.text);
          //             });
          //             _diagnosisAdivceController.clear();
          //           }
          //         },
          //         icon: Icon(Icons.add),
          //       ),
          //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(32.0),
          //       ),
          //     ),
          //     controller: _diagnosisAdivceController,
          //   ),
          // ),
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
          // ListTile(
          //   title: new TextFormField(
          //     keyboardType: TextInputType.text,
          //     autofocus: false,
          //     decoration: new InputDecoration(
          //       hintText: "General Advice",
          //       suffixIcon: IconButton(
          //         // onPressed: addChiefComplaint,
          //         onPressed: () {
          //           if (_generalAdivceController.text.isNotEmpty) {
          //             setState(() {
          //               generalAdviceEntry.add(_generalAdivceController.text);
          //             });
          //             _generalAdivceController.clear();
          //           }
          //         },
          //         icon: Icon(Icons.add),
          //       ),
          //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(32.0),
          //       ),
          //     ),
          //     controller: _generalAdivceController,
          //   ),
          // ),
          // generalAdviceEntry.length > 0
          //     ? ListTile(
          //         title: ListView.builder(
          //             shrinkWrap: true,
          //             scrollDirection: Axis.vertical,
          //             itemCount: generalAdviceEntry.length,
          //             itemBuilder: (BuildContext context, int index) {
          //               return Text(generalAdviceEntry[index]);
          //             }))
          //     : Container(),
          // ListTile(
          //   title: new TextField(
          //     keyboardType: TextInputType.text,
          //     autofocus: false,
          //     decoration: new InputDecoration(
          //       hintText: "General Advise",
          //       suffixIcon: IconButton(
          //         onPressed: addGeneralAdvise,
          //         icon: Icon(Icons.add),
          //       ),
          //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(32.0)),
          //     ),
          //   ),
          // ),
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

          print('returned prescription id : ${returnMap['prescriptionID']}');

          final url = '${returnMap['pdfUrl']}';
          final fileName = '${returnMap['prescriptionID']}';
          final file = await PdfApi.loadNetwork(url, fileName);

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PdfViewPage(pdfFile: file),
            ),
          );

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => PdfViewPage(
          //         // path: generatedPdfFilePath,
          //         path: fullPath,
          //         fileType: 'file',
          //         pdfFile: generatedPdfFile),
          //   ),
          // );
        },
        // onPressed: () async {
        //   Prescription prescription = makePrescription();
        //   // final pdfFile = await PdfPrescription.generate(prescription);
        //   final pdfFile = await SfPdfPrescription.generate(prescription);

        //   // writeOnPdf();
        //   // await savePdf();
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => PdfViewPage(
        //         // path: generatedPdfFilePath,
        //         path: fullPath,
        //         fileType: 'file',
        //         pdfFile: pdfFile,
        //       ),
        //       // pdfFile: generatedPdfFile),
        //     ),
        //   );
        // },
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
            true,
          );

          print('returned prescription id : ${returnMap['prescriptionID']}');

          final url = '${returnMap['pdfUrl']}';
          final fileName = '${returnMap['prescriptionID']}';
          final file = await PdfApi.loadNetwork(url, fileName);
          // openPDF(context, file);

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PdfViewPage(
                  pdfFile: file,
                  path: url,
                  bmdcNo: bmdcNmuber,
                  memberId: memberId,
                  doctorId: doctorId,
                  title: '${returnMap['prescriptionID']}'),
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
            false,
          );

          print('returned prescription id : ${returnMap['prescriptionID']}');

          final url = '${returnMap['pdfUrl']}';
          final fileName = '${returnMap['prescriptionID']}';
          await PdfApi.shareFile(url, fileName);

          // openPDF(context, file);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
        color: kWhiteShadow,
        child: Text('Send to Patient',
            style: TextStyle(
                fontFamily: "Segoe",
                fontSize: 15,
                color: kBaseColor,
                fontWeight: FontWeight.w700)),
      ),
    );

    //Old Patient

    final oldPatientSearch = Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: new FindDropdown<UserModel>(
        label: 'Patient Search/Select',
        labelStyle: TextStyle(
          fontFamily: 'Segoe',
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        showSearchBox: true,
        searchBoxDecoration: InputDecoration(
            hintText: 'By Name or Phone Number',
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
            prefixIcon: Icon(Icons.search)),
        onFind: (String filter) => getData(filter).then((value) => value!),
        onChanged: (UserModel? data) {
          print(data);
        },
        dropdownBuilder: (BuildContext context, UserModel? item) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
            ),
            child: (item?.avatar == null)
                ? ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 40.0,
                      child: Icon(
                        Icons.wheelchair_pickup_outlined,
                        size: 35,
                      ),
                      //Image.asset('assets/apatient.png'),
                    ),
                    title: Text("No patient selected"),
                  )
                : ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(item!.avatar!),
                    ),
                    title: Text(item.name!),
                    subtitle: Text(item.createdAt.toString()),
                  ),
          );
        },
        dropdownItemBuilder:
            (BuildContext context, UserModel item, bool isSelected) {
          return Container(
            decoration: !isSelected
                ? null
                : BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
            child: ListTile(
              selected: isSelected,
              title: Text(item.name!),
              subtitle: Text(item.createdAt.toString()),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(item.avatar!),
              ),
            ),
          );
        },
      ),
    );

    final editPrescription = Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 90),
      child: MaterialButton(
        onPressed: () {
          savePdf();
          // Navigator.of(context).pushNamed('');
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
        color: kWhiteShadow,
        child: Text('Edit Prescription',
            style: TextStyle(
                fontFamily: "Segoe",
                fontSize: 15,
                color: kBaseColor,
                fontWeight: FontWeight.w700)),
      ),
    );

    return Material(
      child: DefaultTabController(
        length: 2,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
              drawer: CustomDrawerDoctor(),
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: kBaseColor,
                iconTheme: IconThemeData(color: kTitleColor),
                toolbarHeight: 50,
                elevation: 2.0,
                title: Text('Prescription',
                    style: TextStyle(fontFamily: 'Segoe', color: kTitleColor)),
              ),
              backgroundColor: kBackgroundColor,
              body: Center(
                child: Column(
                  children: [
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
                            labelColor: kBackgroundColor,
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
                                          color: kBaseColor, width: 1.2)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Follow-Up Patient",
                                      style: TextStyle(
                                          fontFamily: 'Segoe',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  width: 205,
                                  height: 34,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: kBaseColor, width: 1.2)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "New Patient",
                                      style: TextStyle(
                                          fontFamily: 'Segoe',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(children: <Widget>[
                        Container(
                          color: kBackgroundColor,
                          child: ListView(
                            padding: EdgeInsets.all(4),
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              oldPatientSearch,
                              SizedBox(
                                height: 0,
                              ),
                              editPrescription
                            ],
                          ),
                        ),
                        Container(
                          color: kBackgroundColor,
                          child: ListView(
                            children: [
                              SizedBox(
                                height: 20,
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
                            ],
                          ),
                          //color: kBackgroundColor,
                        ),
                        //Icon(Icons.movie),
                      ]),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Future<List<UserModel>?> getData(filter) async {
    var response = await Dio().get(
      "http://5d85ccfb1e61af001471bf60.mockapi.io/user",
      queryParameters: {"filter": filter},
    );

    var models = UserModel.fromJsonList(response.data);
    return models;
  }

  addDiseaseCondition() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Add New Disease Condition"),
              content: new Text(
                  "Hey! Are you sure? You want to add new Disease Condition!"),
              actions: <Widget>[
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  padding: EdgeInsets.all(10),
                  color: kButtonColor,
                  child: Text('Cancel',
                      style: TextStyle(
                          fontFamily: "Poppins-Bold",
                          fontSize: 14,
                          color: Colors.white)),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  padding: EdgeInsets.all(10),
                  color: kButtonColor,
                  child: Text('Add',
                      style: TextStyle(
                          fontFamily: "Poppins-Bold",
                          fontSize: 14,
                          color: Colors.white)),
                ),
              ],
            ));
  }

  addChiefComplaint() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Add New Chief Complaint"),
              content: new Text("Hey! I'm from Chief Complaint!"),
              actions: <Widget>[
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  padding: EdgeInsets.all(10),
                  color: kButtonColor,
                  child: Text('Cancel',
                      style: TextStyle(
                          fontFamily: "Poppins-Bold",
                          fontSize: 14,
                          color: Colors.white)),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  padding: EdgeInsets.all(10),
                  color: kButtonColor,
                  child: Text('Add',
                      style: TextStyle(
                          fontFamily: "Poppins-Bold",
                          fontSize: 14,
                          color: Colors.white)),
                ),
              ],
            ));
  }

  addGeneralAdvise() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Add New General Advise"),
              content: new Text("Hey! I'm from General Advises!"),
              actions: <Widget>[
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  padding: EdgeInsets.all(10),
                  color: kButtonColor,
                  child: Text('Cancel',
                      style: TextStyle(
                          fontFamily: "Poppins-Bold",
                          fontSize: 14,
                          color: Colors.white)),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  padding: EdgeInsets.all(10),
                  color: kButtonColor,
                  child: Text('Add',
                      style: TextStyle(
                          fontFamily: "Poppins-Bold",
                          fontSize: 14,
                          color: Colors.white)),
                ),
              ],
            ));
  }

  addDiagnosisAdvise() {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text("Add New Diagnosis Advise"),
        content: new Text("Hey! I'm from Diagnosis Advises!"),
        actions: <Widget>[
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            padding: EdgeInsets.all(10),
            color: kButtonColor,
            child: Text('Cancel',
                style: TextStyle(
                    fontFamily: "Poppins-Bold",
                    fontSize: 14,
                    color: Colors.white)),
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            padding: EdgeInsets.all(10),
            color: kButtonColor,
            child: Text('Add',
                style: TextStyle(
                    fontFamily: "Poppins-Bold",
                    fontSize: 14,
                    color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// class PdfPreviewScreen extends StatelessWidget {
//   final String? path;
//   final generatedPdfFile;
//   final fileType;

//   PdfPreviewScreen({
//     this.path,
//     appBarAppBar,
//     AppBar? appBar,
//     this.generatedPdfFile,
//     this.fileType,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return PdfViewPage(
//         path: path, fileType: fileType, pdfFile: generatedPdfFile);
//     // return PDFViewerScaffold(
//     //   appBar: AppBar(title: Text("Generated PDF Document")),
//     //   path: path,
//     // );
//   }
// }

class PaidTK {
  PaidTK(this.name, this.address);
  final String name, address;
  @override
  String toString() => name;
}

class NextVisit {
  NextVisit(this.name, this.address);
  final String name, address;
  @override
  String toString() => name;
}

class Brand {
  Brand(this.name, this.address);
  final String name, address;
  @override
  String toString() => name;
}

class NewPatient {
  NewPatient(this.name, this.phone);
  final String name, phone;
  @override
  String toString() => name;
}

class UserModel {
  final String? id;
  final DateTime? createdAt;
  final String? name;
  final String? avatar;

  UserModel({this.id, this.createdAt, this.name, this.avatar});

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    if (json == null)
      return UserModel(id: null, createdAt: null, name: null, avatar: null);
    return UserModel(
      id: json["id"],
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      name: json["name"],
      avatar: json["avatar"],
    );
  }

  static List<UserModel>? fromJsonList(List? list) {
    if (list == null) return null;
    return list.map((item) => UserModel.fromJson(item)).toList();
  }
}
