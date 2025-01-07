import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/models/doctorReviewModel.dart';
import 'package:pro_health/doctor/models/doctor_model.dart';
import 'package:pro_health/doctor/models/doctor_speciality_model.dart';
import 'package:pro_health/doctor/models/profile/doctor_profile_model.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';

class DoctorProfileController extends GetxController {
  var doctorProfile = DoctorProfileModel().obs;
  var doctor = DoctorModel().obs;
  var doctorSpecialityList = <DoctorSpecialityModel>[].obs;
  ApiServices apiServices = ApiServices();
  var profilePic = ''.obs;
  var doctorPhone = ''.obs;
  var memberId = 0.obs;
  var validityDaysLeft = 0.obs;
  var consultationNumber = 0.obs;
  var _timer;

  var averageRating = 0.0.obs;
  List reviewList = [];

  var selectedImageBase64String = '';
  var selectedImageExt = '';
  var selectedImageName = '';
  var selectedImagePath = ''.obs;
  var userProfileImg = ''.obs;
  File? imageFile;

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      imageFile = File(pickedFile.path);
      // log(pickedFile.path);
      // log(pickedFile.path.split('.').last);

      selectedImageBase64String = getStringImage(imageFile) ?? '';
      selectedImageExt = pickedFile.path.split('.').last;
      selectedImageName = pickedFile.path.split('/').last.split('.').first;
      // log(selectedImageBase64String);
      // log(selectedImageExt);
      // log(selectedImageName);

      int memberId = await getDoctorMemberId();

      var body = jsonEncode({
        "imageName": "$selectedImageName",
        "imageBase64": "$selectedImageBase64String",
        "imageType": "profile",
        "imageExtension": "$selectedImageExt",
        "tableName": "Doctor",
        "columnName": "ProfilePicture",
        "whereClouse": "memberID",
        "whereValue": "${memberId.toString()}",
      });

      var updated = await apiServices.uploadProfileImage(body);

      if (!updated) {
        Get.defaultDialog(
          title: "Opps!",
          middleText:
              'Something went wrong, failed to update profile picture. Try again later.',
          textCancel: 'Ok',
          onCancel: () {},
        );
      }
    } else {
      Get.snackbar('error', 'No image selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  getDoctorProfile() async {
    memberId.value = await getDoctorMemberId();
    var response = await apiServices.getDoctorProfile(memberId.value);
    if (response.isNotEmpty) {
      doctorProfile.value = response[0];
    }
    profilePic.value = getDoctorProfilePic(doctorProfile.value.profilePicture);
    validityDaysLeft.value = await getValidityDays();
  }

  getDoctor() async {
    doctorPhone.value = await getDoctorPhone();
    var response = await apiServices.getDoctor(doctorPhone.value);
    if (response.isNotEmpty) {
      doctor.value = response[0];
    }
  }

  getTotalConsults() async {
    int memberId = await getDoctorMemberId();
    var response = await apiServices.fetchConsultHistory(memberId);

    if (response.isNotEmpty) {
      consultationNumber.value = response.length;
    }
  }

  getSpeciality() async {
    var specialities = await apiServices.fetchSpeciality();
    if (specialities.isNotEmpty) {
      if (doctorSpecialityList.isNotEmpty) {
        doctorSpecialityList.clear();
        doctorSpecialityList.addAll(specialities);
      } else {
        doctorSpecialityList.addAll(specialities);
      }
    }
  }

  getReview() async {
    // print('review function calling');
    int memberId = await getDoctorMemberId();
    var reviews = await apiServices.fetchDoctorReview(memberId);
    // print(reviews);
    reviewList.clear();
    for (var review in reviews) {
      if (review.memberId == memberId) {
        if (reviewList.isNotEmpty) {
          reviewList.add(review.rating ?? 0.0);
        } else {
          reviewList.add(review.rating ?? 0.0);
        }
      }
    }
    double sum = reviewList.fold(0, (p, c) => p + c);
    if (sum > 0) {
      averageRating.value =
          double.parse((sum / reviewList.length).toStringAsFixed(2));
    }
  }

  callFunctions() {
    getDoctorProfile();
    getDoctor();
    getSpeciality();
    getTotalConsults();

    getReview();

    const oneSec = Duration(seconds: 3);
    _timer = Timer.periodic(oneSec, (Timer t) {
      getDoctorProfile();
      getDoctor();
      getSpeciality();
      getTotalConsults();
      getReview();
    });
  }

  @override
  void onInit() {
    callFunctions();
    super.onInit();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}
