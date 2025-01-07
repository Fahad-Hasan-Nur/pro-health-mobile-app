// ignore_for_file: unused_catch_clause, unused_local_variable

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:pro_health/base/helper_functions.dart';
// import 'package:path/path.dart';
import 'package:pro_health/base/utils/ApiList.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/models/Api_response.dart';
import 'package:pro_health/doctor/models/case%20exchange/case_comment_model.dart';
import 'package:pro_health/doctor/models/case%20exchange/case_exchange_model.dart';
import 'package:pro_health/doctor/models/case%20exchange/case_like_model.dart';
import 'package:pro_health/doctor/models/case%20exchange/case_photo_model.dart';
import 'package:pro_health/doctor/models/chat/chat_list.dart';
import 'package:pro_health/doctor/models/chat/single_chat_model.dart';
import 'package:pro_health/doctor/models/consult%20history/consult_history.dart';
import 'package:pro_health/doctor/models/district_model.dart';
import 'package:pro_health/doctor/models/doctorReviewModel.dart';
import 'package:pro_health/doctor/models/doctor_model.dart';
// import 'package:pro_health/doctor/models/consultationModel.dart';
import 'package:pro_health/doctor/models/doctor_speciality_model.dart';
import 'package:pro_health/doctor/models/online%20consultation/online_consultations.dart';
import 'package:pro_health/doctor/models/payment_method.dart';
import 'package:pro_health/doctor/models/police_station_model.dart';
import 'package:pro_health/doctor/models/post_office_model.dart';
import 'package:pro_health/doctor/models/profile/doctor_experience.dart';
import 'package:pro_health/doctor/models/profile/doctor_profile_model.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/models/next_visit.dart';
import 'package:pro_health/doctor/views/dashboard/case_exchange/case_exchange_api_model.dart';
import 'package:pro_health/patient/models/doctor_slider.dart';
// import 'package:pro_health/doctor/models/profile/doctor_profile_model.dart';

class ApiServices {
  Future fetchDoctorProfile(var doctorMemberId) async {
    var doctorProfile = [];
    var url = Uri.parse(doctorProfileApi + doctorMemberId.toString());

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var doctorInfo = json.decode(response.body);
      for (var doctor in doctorInfo) {
        doctorProfile.add(doctor);
      }
    }
    return doctorProfile;
  }

  Future<List<DoctorProfileModel>> getDoctorProfile(int doctorMemberId) async {
    List<DoctorProfileModel> doctorProfile = [];
    var url = Uri.parse(doctorProfileApi + doctorMemberId.toString());

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var doctorInfo = json.decode(response.body);
      for (var doctor in doctorInfo) {
        doctorProfile.add(DoctorProfileModel.fromJson(doctor));
      }
    }
    return doctorProfile;
  }

  Future<List<DoctorSpecialityModel>> fetchSpeciality() async {
    List<DoctorSpecialityModel> doctorSpeciality = [];
    var url = Uri.parse(doctorSpecialityApi);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var specialities = json.decode(response.body);
      for (var speciality in specialities) {
        doctorSpeciality.add(DoctorSpecialityModel.fromJson(speciality));
      }
    }
    return doctorSpeciality;
  }

  Future updateDoctorInfo(Map doctorInfoMap, Map chamberInfoMap, var memberid,
      var experienceList) async {
    var doctorName = doctorInfoMap['doctorName'];
    var doctorID = doctorInfoMap['doctorID'];
    var selectedGender = doctorInfoMap['gender'];
    var experience = doctorInfoMap['experience'];
    var dob = doctorInfoMap['dateOfBirth'];
    var editDoctorWorkPlace = doctorInfoMap['workingPlace'];
    var editDoctorConsultationFeeOnline =
        doctorInfoMap['consultationFeeOnline'];
    var editDoctorConsultationFeePhysical =
        doctorInfoMap['consultationFeePhysical'];
    var editDoctorFollowupFee = doctorInfoMap['followupFee'];
    var editDoctorProfilePic = doctorInfoMap['profilePicture'];
    var editDoctorNameBangla = doctorInfoMap['doctorNameBangla'];
    var editWorkingPlaceBangla = doctorInfoMap['workingPlaceBangla'];
    var qualificationOne = doctorInfoMap['qualificationOne'];
    var qualificationTwo = doctorInfoMap['qualificationTwo'];
    var qualificationOneBangla = doctorInfoMap['qualificationOneBangla'];
    var qualificationTwoBangla = doctorInfoMap['qualificationTwoBangla'];
    var designationOne = doctorInfoMap['designationOne'];
    var designationTwo = doctorInfoMap['designationTwo'];
    var designationOneBangla = doctorInfoMap['designationOneBangla'];
    var designationTwoBangla = doctorInfoMap['designationTwoBangla'];

    var selectedSpecialityId = doctorInfoMap['specialityId'];

    var doctorTablequery =
        "UPDATE Doctor SET SpecialityID ='$selectedSpecialityId', DoctorName = N'$doctorName', DateOfBirth = '$dob', Gender = '$selectedGender', Experience = N'$experience', WorkingPlace = N'$editDoctorWorkPlace', ConsultationFeeOnline = N'$editDoctorConsultationFeeOnline', ConsultationFeePhysical = N'$editDoctorConsultationFeePhysical', FollowupFee = N'$editDoctorFollowupFee', ProfilePicture = '$editDoctorProfilePic', DoctorNameBangla = N'$editDoctorNameBangla', WorkingPlaceBangla = N'$editWorkingPlaceBangla', QualificationOne = N'$qualificationOne', QualificationTwo = N'$qualificationTwo', QualificationOneBangla = N'$qualificationOneBangla', QualificationTwoBangla = N'$qualificationTwoBangla', DesignationOne = N'$designationOne', DesignationTwo = N'$designationTwo', DesignationOneBangla = N'$designationOneBangla', DesignationTwoBangla = N'$designationTwoBangla' where MemberId = '$memberid'";
    // var consultationTableQuery =
    //     "Update Consultation SET ConsultationDay = '$consultationDay', ConsultationStartTime ='$consultationStartTime', ConsultationEndTime ='$consultationEndTime' where MemberID = '$memberid'";

    var chamberDoctorTableQuery =
        generateChamberDoctorQuery(chamberInfoMap, memberid, doctorID);

    var experienceTableQuery =
        generateExperienceQuery(experienceList, memberid);

    var query =
        '$doctorTablequery;$chamberDoctorTableQuery;$experienceTableQuery';

    var doctorUrl = Uri.parse(postApi + doctorTablequery);
    var doctorResponse = await http.post(doctorUrl);

    var chamberUrl = Uri.parse(postApi + chamberDoctorTableQuery);
    var chamberResponse = await http.post(chamberUrl);

    var experienceUrl = Uri.parse(postApi + experienceTableQuery);
    // print(experienceTableQuery);
    var experieceResponse = await http.post(experienceUrl);

    return doctorResponse.statusCode;
  }

  generateExperienceQuery(var experienceList, var memberid) {
    var listOfExpQuery = [];
    var joindExpQueries = '';

    listOfExpQuery.add("delete from experience where memberid = '$memberid'");

    for (var exp in experienceList) {
      var experienceID = exp['experienceID'] ?? 0;
      var doctorID = exp['doctorID'] ?? 0;
      var memberID = exp['memberID'] ?? 0;
      var hospitalName = exp['hospitalName'] ?? '';
      var designation = exp['designation'] ?? '';
      var department = exp['department'] ?? '';
      var duration = exp['duration'] ?? '';
      var workingPeriod = exp['workingPeriod'] ?? '';

      var query =
          "insert into Experience(DoctorID, MemberID, HospitalName, Designation, Department, Duration, WorkingPeriod) values('$doctorID', '$memberID', N'$hospitalName', N'$designation', N'$department', N'$duration', N'$workingPeriod')";

      // if (experienceID == 0) {
      //   query =
      //       "insert into Experience(DoctorID, MemberID, HospitalName, Designation, Department, Duration, WorkingPeriod) values('$doctorID', '$memberID', '$hospitalName', '$designation', '$department', '$duration', '$workingPeriod')";
      // } else {
      //   query =
      //       "Update Experience SET HospitalName = '$hospitalName', Designation ='$designation', Department = '$department', Duration ='$duration ', WorkingPeriod = '$workingPeriod' where MemberID = '$memberID'";
      // }

      // delete from experience where memberid = '8'

      listOfExpQuery.add(query);
    }

    joindExpQueries = listOfExpQuery.length > 0
        ? listOfExpQuery.reduce((value, element) => '$value;$element')
        : '';

    return joindExpQueries;
  }

  generateChamberDoctorQuery(Map chamberInfoMap, var memberId, var doctorId) {
    int chamberDoctorId = chamberInfoMap['chamberDoctorID'] ?? 0;

    var chamberOneAddress = chamberInfoMap['chamberOneAddress'] ?? '';
    var chamberTwoAddress = chamberInfoMap['chamberTwoAddress'];
    var chamberOneConsultDay = chamberInfoMap['chamberOneConsultDay'];

    var chamberTwoConsultDay = chamberInfoMap['chamberTwoConsultDay'];

    var chamberOneConsultTime = chamberInfoMap['chamberOneConsultTime'];
    var chamberOneConsultTimeBangla =
        chamberInfoMap['chamberOneConsultTimeBangla'];
    var chamberTwoConsultTime = chamberInfoMap['chamberTwoConsultTime'];
    var chamberTwoConsultTimeBangla =
        chamberInfoMap['chamberTwoConsultTimeBangla'];
    var chamberOneAddressBangla = chamberInfoMap['chamberOneAddressBangla'];
    var chamberTwoAddressBangla = chamberInfoMap['chamberTwoAddressBangla'];
    var chamberOneConsultDayBangla =
        chamberInfoMap['chamberOneConsultDayBangla'];
    var chamberTwoConsultDayBangla =
        chamberInfoMap['chamberTwoConsultDayBangla'];

    String query = '';
    if (chamberDoctorId == 0) {
      query =
          "insert into ChamberDoctor(DoctorID, MemberID, ChamberOneAddress, ChamberTwoAddress, ChamberOneConsultDay, ChamberTwoConsultDay, chamberOneConsultTime, chamberOneConsultTimeBangla, chamberTwoConsultTime, chamberTwoConsultTimeBangla, ChamberOneAddressBangla, ChamberTwoAddressBangla, ChamberOneConsultDayBangla, ChamberTwoConsultDayBangla) values('$doctorId', '$memberId', N'$chamberOneAddress', N'$chamberTwoAddress', N'$chamberOneConsultDay', N'$chamberTwoConsultDay', N'$chamberOneConsultTime', N'$chamberOneConsultTimeBangla', N'$chamberTwoConsultTime', N'$chamberTwoConsultTimeBangla', N'$chamberOneAddressBangla', N'$chamberTwoAddressBangla', N'$chamberOneConsultDayBangla', N'$chamberTwoConsultDayBangla')";
    } else {
      query =
          "Update ChamberDoctor SET DoctorID = '$doctorId', MemberID = '$memberId', ChamberOneAddress = N'$chamberOneAddress', ChamberTwoAddress = N'$chamberTwoAddress', ChamberOneConsultDay = N'$chamberOneConsultDay', ChamberTwoConsultDay = N'$chamberTwoConsultDay', chamberOneConsultTime = N'$chamberOneConsultTime', chamberOneConsultTimeBangla = N'$chamberOneConsultTimeBangla', chamberTwoConsultTime = N'$chamberTwoConsultTime', chamberTwoConsultTimeBangla = N'$chamberTwoConsultTimeBangla', ChamberOneAddressBangla = N'$chamberOneAddressBangla', ChamberTwoAddressBangla = N'$chamberTwoAddressBangla', ChamberOneConsultDayBangla = N'$chamberOneConsultDayBangla', ChamberTwoConsultDayBangla = N'$chamberTwoConsultDayBangla' where MemberID = '$memberId'";
    }
    return query;
  }

  Future fetchConsultation(var memberid) async {
    List consults = [];
    var url = Uri.parse(consultationApi + '$memberid');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var consultJson = json.decode(response.body);
      for (var item in consultJson) {
        consults.add(item);
      }
    }
    return consults;
  }

  Future<bool> saveConsultHistory(
      Map<String, dynamic> conslutHistoryMap) async {
    String prescription = conslutHistoryMap['prescription'] ?? '';
    int patientId = conslutHistoryMap['patientId'];
    int doctorId = conslutHistoryMap['doctorId'];
    int memberId = conslutHistoryMap['memberId'];
    String patientName = conslutHistoryMap['patientName'] ?? '';
    String bmdcNo = conslutHistoryMap['bmdcNo'] ?? '';
    String bkashSenderNo = conslutHistoryMap['bkashSenderNo'] ?? '';
    String createOn = getTimeNow();

    var query =
        "insert into ConsultHistory(Prescription, PatientID, DoctorID, MemberID, PatientName, BmdcNo, BkashSenderNo, CreateOn) values('$prescription', '$patientId', '$doctorId', '$memberId', '$patientName', '$bmdcNo', '$bkashSenderNo', '$createOn' )";

    var url = Uri.parse(postApi + query);

    try {
      var response = await http.post(url);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      //
    }
    return false;
  }

  //  Future<List<ConsultHistoryPatientModel>> fetchConsultHistoryPatient(
  //     int patientId) async {
  //   List<ConsultHistoryPatientModel> consultHistory = [];

  //   var url = Uri.parse(consultHistoryPatientApi + patientId.toString());

  //   try {
  //     var response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       var jsonData = json.decode(response.body);
  //       for (var item in jsonData) {
  //         consultHistory.add(ConsultHistoryPatientModel.fromJson(item));
  //       }
  //       // print('length = ${consultHistory.length}');
  //     }
  //   } catch (e) {
  //     //
  //   }

  //   return consultHistory;
  // }

  Future<List<ConsultHistoryDoctorModel>> fetchConsultHistory(
      var memberid) async {
    List<ConsultHistoryDoctorModel> consults = [];
    var url = Uri.parse(consultHistoryApi + memberid.toString());
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var consultJson = json.decode(response.body);

      for (var item in consultJson) {
        consults.add(ConsultHistoryDoctorModel.fromJson(item));
      }
    }

    return consults;
  }

  Future<bool> deletePaymentMethod(int id) async {
    int memberID = await getDoctorMemberId();
    var query = "delete from paymentMethod where Id = '$id'";

    var url = Uri.parse(postApi + query);

    try {
      var response = await http.post(url);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      //
    }
    return false;
  }

  Future<bool> udpatePaymentMethod(String phone, String method, int id) async {
    var query =
        "update paymentMethod set PaymentMode = '$method', PaymentPhone = '$phone'  where Id = '$id'";

    var url = Uri.parse(postApi + query);

    try {
      var response = await http.post(url);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      //
    }
    return false;
  }

  Future<bool> createPaymentMethod(String phone, String method) async {
    int memberID = await getDoctorMemberId();
    String createOn = getTimeNow();
    bool isDoctor = true;
    var query =
        "insert into paymentMethod(MemberID, PaymentMode, PaymentPhone, isDoctor, CreateOn) values('$memberID','$method','$phone','$isDoctor','$createOn')";

    var url = Uri.parse(postApi + query);

    try {
      var response = await http.post(url);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      //
    }
    return false;
  }

  Future<bool> uploadProfileImage(var body) async {
    log('$body');

    var url = Uri.parse(uploadImagApi);

    var headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };

    try {
      var response = await http.post(url, body: body, headers: headers);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      //
    }
    return false;
  }

  Future<List<PaymentMethod>> fetchPaymentMethods() async {
    int memberId = await getDoctorMemberId();
    var url = Uri.parse(paymentMethodApi + memberId.toString());
    List<PaymentMethod> paymentMethods = [];

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          paymentMethods.add(PaymentMethod.fromJson(item));
        }
      }
    } catch (e) {
      //
    }

    return paymentMethods;
  }

  Future<List<Map<String, dynamic>?>> fetchDoctorInfo(var phone) async {
    var url = Uri.parse(doctorApi + phone);

    List<Map<String, dynamic>?> doctorInfo = [];

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var signinJson = json.decode(response.body);
      for (var doctor in signinJson) {
        doctorInfo.add(doctor);
      }
    }
    return doctorInfo;
  }

  Future<List<DoctorModel>> getDoctor(var phone) async {
    var url = Uri.parse(doctorApi + phone);

    List<DoctorModel> doctorInfo = [];

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var doctor in jsonData) {
        doctorInfo.add(DoctorModel.fromJson(doctor));
      }
    }
    return doctorInfo;
  }

  Future fetchPharmaUpdates() async {
    List news = [];
    var url = Uri.parse(pharmaUpdateApi);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var dataList = json.decode(response.body);
      news.addAll(dataList);
    }
    return news;
  }

  Future fetchNewBrand() async {
    List brands = [];
    var url = Uri.parse(newBrandApi);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var dataList = json.decode(response.body);
      brands.addAll(dataList);
    }
    return brands;
  }

  Future<List> fetchDoctorAppoinment(var memberId) async {
    List appoinments = [];

    var url = Uri.parse(appointmentDoctorApi + memberId.toString());
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      for (var item in responseBody) {
        if (item['stutas'].trim() != 'accepted' &&
            item['stutas'].trim() != 'declined' &&
            item['patiantID'] != null &&
            item['patiantID'] != 0) {
          appoinments.add(item);
        }
      }
    }
    return appoinments;
  }

  Future<List> getLastAppointment(var memberId, int patientID) async {
    List appoinments = [];

    var url = Uri.parse(appointmentDoctorApi + memberId.toString());
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      for (var item in responseBody) {
        if (item['patiantID'] == patientID) {
          appoinments.add(item);
        }
      }
    }
    return appoinments;
  }

  Future fetchAccedptedAppoinments(var memberId) async {
    List appoinments = [];

    var url = Uri.parse(appointmentDoctorApi + memberId.toString());
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      for (var item in responseBody) {
        if (item['stutas'].trim() == 'accepted') {
          appoinments.add(item);
        }
      }
    }

    return appoinments;
  }

  Future updateDoctorAppointmentStatus(String status, var id) async {
    var query =
        "update appointment set stutas = '$status' where AppoitmentID = '$id'";

    var url = Uri.parse(postApi + query);

    var response = await http.post(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<DoctorReviewModel>> fetchDoctorReview(var memberId) async {
    List<DoctorReviewModel> reviews = [];

    var url = Uri.parse(doctorReviewApi + memberId.toString());

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (var item in responseJson) {
        if (item['rating'] != null || item['rating'] != 0) {
          reviews.add(DoctorReviewModel.fromJson(item));
        }
      }
    }
    return reviews;
  }

  Future<bool> sendContactMessageToDb(String name, String email, var phone,
      String subject, String message, var memberId) async {
    var time = await getTimeNow();
    var query =
        "INSERT INTO ContactUS(MemberID, ContactMobile, ContactEmail, ContactUsName, Subject, Message,CreateOn ) VALUES('$memberId', '$phone', '$email', N'$name', N'$subject', N'$message','$time')";

    var url = Uri.parse(postApi + query);

    var response = await http.post(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future setDoctorActiveStatus(var status, var memberId) async {
    var query =
        "update doctor set isonline = '$status' where memberid = '$memberId'";
    var url = Uri.parse(postApi + query);

    var response = await http.post(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<NextVisitModel>> fetchNextVisits() async {
    List<NextVisitModel> nextVisits = [];
    var url = Uri.parse(nextVisitApi);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (var item in responseJson) {
        nextVisits.add(NextVisitModel.fromJson(item));
      }
    }
    return nextVisits;
  }

  Future<List<DistrictModel>> fetchDistricts() async {
    List<DistrictModel> districts = [];
    var url = Uri.parse(districtApi);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (var item in responseJson) {
        districts.add(DistrictModel.fromJson(item));
      }
    }

    return districts;
  }

  Future<List<PoliceStationModel>> fetchPoliceStations(
      String districtId) async {
    List<PoliceStationModel> policeStations = [];
    var url = Uri.parse(policeStationApi + districtId);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (var item in responseJson) {
        policeStations.add(PoliceStationModel.fromJson(item));
      }
    }
    return policeStations;
  }

  Future<List<PostOfficeModel>> fetchPostOffices(String policeStationId) async {
    List<PostOfficeModel> postOffices = [];
    var url = Uri.parse(postOfficeApi + policeStationId);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (var item in responseJson) {
        postOffices.add(PostOfficeModel.fromJson(item));
      }
    }
    return postOffices;
  }

  Future<List<DoctorModel>> fetchReferredByDoctors() async {
    List<DoctorModel> doctors = [];
    var url = Uri.parse(doctorApi);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (var item in responseJson) {
        doctors.add(DoctorModel.fromJson(item));
      }
    }
    return doctors;
  }

  // Future fetchConsultationHistory(var memberId) async {
  //   List<DoctorAppointmentModel> appoinments = [];

  //   var url = Uri.parse(appointmentDoctorApi + memberId.toString());

  //   var response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     var responseBody = json.decode(response.body);
  //     for (var item in responseBody) {
  //       if (item['stutas'].trim() == 'accepted' &&
  //           item['patiantID'] != null &&
  //           item['patiantID'] != 0) {
  //         appoinments.add(DoctorAppointmentModel.fromJson(item));
  //       }
  //     }
  //   }
  //   return appoinments;
  // }

  Future<List<CaseExchangeModel>> fetchCases() async {
    List<CaseExchangeModel> cases = [];

    var url = Uri.parse(caseExchangeApi);

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (var item in responseJson) {
        cases.add(CaseExchangeModel.fromJson(item));
      }
    }
    return cases;
  }

  Future<ApiResponse> fetchCaseLikes(var caseExchangeId) async {
    ApiResponse apiResponse = ApiResponse();

    var url = Uri.parse(caseLikeApi + caseExchangeId.toString());

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        apiResponse.data = jsonDecode(response.body)
            .map((p) => CaseLikeModel.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
      } else {
        apiResponse.error = somethingWentWrong;
      }
    } on Exception catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }

  Future<ApiResponse> fetchCaseComments(var caseExchangeId) async {
    ApiResponse apiResponse = ApiResponse();

    var url = Uri.parse(caseCommentApi + caseExchangeId.toString());

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        apiResponse.data = jsonDecode(response.body)
            .map((p) => CaseCommentModel.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
      } else {
        apiResponse.error = somethingWentWrong;
      }
    } on Exception catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }

  Future<ApiResponse> fetchCasePhotos(var caseExchangeId) async {
    ApiResponse apiResponse = ApiResponse();

    var url = Uri.parse(casePhotoApi + caseExchangeId.toString());

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        apiResponse.data = jsonDecode(response.body)
            .map((p) => CasePhotoModel.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
      } else {
        apiResponse.error = somethingWentWrong;
      }
    } on Exception catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }

  Future<ApiResponse> likeUnlike(var caseExchangeId, var memberId) async {
    ApiResponse apiResponse = ApiResponse();

    List<dynamic> likesList = [];

    var query = '';

    ApiResponse likeResponse = await this.fetchCaseLikes(caseExchangeId);
    if (likeResponse.data != null) {
      likesList = likeResponse.data as List<dynamic>;
    }

    for (var item in likesList) {
      List selfLiked = [];

      if (item.memberID == memberId) {
        selfLiked.add(item);
      }
      if (selfLiked.length > 0) {
        query = "delete from CaseLike where MemberID = '$memberId'";
      } else {
        query =
            "insert into caselike(CaseExchangeID, MemberID) values('$caseExchangeId','$memberId')";
      }
    }

    var url = Uri.parse(postApi + query);

    try {
      var response = await http.post(url);

      if (response.statusCode == 200) {
        apiResponse.data = jsonDecode("likeUpdated");
      } else {
        apiResponse.error = somethingWentWrong;
      }
    } on Exception catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }

  Future saveImageToDb(int caseExchangeId, String imageData) async {
    var query =
        "insert into CasePhoto(CaseExchangeID, CasePhotos) values($caseExchangeId, '$imageData')";

    var url = Uri.parse(postApi + query);

    var response = await http.post(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future addConsultionsToDb(Map consultationInfo) async {
    var appointmentId = consultationInfo['appointmentID'];
    var memberID = consultationInfo['memberID'];
    var doctorID = consultationInfo['doctorID'];
    var patientID = consultationInfo['patiantID'];
    var prescriptionID = consultationInfo['prescriptionID'] ?? 0;
    var patientName = consultationInfo['patientName'];
    var createdOn = consultationInfo['createdOn'];
    var query =
        "INSERT INTO onlineconsultation(AppointmentID, MemberID, DoctorID, PatientID, PrescriptionID, PatientName, CreatedOn ) VALUES('$appointmentId','$memberID','$doctorID','$patientID','$prescriptionID', N'$patientName','$createdOn')";

    var url = Uri.parse(postApi + query);

    var response = await http.post(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<OnlineConsultationModel>> fetchOnlineConsultations(
      var memberId) async {
    List<OnlineConsultationModel> consultations = [];

    var url = Uri.parse(onlineConsultationApi + memberId.toString());

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      for (var item in responseBody) {
        consultations.add(OnlineConsultationModel.fromJson(item));
      }
    }
    return consultations;
  }

  Future createCase(Map caseBody) async {
    var url = Uri.parse(createCaseApi);

    Map<String, dynamic> bodyMap = {
      "doctorId": 1015,
      "memberID": 6,
      "specialityID": 2,
      "caseType": "yes",
      "dateTime": "2021-07-07T00:00:00",
      "heading": "new post does it come from?",
      "description":
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.",
      "isSave": true,
      "saveByMemberID": 1
      // "doctorId": caseBody['doctorId'],
      // "memberID": caseBody['memberID'],
      // "specialityID": caseBody['specialityID'],
      // "caseType": caseBody['caseType'],
      // "dateTime": caseBody['dateTime'],
      // "heading": caseBody['heading'],
      // "description": caseBody['description'],
      // "isSave": caseBody['isSave'],
      // "saveByMemberID": caseBody['saveByMemberID'],
    };

    try {
      var response = await http.post(url, headers: {
        'Accept': 'application/json'
      }, body: {
        "doctorId": 1015,
        "memberID": 6,
        "specialityID": 2,
        "caseType": "yes",
        "dateTime": "2021-07-07T00:00:00",
        "heading": "new post does it come from?",
        "description":
            "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.",
        "isSave": 0,
        "saveByMemberID": 1
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future getCases(var memberId) async {
    ApiResponse apiResponse = ApiResponse();
    var url = Uri.parse(createCaseApi + memberId.toString());
    try {
      var response =
          await http.get(url, headers: {'Accept': 'application/json'});

      if (response.statusCode == 200) {
        apiResponse.data = CasePostApiModel.fromJson(jsonDecode(response.body));
      } else {
        apiResponse.error = somethingWentWrong;
      }
    } catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }

  Future<ApiResponse> getChatMessages(var chatListId) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http
          .get(Uri.parse(singleChatApi + chatListId.toString()), headers: {
        'Accept': 'application/json',
      });

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)
              .map((p) => SingleChatModel.fromJson(p))
              .toList();
          apiResponse.data as List<dynamic>;
          break;

        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }

  Future sendMessageToDb(Map bodyMap) async {
    var memberID = bodyMap['memberID'];
    var patientID = bodyMap['patientID'];
    var doctorID = bodyMap['doctorID'];
    var chatListID = bodyMap['chatListID'];
    var roomID = bodyMap['roomID'];
    var sender = bodyMap['sender'];
    var message = bodyMap['message'];
    var attachment = bodyMap['attachment'];
    var createOn = bodyMap['createOn'];
    var seenByDoctor = bodyMap['seenByDoctor'];
    var seenByPatient = bodyMap['seenByPatient'];
    var isDoctor = bodyMap['isDoctor'];
    var isPatient = bodyMap['isPatient'];

    var query =
        "insert into chat(MemberID, PatientID,  DoctorID, ChatListID, RoomID, Sender, Message, Attachment, CreateOn, SeenByDoctor, SeenByPatient, IsDoctor, IsPatient) Values('$memberID', '$patientID','$doctorID', '$chatListID', '$roomID', N'$sender', N'$message', '$attachment', '$createOn', '$seenByDoctor', '$seenByPatient', '$isDoctor', '$isPatient' )";
    // "insert into chat(MemberID, PatientID,  DoctorID, ChatListID, Sender, Message, Attachment, CreateOn, SeenByDoctor, SeenByPatient, IsDoctor, IsPatient) Values('$memberID', '$patientID','$doctorID', '$chatListID', '$sender', '$message', '$attachment', '$createOn', '$seenByDoctor', '$seenByPatient', '$isDoctor', '$isPatient' )";

    // print(query);

    var url = Uri.parse(postApi + query);

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<ApiResponse> getChatList(var memberId) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http
          .get(Uri.parse(chatListApi + memberId.toString()), headers: {
        'Accept': 'application/json',
      });

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)
              .map((p) => ChatListModel.fromJson(p))
              .toList();
          apiResponse.data as List<dynamic>;
          break;

        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }

  Future updateDoctorMsgSeenStatus(String rooomID) async {
    var query =
        "update chat set SeenByDoctor = 'true' where RoomID = '$rooomID'";
    var url = Uri.parse(postApi + query);

    try {
      var response = await http.post(url);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      return false;
    }
  }

  Future<List<DoctorExperienceModel>> fetchDoctorExperience(
      var memberId) async {
    List<DoctorExperienceModel> experiences = [];
    var url = Uri.parse(experienceApi + memberId.toString());
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (var item in responseJson) {
        experiences.add(DoctorExperienceModel.fromJson(item));
      }
    }

    return experiences;
  }

  Future<List<DoctorSliderModel>> fetchDoctorSliderImages() async {
    List<DoctorSliderModel> sliderImages = [];

    var url = Uri.parse(doctorSliderApi);

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          sliderImages.add(DoctorSliderModel.fromJson(item));
        }
      }
    } catch (e) {
      //
    }

    return sliderImages;
  }

  // Future<bool> insertAppointmentPhoto(
  //     List<String> imageStrList, int appointmenId) async {
  //   int patientId = await getPatientId();

  //   // String createOn = getTimeNow();

  //   //   // log(selectedImageBase64String);
  //   //   // log(selectedImageExt);
  //   //   // log(selectedImageName);

  //   //   int patientId = await getPatientId();

  //   //   var body = jsonEncode({
  //   //     "imageName": "$selectedImageName",
  //   //     "imageBase64": "$selectedImageBase64String",
  //   //     "imageType": "profile",
  //   //     "imageExtension": "$selectedImageExt",
  //   //     "tableName": "patient",
  //   //     "columnName": "ProfilePic",
  //   //     "whereClouse": "patientID",
  //   //     "whereValue": "${patientId.toString()}",
  //   //   });

  //   //   var updated = await patientProfileService.uploadProfileImage(body);

  //   String query =
  //       "insert into PatientRelatives(PatientID, Name, Relationship, Age, Weight, Gender, CreateOn) values('$patientId','$name','$relationship','$age','$weight','$gender','$createOn')";
  //   var url = Uri.parse(postApi + query);
  //   print(query);

  //   try {
  //     var response = await http.post(url);
  //     print('response code ${response.statusCode}');
  //     if (response.statusCode == 200) {
  //       return true;
  //     }
  //   } catch (e) {
  //     //
  //   }
  //   return false;
  // }

}
