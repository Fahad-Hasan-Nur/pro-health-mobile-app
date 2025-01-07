// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:developer';

import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/ApiList.dart';
import 'package:pro_health/doctor/models/advance_doctor_search.dart';
import 'package:pro_health/doctor/models/doctorReviewModel.dart';
import 'package:pro_health/doctor/models/doctor_appointment_model.dart';
import 'package:pro_health/doctor/models/doctor_speciality_model.dart';
import 'package:http/http.dart' as http;
import 'package:pro_health/doctor/models/payment_method.dart';
import 'package:pro_health/patient/models/consult_history_patient.dart';
import 'package:pro_health/patient/models/favorite_model.dart';
import 'package:pro_health/patient/models/latest_news.dart';
import 'package:pro_health/patient/models/patient_relatives.dart';
import 'package:pro_health/patient/models/patient_slider.dart';
import 'package:pro_health/patient/models/recent.dart';
import 'package:pro_health/patient/models/review.dart';
import 'package:pro_health/patient/models/slider.dart';

class PatientApiService {
  // Future<List<Map<String, dynamic>>> fetcOnlineDoctors() async {
  //   List<Map<String, dynamic>> onlineDoctors = [];

  //   var url = Uri.parse(doctorApi);

  //   try {
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       var jsonData = json.decode(response.body);
  //       // for (var item in jsonData) {

  //       // }
  //       print(jsonData);
  //       for (var i = 0; i < jsonData.length; i++) {
  //         if (onlineDoctors.length == 20) {
  //           break;
  //         }

  //         var item = jsonData[i];
  //         if (item['isOnline']) {
  //           double averageRating = 0.0;
  //           List reviewList = [];
  //           String specialityName = '';
  //           var reviews = await fetchDoctorReview(item['memberID']);
  //           for (var review in reviews) {
  //             if (review.memberId == item['memberID']) {
  //               reviewList.add(review.rating);
  //             }
  //           }

  //           double sum = reviewList.fold(0, (p, c) => p + c);
  //           if (sum > 0) {
  //             averageRating =
  //                 double.parse((sum / reviewList.length).toStringAsFixed(2));
  //           }

  //           // print('speciality id = ${item['specialityID']}');

  //           List<DoctorSpecialityModel> speciality =
  //               await fetchSpeciality(item['specialityID']);
  //           if (speciality.isNotEmpty) {
  //             specialityName = speciality[0].specialityName ?? '';
  //           }

  //           // print('speciality list $speciality');

  //           Map<String, dynamic> doctor = {};
  //           doctor['doctorID'] = item['doctorID'];
  //           doctor['memberID'] = item['memberID'];
  //           doctor['specialityID'] = item['specialityID'];
  //           doctor['doctorName'] = item['doctorName'];
  //           doctor['gender'] = item['gender'];
  //           doctor['workingPlace'] = item['workingPlace'];
  //           doctor['bmdcNmuber'] = item['bmdcNmuber'];
  //           doctor['profilePicture'] =
  //               getDoctorProfilePic(item['profilePicture']) ?? '';
  //           doctor['isOnline'] = item['isOnline'];
  //           doctor['chamberDoctorID'] = item['chamberDoctorID'];
  //           doctor['specialityName'] = specialityName;
  //           doctor['rating'] = averageRating;

  //           onlineDoctors.add(doctor);
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     //
  //   }

  //   return onlineDoctors;
  // }

  Future<List<AdvanceDoctorSearch>> fetcOnlineDoctors() async {
    List<AdvanceDoctorSearch> doctors = [];
    String query = "select * from vwAdvancedSearchDoctors where IsOnline = 1";
    var url = Uri.parse(getApi + query);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        // log('jsonData $jsonData');
        for (var item in jsonData) {
          doctors.add(AdvanceDoctorSearch.fromJson(item));
        }
      }
    } catch (e) {
      //
    }

    return doctors;
  }

  Future<Map<String, dynamic>> insertChatImage(String body) async {
    Map<String, dynamic> insertStatus = {'inserted': false, 'path': ''};
    var url = Uri.parse(insertImgApi);

    log('body $body');

    var headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };

    try {
      var response = await http.post(url, body: body, headers: headers);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        insertStatus['inserted'] = true;
        insertStatus['path'] = jsonData;

        return insertStatus;
      }
    } catch (e) {
      //
    }
    return insertStatus;
  }

  Future<bool> insertAppointmentImage(String body) async {
    var url = Uri.parse(insertImgApi);

    var headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };

    try {
      var response = await http.post(url, body: body, headers: headers);

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      //
    }
    return false;
  }

  Future<bool> uploadChatImage(var body) async {
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

  Future<List<PatientSliderModel>> fetchPatientSliderImages() async {
    List<PatientSliderModel> sliderImages = [];

    var url = Uri.parse(patientSliderApi);

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          sliderImages.add(PatientSliderModel.fromJson(item));
        }
      }
    } catch (e) {
      //
    }

    return sliderImages;
  }

  Future<List<Map<String, dynamic>>> fetchAllDoctors() async {
    List<Map<String, dynamic>> allDoctors = [];

    var url = Uri.parse(doctorApi);

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          double averageRating = 0.0;
          List reviewList = [];
          String specialityName = '';
          var reviews = await fetchDoctorReview(item['memberID']);
          for (var review in reviews) {
            if (review.memberId == item['memberID']) {
              reviewList.add(review.rating);
            }
          }

          double sum = reviewList.fold(0, (p, c) => p + c);
          if (sum > 0) {
            averageRating =
                double.parse((sum / reviewList.length).toStringAsFixed(2));
          }

          // print('speciality id = ${item['specialityID']}');

          List<DoctorSpecialityModel> speciality =
              await fetchSpeciality(item['specialityID']);
          if (speciality.isNotEmpty) {
            specialityName = speciality[0].specialityName ?? '';
          }

          // print('speciality list $speciality');

          Map<String, dynamic> doctor = {};
          doctor['doctorID'] = item['doctorID'] ?? 0;
          doctor['memberID'] = item['memberID'] ?? 0;
          doctor['specialityID'] = item['specialityID'] ?? 0;
          doctor['doctorName'] = item['doctorName'] ?? '';
          doctor['gender'] = item['gender'] ?? '';
          doctor['workingPlace'] = item['workingPlace'] ?? '';
          doctor['bmdcNmuber'] = item['bmdcNmuber'] ?? '';
          doctor['profilePicture'] =
              getDoctorProfilePic(item['profilePicture']) ?? '';
          doctor['isOnline'] = item['isOnline'] ?? false;
          doctor['chamberDoctorID'] = item['chamberDoctorID'] ?? 0;
          doctor['experience'] = item['experience'] ?? '';
          doctor['qualificationOne'] = item['qualificationOne'] ?? '';
          doctor['qualificationTwo'] = item['qualificationTwo'] ?? '';
          doctor['consultationFeeOnline'] = item['consultationFeeOnline'] ?? '';
          doctor['specialityName'] = specialityName;
          doctor['rating'] = averageRating;
          doctor['reviewCount'] = reviewList.length;

          allDoctors.add(doctor);
        }
      }
    } catch (e) {
      //
    }

    return allDoctors;
  }

  Future<List<AdvanceDoctorSearch>> getAdvanceDoctors() async {
    List<AdvanceDoctorSearch> doctors = [];
    String query = "select * from vwAdvancedSearchDoctors";
    var url = Uri.parse(getApi + query);

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          doctors.add(AdvanceDoctorSearch.fromJson(item));
        }
      }
    } catch (e) {
      //
    }

    return doctors;
  }

  Future<List<AdvanceDoctorSearch>> searchAdvanceDoctor(
      String searchTerm) async {
    List<AdvanceDoctorSearch> doctors = [];
    String query =
        "SELECT DoctorID, SpecialityID, DoctorName, Rating, MobileNo, DateOfBirth, Gender, EduQualificationID, Experience, WorkingPlace, FollowupFee, ConsultationFeePhysical, BmdcNmuber, ProfilePicture, ConsultationDay, IsOnline, MemberID, ConsultationFeeOnline, Availability, QualificationOne, QualificationTwo, DesignationOne, DesignationTwo, Rocket, BKash, Nagad, SpecialityName FROM vwAdvancedSearchDoctors WHERE (SearchQuery LIKE N'%$searchTerm%')";
    var url = Uri.parse(getApi + query);

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          doctors.add(AdvanceDoctorSearch.fromJson(item));
        }
      }
    } catch (e) {
      //
    }

    return doctors;
  }

  Future<List<DoctorSpecialityModel>> fetchSpeciality(int specialityId) async {
    List<DoctorSpecialityModel> doctorSpeciality = [];
    var url = Uri.parse(doctorSpecialityApi + specialityId.toString());
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var specialities = json.decode(response.body);
      for (var speciality in specialities) {
        doctorSpeciality.add(DoctorSpecialityModel.fromJson(speciality));
      }
    }
    return doctorSpeciality;
  }

  Future<bool> checkIfAlreadyLiked(int patientID, int doctorId) async {
    var doctors = [];
    var url = Uri.parse(favoriteApi + patientID.toString());
    // print('already liked url = $url');

    try {
      var response = await http.get(url);
      // print('already liked response code ${response.statusCode}');
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          // print('already liked doctor id = ${item['doctorID']} ');
          if (item['doctorID'] == doctorId) {
            doctors.add(FavoriteModel.fromJson(item));
            break;
          }
        }
      }
    } catch (e) {
      //
    }

    if (doctors.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<Map<dynamic, dynamic>> updateFavoriteStatus(
      int patientId, int doctorId) async {
    bool alreadyLiked = await checkIfAlreadyLiked(patientId, doctorId);

    String query = "";

    String timeNow = getTimeNow();

    if (alreadyLiked) {
      // delte query
      query =
          "DELETE FROM Favorite WHERE PatientID = '$patientId' AND DoctorId = '$doctorId'";
    } else {
      // insert quer
      query =
          "INSERT INTO favorite(patientid, doctorid, CreateOn) VALUES('$patientId','$doctorId', '$timeNow')";
    }

    // print(query);

    var url = Uri.parse(postApi + query);

    Map likeUpdateStatus = {'liked': false, 'status': false};

    try {
      var response = await http.post(url);
      if (response.statusCode == 200) {
        if (alreadyLiked) {
          likeUpdateStatus['liked'] = false;
          likeUpdateStatus['status'] = true;
        } else {
          likeUpdateStatus['liked'] = true;
          likeUpdateStatus['status'] = true;
        }
      }
    } catch (e) {
      //
    }
    return likeUpdateStatus;
  }

  Future<List<FavoriteModel>> fetchFavoriteDoctors(int patientId) async {
    List<FavoriteModel> favorites = [];

    var url = Uri.parse(favoriteApi + patientId.toString());

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          favorites.add(FavoriteModel.fromJson(item));
        }
      }
    } catch (e) {
      //
    }

    return favorites;
  }

  Future<bool> deleteFromFavorite(int patientId, int doctorId) async {
    // DELETE FROM Favorite WHERE PatientID = '12' AND DoctorId = '2033'
    bool deleted = false;
    if (patientId == 0) {
      return false;
    } else {
      String query =
          "DELETE FROM Favorite WHERE PatientID = '$patientId' AND DoctorId = '$doctorId'";
      var url = Uri.parse(postApi + query);
      try {
        var response = await http.post(url);
        if (response.statusCode == 200) {
          deleted = true;
        }
      } catch (e) {
        //
      }
    }

    return deleted;
  }

  Future<int> fetchPatientInQueue(int memberId) async {
    int patientInQueue = 0;

    List<DoctorAppointmentModel> appointments = [];

    var url = Uri.parse(appointmentDoctorApi + memberId.toString());
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          if (item['stutas'].toString().toLowerCase().trim() == 'pending') {
            appointments.add(DoctorAppointmentModel.fromJson(item));
          }
        }

        patientInQueue = appointments.length;
      }
    } catch (e) {
      //
    }

    return patientInQueue;
  }

  Future<List<RecentModel>> fetchRecentDoctors(int patientId) async {
    List<RecentModel> recentDoctorList = [];

    var url = Uri.parse(recentApi + patientId.toString());

    try {
      var response = await http.get(url);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          DateTime dateTimeCreatedAt = DateTime.parse(item['createOn']);
          DateTime dateTimeNow = DateTime.now();
          final differenceInDays =
              dateTimeNow.difference(dateTimeCreatedAt).inDays;

          if (differenceInDays <= 1) {
            recentDoctorList.add(RecentModel.fromJson(item));
          }
        }
      }
    } catch (e) {
      //
    }

    return recentDoctorList;
  }

  Future<List<RecentModel>> cehckIfRecentDoctorsExists(int patientId) async {
    List<RecentModel> recentDoctorList = [];

    var url = Uri.parse(recentApi + patientId.toString());

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          recentDoctorList.add(RecentModel.fromJson(item));
        }
      }
    } catch (e) {
      //
    }

    return recentDoctorList;
  }

  Future<bool> addRecentDoctors(int patientId, int doctorId) async {
    if (patientId == 0 || doctorId == 0) {
      return false;
    }
    List<RecentModel> recentDoctors = [];

    bool alreadyAdded = false;

    var response = await cehckIfRecentDoctorsExists(patientId);
    for (var item in response) {
      if (item.doctorID == doctorId) {
        recentDoctors.add(item);
        break;
      }
    }
    if (recentDoctors.isNotEmpty) {
      alreadyAdded = true;
    }
    String query = "";
    String timeNow = getTimeNow();
    if (alreadyAdded) {
      query =
          "delete from Recent where PatientID = '$patientId' AND DoctorId = '$doctorId';insert into Recent(DoctorID, PatientID, CreateOn) values('$doctorId','$patientId','$timeNow')";
    } else {
      query =
          "insert into Recent(DoctorID, PatientID, CreateOn) values('$doctorId','$patientId','$timeNow')";
    }

    var url = Uri.parse(postApi + query);

    try {
      var response = await http.post(url);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      //
    }
    return false;
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

  Future<List<PatientReviewModel>> fetchReviews(int patientId) async {
    List<PatientReviewModel> reviews = [];

    var url = Uri.parse(patientReviewApi + patientId.toString());

    // print(url);

    try {
      var response = await http.get(url);

      // print('status code = ${response.statusCode}');
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          // print(item['doctorName']);
          reviews.add(PatientReviewModel.fromJson(item));
        }
      }
    } catch (e) {
      //
    }

    // print('rev lengh ${reviews.length}');

    return reviews;
  }

  Future<List<SliderImageModel>> fetchSliderImages() async {
    List<SliderImageModel> images = [];

    var url = Uri.parse(sliderApi);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          if (item['isDoctor']) {}
          images.add(SliderImageModel.fromJson(item));
        }
      }
    } catch (e) {
      //
    }

    return images;
  }

  Future<LatestNewsModel> fetchlatestNews() async {
    List<LatestNewsModel> news = [];

    LatestNewsModel latestNews = LatestNewsModel();

    var url = Uri.parse(latestNewsApi);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        latestNews = LatestNewsModel.fromJson(jsonData.last);
      }
    } catch (e) {
      //
    }

    return latestNews;
  }

  Future<bool> sendContactMessageToDb(String name, String email, var phone,
      String subject, String message, int patientId) async {
    var time = await getTimeNow();
    var query =
        "insert into ContactPatient(PatientID, ContactMobile, ContactEmail, ContactUsName, Subject, Message, CreateOn) values('$patientId', '$phone', '$email', N'$name', N'$subject', N'$message', '$time')";

    var url = Uri.parse(postApi + query);

    var response = await http.post(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<ConsultHistoryPatientModel>> fetchConsultHistoryPatient(
      int patientId) async {
    List<ConsultHistoryPatientModel> consultHistory = [];

    var url = Uri.parse(consultHistoryPatientApi + patientId.toString());

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          consultHistory.add(ConsultHistoryPatientModel.fromJson(item));
        }
        // print('length = ${consultHistory.length}');
      }
    } catch (e) {
      //
    }

    return consultHistory;
  }

  Future<List<Map<String, dynamic>>> fetchPatientComplaints(
      int patientId) async {
    List<Map<String, dynamic>> patientComplaints = [];

    var url = Uri.parse(patientComplainApi + patientId.toString());

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var item in jsonData) {
          Map<String, dynamic> newComplaint = {};
          newComplaint['complainID'] = item['complainID'];
          newComplaint['patientID'] = item['patientID'];
          newComplaint['problem'] = item['problem'];
          newComplaint['date'] = getDate(item['date']);
          newComplaint['email'] = item['email'];
          newComplaint['phone'] = item['phone'];
          patientComplaints.add(newComplaint);
        }
        // print('length = ${patientComplaints.length}');
      }
    } catch (e) {
      //
    }

    return patientComplaints;
  }

  Future<bool> saveComplaint(Map<String, dynamic> complaintMap) async {
    String patientId = complaintMap['patientId'].toString();
    String problem = complaintMap['problem'];
    String date = complaintMap['date'];
    String email = complaintMap['email'];
    String phone = complaintMap['phone'];
    var query =
        "insert into complain(patientid, problem, date, email, phone) values('$patientId','$problem', '$date', '$email', '$phone')";

    var url = Uri.parse(postApi + query);
    try {
      var response = await http.post(url);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      //
    }
    return false;
  }

  Future<bool> updatePersonalHistory(
      Map<String, dynamic> personalHistoryMap, int patientId) async {
    // update patient set Allergies = 'food', Occupation = 'App Developer', Smoking = 'no', maritalStatus = 'Single', Alcohol = 'no', Exercise = 'yes',  caffinatedBeverage = 'yes' where patientId = '12'
    String allergies = personalHistoryMap['allergies'];
    String occupation = personalHistoryMap['occupation'];
    String smoking = personalHistoryMap['smoking'];
    String maritalStatus = personalHistoryMap['maritalStatus'];
    String alcohol = personalHistoryMap['alcohol'];
    String exercise = personalHistoryMap['exercise'];
    String caffinatedBeverage = personalHistoryMap['caffinatedBeverage'];

    String query =
        "update patient set Allergies = '$allergies', Occupation = '$occupation', Smoking = '$smoking', maritalStatus = '$maritalStatus', Alcohol = '$alcohol', Exercise = '$exercise',  caffinatedBeverage = '$caffinatedBeverage' where patientId = '$patientId'";
    var url = Uri.parse(postApi + query);
    try {
      var response = await http.post(url);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      //
    }

    return false;
  }

  Future<List<PatientRelativesModel>> fetchPatientRelatives() async {
    List<PatientRelativesModel> relatives = [];
    int patientId = await getPatientId();

    var url = Uri.parse(patientRelativesApi + patientId.toString());

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        for (var item in responseJson) {
          relatives.add(PatientRelativesModel.fromJson(item));
        }
      }
    } catch (e) {
      //
    }

    return relatives;
  }

  Future<List<PaymentMethod>> fetchPaymentMethods(int memberId) async {
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

  Future<bool> createAppointment(
      Map<String, dynamic> createAppointmentMap,
      Map<String, dynamic> paymentMap,
      Map<String, dynamic> doctorInfo,
      String appointmentUID) async {
    int patientId = await getPatientId();
    int doctorId = createAppointmentMap['doctorId'];
    int memberId = createAppointmentMap['memberId'];
    String name = createAppointmentMap['name'];
    String problem = createAppointmentMap['problem'];
    String status = createAppointmentMap['status'];
    String selfOrOthers = createAppointmentMap['selfOrOthers'];
    String createOn = getTimeNow();
    // String appointmentUID = generateUid();
    String doctorName = doctorInfo['doctorName'];
    String doctorProfilePic = convertDoctorPic(doctorInfo['doctorPic']);
    String paymentPhone = paymentMap['paymentPhone'];
    String trxID = paymentMap['trxID'];
    String paidToPhone = paymentMap['paidToPhone'];

    String query =
        "insert into Appointment(AppointmentUID, DoctorID, MemberID, PatiantID, Problem, Stutas, CreatedOn, DoctorName, DoctorProfilePic, SelfOrOther, PaymentPhone, TrxID, PaidToPhone, PatientName ) values('$appointmentUID', '$doctorId','$memberId','$patientId', N'$problem', 'pending', '$createOn', N'$doctorName','$doctorProfilePic','$selfOrOthers','$paymentPhone','$trxID', '$paidToPhone', N'$name')";
    var url = Uri.parse(postApi + query);
    print(query);

    try {
      var response = await http.post(url);
      print('response code ${response.statusCode}');
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      //
    }
    return false;
  }

  Future<bool> createRelatives(
      Map<String, dynamic> createAppointmentMap) async {
    int patientId = await getPatientId();
    String name = createAppointmentMap['name'];
    String relationship = createAppointmentMap['relationship'];
    String age = createAppointmentMap['age'].toString();
    String weight = createAppointmentMap['weight'].toString();
    String gender = createAppointmentMap['gender'].toString();
    String createOn = getTimeNow();

    String query =
        "insert into PatientRelatives(PatientID, Name, Relationship, Age, Weight, Gender, CreateOn) values('$patientId','$name','$relationship','$age','$weight','$gender','$createOn')";
    var url = Uri.parse(postApi + query);
    print(query);

    try {
      var response = await http.post(url);
      print('response code ${response.statusCode}');
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      //
    }
    return false;
  }
}
