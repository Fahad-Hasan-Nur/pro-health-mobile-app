// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:pro_health/base/utils/ApiList.dart';
import 'package:pro_health/doctor/models/generate_uid.dart';
import 'package:pro_health/doctor/models/medication_model.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/data.dart';
import 'package:http/http.dart' as http;

// generatePrescriptionId() {
//   var nanoId = nanoid();
//   var uuid = Uuid();
//   var time = DateTime.now().toLocal();
//   var randomCode = Random().nextInt(100000) + 1000000;

//   var id = uuid.v1();

//   // var prescriptionId = '$nanoId$id$randomCode${time.microsecondsSinceEpoch}';
//   var prescriptionId = '$id${time.microsecondsSinceEpoch}';
//   return prescriptionId;
// }

generatePrescriptionId(var patientPhone) async {
  var prescriptionId = '';
  var url = Uri.parse(uidApi + patientPhone.toString());

  List ids = [];
  // print('url $url');

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    for (var item in jsonResponse) {
      ids.add(GenerateUidModel.fromJson(item));
    }
  }

  // print(ids.length);

  var year = DateTime.now().year.toString().substring(2);
  var month = DateTime.now().month;
  var day = DateTime.now().day;
  var newMonth = month < 10 ? '0$month' : '$month';

  var pid = '';
  if (ids.length == 0) {
    pid = '001';
  } else if (ids.length < 10) {
    pid = '00${ids.length + 1}';
  } else if (ids.length < 100) {
    pid = '0${ids.length + 1}';
  } else {
    pid = '${ids.length + 1}';
  }

  prescriptionId = '$year$newMonth${patientPhone.substring(0, 11)}$pid';

  print(prescriptionId);

  return prescriptionId;
}

class PrescriptionService {
  static Future<List<String>> getCCSuggestions(String query) async {
    var url = Uri.parse(chiefComplaintApi);
    List<String> cc = [];
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final List ccList = json.decode(response.body);

        for (var item in ccList) {
          if (item['chiefComplainName'] != null ||
              item['chiefComplainName'].isNotEmpty) {
            cc.add(item['chiefComplainName']);
          }
        }
      }
    } catch (e) {
      throw Exception();
    }

    return List.of(cc).where((cc) {
      final ccLower = cc.toLowerCase();
      final queryLower = query.toLowerCase();

      return ccLower.contains(queryLower);
    }).toList();
  }

  // duration suggestion

  static Future<List<String>> getDurationSuggestions(String query) async {
    var url = Uri.parse(durationApi);
    List<String> duration = [];
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final List durationList = json.decode(response.body);

        for (var item in durationList) {
          if (item['details'] != null || item['details'].isNotEmpty) {
            duration.add(item['details']);
          }
        }
      }
    } catch (e) {
      throw Exception();
    }

    return List.of(duration).where((d) {
      final durationLower = d.toLowerCase();
      final queryLower = query.toLowerCase();

      return durationLower.contains(queryLower);
    }).toList();
  }

  static Future<List<String>> getDoseSuggestion(String query) async {
    List<String> dose = [
      '0 + 0 + 1',
      '0 + 1 + 1',
      '1 + 1 + 1',
      '1 + 0 + 1',
      '1 + 0 + 0',
      '0 + 1 + 0',
    ];
    return List.of(dose).where((d) {
      final durationLower = d.toLowerCase();
      final queryLower = query.toLowerCase();

      return durationLower.contains(queryLower);
    }).toList();
  }

  // need to cahnge for diagnosis advice calculation

  static Future<List<String>> getDiagnosisAdviceSuggestions(
      String query) async {
    var url = Uri.parse(diagnosisAdviceApi);
    List<String> diagnosisAdvices = [];
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final List diagnosisAdvicesList = json.decode(response.body);
        print(diagnosisAdvicesList.length);

        for (var item in diagnosisAdvicesList) {
          if (item['advice'] != null || item['advice'].isNotEmpty) {
            diagnosisAdvices.add(item['advice']);
          }
        }
      }
    } catch (e) {
      // throw Exception();
    }

    return List.of(diagnosisAdvices).where((advice) {
      final adviceLower = advice.toLowerCase();
      final queryLower = query.toLowerCase();

      return adviceLower.contains(queryLower);
    }).toList();
  }

  static Future<List<String>> getGeneralAdviceSuggestions(String query) async {
    var url = Uri.parse(generalAdviceApi);
    List<String> generalAdvices = [];
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final List generalAdvicesList = json.decode(response.body);

        for (var item in generalAdvicesList) {
          if (item['advice'] != null || item['advice'].isNotEmpty) {
            generalAdvices.add(item['advice']);
          }
        }
      }
    } catch (e) {
      // throw Exception();
    }

    return List.of(generalAdvices).where((advice) {
      final adviceLower = advice.toLowerCase();
      final queryLower = query.toLowerCase();

      return adviceLower.contains(queryLower);
    }).toList();
  }

  static Future<List<String>> getSPO2Suggestions(String query) async {
    DataList dataList = DataList();

    List<String> spo2List = dataList.spo2PercentList;

    return List.of(spo2List).where((spo2) {
      final spo2Lower = spo2.toLowerCase();
      final queryLower = query.toLowerCase();

      return spo2Lower.contains(queryLower);
    }).toList();
  }

  // disease condition
  static Future<List<String>> getDiseaseConditionSuggestions(
      String query) async {
    var url = Uri.parse(diseaseConditionApi);
    List<String> diseaseConditions = [];
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final List diseaseConditionsList = json.decode(response.body);

        for (var item in diseaseConditionsList) {
          if (item['diseaseConditionName'] != null ||
              item['diseaseConditionName'].isNotEmpty) {
            diseaseConditions.add(item['diseaseConditionName']);
          }
        }
      }
    } catch (e) {
      throw Exception();
    }

    return List.of(diseaseConditions).where((disease) {
      final diseaseLower = disease.toLowerCase();
      final queryLower = query.toLowerCase();

      return diseaseLower.contains(queryLower);
    }).toList();
  }

  // drug history
  static Future<List<String>> getDrugHistorySuggestions(String query) async {
    var url = Uri.parse(historyApi);
    List<String> drugHistoryList = [];
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final List drugHistoryJson = json.decode(response.body);

        for (var item in drugHistoryJson) {
          if (item['historyType'].toString().toLowerCase().trim() == 'drug') {
            if (item['details'] != null || item['details'].isNotEmpty) {
              drugHistoryList.add(item['details']);
            }
          }
        }
      }
    } catch (e) {
      // throw Exception();
    }

    return List.of(drugHistoryList).where((drugHistory) {
      final drugHistoryLower = drugHistory.toLowerCase();
      final queryLower = query.toLowerCase();

      return drugHistoryLower.contains(queryLower);
    }).toList();
  }

  // name suggestion
  static Future<List<String>> getNamesSuggestions(String query) async {
    var url = Uri.parse(historyApi);
    List<String> drugHistoryList = [];
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final List drugHistoryJson = json.decode(response.body);

        for (var item in drugHistoryJson) {
          if (item['historyType'].toString().toLowerCase().trim() == 'drug') {
            if (item['details'] != null || item['details'].isNotEmpty) {
              drugHistoryList.add(item['details']);
            }
          }
        }
      }
    } catch (e) {
      // throw Exception();
    }

    return List.of(drugHistoryList).where((drugHistory) {
      final drugHistoryLower = drugHistory.toLowerCase();
      final queryLower = query.toLowerCase();

      return drugHistoryLower.contains(queryLower);
    }).toList();
  }

  static Future saveDiseaseConditionToDB(
      String diseaseConditionName, var memberId) async {
    var query =
        "insert into DiseaseCondition(MemberID, DiseaseConditionName) values('$memberId', N'$diseaseConditionName')";

    var url = Uri.parse(postApi + query);

    var response = await http.post(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future saveCCToDB(
      String chiefComplainName, var doctorId, var memberId) async {
    var query =
        "insert into ChiefComplain(MemberID, DoctorID, ChiefComplainName) values('$memberId', '$doctorId', N'$chiefComplainName')";
    print(query);
    var url = Uri.parse(postApi + query);

    var response = await http.post(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future saveHistoryToDB(var memberId, String historyType, String status,
      String details, var createOn) async {
    var query =
        "insert into History(MemberID, HistoryType, status, details, createOn) values('$memberId', N'$historyType', N'$status', N'$details','$createOn' )";
    print(query);
    var url = Uri.parse(postApi + query);

    var response = await http.post(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future saveDiagnosisAdivceToDB(var memberId, String advice) async {
    var query =
        "insert into DiagnosisAdvice(MemberID, Advice) values('$memberId', N'$advice')";
    print(query);
    var url = Uri.parse(postApi + query);

    var response = await http.post(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future saveGeneralAdivceToDB(var memberId, String advice) async {
    var query =
        "insert into advices(Memberid,Advice) values('$memberId', N'$advice')";
    print(query);
    var url = Uri.parse(postApi + query);

    var response = await http.post(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future savePrescription(
      var adviceList,
      var diagnosisAdviceList,
      var historyList,
      var oeMap,
      var ccList,
      var diseaseList,
      var prescriptionInfoMap,
      var medicineList,
      bool isSaving) async {
    var listOfQueries = [];
    // var prescriptionId = generatePrescriptionId();
    var prescriptionId =
        await generatePrescriptionId(prescriptionInfoMap['mobileNo']);
    // Generate generalAdvice queries
    var adviceQueries = generateAdvicesQuery(prescriptionId, adviceList);
    listOfQueries.addAll(adviceQueries);

    // Generate Diagnosis advice queries
    var diagnosisAdviceQueries =
        generateDiagnosisAdvicesQuery(prescriptionId, diagnosisAdviceList);
    listOfQueries.addAll(diagnosisAdviceQueries);

    // Generate History queries
    var historyQueries =
        generateHistoryQuery(prescriptionId, historyList, 'drug');
    listOfQueries.addAll(historyQueries);

    // generate OE query
    var oeQuery = generateOEQuery(prescriptionId, oeMap);
    listOfQueries.add(oeQuery);

    // generate CC query
    var ccQueries = generateCCQuery(prescriptionId, ccList);
    listOfQueries.addAll(ccQueries);

    // generate Disease Condition query
    var diseaseConditionQueries =
        generateDiseaseConditionQuery(prescriptionId, diseaseList);
    listOfQueries.addAll(diseaseConditionQueries);

    // generate Prescription query
    var prescriptionQuery =
        generatePrescriptionQuery(prescriptionId, prescriptionInfoMap);
    listOfQueries.add(prescriptionQuery);

    // generate Prescribed Medicine query
    var prescribedMedicineQuery =
        generatePrescribedMedicineQuery(prescriptionId, medicineList);
    listOfQueries.addAll(prescribedMedicineQuery);

    // joining all qeuries
    // var joinedQuery =
    //     listOfQueries.reduce((value, element) => '$value;$element');

    var joindAdviceQueries = adviceQueries.length > 0
        ? adviceQueries.reduce((value, element) => '$value;$element')
        : '';

    var joinedDiagnosisAdviceQueries = diagnosisAdviceQueries.length > 0
        ? diagnosisAdviceQueries.reduce((value, element) => '$value;$element')
        : '';

    var joinedHistoryQueries = historyQueries.length > 0
        ? historyQueries.reduce((value, element) => '$value;$element')
        : '';

    var joinedCcQueries = ccQueries.length > 0
        ? ccQueries.reduce((value, element) => '$value;$element')
        : '';

    var joinedDiseaseConditionQueries = diseaseConditionQueries.length > 0
        ? diseaseConditionQueries.reduce((value, element) => '$value;$element')
        : '';

    var joinedPrescribedMedicineQuery = prescribedMedicineQuery.length > 0
        ? prescribedMedicineQuery.reduce((value, element) => '$value;$element')
        : '';

    // print(joindAdviceQueries);
    // print(joinedDiagnosisAdviceQueries);
    // print(joinedHistoryQueries);
    // print(oeQuery);
    // print(prescriptionQuery);
    // print(joinedCcQueries);
    // print(joinedDiseaseConditionQueries);
    // print(joinedPrescribedMedicineQuery);

    // String newQuery =
    //     "$joindAdviceQueries;$joinedDiagnosisAdviceQueries;$joinedHistoryQueries;$oeQuery;$prescriptionQuery;$joinedCcQueries;$joinedDiseaseConditionQueries;$joinedPrescribedMedicineQuery";
    // print(newQuery);
    var adviceUrl = Uri.parse(postApi + joindAdviceQueries);
    var diagnosisAdviceUrl = Uri.parse(postApi + joinedDiagnosisAdviceQueries);
    var historyUrl = Uri.parse(postApi + joinedHistoryQueries);
    var oeUrl = Uri.parse(postApi + oeQuery);
    var prescriptionUrl = Uri.parse(postApi + prescriptionQuery);
    var ccUrl = Uri.parse(postApi + joinedCcQueries);
    var diseaseConditionUrl =
        Uri.parse(postApi + joinedDiseaseConditionQueries);
    var prescribedMedicineUrl =
        Uri.parse(postApi + joinedPrescribedMedicineQuery);

    // print(prescriptionId);

    var prescriptionResponse = await http.post(prescriptionUrl);
    var diseaseConditionResponse = await http.post(diseaseConditionUrl);
    var ccResponse = await http.post(ccUrl);
    var oeResponse = await http.post(oeUrl);
    var prescribedMedicineResponse = await http.post(prescribedMedicineUrl);
    var historyResponse = await http.post(historyUrl);
    var adviceResponse = await http.post(adviceUrl);
    var diagnosisAdviceResponse = await http.post(diagnosisAdviceUrl);

    Map<String, dynamic> returnMap = {};
    returnMap['prescriptionID'] = prescriptionId;
    // returnMap['pdfUrl'] = 'https://core.ac.uk/download/pdf/61806036.pdf';
    // returnMap['pdfUrl'] = 'https://core.ac.uk/download/pdf/61806036.pdf';
    returnMap['pdfUrl'] = reportLink + prescriptionId;
    print(returnMap['pdfUrl']);

    if (isSaving) {
      Map consultHistory = {};

      consultHistory['prescriptionUrl'] = reportLink + prescriptionId;
      consultHistory['patientID'] = prescriptionInfoMap['patientID'];
      consultHistory['doctorID'] = prescriptionInfoMap['doctorID'];
      consultHistory['bmdcNo'] = prescriptionInfoMap['bmdcNo'];
      consultHistory['memberID'] = prescriptionInfoMap['memberId'];
      consultHistory['patientName'] = prescriptionInfoMap['patientName'];
      consultHistory['patientPhone'] = prescriptionInfoMap['mobileNo'];
      saveConsultHistory(consultHistory);
    }

    return returnMap;

    // if (response.statusCode == 200 || response.statusCode == 201) {
    //   return true;
    // } // else {
    //   return false;
    // }
  }

  saveConsultHistory(Map consultHistory) async {
    var prescriptionUrl = consultHistory['prescriptionUrl'];
    var patientID = consultHistory['patientID'];
    var doctorID = consultHistory['doctorID'];
    var bmdcNo = consultHistory['bmdcNo'];
    var memberID = consultHistory['memberID'];
    var patientName = consultHistory['patientName'];
    var patientPhone = consultHistory['patientPhone'];
    var query =
        "insert into ConsultHistory(Prescription, PatientID, DoctorID, MemberID, PatientName, Phone, BmdcNo) values('$prescriptionUrl', '$patientID', '$doctorID', '$memberID', N'$patientName', '$patientPhone', '$bmdcNo')";

    var url = Uri.parse(postApi + query);

    print(query);

    var response = await http.post(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  printPrescription(
      String prescriptionUrl, int doctorId, int memberId, String bmdcNo) async {
    var query =
        "insert into PrintPdf(DoctorId, MemberId, PrescriptionUrl, BmdcNo, isPrinted) values('$doctorId', '$memberId', '$prescriptionUrl', '$bmdcNo','False')";
    var url = Uri.parse(postApi + query);

    var response = await http.post(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  generateOEQuery(var prescriptionId, var oeMap) {
    var bp = oeMap['bp'];
    var height = oeMap['height'];
    var weight = oeMap['weight'];
    var bmi = oeMap['bmi'];
    var lmp = oeMap['lmp'];
    var edd = oeMap['edd'];
    var pDose = oeMap['pDose'];
    var pulse = oeMap['pulse'];
    var spo2 = oeMap['spo2'];
    var rr = oeMap['rr'];
    var query =
        "insert into OE(PrescriptionId, BP, LMP, Edd, Height, Weight, BMI, Spo2, PDose, Pulse, RR) values('$prescriptionId', '$bp', '$lmp','$edd', '$height','$weight', '$bmi', '$spo2', '$pDose','$pulse','$rr')";
    return query;
  }

  generatePrescriptionQuery(var prescriptionId, var prescriptionInfoMap) {
    var memberId = prescriptionInfoMap['memberId'];
    var doctorID = prescriptionInfoMap['doctorID'];
    var bmdcNo = prescriptionInfoMap['bmdcNo'];
    var patientID = prescriptionInfoMap['patientID'];
    var drugAllergy = prescriptionInfoMap['drugAllergy'];
    var foodAllergy = prescriptionInfoMap['foodAllergy'];
    var createOn = prescriptionInfoMap['createOn'];
    var patientName = prescriptionInfoMap['patientName'];
    var age = prescriptionInfoMap['age'];
    var dist = prescriptionInfoMap['dist'];
    var postOffice = prescriptionInfoMap['postOffice'];
    var currentDate = prescriptionInfoMap['currentDate'];
    var mobileNo = prescriptionInfoMap['mobileNo'];
    var gender = prescriptionInfoMap['gender'];
    var referenceBy = prescriptionInfoMap['referenceBy'];
    var thana = prescriptionInfoMap['thana'];
    var nextVisit = prescriptionInfoMap['nextVisit'];
    var paidTaka = prescriptionInfoMap['paidTaka'];
    var visitNo = prescriptionInfoMap['visitNo'];

    print('prescription id = $prescriptionId,  info map $prescriptionInfoMap');

    var query =
        "insert into NewPrescription(PrescriptionId, MemberID, DoctorID, PatientID, DrugAllergy, FoodAllergy, CreateOn, PatientName, Age, Dist, PostOffice, CurrentDate, MobileNo, Gender, ReferenceBy, Thana, NextVisit, PaidTaka, VisitNo, BmdcNo) values('$prescriptionId', '$memberId', '$doctorID','$patientID','$drugAllergy','$foodAllergy','$createOn', N'$patientName', '$age', N'$dist', N'$postOffice', '$currentDate', '$mobileNo', '$gender', N'$referenceBy', N'$thana', N'$nextVisit','$paidTaka','$visitNo', '$bmdcNo')";
    return query;
  }

  generateCCQuery(var prescriptionId, var ccList) {
    var listOfCCQuery = [];
    for (var cc in ccList) {
      var singleQuery =
          "insert into CCNew(PrescriptionId, Details) values('$prescriptionId', N'$cc')";
      listOfCCQuery.add(singleQuery);
    }
    return listOfCCQuery;
  }

  generatePrescribedMedicineQuery(var prescriptionId, var medicineList) {
    var listOfPrescribedMedicineQuery = [];
    for (var medicine in medicineList) {
      String brandName = medicine['BrandName'];
      String dose = medicine['Dose'];
      String duration = medicine['Duration'];
      String medicineCategory = medicine['MedicineCategory'];
      String medicineGroup = medicine['MedicineGroup'];
      String companyName = medicine['CompanyName'];
      String price = medicine['Price'];
      bool fdaApproved = medicine['FDAApproved'];
      int companyId = medicine['CompanyID'];
      int brandId = medicine['BrandId'];
      int genericId = medicine['GenericID'];
      bool beforeMeal = medicine['BeforeMeal'];
      bool afterMeal = medicine['AfterMeal'];
      var singleQuery =
          "insert into PrescribedMedicine(PrescriptionId, BrandName, Dose, Duration, MedicineCategory, MedicineGroup, CompanyName, Price, FDAApproved, CompanyID, BrandId, GenericID, BeforeMeal, AfterMeal) values('$prescriptionId', '$brandName', '$dose', '$duration', '$medicineCategory', '$medicineGroup', '$companyName', '$price','$fdaApproved','$companyId','$brandId','$genericId', '$beforeMeal', '$afterMeal')";
      listOfPrescribedMedicineQuery.add(singleQuery);
    }
    return listOfPrescribedMedicineQuery;
  }

  generateDiseaseConditionQuery(var prescriptionId, var diseaseConditionList) {
    var listOfDiseaseConditionQuery = [];
    for (var disease in diseaseConditionList) {
      var singleQuery =
          "insert into DiseaseConditionNew(PrescriptionId, Details) values('$prescriptionId', N'$disease')";
      listOfDiseaseConditionQuery.add(singleQuery);
    }
    return listOfDiseaseConditionQuery;
  }

  generateAdvicesQuery(var prescriptionId, var adviceList) {
    var listOfAdviceQuery = [];
    for (var advice in adviceList) {
      var singleQuery =
          "insert into adviceNew(PrescriptionId, Advice) values('$prescriptionId', N'$advice')";
      listOfAdviceQuery.add(singleQuery);
    }
    return listOfAdviceQuery;
  }

  generateDiagnosisAdvicesQuery(var prescriptionId, var adviceList) {
    var listOfDiagnosisAdviceQuery = [];
    for (var advice in adviceList) {
      var singleQuery =
          "insert into diagnosisAdviceNew(PrescriptionId, Advice) values('$prescriptionId', N'$advice')";
      listOfDiagnosisAdviceQuery.add(singleQuery);
    }
    return listOfDiagnosisAdviceQuery;
  }

  generateHistoryQuery(var prescriptionId, var historyList, var type) {
    var listOfDiagnosisAdviceQuery = [];
    for (var history in historyList) {
      var singleQuery =
          "insert into HistoryNew(PrescriptionId, Details, HistoryType) values('$prescriptionId', N'$history', N'$type')";
      listOfDiagnosisAdviceQuery.add(singleQuery);
    }
    return listOfDiagnosisAdviceQuery;
  }

  Future<List<MedicationModel>> fetchMedicationList() async {
    List<MedicationModel> medicationList = [];

    var url = Uri.parse(medicationApi);

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          medicationList.add(MedicationModel.fromJson(item));
        }
      }
    } catch (e) {
      //
    }

    return medicationList;
  }
}
