import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/doctor/models/doctorReviewModel.dart';
import 'package:pro_health/doctor/models/doctor_speciality_model.dart';
import 'package:pro_health/doctor/models/online%20consultation/online_consultations.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/doctor/services/auth_service/auth_service.dart';
import 'package:pro_health/patient/models/chatlist_patient.dart';
import 'package:pro_health/patient/service/dashboard/api_patient.dart';
import 'package:pro_health/patient/service/dashboard/chat_service.dart';
import 'package:pro_health/patient/views/bottombar/home/select_patient.dart';
import 'package:pro_health/patient/views/bottombar/message/chat_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorProfileControllerPatientPart extends GetxController {
  var memberId;
  var doctorId;

  var prefs;
  var rating = 4.5.obs;

  var liked = false.obs;
  var patientId = 0.obs;

  ApiServices apiServices = ApiServices();
  AuthService authService = AuthService();
  ChatServicesPatient chatServicesPatient = ChatServicesPatient();
  PatientApiService patientApiService = PatientApiService();
  var validity = 0.obs;
  var _timer;
  var doctorPhone = ''.obs;
  var isOnline = true.obs;
  var doctorProfileInfo = [].obs;
  var consultations = <OnlineConsultationModel>[].obs;
  var doctorSpeciality = <DoctorSpecialityModel>[].obs;
  var experiences = [].obs;
  var isFavoriteDoctor = false.obs;

  var consultationNumber = 0.obs;
  var name = ''.obs;
  var degree = ''.obs;
  var workPlace = ''.obs;

  var speciality = ''.obs;
  var bmdcNum = ''.obs;
  var doctorExperience = ''.obs;
  var doctorStarRating = ''.obs;
  var consultationsCount = 0.0.obs;
  var onlineConsultionFee = 0.0.obs;
  var physicalConsultationFee = 0.0.obs;
  var doctorFollowupFee = 0.0.obs;
  var doctorProfilePic = ''.obs;
  // var memberId;
  var appJoinDate = ''.obs;
  var expireDate = ''.obs;
  var validityDaysLeft = 0.obs;
  var qualificationOne = ''.obs;
  var qualificationTwo = ''.obs;

  var chamberOneConsultTime = ''.obs;
  var chamberTwoConsultTime = ''.obs;
  var chamberOneAddress = ''.obs;
  var chamberTwoAddress = ''.obs;
  var chamberOneConsultDay = ''.obs;
  var chamberTwoConsultDay = ''.obs;

  final format = DateFormat("hh:mm a");

  var reviews = <DoctorReviewModel>[].obs;
  var newReviews = [].obs;

  var patientInQueue = 0.obs;
  var averageRating = 0.0.obs;

  var bkashNo = ''.obs;
  var nagadNo = ''.obs;
  var rocketNo = ''.obs;

  updateLikeDislike() async {
    int patientID = await getPatientId();

    Map favoriteStatus =
        await patientApiService.updateFavoriteStatus(patientID, doctorId);
    if (favoriteStatus['status']) {
      if (favoriteStatus['liked']) {
        liked.value = true;
      } else {
        liked.value = false;
      }
    }
  }

  seeDoctorNow() {
    print('doctor.memberID $memberId');
    Map<String, dynamic> doctorInfo = {};
    doctorInfo['memberId'] = memberId;
    doctorInfo['doctorId'] = doctorId;
    doctorInfo['rating'] = averageRating.value;
    doctorInfo['doctorPic'] = doctorProfilePic.value;
    doctorInfo['doctorName'] = name.value;
    doctorInfo['bKash'] = bkashNo.value;
    doctorInfo['rocket'] = rocketNo.value;
    doctorInfo['nagad'] = rocketNo.value;
    doctorInfo['onlineConsultionFee'] = onlineConsultionFee.value;
    doctorInfo['qualification'] =
        '${qualificationOne.value}${qualificationTwo.value}'.isEmpty
            ? 'Your Qualification I.e: MBBS etc'
            : '${qualificationOne.value}, ${qualificationTwo.value}';

    // Navigator.of(context).pushNamed(SelectPatient.tag);
    Get.to(() => SelectPatient(doctorInfo: doctorInfo));
  }

  gotoChatScreen() async {
    ChatList chatList = ChatList();
    Map<String, dynamic> chatListMap =
        await chatServicesPatient.createChatList(memberId, doctorId);

    if (chatListMap['created']) {
      chatList = chatListMap['chatlist'];
      chatList.doctorName = name.value;
      chatList.profilePicture = doctorProfilePic.value;
    } else {
      chatList = chatListMap['chatlist'];
    }
    Get.to(() => ChatScreen(chatList: chatList));
  }

  getPatientInQueueNumber() async {
    var number = await patientApiService.fetchPatientInQueue(memberId);
    patientInQueue.value = number;
  }

  addRecentDoctor() async {
    int patientId = await getPatientId();
    await patientApiService.addRecentDoctors(patientId, doctorId);
  }

  checkFavoriteStatus() async {
    int patientID = await getPatientId();

    bool alreadyLiked =
        await patientApiService.checkIfAlreadyLiked(patientID, doctorId);

    if (alreadyLiked) {
      liked.value = true;
    }
  }

  getAverageRatings() {
    List<double> ratingsList = reviews.map((r) => r.rating!).toList();
    double sum = ratingsList.fold(0, (p, c) => p + c);
    if (sum > 0) {
      averageRating.value =
          double.parse((sum / ratingsList.length).toStringAsFixed(2));
    }
  }

  fetchDoctorReviews() async {
    var response = await apiServices.fetchDoctorReview(memberId);

    print('review length = ${response.length}');

    if (response.isNotEmpty) {
      if (reviews.isNotEmpty) {
        reviews.clear();
        newReviews.clear();
        reviews.addAll(response);
      } else {
        reviews.addAll(response);
      }
    }
    getAverageRatings();
    createNewReviewList();
  }

  // getFavoriteDoctors() async {
  //   patientId = getPatientId();
  //   var response = await patientApiService.fetchFavoriteDoctors(patientId);

  // }

  createNewReviewList() {
    for (var item in reviews) {
      Map reviewMap = Map();

      reviewMap['doctorID'] = item.doctorId;
      reviewMap['memberID'] = item.memberId;
      reviewMap['comments'] = item.comments;
      reviewMap['rating'] = item.rating;
      reviewMap['reviewDate'] = getDataAndTime(item.reviewDate!);
      reviewMap['patientName'] = item.patientName;
      reviewMap['profilePic'] = item.profilePic;

      // if (newReviews.isNotEmpty) {
      //   newReviews.clear();
      //   newReviews.add(reviewMap);
      // } else {
      //   newReviews.add(reviewMap);
      // }
      newReviews.add(reviewMap);
    }
  }

  getDoctorExperiences() async {
    var response = await apiServices.fetchDoctorExperience(memberId);
    print('experience length = ${response.length}');
    if (response.isNotEmpty) {
      experiences.clear();
      for (var item in response) {
        Map exp = {};
        exp['experienceID'] = item.experienceID;
        exp['doctorID'] = item.doctorID ?? 0;
        exp['memberID'] = item.memberID ?? 0;
        exp['hospitalName'] = item.hospitalName ?? '';
        exp['designation'] = item.designation ?? '';
        exp['department'] = item.department ?? '';
        exp['duration'] = item.duration ?? '';
        exp['workingPeriod'] = item.workingPeriod ?? '';

        experiences.add(exp);
      }
    }
  }

  fetchDoctorProfileInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int? validityDays = prefs.getInt('ValidityDaysLeft');

    var doctorProfile = await apiServices.fetchDoctorProfile(memberId);

    if (doctorProfile.length > 0) {
      name.value = doctorProfile[0]['doctorName'] ?? '';
      // memberId = doctorProfile[0]['memberID'];

      // degree = doctorProfile[0]['eduQualificationID'];
      workPlace.value = doctorProfile[0]['workingPlace'] ?? '';
      speciality.value = doctorProfile[0]['specialityName'] ?? '';
      bmdcNum.value = doctorProfile[0]['bmdcNmuber'] ?? '';
      doctorExperience.value = doctorProfile[0]['experience'] ?? '';
      qualificationOne.value = doctorProfile[0]['qualificationOne'] ?? '';
      qualificationTwo.value = doctorProfile[0]['qualificationTwo'] ?? '';

      onlineConsultionFee.value =
          doctorProfile[0]['consultationFeeOnline'] ?? 0.0;
      physicalConsultationFee.value =
          doctorProfile[0]['consultationFeePhysical'] ?? 0.0;
      doctorFollowupFee.value = doctorProfile[0]['followupFee'] ?? 0.0;
      bkashNo.value = doctorProfile[0]['bKash'] ?? '';
      nagadNo.value = doctorProfile[0]['nagad'] ?? '';
      rocketNo.value = doctorProfile[0]['rocket'] ?? '';
      chamberOneAddress.value = doctorProfile[0]['chamberOneAddress'] ?? '';
      chamberTwoAddress.value = doctorProfile[0]['chamberTwoAddress'] ?? '';
      chamberOneConsultDay.value =
          doctorProfile[0]['chamberOneConsultDay'] ?? '';
      chamberTwoConsultDay.value =
          doctorProfile[0]['chamberTwoConsultDay'] ?? '';
      appJoinDate.value = doctorProfile[0]['appJoinDate'] ?? '';
      expireDate.value = doctorProfile[0]['expireDate'] ?? '';
      chamberOneConsultTime.value =
          doctorProfile[0]['chamberOneConsultTime'] ?? '';
      chamberTwoConsultTime.value =
          doctorProfile[0]['chamberTwoConsultTime'] ?? '';
      // doctorProfilePic = doctorProfile[0]['profilePicture'];

      doctorProfilePic.value =
          getDoctorProfilePic(doctorProfile[0]['profilePicture'] ?? '');

      validityDaysLeft.value = validityDays ?? 0;
    }
    fetchDoctorRating();
    getSpeciality();

    // fetchConsultations(doctorMemberId);
    fetchConsults();

    // getValidityDays(appJoinDate, expireDate);
  }

  fetchDoctorRating() async {
    var reviews = await apiServices.fetchDoctorReview(memberId);
    List<double> ratingsList = reviews.map((r) => r.rating!).toList();
    double sum = ratingsList.fold(0, (p, c) => p + c);
    if (sum > 0) {
      rating.value = sum / ratingsList.length;
    }
  }

  fetchConsults() async {
    // var response = await apiServices.fetchConsultation(doctorMemberId);
    var response = await apiServices.fetchOnlineConsultations(memberId);
    if (response.length > 0) {
      if (consultations.isNotEmpty) {
        consultations.clear();
        consultations.addAll(response);
      } else {
        consultations.addAll(response);
      }
    }
    consultationNumber.value = consultations.length;
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

  getSpeciality() async {
    var specialities = await apiServices.fetchSpeciality();

    if (doctorSpeciality.isNotEmpty) {
      doctorSpeciality.clear();
      doctorSpeciality.addAll(specialities);
    } else {
      doctorSpeciality.addAll(specialities);
    }
  }

  fetchDoctor() async {
    var doctor = await apiServices.fetchDoctorProfile(memberId);
    if (doctor.isNotEmpty) {
      isOnline.value = doctor[0]!['isOnline'];
    }
  }

  callFunctions({memberID, doctorID}) {
    memberId = memberID;
    doctorId = doctorID;
    fetchDoctorProfileInfo();
    fetchDoctorReviews();
    fetchDoctor();
    getDoctorExperiences();
    checkFavoriteStatus();
    addRecentDoctor();
    const oneSec = Duration(seconds: 3);
    _timer = Timer.periodic(oneSec, (Timer t) {
      fetchDoctor();
      getPatientInQueueNumber();
    });
  }

  @override
  void onInit() {
    // callFunctions();
    super.onInit();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}
